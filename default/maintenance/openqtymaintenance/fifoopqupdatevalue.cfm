<cfsetting showdebugoutput="no">

<cfset itemno = URLDecode(url.itemno)>

<cfquery name="updateitemvalue" datasource="#dts#">
	update icitem set #url.itemfield# = "#val(url.updatevalue)#"
    where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
</cfquery>