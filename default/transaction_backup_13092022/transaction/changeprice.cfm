<cfquery name="getprice" datasource="#dts#">
SELECT price_bil FROM ictran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.trancode)#">
</cfquery>
<cfoutput>
<cfform name="changepriceform" id="changepriceform" method="post" action="changepriceprocess.cfm?refno=#url.refno#&type=#url.type#&trancode=#url.trancode#&custno=#url.custno#">
<table>
<tr>
<th>Price</th>
<td>
<cfinput type="text" name="price_bil1" id="price_bil1" value="#numberformat(val(getprice.price_bil),'.__')#" required="yes" message="Price is Required or not valid" validate="float" validateat="onsubmit"/>
</td>
</tr>
<tr>
<td colspan="2">
<input type="submit" name="sub_btn" id="sub_btn" value="Update" onClick="releaseDirtyFlag();setTimeout('submitinvoice();',1500);" />
</td>
</tr>
</table>



</cfform>
</cfoutput>
