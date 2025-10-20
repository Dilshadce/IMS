<!---iclocation --->
<cfquery name="moveiclocation" datasource="importfromdbf">
SELECT * FROM iclocation
</cfquery>

<cfloop query="moveiclocation">

<cfquery name="inserticlocation" datasource="#dts#">
INSERT IGNORE INTO iclocation
(
LOCATION,
DESP,
ADDR1,
ADDR2,
ADDR3,
ADDR4,
OUTLET,
CUSTNO,
TEMPN1,
TEMPC

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.LOCATION)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.ADDR1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.ADDR2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.ADDR3)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.ADDR4)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.OUTLET)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.CUSTNO)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveiclocation.TEMPN1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclocation.TEMPC)#">
)
</cfquery>

</cfloop>

