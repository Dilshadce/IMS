<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql" and (right(schema_name,2) = "_a" or right(schema_name,2) = "_i")
</cfquery>
<cfloop query="backupdb">
<cftry>
<cfquery name="getarcust" datasource="#dts#">
INSERT INTO EMAIL SELECT e_mail FROM #backupdb.schema_name#.arcust WHERE e_mail <> ""
</cfquery>
<cfquery name="getarcust" datasource="#dts#">
INSERT INTO EMAIL SELECT e_mail FROM #backupdb.schema_name#.apvend WHERE e_mail <> ""
</cfquery>
<cfcatch type="any">
<cfoutput>
#cfcatch.Detail# #backupdb.schema_name#
</cfoutput>
</cfcatch>
</cftry>
</cfloop>