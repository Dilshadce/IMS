<cfquery name="getitemcost" datasource="#dts#">
SELECT itemno,ucost,qtybf,wos_group,shelf from icitem where itemno like "Z%"
</cfquery>

<cfloop query="getitemcost">
<cfquery name="insertfifo" datasource="#dts#">
Insert locqdbf (itemno,location,LOCQFIELD,PRICE,wos_group,shelf)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.itemno#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="AMK" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.qtybf#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.ucost#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.wos_group#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.shelf#" >
)
</cfquery>
</cfloop>

<cfquery name="getitemcost1" datasource="#dts#">
SELECT itemno,ucost,qtybf,wos_group,shelf from icitem where itemno not like "Z%"
</cfquery>

<cfloop query="getitemcost1">
<cfquery name="insertfifo" datasource="#dts#">
Insert locqdbf (itemno,location,LOCQFIELD,PRICE,wos_group,shelf)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost1.itemno#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="GL" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost1.qtybf#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost1.ucost#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost1.wos_group#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost1.shelf#" >
)
</cfquery>
</cfloop>