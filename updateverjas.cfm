<cfquery name="getmitem" datasource="#dts#">
SELECT mitemno,price,category,length(mitemno) as lenmitemno from icmitem where mitemno not like "%-%"
</cfquery>
<cfloop query="getmitem">
<cfquery name="updateicitem" datasource="#dts#">
UPDATE icitem SET 
price = <cfqueryparam cfsqltype="cf_sql_double" value="#getmitem.price#" >,
Category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmitem.category#" >
WHERE left(itemno,#getmitem.lenmitemno#) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmitem.mitemno#">
</cfquery>
</cfloop>