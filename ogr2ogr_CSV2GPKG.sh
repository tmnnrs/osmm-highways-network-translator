#!/bin/bash

GDAL_DIR='/Library/Frameworks/GDAL.framework/Versions/Current/Programs'

DATA_DIR='~/Documents/osdata/osmm-highways/output'
GPKG_DIR='~/Documents/osdata/osmm-highways/output'

rm -f $GPKG_DIR/osmmhighways.gpkg

# RoadLink
awk -F ',' '{if ($2 == "RoadLink") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadLink.vrt
awk -F ',' '{if ($2 == "RoadLink_alternateIdentifier") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadLink_alternateIdentifier.vrt
awk -F ',' '{if ($2 == "RoadLink_formsPartOf") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadLink_formsPartOf.vrt
awk -F ',' '{if ($2 == "RoadLink_relatedRoadArea") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadLink_relatedRoadArea.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadLink.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadLink_alternateIdentifier.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadLink_formsPartOf.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadLink_relatedRoadArea.vrt
rm -f $DATA_DIR/RoadLink*.vrt

# RoadNode
awk -F ',' '{if ($2 == "RoadNode") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadNode.vrt
awk -F ',' '{if ($2 == "RoadNode_relatedRoadArea") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadNode_relatedRoadArea.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadNode.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadNode_relatedRoadArea.vrt
rm -f $DATA_DIR/RoadNode*.vrt

# Road
awk -F ',' '{if ($2 == "Road") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Road.vrt
awk -F ',' '{if ($2 == "Road_link") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Road_link.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Road.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Road_link.vrt
rm -f $DATA_DIR/Road*.vrt

# Street
awk -F ',' '{if ($2 == "Street") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Street.vrt
awk -F ',' '{if ($2 == "Street_link") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Street_link.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Street.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Street_link.vrt
rm -f $DATA_DIR/Street*.vrt

# RoadJunction
awk -F ',' '{if ($2 == "RoadJunction") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadJunction.vrt
awk -F ',' '{if ($2 == "RoadJunction_node") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RoadJunction_node.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadJunction.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RoadJunction_node.vrt
rm -f $DATA_DIR/RoadJunction*.vrt

# PathLink
awk -F ',' '{if ($2 == "PathLink") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/PathLink.vrt
awk -F ',' '{if ($2 == "PathLink_formsPartOf") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/PathLink_formsPartOf.vrt
awk -F ',' '{if ($2 == "PathLink_relatedRoadArea") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/PathLink_relatedRoadArea.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/PathLink.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/PathLink_formsPartOf.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/PathLink_relatedRoadArea.vrt
rm -f $DATA_DIR/PathLink*.vrt

# PathNode
awk -F ',' '{if ($2 == "PathNode") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/PathNode.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/PathNode.vrt
rm -f $DATA_DIR/PathNode*.vrt

# ConnectingLink
awk -F ',' '{if ($2 == "ConnectingLink") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/ConnectingLink.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/ConnectingLink.vrt
rm -f $DATA_DIR/ConnectingLink*.vrt

# ConnectingNode
awk -F ',' '{if ($2 == "ConnectingNode") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/ConnectingNode.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/ConnectingNode.vrt
rm -f $DATA_DIR/ConnectingNode*.vrt

# Path
awk -F ',' '{if ($2 == "Path") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Path.vrt
awk -F ',' '{if ($2 == "Path_link") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Path_link.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Path.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Path_link.vrt
rm -f $DATA_DIR/Path*.vrt

# FerryLink
awk -F ',' '{if ($2 == "FerryLink") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/FerryLink.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/FerryLink.vrt
rm -f $DATA_DIR/FerryLink*.vrt

# FerryNode
awk -F ',' '{if ($2 == "FerryNode") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/FerryNode.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/FerryNode.vrt
rm -f $DATA_DIR/FerryNode*.vrt

# FerryTerminal
awk -F ',' '{if ($2 == "FerryTerminal") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/FerryTerminal.vrt
awk -F ',' '{if ($2 == "FerryTerminal_element") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/FerryTerminal_element.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/FerryTerminal.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/FerryTerminal_element.vrt
rm -f $DATA_DIR/FerryTerminal*.vrt

# AccessRestriction
awk -F ',' '{if ($2 == "AccessRestriction") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction.vrt
awk -F ',' '{if ($2 == "AccessRestriction_pointReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_pointReference.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_timePeriod.vrt
awk -F ',' '{if ($2 == "AccessRestriction_vehicleQualifier") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_vehicleQualifier.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction_pointReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction_timeInterval_namedDate.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction_timeInterval_dateRange.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_namedDay.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_namedPeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_timePeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/AccessRestriction_vehicleQualifier.vrt
rm -f $DATA_DIR/AccessRestriction*.vrt

# HighwayDedication
awk -F ',' '{if ($2 == "HighwayDedication") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication.vrt
awk -F ',' '{if ($2 == "HighwayDedication_networkReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_networkReference.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_timePeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/HighwayDedication.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/HighwayDedication_networkReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/HighwayDedication_timeInterval_namedDate.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/HighwayDedication_timeInterval_dateRange.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_namedDay.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_namedPeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_timePeriod.vrt
rm -f $DATA_DIR/HighwayDedication*.vrt

# TurnRestriction
awk -F ',' '{if ($2 == "TurnRestriction") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction.vrt
awk -F ',' '{if ($2 == "TurnRestriction_linkReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_linkReference.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_timePeriod.vrt
awk -F ',' '{if ($2 == "TurnRestriction_vehicleQualifier") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_vehicleQualifier.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction_linkReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction_timeInterval_namedDate.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction_timeInterval_dateRange.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_namedDay.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_namedPeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_timePeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/TurnRestriction_vehicleQualifier.vrt
rm -f $DATA_DIR/TurnRestriction*.vrt

# RestrictionForVehicles
awk -F ',' '{if ($2 == "RestrictionForVehicles") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RestrictionForVehicles.vrt
awk -F ',' '{if ($2 == "RestrictionForVehicles_nodeReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RestrictionForVehicles_nodeReference.vrt
awk -F ',' '{if ($2 == "RestrictionForVehicles_pointReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/RestrictionForVehicles_pointReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RestrictionForVehicles.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RestrictionForVehicles_nodeReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/RestrictionForVehicles_pointReference.vrt
rm -f $DATA_DIR/RestrictionForVehicles*.vrt

# Hazard
awk -F ',' '{if ($2 == "Hazard") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Hazard.vrt
awk -F ',' '{if ($2 == "Hazard_linkReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Hazard_linkReference.vrt
awk -F ',' '{if ($2 == "Hazard_nodeReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Hazard_nodeReference.vrt
awk -F ',' '{if ($2 == "Hazard_pointReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Hazard_pointReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Hazard.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Hazard_linkReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Hazard_nodeReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Hazard_pointReference.vrt
rm -f $DATA_DIR/Hazard*.vrt

# Structure
awk -F ',' '{if ($2 == "Structure") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Structure.vrt
awk -F ',' '{if ($2 == "Structure_linkReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Structure_linkReference.vrt
awk -F ',' '{if ($2 == "Structure_nodeReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Structure_nodeReference.vrt
awk -F ',' '{if ($2 == "Structure_pointReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Structure_pointReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Structure.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Structure_linkReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Structure_nodeReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Structure_pointReference.vrt
rm -f $DATA_DIR/Structure*.vrt

# Maintenance
awk -F ',' '{if ($2 == "Maintenance") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Maintenance.vrt
awk -F ',' '{if ($2 == "Maintenance_networkReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Maintenance_networkReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Maintenance.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Maintenance_networkReference.vrt
rm -f $DATA_DIR/Maintenance*.vrt

# Reinstatement
awk -F ',' '{if ($2 == "Reinstatement") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Reinstatement.vrt
awk -F ',' '{if ($2 == "Reinstatement_networkReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/Reinstatement_networkReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Reinstatement.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/Reinstatement_networkReference.vrt
rm -f $DATA_DIR/Reinstatement*.vrt

# SpecialDesignation
awk -F ',' '{if ($2 == "SpecialDesignation") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_networkReference") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_networkReference.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_timePeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -a_srs "EPSG:27700" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/SpecialDesignation.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/SpecialDesignation_networkReference.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/SpecialDesignation_timeInterval_namedDate.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/SpecialDesignation_timeInterval_dateRange.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_namedDay.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_namedPeriod.vrt
$GDAL_DIR/ogr2ogr -append -f "GPKG" -lco FID=ogc_fid $GPKG_DIR/osmmhighways.gpkg $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_timePeriod.vrt
rm -f $DATA_DIR/SpecialDesignation*.vrt

exit
