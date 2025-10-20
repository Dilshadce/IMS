<!---icarea --->
<cfquery name="moveicarea" datasource="importfromdbf">
SELECT * FROM icarea
</cfquery>

<cfloop query="moveicarea">

<cfquery name="inserticarea" datasource="#dts#">
INSERT IGNORE INTO icarea
(
Area,
Desp

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicarea.Area)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicarea.Desp)#">

)
</cfquery>

</cfloop>

