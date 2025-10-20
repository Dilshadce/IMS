<!---comments --->
<cfquery name="movecomments" datasource="importfromdbf">
SELECT * FROM comments
</cfquery>

<cfloop query="movecomments">

<cfquery name="insertcomments" datasource="#dts#">
INSERT IGNORE INTO comments
(
code,
desp,
details
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movecomments.code)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movecomments.desp)#">,
''
)
</cfquery>

</cfloop>

