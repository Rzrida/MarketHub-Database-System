import pyodbc

# Your SQL Server connection settings
SERVER   = 'DESKTOP-454MCC3'
DATABASE = 'MarketHubDB'

def get_connection():
    """Returns a new database connection each time it's called."""
    conn = pyodbc.connect(
        f'DRIVER={{ODBC Driver 17 for SQL Server}};'
        f'SERVER={SERVER};'
        f'DATABASE={DATABASE};'
        f'Trusted_Connection=yes;'
    )
    return conn


def test_connection():
    """Quick test — run this file directly to check if DB connects."""
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM [User]")
        count = cursor.fetchone()[0]
        print(f"✅ Connected! Found {count} users in the database.")
        conn.close()
    except Exception as e:
        print(f"❌ Connection failed: {e}")


if __name__ == '__main__':
    test_connection()