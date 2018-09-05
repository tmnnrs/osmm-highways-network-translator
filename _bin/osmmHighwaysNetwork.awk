# COMMAND LINE awk -v outdir=<output_directory> -f userDefinedFunctions.awk -f osmmHighwaysNetwork.awk [input]

{
	i = split($0,highwaysStr,"#")

	featureMember = highwaysStr[1]
	id = highwaysStr[2]
	localId = highwaysStr[3]
	beginLifespanVersion = highwaysStr[4]
	validFrom = highwaysStr[5]

	if (featureMember == "featureMember_RoadLink") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,fictitious,roadClassification,routeHierarchy,formOfWay,trunkRoad,primaryRoute,roadClassificationNumber,roadName,alternateName,operationalState,provenance,directionality,length,matchStatus,startNode,startGradeSeparation,endNode,endGradeSeparation,roadStructure,cycleFacility,roadWidthAverage,roadWidthMinimum,roadWidthConfidence,numberOfLanes,elevationGainInDirection,elevationGainInOppositeDirection,reasonForChange,wkt\n") > (outdir "/RoadLink.csv")
			printf("id,identifier,scheme\n") > (outdir "/RoadLink_alternateIdentifier.csv")
			printf("id,identifier,role\n") > (outdir "/RoadLink_formsPartOf.csv")
			printf("id,roadArea\n") > (outdir "/RoadLink_relatedRoadArea.csv")
		}

		fictitious = highwaysStr[6]
		roadClassification = highwaysStr[7]
		routeHierarchy = highwaysStr[8]
		formOfWay = highwaysStr[9]
		trunkRoad = highwaysStr[10]
		primaryRoute = highwaysStr[11]
		roadClassificationNumber = highwaysStr[12]
		roadName = highwaysStr[13]
		alternateName = highwaysStr[14]
		operationalState = highwaysStr[15]
		provenance = highwaysStr[16]
		directionality = highwaysStr[17]
		lnklength = highwaysStr[18]
		matchStatus = highwaysStr[19]
		alternateIdentifier = highwaysStr[20]
		startNode = highwaysStr[21]
		startGradeSeparation = highwaysStr[22]
		endNode = highwaysStr[23]
		endGradeSeparation = highwaysStr[24]
		roadStructure = highwaysStr[25]
		cycleFacility = highwaysStr[26]
		roadWidth_averageWidth = highwaysStr[27]
		roadWidth_minimumWidth = highwaysStr[28]
		roadWidth_confidenceLevel = highwaysStr[29]
		numberOfLanes = highwaysStr[30]
		elevationGain_inDirection = highwaysStr[31]
		elevationGain_inOppositeDirection = highwaysStr[32]
		formsPartOf = highwaysStr[33]
		relatedRoadArea = highwaysStr[34]
		reasonForChange = highwaysStr[35]
		centrelineGeometry = highwaysStr[36]

		roadName = stringList(roadName)
		alternateName = stringList(alternateName)

		wktStr = lineStringToWKT(centrelineGeometry)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(fictitious),
			addQuotes(roadClassification),
			addQuotes(routeHierarchy),
			addQuotes(formOfWay),
			addQuotes(trunkRoad),
			addQuotes(primaryRoute),
			addQuotes(roadClassificationNumber),
			addQuotes(roadName),
			addQuotes(alternateName),
			addQuotes(operationalState),
			addQuotes(provenance),
			addQuotes(directionality),
			lnklength,
			addQuotes(matchStatus),
			addQuotes(startNode),
			startGradeSeparation,
			addQuotes(endNode),
			endGradeSeparation,
			addQuotes(roadStructure),
			addQuotes(cycleFacility),
			roadWidth_averageWidth,
			roadWidth_minimumWidth,
			addQuotes(roadWidth_confidenceLevel),
			addQuotes(numberOfLanes),
			elevationGain_inDirection,
			elevationGain_inOppositeDirection,
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/RoadLink.csv")

		alternateIdentifierHandler("RoadLink")
		formsPartOfHandler("RoadLink")
		relatedRoadAreaHandler("RoadLink")

	} else if (featureMember == "featureMember_RoadNode") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,formOfRoadNode,classification,access,junctionName,junctionNumber,reasonForChange,wkt\n") > (outdir "/RoadNode.csv")
			printf("id,roadArea\n") > (outdir "/RoadNode_relatedRoadArea.csv")
		}

		formOfRoadNode = highwaysStr[6]
		classification = highwaysStr[7]
		access = highwaysStr[8]
		junctionName = highwaysStr[9]
		junctionNumber = highwaysStr[10]
		relatedRoadArea = highwaysStr[11]
		reasonForChange = highwaysStr[12]
		geometry = highwaysStr[13]

		junctionName = stringList(junctionName)
		junctionNumber = stringList(junctionNumber)

		wktStr = pointToWKT(geometry)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(formOfRoadNode),
			addQuotes(classification),
			addQuotes(access),
			addQuotes(junctionName),
			addQuotes(junctionNumber),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/RoadNode.csv")

		relatedRoadAreaHandler("RoadNode")

	} else if (featureMember == "featureMember_Road") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,localRoadCode,nationalRoadCode,roadClassification,designatedName,localName,descriptor,reasonForChange\n") > (outdir "/Road.csv")
			printf("id,link\n") > (outdir "/Road_link.csv")
		}

		localRoadCode = highwaysStr[6]
		nationalRoadCode = highwaysStr[7]
		roadClassification = highwaysStr[8]
		designatedName = highwaysStr[9]
		localName = highwaysStr[10]
		descriptor = highwaysStr[11]
		link = highwaysStr[12]
		reasonForChange = highwaysStr[13]

		designatedName = stringList(designatedName)
		localName = stringList(localName)
		descriptor = stringList(descriptor)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(localRoadCode),
			addQuotes(nationalRoadCode),
			addQuotes(roadClassification),
			addQuotes(designatedName),
			addQuotes(localName),
			addQuotes(descriptor),
			addQuotes(reasonForChange)) > (outdir "/Road.csv")

		linkHandler("Road")

	} else if (featureMember == "featureMember_Street") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,localRoadCode,nationalRoadCode,descriptor,designatedName,localName,roadClassification,streetType,operationalState,locality,town,administrativeArea,responsibleAuthority,geometryProvenance,gssCode,reasonForChange,wkt\n") > (outdir "/Street.csv")
			printf("id,link\n") > (outdir "/Street_link.csv")
		}

		localRoadCode = highwaysStr[6]
		nationalRoadCode = highwaysStr[7]
		designatedName = highwaysStr[8]
		localName = highwaysStr[9]
		descriptor = highwaysStr[10]
		roadClassification = highwaysStr[11]
		streetType = highwaysStr[12]
		operationalState = highwaysStr[13]
		locality = highwaysStr[14]
		town = highwaysStr[15]
		administrativeArea = highwaysStr[16]
		responsibleAuthority = highwaysStr[17]
		geometryProvenance = highwaysStr[18]
		gssCode = highwaysStr[19]
		link = highwaysStr[20]
		reasonForChange = highwaysStr[21]
		geometry = highwaysStr[22]

		designatedName = stringList(designatedName)
		localName = stringList(localName)
		descriptor = stringList(descriptor)
		locality = stringList(locality)
		town = stringList(town)
		administrativeArea = stringList(administrativeArea)

		j = split(geometry,geometryStr,";")
		if (j == 1) {
			wktStr = lineStringToWKT(geometry)
		} else {
			wktStr = multiLineStringToWKT(geometry)
		}

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(localRoadCode),
			addQuotes(nationalRoadCode),
			addQuotes(descriptor),
			addQuotes(designatedName),
			addQuotes(localName),
			addQuotes(roadClassification),
			addQuotes(streetType),
			addQuotes(operationalState),
			addQuotes(locality),
			addQuotes(town),
			addQuotes(administrativeArea),
			addQuotes(responsibleAuthority),
			addQuotes(geometryProvenance),
			addQuotes(gssCode),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/Street.csv")

		linkHandler("Street")

	} else if (featureMember == "featureMember_RoadJunction") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,junctionType,junctionName,roadClassificationNumber,junctionNumber,reasonForChange\n") > (outdir "/RoadJunction.csv")
			printf("id,node\n") > (outdir "/RoadJunction_node.csv")
		}

		junctionType = highwaysStr[6]
		junctionName = highwaysStr[7]
		roadClassificationNumber = highwaysStr[8]
		junctionNumber = highwaysStr[9]
		node = highwaysStr[10]
		reasonForChange = highwaysStr[11]

		junctionName = stringList(junctionName)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(junctionType),
			addQuotes(junctionName),
			addQuotes(roadClassificationNumber),
			addQuotes(junctionNumber),
			addQuotes(reasonForChange)) > (outdir "/RoadJunction.csv")

		nodeHandler("RoadJunction")

	} else if (featureMember == "featureMember_PathLink") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,fictitious,formOfWay,pathName,alternateName,provenance,surfaceType,cycleFacility,matchStatus,length,startNode,startGradeSeparation,endNode,endGradeSeparation,elevationGainInDirection,elevationGainInOppositeDirection,reasonForChange,wkt\n") > (outdir "/PathLink.csv")
			printf("id,identifier,scheme\n") > (outdir "/PathLink_alternateIdentifier.csv")
			printf("id,identifier,role\n") > (outdir "/PathLink_formsPartOf.csv")
			printf("id,roadArea\n") > (outdir "/PathLink_relatedRoadArea.csv")
		}

		fictitious = highwaysStr[6]
		formOfWay = highwaysStr[7]
		pathName = highwaysStr[8]
		alternateName = highwaysStr[9]
		provenance = highwaysStr[10]
		surfaceType = highwaysStr[11]
		cycleFacility = highwaysStr[12]
		matchStatus = highwaysStr[13]
		lnklength = highwaysStr[14]
		alternateIdentifier = highwaysStr[15]
		startNode = highwaysStr[16]
		startGradeSeparation = highwaysStr[17]
		endNode = highwaysStr[18]
		endGradeSeparation = highwaysStr[19]
		elevationGain_inDirection = highwaysStr[20]
		elevationGain_inOppositeDirection = highwaysStr[21]
		formsPartOf = highwaysStr[22]
		relatedRoadArea = highwaysStr[23]
		reasonForChange = highwaysStr[24]
		centrelineGeometry = highwaysStr[25]

		pathName = stringList(pathName)
		alternateName = stringList(alternateName)

		wktStr = lineStringToWKT(centrelineGeometry)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(fictitious),
			addQuotes(formOfWay),
			addQuotes(pathName),
			addQuotes(alternateName),
			addQuotes(provenance),
			addQuotes(surfaceType),
			addQuotes(cycleFacility),
			addQuotes(matchStatus),
			lnklength,
			addQuotes(startNode),
			startGradeSeparation,
			addQuotes(endNode),
			endGradeSeparation,
			elevationGain_inDirection,
			elevationGain_inOppositeDirection,
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/PathLink.csv")

		alternateIdentifierHandler("PathLink")
		formsPartOfHandler("PathLink")
		relatedRoadAreaHandler("PathLink")

	} else if (featureMember == "featureMember_PathNode") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,formOfRoadNode,classification,reasonForChange,wkt\n") > (outdir "/PathNode.csv")
		}

		formOfRoadNode = highwaysStr[6]
		classification = highwaysStr[7]
		reasonForChange = highwaysStr[8]
		geometry = highwaysStr[9]

		wktStr = pointToWKT(geometry)

		printf("%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(formOfRoadNode),
			addQuotes(classification),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/PathNode.csv")

	} else if (featureMember == "featureMember_ConnectingLink") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,fictitious,connectingNode,pathNode,reasonForChange,wkt\n") > (outdir "/ConnectingLink.csv")
		}

		fictitious = highwaysStr[6]
		connectingNode = highwaysStr[7]
		pathNode = highwaysStr[8]
		reasonForChange = highwaysStr[9]
		centrelineGeometry = highwaysStr[10]

		wktStr = lineStringToWKT(centrelineGeometry)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(fictitious),
			addQuotes(connectingNode),
			addQuotes(pathNode),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/ConnectingLink.csv")

	} else if (featureMember == "featureMember_ConnectingNode") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,roadLink,reasonForChange,wkt\n") > (outdir "/ConnectingNode.csv")
		}

		roadLink = highwaysStr[6]
		reasonForChange = highwaysStr[7]
		geometry = highwaysStr[8]

		wktStr = pointToWKT(geometry)

		printf("%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(roadLink),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/ConnectingNode.csv")

	} else if (featureMember == "featureMember_Path") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,pathName,reasonForChange\n") > (outdir "/Path.csv")
			printf("id,link\n") > (outdir "/Path_link.csv")
		}

		pathName = highwaysStr[6]
		link = highwaysStr[7]
		reasonForChange = highwaysStr[8]

		pathName = stringList(pathName)

		printf("%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(pathName),
			addQuotes(reasonForChange)) > (outdir "/Path.csv")

		linkHandler("Path")

	} else if (featureMember == "featureMember_FerryLink") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,fictitious,vehicularFerry,routeOperator,startNode,endNode,reasonForChange,wkt\n") > (outdir "/FerryLink.csv")
		}

		fictitious = highwaysStr[6]
		vehicularFerry = highwaysStr[7]
		routeOperator = highwaysStr[8]
		startNode = highwaysStr[9]
		endNode = highwaysStr[10]
		reasonForChange = highwaysStr[11]
		centrelineGeometry = highwaysStr[12]

		wktStr = lineStringToWKT(centrelineGeometry)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(fictitious),
			addQuotes(vehicularFerry),
			addQuotes(routeOperator),
			addQuotes(startNode),
			addQuotes(endNode),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/FerryLink.csv")

	} else if (featureMember == "featureMember_FerryNode") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,formOfWaterwayNode,reasonForChange,wkt\n") > (outdir "/FerryNode.csv")
		}

		formOfWaterwayNode = highwaysStr[6]
		reasonForChange = highwaysStr[7]
		geometry = highwaysStr[8]

		wktStr = pointToWKT(geometry)

		printf("%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(formOfWaterwayNode),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/FerryNode.csv")

	} else if (featureMember == "featureMember_FerryTerminal") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,type,ferryTerminalName,ferryTerminalCode,refToFunctionalSite,reasonForChange\n") > (outdir "/FerryTerminal.csv")
			printf("id,identifier,role\n") > (outdir "/FerryTerminal_element.csv")
		}

		type = highwaysStr[6]
		ferryTerminalName = highwaysStr[7]
		ferryTerminalCode = highwaysStr[8]
		refToFunctionalSite = highwaysStr[9]
		element = highwaysStr[10]
		reasonForChange = highwaysStr[11]

		ferryTerminalName = stringList(ferryTerminalName)

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(type),
			addQuotes(ferryTerminalName),
			addQuotes(ferryTerminalCode),
			addQuotes(refToFunctionalSite),
			addQuotes(reasonForChange)) > (outdir "/FerryTerminal.csv")

		j = split(element,elementStr,";")
		for (k=1; k<=j; ++k) {
			l = split(elementStr[k],elementStr1,"|")
			identifier = elementStr1[1]
			role = elementStr1[2]
			printf("%s,%s,%s\n",id,identifier,role) > (outdir "/FerryTerminal_element.csv")
		}

	} else if (featureMember == "featureMember_AccessRestriction") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,restriction,trafficSign,reasonForChange,wkt\n") > (outdir "/AccessRestriction.csv")
			printf("id,linkReference,applicableDirection,atPosition,atPositionGeometryX,atPositionGeometryY\n") > (outdir "/AccessRestriction_pointReference.csv")
			printf("id,exceptFor,qualifier,qualifierType\n") > (outdir "/AccessRestriction_vehicleQualifier.csv")
			printf("id,pkey,namedDate\n") > (outdir "/AccessRestriction_timeInterval_namedDate.csv")
			printf("id,pkey,startDate,endDate,startMonthDay,endMonthDay\n") > (outdir "/AccessRestriction_timeInterval_dateRange.csv")
			printf("id,pkey,namedDay\n") > (outdir "/AccessRestriction_timeInterval_dayPeriod_namedDay.csv")
			printf("id,pkey,namedPeriod\n") > (outdir "/AccessRestriction_timeInterval_dayPeriod_namedPeriod.csv")
			printf("id,pkey,namedTime,startTime,endTime\n") > (outdir "/AccessRestriction_timeInterval_dayPeriod_timePeriod.csv")
		}

		pointReference = highwaysStr[6]
		restriction = highwaysStr[7]
		trafficSign = highwaysStr[8]
		inclusion = highwaysStr[9]
		exemption = highwaysStr[10]
		timeInterval = highwaysStr[11]
		reasonForChange = highwaysStr[12]

		wktStr = ""

		pointReferenceHandler("AccessRestriction")

		inclusionHandler("AccessRestriction")
		exemptionHandler("AccessRestriction")

		timeIntervalHandler("AccessRestriction")

		printf("%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(restriction),
			addQuotes(trafficSign),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/AccessRestriction.csv")

	} else if (featureMember == "featureMember_HighwayDedication") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,dedication,publicRightOfWay,nationalCycleRoute,quietRoute,obstruction,planningOrder,worksProhibited,reasonForChange,wkt\n") > (outdir "/HighwayDedication.csv")
			printf("id,networkReference,locationDescription,locationStart,locationEnd\n") > (outdir "/HighwayDedication_networkReference.csv")
			printf("id,pkey,namedDate\n") > (outdir "/HighwayDedication_timeInterval_namedDate.csv")
			printf("id,pkey,startDate,endDate,startMonthDay,endMonthDay\n") > (outdir "/HighwayDedication_timeInterval_dateRange.csv")
			printf("id,pkey,namedDay\n") > (outdir "/HighwayDedication_timeInterval_dayPeriod_namedDay.csv")
			printf("id,pkey,namedPeriod\n") > (outdir "/HighwayDedication_timeInterval_dayPeriod_namedPeriod.csv")
			printf("id,pkey,namedTime,startTime,endTime\n") > (outdir "/HighwayDedication_timeInterval_dayPeriod_timePeriod.csv")
		}

		networkReference = highwaysStr[6]
		dedication = highwaysStr[7]
		timeInterval = highwaysStr[8]
		publicRightOfWay = highwaysStr[9]
		nationalCycleRoute = highwaysStr[10]
		quietRoute = highwaysStr[11]
		obstruction = highwaysStr[12]
		planningOrder = highwaysStr[13]
		worksProhibited = highwaysStr[14]
		reasonForChange = highwaysStr[15]
		geometry = highwaysStr[16]

		wktStr = lineStringToWKT(geometry)

		if (networkReference != "") {
			networkReferenceHandler("HighwayDedication")
		}

		timeIntervalHandler("HighwayDedication")

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(dedication),
			addQuotes(publicRightOfWay),
			addQuotes(nationalCycleRoute),
			addQuotes(quietRoute),
			addQuotes(obstruction),
			addQuotes(planningOrder),
			addQuotes(worksProhibited),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/HighwayDedication.csv")

	} else if (featureMember == "featureMember_TurnRestriction") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,restriction,reasonForChange\n") > (outdir "/TurnRestriction.csv")
			printf("id,linkReference,applicableDirection\n") > (outdir "/TurnRestriction_linkReference.csv")
			printf("id,exceptFor,qualifier,qualifierType\n") > (outdir "/TurnRestriction_vehicleQualifier.csv")
			printf("id,pkey,namedDate\n") > (outdir "/TurnRestriction_timeInterval_namedDate.csv")
			printf("id,pkey,startDate,endDate,startMonthDay,endMonthDay\n") > (outdir "/TurnRestriction_timeInterval_dateRange.csv")
			printf("id,pkey,namedDay\n") > (outdir "/TurnRestriction_timeInterval_dayPeriod_namedDay.csv")
			printf("id,pkey,namedPeriod\n") > (outdir "/TurnRestriction_timeInterval_dayPeriod_namedPeriod.csv")
			printf("id,pkey,namedTime,startTime,endTime\n") > (outdir "/TurnRestriction_timeInterval_dayPeriod_timePeriod.csv")
		}

		linkReference = highwaysStr[6]
		restriction = highwaysStr[7]
		inclusion = highwaysStr[8]
		exemption = highwaysStr[9]
		timeInterval = highwaysStr[10]
		reasonForChange = highwaysStr[11]

		linkReferenceHandler("TurnRestriction")

		inclusionHandler("TurnRestriction")
		exemptionHandler("TurnRestriction")

		timeIntervalHandler("TurnRestriction")

		printf("%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(restriction),
			addQuotes(reasonForChange)) > (outdir "/TurnRestriction.csv")

	} else if (featureMember == "featureMember_RestrictionForVehicles") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,measure,restrictionType,sourceOfMeasure,measure2,structure,trafficSign,trafficRegulationOrder,reasonForChange,wkt\n") > (outdir "/RestrictionForVehicles.csv")
			printf("id,linkReference,applicableDirection,atPosition,atPositionGeometryX,atPositionGeometryY\n") > (outdir "/RestrictionForVehicles_pointReference.csv")
			printf("id,nodeReference,locationX,locationY,linkReference\n") > (outdir "/RestrictionForVehicles_nodeReference.csv")
		}

		pointReference = highwaysStr[6]
		nodeReference = highwaysStr[7]
		measure = highwaysStr[8]
		restrictionType = highwaysStr[9]
		sourceOfMeasure = highwaysStr[10]
		measure2 = highwaysStr[11]
		inclusion = highwaysStr[12]
		exemption = highwaysStr[13]
		structure = highwaysStr[14]
		trafficSign = highwaysStr[15]
		trafficRegulationOrder = highwaysStr[16]
		reasonForChange = highwaysStr[17]

		trafficSign = stringList(trafficSign)

		wktStr = ""

		pointReferenceHandler("RestrictionForVehicles")
		nodeReferenceHandler("RestrictionForVehicles")

		inclusionHandler("RestrictionForVehicles")
		exemptionHandler("RestrictionForVehicles")

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			measure,
			addQuotes(restrictionType),
			addQuotes(sourceOfMeasure),
			measure2,
			addQuotes(structure),
			addQuotes(trafficSign),
			addQuotes(trafficRegulationOrder),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/RestrictionForVehicles.csv")

	} else if (featureMember == "featureMember_Hazard") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,hazard,description,reasonForChange,wkt\n") > (outdir "/Hazard.csv")
			printf("id,linkReference,applicableDirection,atPosition,atPositionGeometryX,atPositionGeometryY\n") > (outdir "/Hazard_pointReference.csv")
			printf("id,linkReference,applicableDirection\n") > (outdir "/Hazard_linkReference.csv")
			printf("id,nodeReference,locationX,locationY,linkReference\n") > (outdir "/Hazard_nodeReference.csv")
		}

		pointReference = highwaysStr[6]
		linkReference = highwaysStr[7]
		nodeReference = highwaysStr[8]
		hazard = highwaysStr[9]
		description = highwaysStr[10]
		reasonForChange = highwaysStr[11]

		wktStr = ""

		pointReferenceHandler("Hazard")
		linkReferenceHandler("Hazard")
		nodeReferenceHandler("Hazard")

		printf("%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(hazard),
			addQuotes(description),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/Hazard.csv")

	} else if (featureMember == "featureMember_Structure") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,structure,description,reasonForChange,wkt\n") > (outdir "/Structure.csv")
			printf("id,linkReference,applicableDirection,atPosition,atPositionGeometryX,atPositionGeometryY\n") > (outdir "/Structure_pointReference.csv")
			printf("id,linkReference,applicableDirection\n") > (outdir "/Structure_linkReference.csv")
			printf("id,nodeReference,locationX,locationY,linkReference\n") > (outdir "/Structure_nodeReference.csv")
		}

		pointReference = highwaysStr[6]
		linkReference = highwaysStr[7]
		nodeReference = highwaysStr[8]
		structure = highwaysStr[9]
		description = highwaysStr[10]
		reasonForChange = highwaysStr[11]

		wktStr = ""

		pointReferenceHandler("Structure")
		linkReferenceHandler("Structure")
		nodeReferenceHandler("Structure")

		printf("%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(structure),
			addQuotes(description),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/Structure.csv")

	} else if (featureMember == "featureMember_Maintenance") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,maintenanceResponsibility,maintenanceAuthority,partialReference,highwayAuthority,reasonForChange,wkt\n") > (outdir "/Maintenance.csv")
			printf("id,networkReference,locationDescription,locationStart,locationEnd\n") > (outdir "/Maintenance_networkReference.csv")
		}

		networkReference = highwaysStr[6]
		networkReferenceLocation = highwaysStr[7]
		maintenanceResponsibility = highwaysStr[8]
		maintenanceAuthority = highwaysStr[9]
		partialReference = highwaysStr[10]
		highwayAuthority = highwaysStr[11]
		reasonForChange = highwaysStr[12]

		wktStr = ""

		if (networkReference != "") {
			networkReferenceHandler("Maintenance")
		} else if (networkReferenceLocation != "") {
			networkReferenceLocationHandler("Maintenance")
		}

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(maintenanceResponsibility),
			addQuotes(maintenanceAuthority),
			addQuotes(partialReference),
			addQuotes(highwayAuthority),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/Maintenance.csv")

	} else if (featureMember == "featureMember_Reinstatement") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,reinstatementType,partialReference,reasonForChange,wkt\n") > (outdir "/Reinstatement.csv")
			printf("id,networkReference,locationDescription,locationStart,locationEnd\n") > (outdir "/Reinstatement_networkReference.csv")
		}

		networkReference = highwaysStr[6]
		networkReferenceLocation = highwaysStr[7]
		reinstatementType = highwaysStr[8]
		partialReference = highwaysStr[9]
		reasonForChange = highwaysStr[10]

		wktStr = ""

		if (networkReference != "") {
			networkReferenceHandler("Reinstatement")
		} else if (networkReferenceLocation != "") {
			networkReferenceLocationHandler("Reinstatement")
		}

		printf("%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			addQuotes(reinstatementType),
			addQuotes(partialReference),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/Reinstatement.csv")

	} else if (featureMember == "featureMember_SpecialDesignation") {
		if (NR == 1) {
			printf("id,localId,beginLifespanVersion,validFrom,validTo,designation,description,contactAuthority,partialReference,reasonForChange,wkt\n") > (outdir "/SpecialDesignation.csv")
			printf("id,networkReference,locationDescription,locationStart,locationEnd\n") > (outdir "/SpecialDesignation_networkReference.csv")
			printf("id,pkey,namedDate\n") > (outdir "/SpecialDesignation_timeInterval_namedDate.csv")
			printf("id,pkey,startDate,endDate,startMonthDay,endMonthDay\n") > (outdir "/SpecialDesignation_timeInterval_dateRange.csv")
			printf("id,pkey,namedDay\n") > (outdir "/SpecialDesignation_timeInterval_dayPeriod_namedDay.csv")
			printf("id,pkey,namedPeriod\n") > (outdir "/SpecialDesignation_timeInterval_dayPeriod_namedPeriod.csv")
			printf("id,pkey,namedTime,startTime,endTime\n") > (outdir "/SpecialDesignation_timeInterval_dayPeriod_timePeriod.csv")
		}

		validTo = highwaysStr[6]
		networkReference = highwaysStr[7]
		networkReferenceLocation = highwaysStr[8]
		designation = highwaysStr[9]
		description = highwaysStr[10]
		timeInterval = highwaysStr[11]
		contactAuthority = highwaysStr[12]
		partialReference = highwaysStr[13]
		reasonForChange = highwaysStr[14]

		wktStr = ""

		if (networkReference != "") {
			networkReferenceHandler("SpecialDesignation")
		} else if (networkReferenceLocation != "") {
			networkReferenceLocationHandler("SpecialDesignation")
		}

		timeIntervalHandler("SpecialDesignation")

		printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",
			addQuotes(id),
			addQuotes(localId),
			beginLifespanVersion,
			validFrom,
			validTo,
			addQuotes(designation),
			addQuotes(description),
			addQuotes(contactAuthority),
			addQuotes(partialReference),
			addQuotes(reasonForChange),
			addQuotes(wktStr)) > (outdir "/SpecialDesignation.csv")

	}
}
