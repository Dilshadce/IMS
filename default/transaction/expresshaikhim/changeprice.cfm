<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,itemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>
<cfoutput>
<cfform name="changepriceform" id="changepriceform" method="post" action="changepriceprocess.cfm?uuid=#url.uuid#&trancode=#url.trancode#">
<table>
<tr>
<th>Price</th>
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
<Br />
<cfquery name="getlast5price" datasource="#dts#">
select wos_date,refno,price,qty,dispec1 from ictran where type in ("INV","CS") and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getprice.itemno#"> order by wos_date desc 
</cfquery>
<table width="100%">
<tr>
          	<th colspan='6'><div align="left">Last 5 Price / Discount History </div></th>
        </tr>
        <tr>
          	<td><strong>Date</strong></td>
            <td><strong>Ref No</strong></td>
          	<td><strong>Price</strong></td>
          	<td><strong>Qty</strong></td>
          	<td><strong>Discount %</strong></td>
        </tr>
        <tr>
          	<td>#dateformat(getlast5price.wos_date,'dd/mm/yyyy')#</td>
            <td>#getlast5price.refno#</td>
          	<td>#getlast5price.price#</td>
          	<td>#getlast5price.qty#</td>
          	<td>#getlast5price.dispec1#</td>
        </tr>

</table>

</cfform>
</cfoutput>
