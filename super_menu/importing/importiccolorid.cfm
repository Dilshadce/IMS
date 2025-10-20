<!---iccolorid --->
<cfquery name="moveiccolorid" datasource="importfromdbf">
SELECT * FROM iccolor
</cfquery>

<cfloop query="moveiccolorid">

<cfquery name="inserticcolorid" datasource="#dts#">
INSERT IGNORE INTO iccolorid
(
COLORID,
DESP

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiccolorid.COLORID)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiccolorid.DESP)#">

)
</cfquery>

</cfloop>

