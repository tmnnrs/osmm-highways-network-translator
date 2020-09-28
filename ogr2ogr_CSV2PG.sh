#!/bin/bash

GDAL_DIR='/Library/Frameworks/GDAL.framework/Versions/Current/Programs'
PSQL_DIR='/Applications/Postgres.app/Contents/Versions/latest/bin'

DATA_DIR='~/Documents/osdata/osmm-highways/output'

gdalPGDump() {
  # $1 - filename
  # $2 - geomtype|srid
  # $3 - indexname
  # $4 - table
  # $5 - column
  # $6 - uniqueindex
  if [ "$2" != "null" ]; then
    IFS='|' read -r -a geom <<< "$2"
    # $GDAL_DIR/ogr2ogr -overwrite -f "PostgreSQL" PG:"host=localhost dbname=osdata" $DATA_DIR/"$1".vrt -nlt "${geom[0]}" -lco DIM=3 -lco GEOMETRY_NAME=geom -lco SCHEMA=osmm_highways
    $GDAL_DIR/ogr2ogr --config PG_USE_COPY YES -f "PGDump" /vsistdout/ $DATA_DIR/"$1".vrt -nlt "${geom[0]}" -lco DIM=3 -lco GEOMETRY_NAME=geom -lco SCHEMA=osmm_highways -lco SRID="${geom[1]}" | $PSQL_DIR/psql --quiet -d osdata -f -
  else
    # $GDAL_DIR/ogr2ogr -overwrite -f "PostgreSQL" PG:"host=localhost dbname=osdata" $DATA_DIR/"$1".vrt -lco SCHEMA=osmm_highways
    $GDAL_DIR/ogr2ogr --config PG_USE_COPY YES -f "PGDump" /vsistdout/ $DATA_DIR/"$1".vrt -lco SCHEMA=osmm_highways | $PSQL_DIR/psql --quiet -d osdata -f -
  fi
  $PSQL_DIR/psql --quiet -d osdata -c "CREATE $6 $3 ON osmm_highways.$4 ($5)"
  $PSQL_DIR/psql --quiet -d osdata -c "VACUUM ANALYZE osmm_highways.$4"
}

# RoadLink
awk -F ',' '{if ($2 == "RoadLink") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadLink.vrt
awk -F ',' '{if ($2 == "RoadLink_alternateIdentifier") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadLink_alternateIdentifier.vrt
awk -F ',' '{if ($2 == "RoadLink_formsPartOf") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadLink_formsPartOf.vrt
awk -F ',' '{if ($2 == "RoadLink_relatedRoadArea") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadLink_relatedRoadArea.vrt
gdalPGDump RoadLink "LINESTRING|27700" roadlink_id_idx roadlink id "UNIQUE INDEX"
gdalPGDump RoadLink_alternateIdentifier null roadlink_alternateidentifier_id_idx roadlink_alternateidentifier id INDEX
gdalPGDump RoadLink_formsPartOf null roadlink_formspartof_id_idx roadlink_formspartof id INDEX
gdalPGDump RoadLink_relatedRoadArea null roadlink_relatedroadarea_id_idx roadlink_relatedroadarea id INDEX
rm -f $DATA_DIR/RoadLink*.vrt

# RoadNode
awk -F ',' '{if ($2 == "RoadNode") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadNode.vrt
awk -F ',' '{if ($2 == "RoadNode_relatedRoadArea") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadNode_relatedRoadArea.vrt
gdalPGDump RoadNode "POINT|27700" roadnode_id_idx roadnode id "UNIQUE INDEX"
gdalPGDump RoadNode_relatedRoadArea null roadnode_relatedroadarea_id_idx roadnode_relatedroadarea id INDEX
rm -f $DATA_DIR/RoadNode*.vrt

# Road
awk -F ',' '{if ($2 == "Road") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Road.vrt
awk -F ',' '{if ($2 == "Road_link") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Road_link.vrt
gdalPGDump Road null road_id_idx road id "UNIQUE INDEX"
gdalPGDump Road_link null road_link_id_idx road_link id INDEX
rm -f $DATA_DIR/Road*.vrt

# Street
awk -F ',' '{if ($2 == "Street") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Street.vrt
awk -F ',' '{if ($2 == "Street_link") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Street_link.vrt
gdalPGDump Street "MULTILINESTRING|27700" street_id_idx street id "UNIQUE INDEX"
gdalPGDump Street_link null street_link_id_idx street_link id INDEX
rm -f $DATA_DIR/Street*.vrt

# RoadJunction
awk -F ',' '{if ($2 == "RoadJunction") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadJunction.vrt
awk -F ',' '{if ($2 == "RoadJunction_node") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RoadJunction_node.vrt
gdalPGDump RoadJunction null roadjunction_id_idx roadjunction id "UNIQUE INDEX"
gdalPGDump RoadJunction_node null roadjunction_node_id_idx roadjunction_node id INDEX
rm -f $DATA_DIR/RoadJunction*.vrt

# PathLink
awk -F ',' '{if ($2 == "PathLink") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/PathLink.vrt
awk -F ',' '{if ($2 == "PathLink_formsPartOf") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/PathLink_formsPartOf.vrt
awk -F ',' '{if ($2 == "PathLink_relatedRoadArea") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/PathLink_relatedRoadArea.vrt
gdalPGDump PathLink "LINESTRING|27700" pathlink_id_idx pathlink id "UNIQUE INDEX"
gdalPGDump PathLink_formsPartOf null pathlink_formspartof_id_idx pathlink_formspartof id INDEX
gdalPGDump PathLink_relatedRoadArea null pathlink_relatedroadarea_id_idx pathlink_relatedroadarea id INDEX
rm -f $DATA_DIR/PathLink*.vrt

# PathNode
awk -F ',' '{if ($2 == "PathNode") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/PathNode.vrt
gdalPGDump PathNode "POINT|27700" pathnode_id_idx pathnode id "UNIQUE INDEX"
rm -f $DATA_DIR/PathNode*.vrt

# ConnectingLink
awk -F ',' '{if ($2 == "ConnectingLink") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/ConnectingLink.vrt
gdalPGDump ConnectingLink "LINESTRING|27700" connectinglink_id_idx connectinglink id "UNIQUE INDEX"
rm -f $DATA_DIR/ConnectingLink*.vrt

# ConnectingNode
awk -F ',' '{if ($2 == "ConnectingNode") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/ConnectingNode.vrt
gdalPGDump ConnectingNode "POINT|27700" connectingnode_id_idx connectingnode id "UNIQUE INDEX"
rm -f $DATA_DIR/ConnectingNode*.vrt

# Path
awk -F ',' '{if ($2 == "Path") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Path.vrt
awk -F ',' '{if ($2 == "Path_link") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Path_link.vrt
gdalPGDump Path null path_id_idx path id "UNIQUE INDEX"
gdalPGDump Path_link null path_link_id_idx path_link id INDEX
rm -f $DATA_DIR/Path*.vrt

# FerryLink
awk -F ',' '{if ($2 == "FerryLink") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/FerryLink.vrt
gdalPGDump FerryLink "LINESTRING|27700" ferrylink_id_idx ferrylink id "UNIQUE INDEX"
rm -f $DATA_DIR/FerryLink*.vrt

# FerryNode
awk -F ',' '{if ($2 == "FerryNode") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/FerryNode.vrt
gdalPGDump FerryNode "POINT|27700" ferrynode_id_idx ferrynode id "UNIQUE INDEX"
rm -f $DATA_DIR/FerryNode*.vrt

# FerryTerminal
awk -F ',' '{if ($2 == "FerryTerminal") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/FerryTerminal.vrt
awk -F ',' '{if ($2 == "FerryTerminal_element") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/FerryTerminal_element.vrt
gdalPGDump FerryTerminal null ferryterminal_id_idx ferryterminal id "UNIQUE INDEX"
gdalPGDump FerryTerminal_element null ferryterminal_element_id_idx ferryterminal_element id INDEX
rm -f $DATA_DIR/FerryTerminal*.vrt

# AccessRestriction
awk -F ',' '{if ($2 == "AccessRestriction") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction.vrt
awk -F ',' '{if ($2 == "AccessRestriction_pointReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_pointReference.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "AccessRestriction_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_timeInterval_dayPeriod_timePeriod.vrt
awk -F ',' '{if ($2 == "AccessRestriction_vehicleQualifier") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/AccessRestriction_vehicleQualifier.vrt
gdalPGDump AccessRestriction "POINT|27700" accessrestriction_id_idx accessrestriction id "UNIQUE INDEX"
gdalPGDump AccessRestriction_pointReference null accessrestriction_pointreference_id_idx accessrestriction_pointreference id INDEX
gdalPGDump AccessRestriction_timeInterval_namedDate null accessrestriction_nameddate_id_idx accessrestriction_timeinterval_nameddate id INDEX
gdalPGDump AccessRestriction_timeInterval_dateRange null accessrestriction_daterange_id_idx accessrestriction_timeinterval_daterange id INDEX
gdalPGDump AccessRestriction_timeInterval_dayPeriod_namedDay null accessrestriction_namedday_id_idx accessrestriction_timeinterval_dayperiod_namedday id INDEX
gdalPGDump AccessRestriction_timeInterval_dayPeriod_namedPeriod null accessrestriction_namedperiod_id_idx accessrestriction_timeinterval_dayperiod_namedperiod id INDEX
gdalPGDump AccessRestriction_timeInterval_dayPeriod_timePeriod null accessrestriction_timeperiod_id_idx accessrestriction_timeinterval_dayperiod_timeperiod id INDEX
gdalPGDump AccessRestriction_vehicleQualifier null accessrestriction_vehiclequalifier_id_idx accessrestriction_vehiclequalifier id INDEX
rm -f $DATA_DIR/AccessRestriction*.vrt

# HighwayDedication
awk -F ',' '{if ($2 == "HighwayDedication") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication.vrt
awk -F ',' '{if ($2 == "HighwayDedication_networkReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_networkReference.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "HighwayDedication_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/HighwayDedication_timeInterval_dayPeriod_timePeriod.vrt
gdalPGDump HighwayDedication "LINESTRING|27700" highwaydedication_id_idx highwaydedication id "UNIQUE INDEX"
gdalPGDump HighwayDedication_networkReference null highwaydedication_networkReference_id_idx highwaydedication_networkReference id INDEX
gdalPGDump HighwayDedication_timeInterval_namedDate null highwaydedication_nameddate_id_idx highwaydedication_timeinterval_nameddate id INDEX
gdalPGDump HighwayDedication_timeInterval_dateRange null highwaydedication_daterange_id_idx highwaydedication_timeinterval_daterange id INDEX
gdalPGDump HighwayDedication_timeInterval_dayPeriod_namedDay null highwaydedication_namedday_id_idx highwaydedication_timeinterval_dayperiod_namedday id INDEX
gdalPGDump HighwayDedication_timeInterval_dayPeriod_namedPeriod null highwaydedication_namedperiod_id_idx highwaydedication_timeinterval_dayperiod_namedperiod id INDEX
gdalPGDump HighwayDedication_timeInterval_dayPeriod_timePeriod null highwaydedication_timeperiod_id_idx highwaydedication_timeinterval_dayperiod_timeperiod id INDEX
rm -f $DATA_DIR/HighwayDedication*.vrt

# TurnRestriction
awk -F ',' '{if ($2 == "TurnRestriction") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction.vrt
awk -F ',' '{if ($2 == "TurnRestriction_linkReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_linkReference.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "TurnRestriction_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_timeInterval_dayPeriod_timePeriod.vrt
awk -F ',' '{if ($2 == "TurnRestriction_vehicleQualifier") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/TurnRestriction_vehicleQualifier.vrt
gdalPGDump TurnRestriction null turnrestriction_id_idx turnrestriction id "UNIQUE INDEX"
gdalPGDump TurnRestriction_linkReference null turnrestriction_linkreference_id_idx turnrestriction_linkreference id INDEX
gdalPGDump TurnRestriction_timeInterval_namedDate null turnrestriction_nameddate_id_idx turnrestriction_timeinterval_nameddate id INDEX
gdalPGDump TurnRestriction_timeInterval_dateRange null turnrestriction_daterange_id_idx turnrestriction_timeinterval_daterange id INDEX
gdalPGDump TurnRestriction_timeInterval_dayPeriod_namedDay null turnrestriction_namedday_id_idx turnrestriction_timeinterval_dayperiod_namedday id INDEX
gdalPGDump TurnRestriction_timeInterval_dayPeriod_namedPeriod null turnrestriction_namedperiod_id_idx turnrestriction_timeinterval_dayperiod_namedperiod id INDEX
gdalPGDump TurnRestriction_timeInterval_dayPeriod_timePeriod null turnrestriction_timeperiod_id_idx turnrestriction_timeinterval_dayperiod_timeperiod id INDEX
gdalPGDump TurnRestriction_vehicleQualifier null turnrestriction_vehiclequalifier_id_idx turnrestriction_vehiclequalifier id INDEX
rm -f $DATA_DIR/TurnRestriction*.vrt

# RestrictionForVehicles
awk -F ',' '{if ($2 == "RestrictionForVehicles") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RestrictionForVehicles.vrt
awk -F ',' '{if ($2 == "RestrictionForVehicles_nodeReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RestrictionForVehicles_nodeReference.vrt
awk -F ',' '{if ($2 == "RestrictionForVehicles_pointReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/RestrictionForVehicles_pointReference.vrt
gdalPGDump RestrictionForVehicles "POINT|27700" restrictionforvehicles_id_idx restrictionforvehicles id "UNIQUE INDEX"
gdalPGDump RestrictionForVehicles_nodeReference null restrictionforvehicles_nodereference_id_idx restrictionforvehicles_nodereference id INDEX
gdalPGDump RestrictionForVehicles_pointReference null restrictionforvehicles_pointreference_id_idx restrictionforvehicles_pointreference id INDEX
rm -f $DATA_DIR/RestrictionForVehicles*.vrt

# Hazard
awk -F ',' '{if ($2 == "Hazard") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Hazard.vrt
awk -F ',' '{if ($2 == "Hazard_linkReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Hazard_linkReference.vrt
awk -F ',' '{if ($2 == "Hazard_nodeReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Hazard_nodeReference.vrt
awk -F ',' '{if ($2 == "Hazard_pointReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Hazard_pointReference.vrt
gdalPGDump Hazard "POINT|27700" hazard_id_idx hazard id "UNIQUE INDEX"
gdalPGDump Hazard_linkReference null hazard_linkreference_id_idx hazard_linkreference id INDEX
gdalPGDump Hazard_linkReference null hazard_nodereference_id_idx hazard_nodereference id INDEX
gdalPGDump Hazard_linkReference null hazard_pointreference_id_idx hazard_pointreference id INDEX
rm -f $DATA_DIR/Hazard*.vrt

# Structure
awk -F ',' '{if ($2 == "Structure") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Structure.vrt
awk -F ',' '{if ($2 == "Structure_linkReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Structure_linkReference.vrt
awk -F ',' '{if ($2 == "Structure_nodeReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Structure_nodeReference.vrt
awk -F ',' '{if ($2 == "Structure_pointReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Structure_pointReference.vrt
gdalPGDump Structure "POINT|27700" structure_id_idx structure id "UNIQUE INDEX"
gdalPGDump Structure_linkReference null structure_linkreference_id_idx structure_linkreference id INDEX
gdalPGDump Structure_linkReference null structure_nodereference_id_idx structure_nodereference id INDEX
gdalPGDump Structure_linkReference null structure_pointreference_id_idx structure_pointreference id INDEX
rm -f $DATA_DIR/Structure*.vrt

# Maintenance
awk -F ',' '{if ($2 == "Maintenance") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Maintenance.vrt
awk -F ',' '{if ($2 == "Maintenance_networkReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Maintenance_networkReference.vrt
# gdalPGDump Maintenance null maintenance_id_idx maintenance id "UNIQUE INDEX"
gdalPGDump Maintenance "GEOMETRY|27700" maintenance_id_idx maintenance id "UNIQUE INDEX"
gdalPGDump Maintenance_networkReference null maintenance_networkReference_id_idx maintenance_networkReference id INDEX
rm -f $DATA_DIR/Maintenance*.vrt

# Reinstatement
awk -F ',' '{if ($2 == "Reinstatement") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Reinstatement.vrt
awk -F ',' '{if ($2 == "Reinstatement_networkReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/Reinstatement_networkReference.vrt
# gdalPGDump Reinstatement null reinstatement_id_idx reinstatement id "UNIQUE INDEX"
gdalPGDump Reinstatement "GEOMETRY|27700" reinstatement_id_idx reinstatement id "UNIQUE INDEX"
gdalPGDump Reinstatement_networkReference null reinstatement_networkReference_id_idx reinstatement_networkReference id INDEX
rm -f $DATA_DIR/Reinstatement*.vrt

# SpecialDesignation
awk -F ',' '{if ($2 == "SpecialDesignation") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_networkReference") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_networkReference.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_namedDate") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_namedDate.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dateRange") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dateRange.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dayPeriod_namedDay") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_namedDay.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dayPeriod_namedPeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_namedPeriod.vrt
awk -F ',' '{if ($2 == "SpecialDesignation_timeInterval_dayPeriod_timePeriod") print $0;}' _lib/schema.txt | awk -v useStringList=1 -f _bin/createVRT.awk > $DATA_DIR/SpecialDesignation_timeInterval_dayPeriod_timePeriod.vrt
# gdalPGDump SpecialDesignation null specialdesignation_id_idx specialdesignation id "UNIQUE INDEX"
gdalPGDump SpecialDesignation "GEOMETRY|27700" specialdesignation_id_idx specialdesignation id "UNIQUE INDEX"
gdalPGDump SpecialDesignation_networkReference null specialdesignation_networkReference_id_idx specialdesignation_networkReference id INDEX
gdalPGDump SpecialDesignation_timeInterval_namedDate null specialdesignation_nameddate_id_idx specialdesignation_timeinterval_nameddate id INDEX
gdalPGDump SpecialDesignation_timeInterval_dateRange null specialdesignation_daterange_id_idx specialdesignation_timeinterval_daterange id INDEX
gdalPGDump SpecialDesignation_timeInterval_dayPeriod_namedDay null specialdesignation_namedday_id_idx specialdesignation_timeinterval_dayperiod_namedday id INDEX
gdalPGDump SpecialDesignation_timeInterval_dayPeriod_namedPeriod null specialdesignation_namedperiod_id_idx specialdesignation_timeinterval_dayperiod_namedperiod id INDEX
gdalPGDump SpecialDesignation_timeInterval_dayPeriod_timePeriod null specialdesignation_timeperiod_id_idx specialdesignation_timeinterval_dayperiod_timeperiod id INDEX
rm -f $DATA_DIR/SpecialDesignation*.vrt

exit
