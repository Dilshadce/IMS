<cfsetting requestTimeOut = "72000" >

<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql"
</cfquery>
<cfloop query="backupdb">
<cftry>
<cfquery name="gettabllist" datasource="main">
 SHOW tables FROM #backupdb.schema_name#
</cfquery>

<cfloop query="gettabllist">
<cfset gettablename = evaluate('gettabllist.tables_in_#backupdb.schema_name#')>
<cfquery name="checktbl" datasource="main">
        CHECK TABLE #backupdb.schema_name#.`#gettablename#`
</cfquery>
<cfif checktbl.msg_text neq "OK">
<cfquery name="repairtbl" datasource="main">
REPAIR TABLE #backupdb.schema_name#.`#gettablename#`
</cfquery>
<cfoutput>
#backupdb.schema_name#.#gettablename#<br/>
</cfoutput>
</cfif>
</cfloop>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfloop>