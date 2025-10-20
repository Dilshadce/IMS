<cfif url.type eq 'TR'>
<cfset url.type='TROU'>
</cfif>

<cfquery name="getprice" datasource="#dts#">
SELECT qty_bil FROM ictran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
and itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
</cfquery>
<cfoutput>
<cfform name="changeqtyform" id="changeqtyform" method="post" action="changeqtytrprocess.cfm?refno=#url.refno#&type=#url.type#&itemcount=#url.itemcount#&custno=#url.custno#">
<table>
<tr>
<th>Qty</th>
<td>
<cfinput type="text" name="qty_bil1" id="qty_bil1" value="#val(getprice.qty_bil)#" required="yes" message="Qty is Required or not valid" validate="float" validateat="onsubmit"/>
</td>
</tr>
<tr>
<td colspan="2">
<input type="submit" name="sub_btn" id="sub_btn" value="Update" onClick="setTimeout('submitinvoice();',1500);" />
</td>
</tr>
</table>



</cfform>
</cfoutput>
