<!---icservi --->
<cfquery name="moveicservi" datasource="importfromdbf">
SELECT * FROM icservi
</cfquery>

<cfloop query="moveicservi">

<cfquery name="inserticservi" datasource="#dts#">
INSERT IGNORE INTO icservi
(
servi,
DESP,
SALEC,
SALECSC,
SALECNC,
PURC,
PURPRC


)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicservi.servi)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicservi.DESP)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicservi.SALEC)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicservi.SALECSC)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicservi.SALECNC)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicservi.PURC)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicservi.PURPRC)#">

)
</cfquery>

</cfloop>

