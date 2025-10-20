<cfquery name="getgl" datasource="#dts#">
select source,purchase from project where purchase <> "" or purchase <> null group by source
</cfquery>

<cfloop query="getgl">


<cfquery name="updategl" datasource="#dts#">
Update ictran set gltradac = "#getgl.purchase#" where source = "#getgl.source#" and type = "RC"
</cfquery>

</cfloop>
