<cfsetting showdebugoutput="no">


<cfquery name="getallsize" datasource="#dts#">
	select * from icsizeid where sizeid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.sizeid)#">
</cfquery>

<cfoutput>
<cfloop from="1" to="20" index="i">

<input type="hidden" name="hidsize#i#" id="hidsize#i#" value="#evaluate('getallsize.size#i#')#">

</cfloop>
</cfoutput>