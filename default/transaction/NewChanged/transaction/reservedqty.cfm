<cfoutput>
<h3>Reserved Qty</h3>
<table>
<tr>
<th>LOCATION</th>
<th>RESERVED QTY</th>
</tr>
<cfquery name="getlocation" datasource="#dts#">
SELECT LOCATION FROM ICLOCATION
</cfquery>
<cfloop query="getlocation">
		<cfquery name="getreserveqty" datasource="#dts#">
        select (ifnull(sum(qty),0)-ifnull(sum(writeoff),0)) as reserveqty from ictran where 
        fperiod !='99' 
        and (toinv='' or toinv is null)
        and type='SO'
        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">
        </cfquery>
		
<tr>
<td>#getlocation.location#</td>
<td>#getreserveqty.reserveqty#</td>
</tr>
</cfloop>
		<cfquery name="getreserveqty2" datasource="#dts#">
        select (ifnull(sum(qty),0)-ifnull(sum(writeoff),0)) as reserveqty from ictran where 
        fperiod !='99' 
        and (toinv='' or toinv is null)
        and type='SO'
        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
        </cfquery>
<tr>
<td><strong>STOCK ALL</strong></td>
<td>#getreserveqty2.reserveqty#</strong></td>

</tr>
</table>
<br />

</cfoutput>