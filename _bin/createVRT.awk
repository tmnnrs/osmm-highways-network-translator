# COMMAND LINE awk {-v useStringList=1} -f createVRT.awk [input] > [outfile]

NR == 1 {
	i = split($0,vrtStr,",")

	highwaysLayer = vrtStr[1]
	fileName = vrtStr[2]
	geometryType = vrtStr[3]

	printf("<OGRVRTDataSource>\n")
	printf("    <OGRVRTLayer name=%s>\n",addQuotes(fileName))
	printf("        <SrcDataSource relativeToVRT=%s>%s.csv</SrcDataSource>\n",addQuotes("1"),fileName)
	printf("        <GeometryType>%s</GeometryType>\n",geometryType)
	if (geometryType != "wkbNone") {
		printf("        <LayerSRS>EPSG:27700</LayerSRS>\n")
	}
}

NR != 1 {
	i = split($0,vrtStr,",")

	highwaysLayer = vrtStr[1]
	fileName = vrtStr[2]
	fieldName = vrtStr[3]
	fieldType = vrtStr[4]

	if (!useStringList && fieldType ~ /StringList/) {
		fieldType = "String"
	}

	printf("        <Field name=%s type=%s src=%s />\n",addQuotes(fieldName),addQuotes(fieldType),addQuotes(fieldName))
}

END {
	if (geometryType != "wkbNone") {
		printf("        <GeometryField encoding=%s field=%s />\n",addQuotes("WKT"),addQuotes("wkt"))
	}
	printf("    </OGRVRTLayer>\n")
	printf("</OGRVRTDataSource>\n")
}

function addQuotes(str) {
	return "\"" str "\""
}
