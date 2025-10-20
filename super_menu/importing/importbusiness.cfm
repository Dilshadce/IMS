<!---business --->
<cfquery name="movebusiness" datasource="importfromdbf">
SELECT * FROM business
</cfquery>

<cfloop query="movebusiness">

<cfquery name="insertbusiness" datasource="#dts#">
INSERT IGNORE INTO business
(
BUSINESS,
DESP,
PRICELVL
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movebusiness.BUSINESS)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movebusiness.DESP)#">,
''
)
</cfquery>

</cfloop>

