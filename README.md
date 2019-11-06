# SQLITE Loadable extensions

My customized version of SQLite's [`extension-functions.c`](https://www.sqlite.org/contrib/download/extension-functions.c?get=25) for my own needs.

The original file was contributed to the SQLite repository by Liam Healy on 2010-02-06 15:45:07 and provides mathematical and string extension functions for SQL queries using the loadable extensions mechanism. 

*  **Math:** acos, asin, atan, atn2, atan2, acosh, asinh, atanh, difference, degrees, radians, cos, sin, tan, cot, cosh, sinh, tanh, coth, exp, log, log10, power, sign, sqrt, square, ceil, floor, pi. 
* **String:** replicate, charindex, leftstr, rightstr, ltrim, rtrim, trim, replace, reverse, proper, padl, padr, padc, strfilter. 
* **Aggregate:** stdev, variance, mode, median, lower_quartile, upper_quartile.

I have added the following functions to the original file:

| SQL Function   |  Arguments                  | Description                                 
|:--------------:|:---------------------------:|:------------------------------------------------------------------------------------------|
| latitude       | X                           | Returns printable latitude string   DD MM SS.SS &#91;N|S&#93; given latitude X in floating point degrees.
| longitude      | X                           | Returns printable longitude string DDD MM SS.SS \[E\|W\] given longitude X in floating point degrees.
| sphericaldist  | XLat, XLong, YLat, YLong, R | Returns distance from a given point X to a reference point Y and over a sphere with radius R.

Longitudes and latitudes in these functions are given in floating point degrees (instead of radians) for convenience.
If Radius is `NULL` when calling `sphericaldist`, the Earth radius (6371 Km) is used. Using a R = 1, the spherical distance returned is the substended angle in radians.

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

# How to load extensions from the command line

```sql
sqlite3 test.db
SQLite version 3.22.0 2018-01-22 18:45:57
Enter ".help" for usage hints.
sqlite> .load /usr/local/lib/libsqlitefunctions
sqlite>
```

# How to load extensions from Python
```python
import sqlite3
connection = sqlite.connect(db_file)
connection.enable_load_extension(True)
connection.load_extension("/usr/local/lib/libsqlitefunctions.so")
```
