<cfsetting showdebugoutput="no">

<cfset itemno = URLDecode(url.itemno)>
<cfset location = URLDecode(url.location)>

<cfif fifofield contains "ffd">
<cfset updatevalue=createdate(right(url.updatevalue,4),mid(url.updatevalue,4,2),left(url.updatevalue,2))>
<cfset updatevalue=dateformat(updatevalue,"yyyy-mm-dd")>
</cfif>


<cfif trim(location) eq "">
<cfquery name="updatefifovalue" datasource="#dts#">
	update fifoopq set #url.fifofield# = "#updatevalue#"
    where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
</cfquery>

<cfelse>
<cfquery name="updatefifovalue" datasource="#dts#">
	update fifoopqlocation set #url.fifofield# = "#updatevalue#"
    where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
    and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#" />
</cfquery>

</cfif>
