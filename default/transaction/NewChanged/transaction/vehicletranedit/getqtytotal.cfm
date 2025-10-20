<cfsetting showdebugoutput="no">
<cfset url.refno = URLDECODE(url.refno)>
<cfset url.tran = URLDECODE(url.tran)>
<cfoutput>
<cfquery name="getsumictran" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode desc
</cfquery>
<input type="hidden" id="totalrealqty" name="totalrealqty" value="#getsumictran.sumqty#">
#getsumictran.sumqty#
</cfoutput>
