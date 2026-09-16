import os
import sys
import time
import urllib.request
import urllib.parse
import json

from sqlalchemy.orm import Session
from sqlalchemy import create_engine

# Add parent directory to path so we can import api.models
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from api.models import Printing, ReferenceImage
from api.database import SessionLocal

API_URL = "https://api.pokemontcg.io/v2/cards"

import re

def fetch_image_from_api(name, card_number, set_code=None):
    clean_name = name.split(" ex")[0].split(" EX")[0].strip()
    if clean_name.lower().startswith("mega "):
        clean_name = clean_name[5:] # strip mega

    
    # Extract just the first numeric part for the API query
    match = re.search(r'\d+', card_number)
    clean_num = match.group(0) if match else card_number
    # Remove leading zeros
    clean_num = str(int(clean_num)) if clean_num.isdigit() else clean_num
    
    query = f'name:"{clean_name}*" number:{clean_num}'
    print(f"    -> Querying API: {query}")
    
    url = API_URL + "?q=" + urllib.parse.quote(query)
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    
    try:
        with urllib.request.urlopen(req) as response:
            if response.status == 200:
                data = json.loads(response.read().decode())
                cards = data.get("data", [])
                if cards:
                    best_match = cards[0]
                    img_url = best_match.get("images", {}).get("large")
                    if not img_url:
                        img_url = best_match.get("images", {}).get("small")
                    return img_url
    except urllib.error.HTTPError as e:
        if e.code == 429:
            print("    -> Rate limited! Sleeping for 5s...")
            time.sleep(5)
            return fetch_image_from_api(name, card_number, set_code)
        else:
            print(f"    -> HTTP Error: {e.code}")
    except Exception as e:
        print(f"    -> Error querying API: {e}")
        
    return None

def main():
    print("Starting Reference Image Update Script...")
    db = SessionLocal()
    
    # Get all printings that need updating
    printings = db.query(Printing).filter(Printing.is_active == True).all()
    print(f"Found {len(printings)} active printings.")
    
    updated_count = 0
    
    for p in printings:
        print(f"Processing: {p.id} ({p.name} #{p.card_number})")
        
        # Get its reference image
        ref_img = db.query(ReferenceImage).filter(ReferenceImage.printing_id == p.id).first()
        
        if ref_img:
            print(f"  Current URL: {ref_img.image_url}")
            
            # Fetch new URL
            new_url = fetch_image_from_api(p.name, p.card_number, p.set_id)
            
            if new_url:
                print(f"  Found New URL: {new_url}")
                if new_url != ref_img.image_url:
                    ref_img.image_url = new_url
                    ref_img.source_name = "pokemontcg.io API (Updated)"
                    updated_count += 1
            else:
                print("  No match found on API.")
                
            time.sleep(1) # Respect rate limits
            
    db.commit()
    db.close()
    
    print(f"Update complete! Successfully updated {updated_count} image URLs.")

if __name__ == "__main__":
    main()
