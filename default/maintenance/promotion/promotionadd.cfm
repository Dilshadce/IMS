<cfif promoType eq "priceFixeddis" or promoType eq "priceVarprice" or promoType eq "pricefixedprice">
<cfset type="price">
<cfelseif promoType eq "buyamtdis" or promoType eq "buyamttotalprice" or promoType eq "buyamtsingleprice" or promoType eq "buyqtydis" or promoType eq "buyqtytotalprice" or promoType eq "buyqtysingleprice">
<cfset type="buy">
<cfelse>
<cfset type=form.promoType>
</cfif>


<cfset desp=form.promodesp>
<cfset priceamt = form.priceamt>
<cfset periodfrom = form.profrom>
<cfset nperiodfrom = createdate(right(periodfrom,4),mid(periodfrom,4,2),left(periodfrom,2))>
<cfset periodfrom = #dateformat(nperiodfrom,'yyyy-mm-dd')#>
<cfset periodto = form.proto>
<cfset nperiodto = createdate(right(periodto,4),mid(periodto,4,2),left(periodto,2))>
<cfset periodto = #dateformat(nperiodto,'yyyy-mm-dd')#>
<cfset customer = form.custno>
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
INSERT INTO promotion
(type,description,periodfrom,periodto,priceamt,rangefrom,rangeto,discby,pricedistype,buydistype,customer,memberonly,created_by,created_on)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#periodfrom#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#periodto#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rangefrom#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rangeto#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#discby#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#pricedistype#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#buydistype#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#customer#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#memberonly#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
now()
)
</cfquery>

<cfoutput>
<cfform action="/default/maintenance/promotion/promotion.cfm?promoid=0" method="post">
<table width="100%">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td align="center">Create Success!</td>
</tr>
<tr>
<td align="center"><input type="submit" name="createagain" id="createagain" value="Create Another One" />&nbsp;&nbsp;<input type="button" name="close" id="close" value="Close" onclick="ColdFusion.Grid.refresh('usersgrid',false);ColdFusion.Window.hide('createpromotion');" /></td>
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