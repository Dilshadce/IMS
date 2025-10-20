<cfquery name="getagentlist" datasource="#dts#">
SELECT * FROM custagent
</cfquery>
<cfloop query="getagentlist">
<cfquery name="updateagent" datasource="#dts#">
update arcust set agent = "#getagentlist.agent#" where custno = "#getagentlist.custno#"
</cfquery>
</cfloop>