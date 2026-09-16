import os
import sys
import time
import urllib.request
import urllib.parse
import json
import re

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from api.models import Printing, ReferenceImage
from api.database import SessionLocal

API_URL = "https://api.pokemontcg.io/v2/cards"

# URLs containing these strings are considered broken/untrusted and will be retried
UNTRUSTED_URL_PATTERNS = ["scrydex.com", "pokemontcg.io/bw", "pokemontcg.io/xy4"]

# Card IDs that are manually managed and should never be auto-updated
MANUAL_OVERRIDE_IDS = ["promo-mep-073"]


def is_url_trusted(url: str) -> bool:
    if not url:
        return False
    for pattern in UNTRUSTED_URL_PATTERNS:
        if pattern in url:
            return False
    return True


def fetch_image_from_api(name, card_number, retries=3):
    clean_name = name.split(" ex")[0].split(" EX")[0].strip()
    if clean_name.lower().startswith("mega "):
        clean_name = clean_name[5:]

    match = re.search(r'\d+', card_number)
    clean_num = match.group(0) if match else card_number
    clean_num = str(int(clean_num)) if clean_num.isdigit() else clean_num

    query = f'name:"{clean_name}*" number:{clean_num}'
    url = API_URL + "?" + urllib.parse.urlencode({"q": query})
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})

    for attempt in range(retries):
        try:
            with urllib.request.urlopen(req, timeout=10) as response:
                if response.status == 200:
                    data = json.loads(response.read().decode())
                    cards = data.get("data", [])
                    if cards:
                        img_url = cards[0].get("images", {}).get("large")
                        if not img_url:
                            img_url = cards[0].get("images", {}).get("small")
                        return img_url
                    return None
        except urllib.error.HTTPError as e:
            if e.code == 429:
                print(f"    -> Rate limited! Sleeping 10s...")
                time.sleep(10)
            else:
                print(f"    -> HTTP Error {e.code} (attempt {attempt + 1}/{retries})")
                time.sleep(3)
        except Exception as e:
            print(f"    -> Error: {e} (attempt {attempt + 1}/{retries})")
            time.sleep(3)

    return None


def main():
    db = SessionLocal()

    # Find all printings with missing or untrusted image URLs
    printings = db.query(Printing).filter(Printing.is_active == True).all()

    needs_update = []
    for p in printings:
        ref_img = db.query(ReferenceImage).filter(ReferenceImage.printing_id == p.id).first()
        current_url = ref_img.image_url if ref_img else None
        if not is_url_trusted(current_url):
            if p.id in MANUAL_OVERRIDE_IDS:
                print(f"Skipping {p.id} (manually managed)")
                continue
            needs_update.append((p, ref_img, current_url))

    print(f"Found {len(needs_update)} cards with missing or untrusted images.")
    print(f"(Skipping {len(printings) - len(needs_update)} cards that already have good images)\n")

    if not needs_update:
        print("All cards already have trusted image URLs!")
        db.close()
        return

    fixed = 0
    failed = []

    for p, ref_img, current_url in needs_update:
        print(f"Fixing: {p.id} ({p.name} #{p.card_number})")
        print(f"  Current URL: {current_url or 'MISSING'}")

        new_url = fetch_image_from_api(p.name, p.card_number)

        if new_url:
            print(f"  -> New URL: {new_url}")
            if ref_img:
                ref_img.image_url = new_url
                ref_img.source_name = "pokemontcg.io API (Retry Fixer)"
            else:
                new_ref = ReferenceImage(
                    printing_id=p.id,
                    image_url=new_url,
                    source_name="pokemontcg.io API (Retry Fixer)"
                )
                db.add(new_ref)
            db.commit()
            fixed += 1
        else:
            print(f"  -> FAILED - will be saved to failed_cards.txt")
            failed.append(f"{p.id} | {p.name} #{p.card_number}")

        time.sleep(1)

    # Write failed cards to a file for later retry
    if failed:
        with open("backend/scripts/failed_cards.txt", "w") as f:
            f.write("\n".join(failed))
        print(f"\nSaved {len(failed)} failed cards to backend/scripts/failed_cards.txt")

    print(f"\nDone! Fixed: {fixed}, Failed: {len(failed)}")
    db.close()


if __name__ == "__main__":
    main()
