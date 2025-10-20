<cfsetting showdebugoutput="no">  
<cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'>

<cfquery name="lastprice" datasource="#dts#">
select * from ictran where itemno='#url.itemno#' and custno='#custno#' and type='PO' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>

<cfquery name="lastprice2" datasource="#dts#">
select * from ictran where itemno='#url.itemno#'  and custno='#custno#' and type='RC' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>
<cfelse>
<cfquery name="lastprice" datasource="#dts#">
select * from ictran where itemno='#url.itemno#' and custno='#custno#' and type='QUO' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>

<cfquery name="lastprice2" datasource="#dts#">
select * from ictran where itemno='#url.itemno#'  and custno='#custno#' and type='INV' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>
</cfif>
<cfoutput>
<table width="250">
<tr><th colspan="100%">Last 5 <cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'>PURCHASED<cfelse>QUOTED</cfif></th></tr>
<tr>
<th>No.</th>
<th>Price</th>
</tr>
<cfloop query="lastprice">
<tr>
<td>#lastprice.refno#</td>
<td>#numberformat(lastprice.price,',.__')#</td>
</tr>
</cfloop>
</table>
<br />
<table width="250">
<tr><th colspan="100%">Last 5 <cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'>RECEIVED<cfelse>INVOICED</cfif></th></tr>
<tr>
<th>No.</th>
<th>Price</th>
</tr>
<cfloop query="lastprice2">
<tr>
<td>#lastprice2.refno#</td>
<td>#numberformat(lastprice2.price,',.__')#</td>
</tr>
</cfloop>
</table>


</cfoutput>




