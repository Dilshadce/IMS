<cfsetting showdebugoutput="no">
<cfset refno = url.refno>
<cfset tran = url.tran>
<cfoutput>
<cfquery name="getsumictrantemp" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">   and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode desc
</cfquery>
#getsumictrantemp.sumqty#
</cfoutput>
