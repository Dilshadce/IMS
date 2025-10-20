<cfsetting showdebugoutput="no">

<cfoutput>
<cfif url.type eq 'TR'>
<cfquery name="deleteictran" datasource="#dts#">
delete from ictrantemp where  type='TROU' and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> and uuid='#url.uuid#'
</cfquery>
<cfquery name="deleteictran" datasource="#dts#">
delete from ictrantemp where  type='TRIN' and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> and uuid='#url.uuid#'
</cfquery>
<cfelse>
<cfquery name="deleteictran" datasource="#dts#">
delete from ictrantemp where  type='#url.type#' and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> and uuid='#url.uuid#'
</cfquery>
</cfif>

</cfoutput>