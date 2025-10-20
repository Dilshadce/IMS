<cfquery name="getprice" datasource="#dts#">
SELECT price_bil FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>
<cfoutput>
<cfform name="changepriceform" id="changepriceform" method="post" action="changepriceprocess.cfm?uuid=#url.uuid#&trancode=#url.trancode#">
<table>
<tr>
<th>Price</th>
<td>#numberformat(val(getprice.price_bil),'.___')#<br />
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
