

<cfquery name="changediscountquery" datasource="#dts#">
SELECT qty_bil,price_bil,amt_bil,disamt_bil,dispec1,dispec2,dispec3 FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#"> and id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>

<cfoutput>
<!--- <form name="changepriceform" id="changepriceform" method="post" action="changepriceprocess.cfm?uuid=#url.uuid#&trancode=#url.trancode#"> --->
<cfset changediscountquery.amt_bil = val(changediscountquery.price_bil) * val(changediscountquery.qty_bil)>
<table>
<tr height="30">
<td height="30" style="font-size:24px"><strong><div style="vertical-align:bottom">Discount</div></strong></td>

<td>
<input type="hidden" name="amtfordiscount" id="amtfordiscount" value="#changediscountquery.amt_bil#">
<input type="hidden" id="changehighlight" name="changehighlight" value="1" />
<input type="text" size="4" style="font: large bolder;" name="disp1" id="disp1" value="#changediscountquery.dispec1#" 
onKeyUp="getDiscount();" 
validate="float" validateat="onsubmit"/>%
<input type="text" size="4" style="font: large bolder;" name="disp2" id="disp2" value="#changediscountquery.dispec2#" validate="float" onKeyUp="getDiscount();"  validateat="onsubmit"/>%

<input type="text" size="4" style="font: large bolder;" name="disp3" id="disp3" value="#changediscountquery.dispec3#" validate="float" onKeyUp="getDiscount();"  validateat="onsubmit"/>%
<input type="text"  style="font: large bolder;" name="disamt_bil1" id="disamt_bil1" value="#changediscountquery.disamt_bil#" onkeyup="updatediscount2(event,'#url.uuid#','#url.trancode#',document.getElementById('disamt_bil1').value);"/>
</td>
</tr>
<tr>
<td align="center" colspan="2">
<input type="button" name="sub_btn" id="sub_btn" value="Update" onclick="updatediscount('#url.uuid#','#url.trancode#',document.getElementById('disamt_bil1').value,document.getElementById('disp1').value,document.getElementById('disp2').value,document.getElementById('disp3').value);" />
</td>
</tr>
</table>



<!--- </form> --->
</cfoutput>
