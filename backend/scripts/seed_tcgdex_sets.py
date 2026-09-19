import os
import sys
import asyncio
import httpx

# Add backend directory to sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from api.database import SessionLocal
from api.models import CardSet

API_URL = "https://api.tcgdex.net/v2/en"

async def fetch_set_details(client, set_id):
    try:
        resp = await client.get(f"{API_URL}/sets/{set_id}")
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        print(f"Failed to fetch details for set {set_id}: {e}")
        return None

async def main():
    db = SessionLocal()
    
    print("Fetching all English sets summary from TCGdex...")
    async with httpx.AsyncClient(timeout=30.0) as client:
        try:
            resp = await client.get(f"{API_URL}/sets")
            resp.raise_for_status()
            sets_summary = resp.json()
        except Exception as e:
            print(f"Failed to fetch sets from TCGdex API: {e}")
            return

        if not sets_summary:
            print("No sets found from the API. Exiting.")
            return

        print(f"Retrieved {len(sets_summary)} sets. Fetching details concurrently...")
        
        # Fetch all set details concurrently
        tasks = [fetch_set_details(client, s["id"]) for s in sets_summary]
        sets_data = await asyncio.gather(*tasks)

    # Filter out any failed requests
    sets_data = [s for s in sets_data if s is not None]
    print(f"Successfully fetched details for {len(sets_data)} sets.")

    # Load existing local sets into a dictionary for quick lookup by ID
    existing_sets = {s.id: s for s in db.query(CardSet).all()}

    inserted_count = 0
    updated_count = 0

    for s in sets_data:
        s_id = s.get("id")
        if not s_id:
            continue
            
        s_name = s.get("name", "Unknown")
        # For TCGdex, tcgOnline holds the short code (like 'SSH')
        s_ptcgo_code = s.get("tcgOnline") or s.get("abbreviation", {}).get("official")
        s_release_date = s.get("releaseDate")
        
        card_count = s.get("cardCount", {})
        s_printed_total = card_count.get("official") or card_count.get("total")
        
        # We append .png because TCGdex image urls lack extensions by default
        base_logo = s.get("logo")
        s_logo_url = f"{base_logo}.png" if base_logo else None
        
        local_set = existing_sets.get(s_id)
        
        if local_set:
            # Update existing set
            updated = False
            if local_set.set_code != s_ptcgo_code:
                local_set.set_code = s_ptcgo_code
                updated = True
            if local_set.printed_code != s_ptcgo_code:
                local_set.printed_code = s_ptcgo_code
                updated = True
            if local_set.symbol_url != s_logo_url:
                local_set.symbol_url = s_logo_url
                updated = True
            if local_set.release_date != s_release_date:
                local_set.release_date = s_release_date
                updated = True
            if local_set.total_printed != s_printed_total:
                local_set.total_printed = s_printed_total
                updated = True
                
            if updated:
                updated_count += 1
                
        else:
            # Insert new set
            new_set = CardSet(
                id=s_id,
                name=s_name,
                set_code=s_ptcgo_code,
                release_date=s_release_date,
                total_printed=s_printed_total,
                symbol_url=s_logo_url,
                printed_code=s_ptcgo_code,
                language="en"
            )
            db.add(new_set)
            inserted_count += 1
            existing_sets[s_id] = new_set

    # Commit all changes to PostgreSQL
    try:
        db.commit()
        print("\n--- TCGDEX MASTER SET SEEDER SUMMARY ---")
        print(f"Total Sets Processed: {len(sets_data)}")
        print(f"Sets Inserted: {inserted_count}")
        print(f"Sets Updated: {updated_count}")
        print("Done!")
    except Exception as e:
        db.rollback()
        print(f"\nFailed to commit changes to the database: {e}")

if __name__ == "__main__":
    asyncio.run(main())
