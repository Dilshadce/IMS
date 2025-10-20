<!---project--->
<cfquery name="moveproject" datasource="importfromdbf">
SELECT * FROM project
</cfquery>

<cfloop query="moveproject">

<cfquery name="insertproject" datasource="#dts#">
INSERT IGNORE INTO project
(
SOURCE,
PROJECT,
PORJ,
COMPLETED,
CONTRSUM,
DETAIL1,
DETAIL2,
DETAIL3,
creditsales,
cashsales,
salesreturn,
purchase,
purchasereturn

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveproject.SOURCE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveproject.PROJECT)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveproject.PORJ)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveproject.COMPLETED)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveproject.CONTRSUM)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveproject.DETAIL1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveproject.DETAIL2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveproject.DETAIL3)#">,
'',
'',
'',
'',
''

)
</cfquery>

</cfloop>

