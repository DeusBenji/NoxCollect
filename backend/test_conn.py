import psycopg2

try:
    conn = psycopg2.connect(
        host="127.0.0.1",
        port=5433,
        user="noxcollect",
        password="noxpassword",
        dbname="noxcollect_catalog"
    )
    print("Connection successful!")
    conn.close()
except Exception as e:
    print(f"Error: {e}")
