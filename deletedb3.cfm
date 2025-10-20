<cfquery name="deletedb" datasource="#dts#">
SELECT schema_name FROm information_schema.SCHEMATA where right(schema_name,2) = "_a"
</cfquery>
<cfloop query="deletedb">
<cfoutput>
replicate-do-db=#deletedb.schema_name#<br/>
</cfoutput>
</cfloop>