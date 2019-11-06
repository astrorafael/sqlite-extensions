# SQLITE Loadable extensions

My customized version of SQLite's [`extension-functions.c`](https://www.sqlite.org/contrib/download/extension-functions.c?get=25) for my own needs.

I have added the following functions to the original file:


| SQL Function   |  Arguments                  | Description                                 
|:--------------:|:---------------------------:|:------------------------------------------------------------------------------------------|
| latitude       | X                           | Returns printable latitude   DD MM SS.SS [N|S] given latitude X in floating point degrees.
| longitude      | X                           | Returns printable longitude DDD MM SS.SS [E|W] given longitude X in floating point degrees.
| spherical_dist | XLat, XLong, YLat, YLong, R | Returns distance from a given point X to a reference point Y and over a sphere with radius R.

Longitudes and latitudes in these functions are given in floating point degrees (instead of radians) for convenicence.
If Radius is NULL when calling `spherical_dist`, the Earth radius (6371 Km) is used. Using a R = 1, the spherical distance returned is the substended angle in radians.

## Notes

No attempt is given to check the range of input arguments. They ***should*** be ok in the database beforehand. However, using a `NULL` value in any argument returns a `NULL` result.

The [spherical distance](https://en.wikipedia.org/wiki/Great-circle_distance) is computed using the haversine formulae.

The extension should compile on any platform. For Linux, a convenience `Makefile` is provided.

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
