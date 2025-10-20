<cfquery name="getlastcost" datasource="#dts#">
SELECT itemno FROM icitem
</cfquery>

<cfloop query="getlastcost">
<cfquery name="getcost" datasource="#dts#">
SELECT price FROM ictran WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlastcost.itemno#">  and type  = "RC" 
order by wos_date desc
</cfquery>

<cfif getcost.recordcount neq 0>
<cfif getcost.price neq 0>
<cfquery name="updatecost" datasource="#dts#">
UPDATE icitem SET ucost = "#val(getcost.price)#"
WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlastcost.itemno#">
</cfquery>
</cfif>
</cfif>

</cfloop>