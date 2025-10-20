<cfquery name="getprice" datasource="#dts#">
SELECT rem8 as price_bil FROM ictran where and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>
<cfoutput>
<cfform name="changepriceform" id="changepriceform" method="post" action="changesellingpriceprocess.cfm?refno=#url.refno#&tran=#url.tran#&trancode=#url.trancode#">
<table>
<tr>
<th>Selling Price</th>
<td>#numberformat(val(getprice.price_bil),'.__')#<br />
<cfinput type="text" name="price_bil1" id="price_bil1" value="" required="yes" message="Price is Required or not valid" validate="float" validateat="onsubmit"/>
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
