<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:ad="http://inspire.ec.europa.eu/schemas/ad/4.0"
  xmlns:am="http://inspire.ec.europa.eu/schemas/am/4.0"
  xmlns:au="http://inspire.ec.europa.eu/schemas/au/4.0"
  xmlns:base="http://inspire.ec.europa.eu/schemas/base/3.3"
  xmlns:base2="http://inspire.ec.europa.eu/schemas/base2/2.0"
  xmlns:bu-base="http://inspire.ec.europa.eu/schemas/bu-base/4.0"
  xmlns:cp="http://inspire.ec.europa.eu/schemas/cp/4.0"
  xmlns:dedication="http://namespaces.os.uk/mastermap/highwayDedication/1.0"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gml="http://www.opengis.net/gml/3.2"
  xmlns:gmlexr="http://www.opengis.net/gml/3.3/exr"
  xmlns:gmlxbt="http://www.opengis.net/gml/3.3/xbt"
  xmlns:gn="http://inspire.ec.europa.eu/schemas/gn/4.0"
  xmlns:gsr="http://www.isotc211.org/2005/gsr"
  xmlns:gss="http://www.isotc211.org/2005/gss"
  xmlns:gts="http://www.isotc211.org/2005/gts"
  xmlns:highway="http://namespaces.os.uk/mastermap/highwayNetwork/2.0"
  xmlns:hwtn="http://namespaces.os.uk/mastermap/highwaysWaterTransportNetwork/1.0"
  gml:id="OS_HIGHWAYS"
  xmlns:net="http://inspire.ec.europa.eu/schemas/net/4.0"
  xmlns:network="http://namespaces.os.uk/mastermap/generalNetwork/2.0"
  xmlns:os="http://namespaces.os.uk/product/1.0"
  xmlns:ram="http://namespaces.os.uk/mastermap/routingAndAssetManagement/2.1"
  xmlns:sc="http://www.interactive-instruments.de/ShapeChange/AppInfo"
  xsi:schemaLocation="http://namespaces.os.uk/mastermap/highwaysWaterTransportNetwork/1.0 
  https://www.ordnancesurvey.co.uk/xml/schema/highwaysnetwork/1.0/HighwaysWaterTransportNetwork.xsd 
  http://namespaces.os.uk/mastermap/highwayNetwork/2.0 
  https://www.ordnancesurvey.co.uk/xml/schema/highwaysnetwork/2.0/LinearHighwayNetwork.xsd 
  http://namespaces.os.uk/product/1.0 
  https://www.ordnancesurvey.co.uk/xml/schema/product/1.0/OSProduct.xsd 
  http://namespaces.os.uk/mastermap/generalNetwork/2.0 
  https://www.ordnancesurvey.co.uk/xml/schema/network/2.0/generalNetwork.xsd 
  http://namespaces.os.uk/mastermap/routingAndAssetManagement/2.1 
  https://www.ordnancesurvey.co.uk/xml/schema/highwaysnetwork/2.1/RoutingAndAssetManagement.xsd 
  http://namespaces.os.uk/mastermap/highwayDedication/1.0 
  https://www.ordnancesurvey.co.uk/xml/schema/highwaysnetwork/1.0/HighwayDedication.xsd"
  xmlns:stat="urn:x-inspire:specification:gmlas:StatisticalUnits:0.0"
  xmlns:su-core="http://inspire.ec.europa.eu/schemas/su-core/4.0"
  xmlns:tn="http://inspire.ec.europa.eu/schemas/tn/4.0"
  xmlns:tn-ro="http://inspire.ec.europa.eu/schemas/tn-ro/4.0"
  xmlns:tn-w="http://inspire.ec.europa.eu/schemas/tn-w/4.0"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

	<xsl:output method="text" encoding="UTF-8"/>

	<xsl:template name="replace-string">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="with"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$with"/>
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="with" select="$with"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="/">
		<xsl:for-each select="os:FeatureCollection">
			<xsl:apply-templates select=".">
				<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="os:FeatureCollection">
		<xsl:for-each select="os:featureMember">
			<xsl:apply-templates select=".">
				<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="os:featureMember">
		<xsl:param name="position"> </xsl:param>
		<xsl:variable name="HighwayDedication_id"><xsl:value-of select="dedication:HighwayDedication/@gml:id"/></xsl:variable>
		<xsl:variable name="RoadLink_id"><xsl:value-of select="highway:RoadLink/@gml:id"/></xsl:variable>
		<xsl:variable name="RoadNode_id"><xsl:value-of select="highway:RoadNode/@gml:id"/></xsl:variable>
		<xsl:variable name="Road_id"><xsl:value-of select="highway:Road/@gml:id"/></xsl:variable>
		<xsl:variable name="Street_id"><xsl:value-of select="highway:Street/@gml:id"/></xsl:variable>
		<xsl:variable name="RoadJunction_id"><xsl:value-of select="highway:RoadJunction/@gml:id"/></xsl:variable>
		<xsl:variable name="PathLink_id"><xsl:value-of select="highway:PathLink/@gml:id"/></xsl:variable>
		<xsl:variable name="PathNode_id"><xsl:value-of select="highway:PathNode/@gml:id"/></xsl:variable>
		<xsl:variable name="ConnectingLink_id"><xsl:value-of select="highway:ConnectingLink/@gml:id"/></xsl:variable>
		<xsl:variable name="ConnectingNode_id"><xsl:value-of select="highway:ConnectingNode/@gml:id"/></xsl:variable>
		<xsl:variable name="Path_id"><xsl:value-of select="highway:Path/@gml:id"/></xsl:variable>
		<xsl:variable name="FerryLink_id"><xsl:value-of select="hwtn:FerryLink/@gml:id"/></xsl:variable>
		<xsl:variable name="FerryNode_id"><xsl:value-of select="hwtn:FerryNode/@gml:id"/></xsl:variable>
		<xsl:variable name="FerryTerminal_id"><xsl:value-of select="hwtn:FerryTerminal/@gml:id"/></xsl:variable>
		<xsl:variable name="AccessRestriction_id"><xsl:value-of select="ram:AccessRestriction/@gml:id"/></xsl:variable>
		<xsl:variable name="TurnRestriction_id"><xsl:value-of select="ram:TurnRestriction/@gml:id"/></xsl:variable>
		<xsl:variable name="RestrictionForVehicles_id"><xsl:value-of select="ram:RestrictionForVehicles/@gml:id"/></xsl:variable>
		<xsl:variable name="Hazard_id"><xsl:value-of select="ram:Hazard/@gml:id"/></xsl:variable>
		<xsl:variable name="Structure_id"><xsl:value-of select="ram:Structure/@gml:id"/></xsl:variable>
		<xsl:variable name="Maintenance_id"><xsl:value-of select="ram:Maintenance/@gml:id"/></xsl:variable>
		<xsl:variable name="Reinstatement_id"><xsl:value-of select="ram:Reinstatement/@gml:id"/></xsl:variable>
		<xsl:variable name="SpecialDesignation_id"><xsl:value-of select="ram:SpecialDesignation/@gml:id"/></xsl:variable>

		<xsl:variable name="dedication_dedication"><xsl:value-of select="*/dedication:dedication"/></xsl:variable>
		<xsl:variable name="dedication_geometry">
			<xsl:value-of select="*/dedication:geometry/gml:LineString/gml:posList/@srsDimension"/>
			<xsl:text>,</xsl:text>
			<xsl:value-of select="*/dedication:geometry/gml:LineString/gml:posList/@count"/>
			<xsl:text>,</xsl:text>
			<xsl:value-of select="*/dedication:geometry/gml:LineString/gml:posList"/>
		</xsl:variable>
		<xsl:variable name="dedication_nationalCycleRoute"><xsl:value-of select="*/dedication:nationalCycleRoute"/></xsl:variable>
		<xsl:variable name="dedication_obstruction"><xsl:value-of select="*/dedication:obstruction"/></xsl:variable>
		<xsl:variable name="dedication_planningOrder"><xsl:value-of select="*/dedication:planningOrder"/></xsl:variable>
		<xsl:variable name="dedication_publicRightOfWay"><xsl:value-of select="*/dedication:publicRightOfWay"/></xsl:variable>
		<xsl:variable name="dedication_quietRoute"><xsl:value-of select="*/dedication:quietRoute"/></xsl:variable>
		<xsl:variable name="dedication_reasonForChange"><xsl:value-of select="*/dedication:reasonForChange"/></xsl:variable>
		<xsl:variable name="dedication_worksProhibited"><xsl:value-of select="*/dedication:worksProhibited"/></xsl:variable>

		<!-- <xsl:variable name="highway_access"><xsl:value-of select="*/highway:access"/></xsl:variable> -->
		<xsl:variable name="highway_administrativeArea">
			<xsl:for-each select="*/highway:administrativeArea">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_alternateIdentifier">
			<xsl:for-each select="*/highway:alternateIdentifier/base2:ThematicIdentifier">
				<xsl:value-of select="base2:identifier"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="base2:identifierScheme"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_alternateName">
			<xsl:for-each select="*/highway:alternateName">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_classification"><xsl:value-of select="*/highway:classification"/></xsl:variable>
		<xsl:variable name="highway_connectingNode"><xsl:value-of select="substring-after(*/highway:connectingNode/@xlink:href,'#')"/></xsl:variable>
		<xsl:variable name="highway_contactAuthority">
			<xsl:for-each select="*/ram:contactAuthority/highway:ResponsibleAuthority">
				<xsl:value-of select="highway:identifier"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:authorityName"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_cycleFacility">
			<xsl:for-each select="*/highway:cycleFacility/highway:CycleFacility">
				<xsl:value-of select="highway:cycleFacility"/>
				<xsl:choose>
					<xsl:when test="not(highway:wholeLink/@xsl:nil='true')">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="highway:wholeLink"/>
						<xsl:text>)</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> (unknown)</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_descriptor">
			<xsl:for-each select="*/highway:descriptor">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_designatedName">
			<xsl:for-each select="*/highway:designatedName/highway:DesignatedNameType">
				<xsl:value-of select="highway:name"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:namingAuthority/highway:ResponsibleAuthority/highway:identifier"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:namingAuthority/highway:ResponsibleAuthority/highway:authorityName"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_directionality"><xsl:value-of select="*/highway:directionality/@xlink:title"/></xsl:variable>
		<xsl:variable name="highway_elevationGain_inDirection"><xsl:value-of select="*/highway:elevationGain/highway:ElevationGainType/highway:inDirection"/></xsl:variable>
		<xsl:variable name="highway_elevationGain_inOppositeDirection"><xsl:value-of select="*/highway:elevationGain/highway:ElevationGainType/highway:inOppositeDirection"/></xsl:variable>
		<xsl:variable name="highway_endGradeSeparation"><xsl:value-of select="*/highway:endGradeSeparation"/></xsl:variable>
		<xsl:variable name="highway_fictitious"><xsl:value-of select="*/highway:fictitious"/></xsl:variable>
		<xsl:variable name="highway_formOfWay"><xsl:value-of select="*/highway:formOfWay"/></xsl:variable>
		<xsl:variable name="highway_formsPartOf">
			<xsl:for-each select="*/highway:formsPartOf">
				<xsl:value-of select="substring-after(@xlink:href,'#')"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="@xlink:role"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_geometryLineString">
			<xsl:value-of select="*/highway:geometry/gml:LineString/gml:posList/@srsDimension"/>
			<xsl:text>,</xsl:text>
			<xsl:value-of select="*/highway:geometry/gml:LineString/gml:posList/@count"/>
			<xsl:text>,</xsl:text>
			<xsl:value-of select="*/highway:geometry/gml:LineString/gml:posList"/>
		</xsl:variable>
		<xsl:variable name="highway_geometryMultiCurve">
			<xsl:for-each select="*/highway:geometry/gml:MultiCurve/gml:curveMember">
				<xsl:value-of select="gml:LineString/gml:posList/@srsDimension"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="gml:LineString/gml:posList/@count"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="gml:LineString/gml:posList"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_geometryPoint"><xsl:value-of select="*/highway:geometry/gml:Point/gml:pos"/></xsl:variable>
		<xsl:variable name="highway_geometryProvenance"><xsl:value-of select="*/highway:geometryProvenance"/></xsl:variable>
		<xsl:variable name="highway_gssCode">
			<xsl:for-each select="*/highway:gssCode">
				<xsl:value-of select="substring-after(@xlink:href,'#')"/>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="@xlink:role"/>
				<xsl:text>)</xsl:text>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_junctionName">
			<xsl:for-each select="*/highway:junctionName">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_junctionNumber">
			<xsl:for-each select="*/highway:junctionNumber">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_junctionType"><xsl:value-of select="*/highway:junctionType"/></xsl:variable>
		<xsl:variable name="highway_length"><xsl:value-of select="*/highway:length"/></xsl:variable>
		<xsl:variable name="highway_locality">
			<xsl:for-each select="*/highway:locality">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_localName">
			<xsl:for-each select="*/highway:localName">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_matchStatus"><xsl:value-of select="*/highway:matchStatus"/></xsl:variable>
		<xsl:variable name="highway_node">
			<xsl:for-each select="*/highway:node">
				<xsl:value-of select="substring-after(@xlink:href,'#')"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<!--
		<xsl:variable name="highway_numberOfLanes">
			<xsl:for-each select="*/highway:numberOfLanes">
				<xsl:value-of select="highway:numberOfLanes"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:directionality"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:minMaxNumberOfLanes"/>
			</xsl:for-each>
		</xsl:variable>
		-->
		<xsl:variable name="highway_operationalState"><xsl:value-of select="*/highway:operationalState"/></xsl:variable>
		<xsl:variable name="highway_operationalStateType">
			<xsl:for-each select="*/highway:operationalState/highway:OperationalStateType">
				<xsl:value-of select="highway:state"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:validTime/gml:TimePeriod/gml:beginPosition"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="highway:validTime/gml:TimePeriod/gml:endPosition"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:reason"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_pathName">
			<xsl:for-each select="*/highway:pathName">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_pathNode"><xsl:value-of select="substring-after(*/highway:pathNode/@xlink:href,'#')"/></xsl:variable>
		<xsl:variable name="highway_primaryRoute"><xsl:value-of select="*/highway:primaryRoute"/></xsl:variable>
		<xsl:variable name="highway_provenance"><xsl:value-of select="*/highway:provenance"/></xsl:variable>
		<xsl:variable name="highway_reasonForChange"><xsl:value-of select="*/highway:reasonForChange"/></xsl:variable>
		<xsl:variable name="highway_relatedRoadArea">
			<xsl:for-each select="*/highway:relatedRoadArea">
				<xsl:value-of select="substring-after(@xlink:href,'#')"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_responsibleAuthority">
			<xsl:for-each select="*/highway:responsibleAuthority/highway:ResponsibleAuthority">
				<xsl:value-of select="highway:identifier"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:authorityName"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_roadClassification"><xsl:value-of select="*/highway:roadClassification"/></xsl:variable>
		<xsl:variable name="highway_roadClassificationNumber"><xsl:value-of select="*/highway:roadClassificationNumber"/></xsl:variable>
		<xsl:variable name="highway_roadLink"><xsl:value-of select="substring-after(*/highway:roadLink/@xlink:href,'#')"/></xsl:variable>
		<xsl:variable name="highway_roadName">
			<xsl:for-each select="*/highway:roadName">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_roadStructure"><xsl:value-of select="*/highway:roadStructure"/></xsl:variable>
		<xsl:variable name="highway_roadWidth_averageWidth"><xsl:value-of select="*/highway:roadWidth/highway:RoadWidthType/highway:averageWidth"/></xsl:variable>
		<xsl:variable name="highway_roadWidth_minimumWidth"><xsl:value-of select="*/highway:roadWidth/highway:RoadWidthType/highway:minimumWidth"/></xsl:variable>
		<xsl:variable name="highway_roadWidth_confidenceLevel"><xsl:value-of select="*/highway:roadWidth/highway:RoadWidthType/highway:confidenceLevel"/></xsl:variable>
		<xsl:variable name="highway_routeHierarchy"><xsl:value-of select="*/highway:routeHierarchy"/></xsl:variable>
		<xsl:variable name="highway_startGradeSeparation"><xsl:value-of select="*/highway:startGradeSeparation"/></xsl:variable>
		<xsl:variable name="highway_streetType"><xsl:value-of select="*/highway:streetType"/></xsl:variable>
		<xsl:variable name="highway_surfaceType"><xsl:value-of select="*/highway:surfaceType"/></xsl:variable>
		<xsl:variable name="highway_town">
			<xsl:for-each select="*/highway:town">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="highway_trunkRoad"><xsl:value-of select="*/highway:trunkRoad"/></xsl:variable>

		<xsl:variable name="hwtn_ferryTerminalCode"><xsl:value-of select="*/hwtn:ferryTerminalCode"/></xsl:variable>
		<xsl:variable name="hwtn_ferryTerminalName">
			<xsl:for-each select="*/hwtn:ferryTerminalName">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:choose>
					<xsl:when test="@xml:lang">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@xml:lang"/>
						<xsl:text>]</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="hwtn_reasonForChange"><xsl:value-of select="*/hwtn:reasonForChange"/></xsl:variable>
		<xsl:variable name="hwtn_refToFunctionalSite"><xsl:value-of select="substring-after(*/hwtn:refToFunctionalSite/@xlink:href,'#')"/></xsl:variable>
		<xsl:variable name="hwtn_routeOperator"><xsl:value-of select="*/hwtn:routeOperator"/></xsl:variable>
		<xsl:variable name="hwtn_vehicularFerry"><xsl:value-of select="*/hwtn:vehicularFerry"/></xsl:variable>

		<xsl:variable name="net_beginLifespanVersion"><xsl:value-of select="*/net:beginLifespanVersion"/></xsl:variable>
		<xsl:variable name="net_centrelineGeometry">
			<xsl:value-of select="*/net:centrelineGeometry/gml:LineString/gml:posList/@srsDimension"/>
			<xsl:text>,</xsl:text>
			<xsl:value-of select="*/net:centrelineGeometry/gml:LineString/gml:posList/@count"/>
			<xsl:text>,</xsl:text>
			<xsl:value-of select="*/net:centrelineGeometry/gml:LineString/gml:posList"/>
		</xsl:variable>
		<xsl:variable name="net_element">
			<xsl:for-each select="*/net:element">
				<xsl:value-of select="substring-after(@xlink:href,'#')"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="@xlink:role"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="net_endNode"><xsl:value-of select="substring-after(*/net:endNode/@xlink:href,'#')"/></xsl:variable>
		<xsl:variable name="net_fictitious"><xsl:value-of select="*/net:fictitious"/></xsl:variable>
		<xsl:variable name="net_geometryPoint"><xsl:value-of select="*/net:geometry/gml:Point/gml:pos"/></xsl:variable>
		<xsl:variable name="net_link">
			<xsl:for-each select="*/net:link">
				<xsl:value-of select="substring-after(@xlink:href,'#')"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="net_linkReference">
			<xsl:for-each select="*/net:networkRef/net:LinkReference">
				<xsl:value-of select="substring-after(net:element/@xlink:href,'#')"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="net:applicableDirection/@xlink:title"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="net_localId"><xsl:value-of select="*/net:inspireId/base:Identifier/base:localId"/></xsl:variable>
		<xsl:variable name="net_networkReference">
			<xsl:for-each select="*/net:networkRef/net:NetworkReference">
				<xsl:value-of select="substring-after(net:element/@xlink:href,'#')"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="net_networkReferenceLocation">
			<xsl:value-of select="substring-after(*/net:networkRef/ram:NetworkReferenceLocation/net:element/@xlink:href,'#')"/>
			<xsl:text>|</xsl:text>
			<!-- <xsl:value-of select="*/net:networkRef/ram:NetworkReferenceLocation/ram:locationDescription"/> -->
			<xsl:variable name="ram_locationDescription">
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="*/net:networkRef/ram:NetworkReferenceLocation/ram:locationDescription"/>
					<xsl:with-param name="replace" select="'&#09;'"/>
					<xsl:with-param name="with" select="' '"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$ram_locationDescription"/>
			<xsl:text>|</xsl:text>
			<xsl:value-of select="*/net:networkRef/ram:NetworkReferenceLocation/ram:locationStart/gml:Point/gml:pos"/>
			<xsl:text>|</xsl:text>
			<xsl:value-of select="*/net:networkRef/ram:NetworkReferenceLocation/ram:locationEnd/gml:Point/gml:pos"/>
			<xsl:text>|</xsl:text>
			<xsl:for-each select="*/net:networkRef/ram:NetworkReferenceLocation/ram:locationLine/gml:MultiCurve/gml:curveMember[1]">
				<xsl:value-of select="gml:LineString/gml:posList/@srsDimension"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="gml:LineString/gml:posList/@count"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="gml:LineString/gml:posList"/>
			</xsl:for-each>
			<xsl:text>|</xsl:text>
			<xsl:for-each select="*/net:networkRef/ram:NetworkReferenceLocation/ram:locationArea/gml:MultiSurface/gml:surfaceMember[1]">
				<xsl:value-of select="gml:Polygon/gml:exterior/gml:LinearRing/gml:posList/@srsDimension"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="gml:Polygon/gml:exterior/gml:LinearRing/gml:posList/@count"/>
				<xsl:text>,</xsl:text>
				<xsl:value-of select="gml:Polygon/gml:exterior/gml:LinearRing/gml:posList"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="net_nodeReference">
			<xsl:for-each select="*/net:networkRef/ram:NodeReference">
				<xsl:value-of select="substring-after(net:element/@xlink:href,'#')"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="ram:location/gml:Point/gml:pos"/>
				<xsl:text>|</xsl:text>
				<xsl:for-each select="ram:linkReference">
					<xsl:value-of select="substring-after(@xlink:href,'#')"/>
					<xsl:if test="not(position()=last())">,</xsl:if>
				</xsl:for-each>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="net_pointReference">
			<xsl:for-each select="*/net:networkRef/network:PointReference">
				<xsl:value-of select="substring-after(net:element/@xlink:href,'#')"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="net:applicableDirection/@xlink:title"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="net:atPosition"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="network:atPositionGeometry/gml:Point/gml:pos"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="net_startNode"><xsl:value-of select="substring-after(*/net:startNode/@xlink:href,'#')"/></xsl:variable>
		<xsl:variable name="net_type"><xsl:value-of select="*/net:type/@xlink:title"/></xsl:variable>

		<xsl:variable name="ram_description"><xsl:value-of select="*/ram:description"/></xsl:variable>
		<xsl:variable name="ram_designation"><xsl:value-of select="*/ram:designation"/></xsl:variable>
		<xsl:variable name="ram_exemption_vehicleQualifier_vehicle">
			<xsl:for-each select="*/ram:exemption/ram:VehicleQualifier/ram:vehicle">
				<xsl:text>vehicle|</xsl:text>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text>;</xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_exemption_vehicleQualifier_use">
			<xsl:for-each select="*/ram:exemption/ram:VehicleQualifier/ram:use">
				<xsl:text>use|</xsl:text>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text>;</xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_exemption_vehicleQualifier_load">
			<xsl:for-each select="*/ram:exemption/ram:VehicleQualifier/ram:load">
				<xsl:text>load|</xsl:text>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text>;</xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_hazard"><xsl:value-of select="*/ram:hazard"/></xsl:variable>
		<xsl:variable name="ram_highwayAuthority">
			<xsl:for-each select="*/ram:highwayAuthority/highway:ResponsibleAuthority">
				<xsl:value-of select="highway:identifier"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:authorityName"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_inclusion_vehicleQualifier_vehicle">
			<xsl:for-each select="*/ram:inclusion/ram:VehicleQualifier/ram:vehicle">
				<xsl:text>vehicle|</xsl:text>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text>;</xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_inclusion_vehicleQualifier_use">
			<xsl:for-each select="*/ram:inclusion/ram:VehicleQualifier/ram:use">
				<xsl:text>use|</xsl:text>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text>;</xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_inclusion_vehicleQualifier_load">
			<xsl:for-each select="*/ram:inclusion/ram:VehicleQualifier/ram:load">
				<xsl:text>load|</xsl:text>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text>;</xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_maintenanceAuthority">
			<xsl:for-each select="*/ram:maintenanceAuthority/highway:ResponsibleAuthority">
				<xsl:value-of select="highway:identifier"/>
				<xsl:text>|</xsl:text>
				<xsl:value-of select="highway:authorityName"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_maintenanceResponsibility"><xsl:value-of select="*/ram:maintenanceResponsibility"/></xsl:variable>
		<xsl:variable name="ram_measure2"><xsl:value-of select="*/ram:measure2"/></xsl:variable>
		<xsl:variable name="ram_partialReference"><xsl:value-of select="*/ram:partialReference"/></xsl:variable>
		<xsl:variable name="ram_reasonForChange"><xsl:value-of select="*/ram:reasonForChange"/></xsl:variable>
		<xsl:variable name="ram_reinstatementType"><xsl:value-of select="*/ram:reinstatementType"/></xsl:variable>
		<xsl:variable name="ram_restriction"><xsl:value-of select="*/ram:restriction"/></xsl:variable>
		<xsl:variable name="ram_sourceOfMeasure"><xsl:value-of select="*/ram:sourceOfMeasure"/></xsl:variable>
		<xsl:variable name="ram_structure"><xsl:value-of select="*/ram:structure"/></xsl:variable>
		<xsl:variable name="ram_timeInterval">
			<xsl:for-each select="*/ram:timeInterval">
				<xsl:for-each select="ram:TemporalPropertyType/ram:namedDate">
					<xsl:value-of select="normalize-space(.)"/>
					<xsl:if test="not(position()=last())">,</xsl:if>
				</xsl:for-each>
				<xsl:text>@</xsl:text>
				<xsl:for-each select="ram:TemporalPropertyType/ram:dateRange/ram:DateRangeType">
					<xsl:value-of select="ram:startDate"/>
					<xsl:text>|</xsl:text>
					<xsl:value-of select="ram:endDate"/>
					<xsl:text>|</xsl:text>
					<xsl:value-of select="ram:startMonthDay"/>
					<xsl:text>|</xsl:text>
					<xsl:value-of select="ram:endMonthDay"/>
					<xsl:if test="not(position()=last())">,</xsl:if>
				</xsl:for-each>
				<xsl:text>@</xsl:text>
				<xsl:for-each select="ram:TemporalPropertyType/ram:dayPeriod/ram:DayPropertyType">
					<xsl:for-each select="ram:namedDay">
						<xsl:value-of select="normalize-space(.)"/>
						<xsl:if test="not(position()=last())">%</xsl:if>
					</xsl:for-each>
					<xsl:text>|</xsl:text>
					<xsl:for-each select="ram:namedPeriod">
						<xsl:value-of select="normalize-space(.)"/>
						<xsl:if test="not(position()=last())">%</xsl:if>
					</xsl:for-each>
					<xsl:text>|</xsl:text>
					<xsl:for-each select="ram:timePeriod/ram:TimePropertyType">
						<xsl:for-each select="ram:namedTime">
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:if test="not(position()=last())">*</xsl:if>
						</xsl:for-each>
						<xsl:text>?</xsl:text>
						<xsl:for-each select="ram:timeRange/ram:TimeRangeType">
							<xsl:value-of select="ram:startTime"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="ram:endTime"/>	
							<xsl:if test="not(position()=last())">*</xsl:if>
						</xsl:for-each>
						<xsl:if test="not(position()=last())">%</xsl:if>
					</xsl:for-each>
					<xsl:if test="not(position()=last())">,</xsl:if>
				</xsl:for-each>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ram_trafficRegulationOrder"><xsl:value-of select="*/ram:trafficRegulationOrder"/></xsl:variable>
		<xsl:variable name="ram_trafficSign">
			<xsl:for-each select="*/ram:trafficSign">
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:if test="not(position()=last())">;</xsl:if>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="tn_measure"><xsl:value-of select="*/tn:measure"/></xsl:variable>
		<xsl:variable name="tn_restriction"><xsl:value-of select="*/tn:restriction/@xlink:title"/></xsl:variable>
		<xsl:variable name="tn_restrictionType"><xsl:value-of select="*/tn:restrictionType/@xlink:title"/></xsl:variable>
		<xsl:variable name="tn_validFrom"><xsl:value-of select="*/tn:validFrom"/></xsl:variable>
		<xsl:variable name="tn_validTo"><xsl:value-of select="*/tn:validTo"/></xsl:variable>

		<xsl:variable name="tn-ro_formOfRoadNode"><xsl:value-of select="*/tn-ro:formOfRoadNode/@xlink:title"/></xsl:variable>
		<xsl:variable name="tn-ro_localRoadCode"><xsl:value-of select="*/tn-ro:localRoadCode"/></xsl:variable>
		<xsl:variable name="tn-ro_nationalRoadCode"><xsl:value-of select="*/tn-ro:nationalRoadCode"/></xsl:variable>

		<xsl:variable name="tn-w_formOfWaterwayNode"><xsl:value-of select="*/tn-w:formOfWaterwayNode/@xlink:title"/></xsl:variable>

		<xsl:choose>
			<xsl:when test="($RoadLink_id != '')">
				<xsl:text>featureMember_RoadLink&#09;</xsl:text>
				<xsl:value-of select="$RoadLink_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_fictitious"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadClassification"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_routeHierarchy"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_formOfWay"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_trunkRoad"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_primaryRoute"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadClassificationNumber"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_alternateName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_operationalState"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_provenance"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_directionality"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_length"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_matchStatus"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_alternateIdentifier"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_startNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_startGradeSeparation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_endNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_endGradeSeparation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadStructure"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_cycleFacility"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadWidth_averageWidth"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadWidth_minimumWidth"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadWidth_confidenceLevel"/><xsl:text>&#09;</xsl:text>
				<!-- <xsl:value-of select="$highway_numberOfLanes"/> --><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_elevationGain_inDirection"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_elevationGain_inOppositeDirection"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_formsPartOf"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_relatedRoadArea"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_centrelineGeometry"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($RoadNode_id != '')">
				<xsl:text>featureMember_RoadNode&#09;</xsl:text>
				<xsl:value-of select="$RoadNode_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn-ro_formOfRoadNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_classification"/><xsl:text>&#09;</xsl:text>
				<!-- <xsl:value-of select="$highway_access"/> --><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_junctionName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_junctionNumber"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_relatedRoadArea"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_geometryPoint"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($Road_id != '')">
				<xsl:text>featureMember_Road&#09;</xsl:text>
				<xsl:value-of select="$Road_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn-ro_localRoadCode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn-ro_nationalRoadCode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadClassification"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_designatedName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_localName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_descriptor"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_link"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($Street_id != '')">
				<xsl:text>featureMember_Street&#09;</xsl:text>
				<xsl:value-of select="$Street_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn-ro_localRoadCode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn-ro_nationalRoadCode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_designatedName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_localName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_descriptor"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadClassification"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_streetType"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_operationalStateType"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_locality"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_town"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_administrativeArea"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_responsibleAuthority"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_geometryProvenance"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_gssCode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_link"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_geometryMultiCurve"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($RoadJunction_id != '')">
				<xsl:text>featureMember_RoadJunction&#09;</xsl:text>
				<xsl:value-of select="$RoadJunction_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_junctionType"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_junctionName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadClassificationNumber"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_junctionNumber"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_node"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($PathLink_id != '')">
				<xsl:text>featureMember_PathLink&#09;</xsl:text>
				<xsl:value-of select="$PathLink_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_fictitious"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_formOfWay"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_pathName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_alternateName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_provenance"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_surfaceType"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_cycleFacility"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_matchStatus"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_length"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_alternateIdentifier"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_startNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_startGradeSeparation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_endNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_endGradeSeparation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_elevationGain_inDirection"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_elevationGain_inOppositeDirection"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_formsPartOf"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_relatedRoadArea"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_centrelineGeometry"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($PathNode_id != '')">
				<xsl:text>featureMember_PathNode&#09;</xsl:text>
				<xsl:value-of select="$PathNode_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn-ro_formOfRoadNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_classification"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_geometryPoint"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($ConnectingLink_id != '')">
				<xsl:text>featureMember_ConnectingLink&#09;</xsl:text>
				<xsl:value-of select="$ConnectingLink_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_fictitious"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_connectingNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_pathNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_geometryLineString"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($ConnectingNode_id != '')">
				<xsl:text>featureMember_ConnectingNode&#09;</xsl:text>
				<xsl:value-of select="$ConnectingNode_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_roadLink"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_geometryPoint"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($Path_id != '')">
				<xsl:text>featureMember_Path&#09;</xsl:text>
				<xsl:value-of select="$Path_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_pathName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_link"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($FerryLink_id != '')">
				<xsl:text>featureMember_FerryLink&#09;</xsl:text>
				<xsl:value-of select="$FerryLink_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_fictitious"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_vehicularFerry"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_routeOperator"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_startNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_endNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_centrelineGeometry"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($FerryNode_id != '')">
				<xsl:text>featureMember_FerryNode&#09;</xsl:text>
				<xsl:value-of select="$FerryNode_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn-w_formOfWaterwayNode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_geometryPoint"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($FerryTerminal_id != '')">
				<xsl:text>featureMember_FerryTerminal&#09;</xsl:text>
				<xsl:value-of select="$FerryTerminal_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_type"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_ferryTerminalName"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_ferryTerminalCode"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_refToFunctionalSite"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_element"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$hwtn_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($AccessRestriction_id != '')">
				<xsl:text>featureMember_AccessRestriction&#09;</xsl:text>
				<xsl:value-of select="$AccessRestriction_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_pointReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_restriction"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_trafficSign"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_inclusion_vehicleQualifier_vehicle"/><xsl:value-of select="$ram_inclusion_vehicleQualifier_use"/><xsl:value-of select="$ram_inclusion_vehicleQualifier_load"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_exemption_vehicleQualifier_vehicle"/><xsl:value-of select="$ram_exemption_vehicleQualifier_use"/><xsl:value-of select="$ram_exemption_vehicleQualifier_load"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_timeInterval"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($HighwayDedication_id != '')">
				<xsl:text>featureMember_HighwayDedication&#09;</xsl:text>
				<xsl:value-of select="$HighwayDedication_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_networkReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_dedication"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_timeInterval"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_publicRightOfWay"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_nationalCycleRoute"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_quietRoute"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_obstruction"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_planningOrder"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_worksProhibited"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_reasonForChange"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$dedication_geometry"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($TurnRestriction_id != '')">
				<xsl:text>featureMember_TurnRestriction&#09;</xsl:text>
				<xsl:value-of select="$TurnRestriction_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_linkReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_restriction"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_inclusion_vehicleQualifier_vehicle"/><xsl:value-of select="$ram_inclusion_vehicleQualifier_use"/><xsl:value-of select="$ram_inclusion_vehicleQualifier_load"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_exemption_vehicleQualifier_vehicle"/><xsl:value-of select="$ram_exemption_vehicleQualifier_use"/><xsl:value-of select="$ram_exemption_vehicleQualifier_load"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_timeInterval"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($RestrictionForVehicles_id != '')">
				<xsl:text>featureMember_RestrictionForVehicles&#09;</xsl:text>
				<xsl:value-of select="$RestrictionForVehicles_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_pointReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_nodeReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_measure"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_restrictionType"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_sourceOfMeasure"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_measure2"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_inclusion_vehicleQualifier_vehicle"/><xsl:value-of select="$ram_inclusion_vehicleQualifier_use"/><xsl:value-of select="$ram_inclusion_vehicleQualifier_load"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_exemption_vehicleQualifier_vehicle"/><xsl:value-of select="$ram_exemption_vehicleQualifier_use"/><xsl:value-of select="$ram_exemption_vehicleQualifier_load"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_structure"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_trafficSign"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_trafficRegulationOrder"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($Hazard_id != '')">
				<xsl:text>featureMember_Hazard&#09;</xsl:text>
				<xsl:value-of select="$Hazard_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_pointReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_linkReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_nodeReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_hazard"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_description"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($Structure_id != '')">
				<xsl:text>featureMember_Structure&#09;</xsl:text>
				<xsl:value-of select="$Structure_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_pointReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_linkReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_nodeReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_structure"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_description"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($Maintenance_id != '')">
				<xsl:text>featureMember_Maintenance&#09;</xsl:text>
				<xsl:value-of select="$Maintenance_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_networkReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_networkReferenceLocation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_maintenanceResponsibility"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_maintenanceAuthority"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_partialReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_highwayAuthority"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($Reinstatement_id != '')">
				<xsl:text>featureMember_Reinstatement&#09;</xsl:text>
				<xsl:value-of select="$Reinstatement_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_networkReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_networkReferenceLocation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reinstatementType"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_partialReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="($SpecialDesignation_id != '')">
				<xsl:text>featureMember_SpecialDesignation&#09;</xsl:text>
				<xsl:value-of select="$SpecialDesignation_id"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_localId"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_beginLifespanVersion"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validFrom"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$tn_validTo"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_networkReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$net_networkReferenceLocation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_designation"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_description"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_timeInterval"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$highway_contactAuthority"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_partialReference"/><xsl:text>&#09;</xsl:text>
				<xsl:value-of select="$ram_reasonForChange"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

</xsl:stylesheet>
