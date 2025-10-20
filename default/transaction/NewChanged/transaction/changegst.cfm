<cfquery name="getprice" datasource="#dts#">
SELECT taxamt_bil FROM ictran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.trancode)#">
</cfquery>
<cfoutput>
<cfform name="changepriceform" id="changepriceform" method="post" action="changegstprocess.cfm?refno=#url.refno#&type=#url.type#&trancode=#url.trancode#&custno=#url.custno#">
<table>
<tr>
<th>Tax Amount</th>
<td>
<cfinput type="text" name="taxamt_bil1" id="taxamt_bil1" value="#numberformat(val(getprice.taxamt_bil),'.__')#" required="yes" message="Tax Amt is Required or not valid" validate="float" validateat="onsubmit"/>
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
