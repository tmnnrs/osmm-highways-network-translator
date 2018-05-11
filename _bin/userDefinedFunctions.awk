function pointToWKT(coords) {
	return "POINT (" coords ")"
}

function lineStringToWKT(coords) {
	wktStr = "LINESTRING ("
	j = split(coords,coordsStr,",")
	dim = coordsStr[1]
	count = coordsStr[2]
	geom = coordsStr[3]
	j = split(geom,xyStr," ")
	if (dim == 2) {
		for (k=1; k<=j-1; k+=2) {
			wktStr = wktStr xyStr[k] " " xyStr[k+1] ","
		}
	} else {
		for (k=1; k<=j-1; k+=3) {
			wktStr = wktStr xyStr[k] " " xyStr[k+1] " " xyStr[k+2] ","
		}
	}
	lenStr = length(wktStr)-1
	wktStr = substr(wktStr,1,lenStr)
	wktStr = wktStr ")"
	return wktStr
}

function polygonToWKT(coords) {
	wktStr = "POLYGON (("
	j = split(coords,coordsStr,",")
	dim = coordsStr[1]
	count = coordsStr[2]
	geom = coordsStr[3]
	j = split(geom,xyStr," ")
	if (dim == 2) {
		for (k=1; k<=j-1; k+=2) {
			wktStr = wktStr xyStr[k] " " xyStr[k+1] ","
		}
	} else {
		for (k=1; k<=j-1; k+=3) {
			wktStr = wktStr xyStr[k] " " xyStr[k+1] " " xyStr[k+2] ","
		}
	}
	lenStr = length(wktStr)-1
	wktStr = substr(wktStr,1,lenStr)
	wktStr = wktStr "))"
	return wktStr
}

function multiPointToWKT(coords) {
	j = split(coords,coordsStr,",")
	return "MULTIPOINT ((" coordsStr[1] "),(" coordsStr[2] "))"
}

function multiLineStringToWKT(coords) {
	wktStr = "MULTILINESTRING ("
	j = split(coords,lineStr,";")
	for (k=1; k<=j-1; ++k) {
		l = split(lineStr[k],coordsStr,",")
		dim = coordsStr[1]
		count = coordsStr[2]
		geom = coordsStr[3]
		l = split(geom,xyStr," ")
		wktStr = wktStr "("
		if (dim == 2) {
			for (m=1; m<=l-1; m+=2) {
				wktStr = wktStr xyStr[m] " " xyStr[m+1] ","
			}
		} else {
			for (m=1; m<=l-1; m+=3) {
				wktStr = wktStr xyStr[m] " " xyStr[m+1] " " xyStr[m+2] ","
			}
		}
		lenStr = length(wktStr)-1
		wktStr = substr(wktStr,1,lenStr)
		wktStr = wktStr "),"
	}
	lenStr = length(wktStr)-1
	wktStr = substr(wktStr,1,lenStr)
	wktStr = wktStr ")"
	return wktStr
}

function alternateIdentifierHandler(filename) {
	j = split(alternateIdentifier,alternateIdentifierStr,";")
	for (k=1; k<=j; ++k) {
		l = split(alternateIdentifierStr[k],alternateIdentifierStr1,"|")
		identifier = alternateIdentifierStr1[1]
		scheme = alternateIdentifierStr1[2]
		printf("%s,%s,%s\n",
			addQuotes(id),
			addQuotes(identifier),
			addQuotes(scheme)) > (outdir "/" filename "_alternateIdentifier.csv")
	}
}

function formsPartOfHandler(filename) {
	j = split(formsPartOf,formsPartOfStr,";")
	for (k=1; k<=j; ++k) {
		l = split(formsPartOfStr[k],formsPartOfStr1,"|")
		identifier = formsPartOfStr1[1]
		role = formsPartOfStr1[2]
		printf("%s,%s,%s\n",
			addQuotes(id),
			addQuotes(identifier),
			addQuotes(role)) > (outdir "/" filename "_formsPartOf.csv")
	}
}

function relatedRoadAreaHandler(filename) {
	j = split(relatedRoadArea,relatedRoadAreaStr,";")
	for (k=1; k<=j; ++k) {
		printf("%s,%s\n",
			addQuotes(id),
			addQuotes(relatedRoadAreaStr[k])) > (outdir "/" filename "_relatedRoadArea.csv")
	}
}

function linkHandler(filename) {
	j = split(link,linkStr,";")
	for (k=1; k<=j; ++k) {
		printf("%s,%s\n",
			addQuotes(id),
			addQuotes(linkStr[k])) > (outdir "/" filename "_link.csv")
	}
}

function nodeHandler(filename) {
	j = split(node,nodeStr,";")
	for (k=1; k<=j; ++k) {
		printf("%s,%s\n",
			addQuotes(id),
			addQuotes(nodeStr[k])) > (outdir "/" filename "_node.csv")
	}
}

function networkReferenceHandler(filename) {
	j = split(networkReference,networkReferenceStr,";")
	for (k=1; k<=j; ++k) {
		printf("%s,%s,,,\n",
			addQuotes(id),
			addQuotes(networkReferenceStr[k])) > (outdir "/" filename "_networkReference.csv")
	}
}

function networkReferenceLocationHandler(filename) {
	j = split(networkReferenceLocation,networkReferenceLocationStr,"|")
	netRef = networkReferenceLocationStr[1]
	locationDescription = networkReferenceLocationStr[2]
	locationStart = networkReferenceLocationStr[3]
	locationEnd = networkReferenceLocationStr[4]
	locationLine = networkReferenceLocationStr[5]
	locationArea = networkReferenceLocationStr[6]
	printf("%s,%s,%s,%s,%s\n",
		addQuotes(id),
		addQuotes(netRef),
		addQuotes(locationDescription),
		addQuotes(locationStart),
		addQuotes(locationEnd)) > (outdir "/" filename "_networkReference.csv")
	if (locationStart != "" && locationEnd != "") { wktStr = multiPointToWKT(locationStart "," locationEnd) }
	if (locationLine != "") { wktStr = lineStringToWKT(locationLine) }
	if (locationArea != "") { wktStr = polygonToWKT(locationArea) }
}

function nodeReferenceHandler(filename) {
	if (nodeReference != "") {
		j = split(nodeReference,nodeReferenceStr,"|")
		nodeRef = nodeReferenceStr[1]
		location = nodeReferenceStr[2]
		linkReference = nodeReferenceStr[3]
		j = split(location,locationStr," ")
		locationX = locationStr[1]
		locationY = locationStr[2]
		printf("%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(nodeRef),
			locationX,
			locationY,
			addQuotes(linkReference)) > (outdir "/" filename "_nodeReference.csv")
	}
}

function linkReferenceHandler(filename) {
	if (linkReference != "") {
		j = split(linkReference,linkReferenceStr,";")
		for (k=1; k<=j; ++k) {
			l = split(linkReferenceStr[k],linkReferenceStr1,"|")
			element = linkReferenceStr1[1]
			applicableDirection = linkReferenceStr1[2]
			printf("%s,%s,%s\n",
				addQuotes(id),
				addQuotes(element),
				addQuotes(applicableDirection)) > (outdir "/" filename "_linkReference.csv")
		}
	}
}

function pointReferenceHandler(filename) {
	if (pointReference != "") {
		j = split(pointReference,pointReferenceStr,"|")
		element = pointReferenceStr[1]
		applicableDirection = pointReferenceStr[2]
		atPosition = pointReferenceStr[3]
		atPositionGeometry = pointReferenceStr[4]
		j = split(atPositionGeometry,atPositionGeometryStr," ")
		atPositionGeometryX = atPositionGeometryStr[1]
		atPositionGeometryY = atPositionGeometryStr[2]
		printf("%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(element),
			addQuotes(applicableDirection),
			atPosition,
			atPositionGeometryX,
			atPositionGeometryY) > (outdir "/" filename "_pointReference.csv")
		wktStr = pointToWKT(atPositionGeometry)
	}
}

function inclusionHandler(filename) {
	j = split(inclusion,inclusionStr,";")
	for (k=1; k<=j-1; ++k) {
		l = split(inclusionStr[k],inclusionStr1,"|")
		exceptFor = "true"
		qualifier = inclusionStr1[1]
		qualifierType = inclusionStr1[2]
		printf("%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(exceptFor),
			addQuotes(qualifier),
			addQuotes(qualifierType)) > (outdir "/" filename "_vehicleQualifier.csv")
	}
}

function exemptionHandler(filename) {
	j = split(exemption,exemptionStr,";")
	for (k=1; k<=j-1; ++k) {
		l = split(exemptionStr[k],exemptionStr1,"|")
		exceptFor = "false"
		qualifier = exemptionStr1[1]
		qualifierType = exemptionStr1[2]
		printf("%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(exceptFor),
			addQuotes(qualifier),
			addQuotes(qualifierType)) > (outdir "/" filename "_vehicleQualifier.csv")
	}
}

function timeIntervalHandler(filename) {
	j = split(timeInterval,timeIntervalStr,";")
	for (k=1; k<=j; ++k) {
		pkey = k
		l = split(timeIntervalStr[k],timeIntervalStr1,"@")
		namedDate = timeIntervalStr1[1]
		dateRange = timeIntervalStr1[2]
		dayPeriod = timeIntervalStr1[3]
		if (namedDate != "") {
			l = split(namedDate,namedDateStr,",")
			for (m=1; m<=l; ++m) {
				printf("%s,%s,%s\n",
					addQuotes(id),
					pkey,
					addQuotes(namedDateStr[m])) > (outdir "/" filename "_timeInterval_namedDate.csv")
			}
		}
		if (dateRange != "") {
			l = split(dateRange,dateRangeStr,",")
			for (m=1; m<=l; ++m) {
				n = split(dateRangeStr[m],dateRangeStr1,"|")
				startDate = dateRangeStr1[1]
				endDate = dateRangeStr1[2]
				startMonthDay = dateRangeStr1[3]
				endMonthDay = dateRangeStr1[4]
				printf("%s,%s,%s,%s,%s,%s\n",
					addQuotes(id),
					pkey,
					startDate,
					endDate,
					startMonthDay,
					endMonthDay) > (outdir "/" filename "_timeInterval_dateRange.csv")
			}
		}
		if (dayPeriod != "") {
			l = split(dayPeriod,dayPeriodStr,",")
			for (m=1; m<=l; ++m) {
				n = split(dayPeriodStr[m],dayPeriodStr1,"|")
				namedDay = dayPeriodStr1[1]
				namedPeriod = dayPeriodStr1[2]
				timePeriod = dayPeriodStr1[3]
				n = split(namedDay,namedDayStr,"%")
				for (o=1; o<=n; ++o) {
					printf("%s,%s,%s\n",
						addQuotes(id),
						pkey,
						addQuotes(namedDayStr[o])) > (outdir "/" filename "_timeInterval_dayPeriod_namedDay.csv")
				}
				n = split(namedPeriod,namedPeriodStr,"%")
				for (o=1; o<=n; ++o) {
					printf("%s,%s,%s\n",
						addQuotes(id),
						pkey,
						addQuotes(namedPeriodStr[o])) > (outdir "/" filename "_timeInterval_dayPeriod_namedPeriod.csv")
				}
				n = split(timePeriod,timePeriodStr,"%")
				for (o=1; o<=n; ++o) {
					p = split(timePeriodStr[o],timePeriodStr1,"?")
					namedTime = timePeriodStr1[1]
					timeRange = timePeriodStr1[2]
					q = split(namedTime,namedTimeStr,"*")
					for (r=1; r<=q; ++r) {
						printf("%s,%s,%s,,\n",
							addQuotes(id),
							pkey,
							addQuotes(namedTime)) > (outdir "/" filename "_timeInterval_dayPeriod_timePeriod.csv")
					}
					q = split(timeRange,timeRangeStr,"*")
					for (r=1; r<=q; ++r) {
						s = split(timeRangeStr[r],timeRangeStr1,"-")
						startTime = timeRangeStr1[1]
						endTime = timeRangeStr1[2]
						printf("%s,%s,,%s,%s\n",
							addQuotes(id),
							pkey,
							addQuotes(startTime),
							addQuotes(endTime)) > (outdir "/" filename "_timeInterval_dayPeriod_timePeriod.csv")
					}
				}
			}
		}
	}
}

function stringList(str) {
	# gsub("[|]",",",str)
	gsub(";",",",str)
	return "(" split(str,a,",") ":" str ")"
}

function addQuotes(str) {
	return "\"" str "\""
}
