<cfquery name="changeqtyquery" datasource="#dts#">
SELECT qty_bil FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
and id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>


<cfoutput>
<!--- <form name="changepriceform" id="changepriceform" method="post" action="changepriceprocess.cfm?uuid=#url.uuid#&trancode=#url.trancode#"> --->
<table border="0" align="center" width="80%" class="data">
<tr height="30">
<td height="30" style="font-size:3em"><strong><div style="vertical-align:bottom">Qty</div></strong></td>
<td >
<input type="hidden" id="changehighlight" name="changehighlight" value="1" />
<input type="text" style="font-size:2em" name="qty_bil1" id="qty_bil1" value="#numberformat(val(changeqtyquery.qty_bil),'.__')#" onkeyup="updateqty2(event,'#url.uuid#','#url.trancode#',document.getElementById('qty_bil1').value);" onmouseout="doSomethingWithSelectedText();"/>
</td>
</tr>
<tr>
<td align="center" colspan="2" style="font-size:1.5em">
<input type="button" name="sub_btn" id="sub_btn" value="Update" onclick="updateqty('#url.uuid#','#url.trancode#',document.getElementById('qty_bil1').value);" />
</td>

</tr>
<tr>
<td align="center" colspan="2" style="font-size:1em">
<label>You may enter fraction value. E.g. 19/31</label>
</td>
</tr>

</table>



<!--- </form> --->
</cfoutput>
