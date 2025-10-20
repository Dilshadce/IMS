<cfquery name="getitemcost" datasource="#dts#">
SELECT itemno,ucost,qtybf from icitem
</cfquery>

<cfquery name="lastyear" datasource="#dts#">
SELECT lastaccyear FROM gsetup
</cfquery>
<cfloop query="getitemcost">
<cfquery name="insertfifo" datasource="#dts#">
Insert fifoopq (itemno,ffq11,ffc11,ffd11)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.itemno#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.qtybf#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemcost.ucost#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(lastyear.lastaccyear,'yyyy-mm-dd')#" >
)
</cfquery>
</cfloop>