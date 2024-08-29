import sqlite3

def init_db():
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            discord_id TEXT UNIQUE,
            username TEXT,
            role TEXT
        )
    ''')
    conn.commit()
    conn.close()

def save_user(discord_id, username, role):
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    c.execute('INSERT INTO users (discord_id, username, role) VALUES (?, ?, ?)',
              (discord_id, username, role))
    conn.commit()
    conn.close()

def get_staff():
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    c.execute('SELECT * FROM users WHERE role = "staff"')
    users = c.fetchall()
    conn.close()
    return users
