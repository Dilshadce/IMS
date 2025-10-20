<cfquery name="getddns" datasource="ssmain">
SELECT id,ddns FROM apiipallow WHERE ddns <> ""
</cfquery>
<cfset loc.javaInet = createObject("java","java.net.InetAddress")>

<cfloop query="getddns">
<cftry>
<cfset loc.dnsLookup = loc.javaInet.getByName("#getddns.ddns#")>
<cfquery name="update" datasource="ssmain">
UPDATE apiipallow SET ip = "#trim(listlast(loc.dnsLookup,'/'))#" WHERE id = "#getddns.id#"
</cfquery>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfloop>