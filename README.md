# SQLITE Loadable extensions

This is the first release, as it was downloaded from [the SQLite Website](https://www.sqlite.org/contrib/download/extension-functions.c?get=25)

# Install (Linux)

```bash
git clone https://github.com/astrorafael/sqlite-extensions.git
cd sqlite-extensions
make
sudo make install
```

# How to load extensions from teh command line

```sql
.load /usr/local/lib/libsqlitefunctions
select (cos(3.145192));
```

# How to load extensions from Python
```python
import sqlite3
connection = sqlite.connect(db_file)
connection.enable_load_extension(True)
connection.load_extension("/usr/local/lib/libsqlitefunctions.so")
```
