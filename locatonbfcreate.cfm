<cfquery name="insertlocation" datasource="#dts#">
SELECT location FROM iclocation where location not in ("1-Office","1-Warehouse")
</cfquery>
<cfloop query="insertlocation">
<cfquery name="insertlocationbf" datasource="#dts#">
INSERT INTO locqdbf (itemno,location,LOCQFIELD)
SELECT itemno,"#insertlocation.location#","0" from icitem order by itemno
</cfquery>
</cfloop>
