<cfset promoid=form.promoid>
<cfset desp=form.promodesp>
<cfset priceamt = form.priceamt>
<cfset periodfrom = form.profrom>
<cfset custno = form.custno>
<cfset nperiodfrom = createdate(right(periodfrom,4),mid(periodfrom,4,2),left(periodfrom,2))>
<cfset periodfrom = #dateformat(nperiodfrom,'yyyy-mm-dd')#>
<cfset periodto = form.proto>
<cfset nperiodto = createdate(right(periodto,4),mid(periodto,4,2),left(periodto,2))>
<cfset periodto = #dateformat(nperiodto,'yyyy-mm-dd')#>
<cfif isdefined('form.pricedistype')>
<cfset pricedistype = form.pricedistype>
<cfelse>
<cfset pricedistype = "">
</cfif>
<cfif isdefined('form.rangefrom')>
<cfset rangefrom = form.rangefrom>
<cfelse>
<cfset rangefrom = "">
</cfif>
<cfif isdefined('form.rangeto')>
<cfset rangeto = form.rangeto>
<cfelse>
<cfset rangeto = "">
</cfif>
<cfif isdefined('form.discby')>
<cfset discby = form.discby>
<cfelse>
<cfset discby = "">
</cfif>
<cfif isdefined('form.buydistype')>
<cfset buydistype = form.buydistype>
<cfelse>
<cfset buydistype = "">
</cfif>
<cfif isdefined('form.memberonly')>
<cfset memberonly = form.memberonly>
<cfelse>
<cfset memberonly = "">
</cfif>


<cfquery name="insertpromotion" datasource="#dts#">
UPDATE promotion SET
customer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
memberonly = <cfqueryparam cfsqltype="cf_sql_varchar" value="#memberonly#">,
description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">,
periodfrom = <cfqueryparam cfsqltype="cf_sql_varchar" value="#periodfrom#">,
periodto = <cfqueryparam cfsqltype="cf_sql_varchar" value="#periodto#">,
priceamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#priceamt#">,
rangefrom = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rangefrom#">,
rangeto = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rangeto#">,
discby = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discby#">,
pricedistype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pricedistype#">,
buydistype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#buydistype#">,
updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
updated_on = now()
WHERE
promoid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#promoid#">

</cfquery>

<cfoutput>
<cfform action="/default/maintenance/promotion/promotion.cfm?promoid=#promoid#&success=true" method="post">
<table width="100%">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td align="center">Update Success!</td>
</tr>
<tr>
<td align="center"><!--- <input type="submit" name="createagain" id="createagain" value="Create Another One" />&nbsp;&nbsp; ---><input type="button" name="close" id="close" value="Close" onclick="ColdFusion.Grid.refresh('usersgrid',false);ColdFusion.Window.hide('createpromotion');" /></td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
</table>
</cfform>

</cfoutput>