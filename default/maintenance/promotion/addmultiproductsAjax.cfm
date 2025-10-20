<cfset promoid = URLDecode(url.promoid)>

<cfloop from="1" to="50" index="i">
<cftry>
<cfset itemno = evaluate("url.servicecode#i#")>

<cfquery name="getitemlist" datasource="#dts#">
SELECT itemno,desp FROM icitem
WHERE
<cfif lcase(hcomid) eq "aipl_i" or lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "gramas_i">
itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#%" >
<cfelse>
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" >
</cfif>
</cfquery>

<cfloop query="getitemlist">
<cfquery name="checkexist" datasource="#dts#">
SELECT promoitemid FROM promoitem WHERE promoid = "#promoid#" and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.itemno#" >
</cfquery>

<cfif checkexist.recordcount eq 0>
<cfquery name="insertintopromo" datasource="#dts#">
INSERT INTO promoitem (promoid,itemno,desp,created_by,created_on) 
VALUES(
'#promoid#',
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getitemlist.itemno#" >,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.desp#" >,
'#huserid#',
now())
</cfquery>
</cfif>
</cfloop>

<cfcatch></cfcatch></cftry>

</cfloop>