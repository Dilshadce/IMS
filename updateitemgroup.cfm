<cfquery name="getitem" datasource="#dts#">
SELECT * FROM icitem where wos_group <> "" and wos_group is not null
</cfquery>

<cfloop query="getitem">
<cfquery name="updategroup" datasource="#dts#">
UPDATE ictran SET wos_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.wos_group#"> WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getitem.itemno)#">
</cfquery>
</cfloop>