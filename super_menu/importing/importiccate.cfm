<!---iccate --->
<cfquery name="moveiccate" datasource="importfromdbf">
SELECT * FROM iccate
</cfquery>

<cfloop query="moveiccate">

<cfquery name="inserticcate" datasource="#dts#">
INSERT IGNORE INTO iccate
(
CATE,
DESP

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiccate.CATE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiccate.DESP)#">

)
</cfquery>

</cfloop>

