<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where right(schema_name,2) = "_p"
</cfquery>
<cfoutput>
<table>
<cfloop query="backupdb">
<tr>
<th>#backupdb.schema_name#</th>
<cfquery name="getrecord" datasource="main">
SELECT empno FROM #backupdb.schema_name#.PMAST
</cfquery>
<th>#getrecord.recordcount#</th>
</tr>
</cfloop>
</table>
</cfoutput>