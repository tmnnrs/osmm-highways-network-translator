# OS MasterMap<sup>&reg;</sup> Highways Network Translator

### Introduction
This translator has been developed to convert OS MasterMap Highways Network data from its native GML into PostgreSQL/PostGIS and GeoPackage (GPKG) using Open Source tools.

### Requirements
[SAXON] - XSLT processor developed by Saxonica Limited<sup>&dagger;</sup>.

[Geospatial Data Abstraction Library (GDAL)] - Translator library released by the Open Source Geospatial Foundation for reading/writing raster and vector geospatial data formats<sup>&dagger;&dagger;</sup>.

<sup>&dagger;</sup> Saxon 9.x requires Java 6 (also known as JDK 1.6) or later.\
<sup>&dagger;&dagger;</sup> Process assumes GDAL/OGR 2.1.x release.

### Project Tree
```c
.
+-- _bin
|   +-- createVRT.awk
|   +-- osmmHighwaysNetwork.awk
|   +-- osmmHighwaysNetwork.xsl
|   +-- userDefinedFunctions.awk
+-- _lib
│   +-- schema.txt
+-- process.sh
+-- ogr2ogr_CSV2GPKG.sh
+-- ogr2ogr_CSV2PG.sh
```

**`osmmHighwaysNetwork.xsl`**
Extensible Stylesheet Language (XSL) file used to transform GML files into a series of hash delimited staging files.

**`osmmHighwaysNetwork.awk`**
Restructures the hash delimited staging files into CSV format (including generation of cross-reference lookups).

**`userDefinedFunctions.awk`**
Reusable functions for geometry conversion; lookup handling; and vehicle/time qualification.

**`createVRT.awk`**
Generates the GDAL Virtual Format (VRT) files for onwards conversion of the CSV files.

**`schema.txt`**
Defines the data structure in the GDAL Virtual Format (VRT) files.
```c
product,member,geometryType
product,member,name,type,{length}
...
```

### Processing
The first stage (`process.sh`) transforms the GML files into CSV format. The output forms the basis for subsequent loading into PostgreSQL/PostGIS (using `ogr2ogr_CSV2PG.sh`) or GeoPackage (using `ogr2ogr_CSV2GPKG.sh`).

Environment variables in the shell script should be edited accordingly...

**`process.sh`**
```c
DATA_DIR='~/Documents/osdata/osmm-highways/_data'

OUT_DIR='~/Documents/osdata/osmm-highways/output'
TMP_DIR='~/Documents/osdata/osmm-highways/tmp'

XSLT_DIR='~/Documents/shared/tools'
JAVA_HEAP_SIZE=2048m

FEATURES=( RoadLink RoadNode Road Street RoadJunction PathLink PathNode ConnectingLink ConnectingNode Path FerryLink FerryNode FerryTerminal AccessRestriction Dedication TurnRestriction RestrictionForVehicles Hazard Structure Maintenance Reinstatement SpecialDesignation )

```

**`ogr2ogr_CSV2PG.sh`**
```c
OUT_DIR='~/Documents/osdata/osmm-highways/output'
TMP_DIR='~/Documents/osdata/osmm-highways/tmp'

GDAL_DIR='/Library/Frameworks/GDAL.framework/Versions/Current/Programs'
PSQL_DIR='/Applications/Postgres.app/Contents/Versions/latest/bin'

```

To run...
```c
$ ./process.sh
$ ./ogr2ogr_CSV2PG.sh
```

The process takes ~3hrs to run on a 2.5 GHz Intel Core i7 MacBook Pro with 16 GB RAM.

### Change Log
**Version 1.0.0** (May 2018)

* Initial release.

**Version 1.1.0** (June 2018)

* `[schema.txt]` Changed linear geometry types from wkbMultiLineString to wkbLineString (except Street).

**Version 1.1.1** (September 2018)

* Minor bug fix.

**Version 1.2.0** (May 2019)

* `[osmmHighwaysNetwork.xsl]` Fixes issue with refToFunctionalSite attribute being empty for FerryTerminal features.

**Version 1.3.0** (June 2019)

* `[osmmHighwaysNetwork.xsl]` Changed output delimiter to TAB (\t) for improved stability.
* `[schema.txt]` Changed field type for networkReference locationStart + locationEnd.

**Version 1.3.1** (November 2019)

* `[ogr2ogr_CSV2PG.sh]` Minor bug fix in *_timeInterval_dayPeriod_namedPeriod index creation.

**Version 1.4.0** (September 2020)

* `[ogr2ogr_CSV2PG.sh]` Update default PG schema name (for consistency with [highways-network-pgrouting](https://github.com/tmnnrs/highways-network-pgrouting)).


[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [Geospatial Data Abstraction Library (GDAL)]: <https://trac.osgeo.org/gdal/wiki/DownloadingGdalBinaries>
   [SAXON]: <http://saxon.sourceforge.net/>
