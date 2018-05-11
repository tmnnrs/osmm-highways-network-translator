#!/bin/bash

DATA_DIR='~/Documents/osdata/osmm-highways/_data'

OUT_DIR='~/Documents/osdata/osmm-highways/output'
TMP_DIR='~/Documents/osdata/osmm-highways/tmp'

XSLT_DIR='~/Documents/shared/tools'
JAVA_HEAP_SIZE=2048m

FEATURES=( RoadLink RoadNode Road Street RoadJunction PathLink PathNode ConnectingLink ConnectingNode Path FerryLink FerryNode FerryTerminal AccessRestriction Dedication TurnRestriction RestrictionForVehicles Hazard Structure Maintenance Reinstatement SpecialDesignation ) 

preprocessGML() {
  fbname=$(basename "$1" .gml.gz)
  cp "$1" $TMP_DIR/$fbname.gml.gz
  gzip -d $TMP_DIR/$fbname.gml.gz
  java -Xmx$JAVA_HEAP_SIZE -jar $XSLT_DIR/saxon.jar -versionmsg:off -warnings:silent -o:$TMP_DIR/$fbname.tmp -xsl:_bin/osmmHighwaysNetwork.xsl -s:$TMP_DIR/$fbname.gml
  rm $TMP_DIR/$fbname.gml
}

mkdir -p {$OUT_DIR,$TMP_DIR}

for i in "${FEATURES[@]}"; do
  echo "Processing $i..."
  for j in $DATA_DIR/*_"$i"_*; do preprocessGML $j; done
  cat $TMP_DIR/*_"$i"_*.tmp > $TMP_DIR/$i.out && rm $TMP_DIR/*_"$i"_*.tmp
  awk -v outdir=$OUT_DIR -f _bin/userDefinedFunctions.awk -f _bin/osmmHighwaysNetwork.awk $TMP_DIR/$i.out
  # rm -f $TMP_DIR/$i.out
done

exit
