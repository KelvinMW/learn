```Python
import os

# create the database
db_file = 'example_crud.db'
if not os.path.exists(db_file):
    with open(db_file, 'w+') as f:
        f.close()

# connect to the database
import sqlite3
conn = sqlite3.connect(db_file)
c = conn.cursor()

# create a table
try:
    c.execute("""CREATE TABLE records
             (id int, name text, address text)
          """)
    print("Table created successfully")
except:
    print("Table already exists")

# insert a record
c.execute("INSERT INTO records VALUES (1, 'John Doe', '1 Main St')")
conn.commit()

# query the database
c.execute("SELECT * FROM records")
for row in c.fetchall():
    print(row)

# update a record
c.execute("UPDATE records SET name='John Smith' WHERE id=1")
conn.commit()

# delete a record
c.execute("DELETE FROM records WHERE id=1")
conn.commit()

# close the connection
conn.close()
```

