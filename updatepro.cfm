<cfquery name="updatedesp" datasource="#dts#">
Update ictran SET desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
</cfquery>
<cflocation url="updateictrandesp.cfm" addtoken="no" />