<cfquery name="getdiscount" datasource="#dts#">
SELECT qty_bil,price_bil,amt_bil,disamt_bil,dispec1,dispec2,dispec3 FROM ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">  and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>
<cfoutput>
<cfform name="changediscountform" id="changediscountform" method="post" action="changediscountprocess.cfm?refno=#url.refno#&tran=#url.tran#&trancode=#url.trancode#">
<cfset getdiscount.amt_bil = val(getdiscount.price_bil) * val(getdiscount.qty_bil)>
<cfinput type="hidden" name="changediscountitemno" id="changediscountitemno" value="#url.itemno#" />
<table>
<tr>
<th>Discount</th>
<td>#numberformat(val(getdiscount.amt_bil),'.__')#<br />
<cfinput type="hidden" name="amtfordiscount" id="amtfordiscount" value="#getdiscount.amt_bil#">
<cfinput type="text" size="4" name="disp1" id="disp1" value="#getdiscount.dispec1#" 
onKeyUp="getDiscount();" onBlur="getDiscount();" onChange="getDiscount();" validate="float" validateat="onsubmit"/>%
<cfinput type="text" size="4" name="disp2" id="disp2" value="#getdiscount.dispec2#" validate="float" onKeyUp="getDiscount();" onChange="getDiscount();"  validateat="onsubmit"/>%

<cfinput type="text" size="4" name="disp3" id="disp3" value="#getdiscount.dispec3#" validate="float" onKeyUp="getDiscount();" onChange="getDiscount();" onBlur="getDiscount();"  validateat="onsubmit"/>%

<cfinput type="text" size="8" name="disamt_bil1" id="disamt_bil1" value="#getdiscount.disamt_bil#" validate="float" validateat="onsubmit" onBlur="getDiscount();" onKeyUp="getDiscount();"/>
</td>
</tr>
<tr>
<td colspan="2">
<input type="submit" name="sub_btn" id="sub_btn" value="Update" />
</td>
</tr>
</table>

</cfform>
</cfoutput>
