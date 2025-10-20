<cfquery name="getitemlist" datasource="#dts#">
SELECT itemno,desp FROM icitem
WHERE
<cfif url.type eq "itemno">
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.valueget)#" >
<cfelseif url.type eq "group">
wos_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.valueget)#" >
<cfelseif url.type eq "brand">
brand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.valueget)#" >
<cfelseif url.type eq "category">
category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.valueget)#" >
</cfif>
</cfquery>

<cfloop query="getitemlist">
<cfquery name="checkexist" datasource="#dts#">
SELECT promoitemid FROM promoitem WHERE promoid = "#url.promoid#" and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.itemno#" >
</cfquery>

<cfif checkexist.recordcount eq 0>
<cfquery name="insertintopromo" datasource="#dts#">
INSERT INTO promoitem (promoid,itemno,desp,itemprice,created_by,created_on) 
VALUES(
'#url.promoid#',
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getitemlist.itemno#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.desp#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.price)#" >,
'#huserid#',
now())
</cfquery>
</cfif>
</cfloop>

