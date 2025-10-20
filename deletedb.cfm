<cfquery name="getdb" datasource="#dts#">
SELECT dbname from uselessdb
</cfquery>
<cfloop query="getdb">
<cftry>
<cfquery name="dropdb" datasource="main">
DROP database #getdb.dbname#
</cfquery>
<cfquery name="delete" datasource="main">
DELETE FROM users WHERE userbranch = "#getdb.dbname#"
</cfquery>
<cfcatch type="any">
<cfoutput>
#cfcatch.Detail#
</cfoutput>
</cfcatch>

</cftry>
</cfloop>
