<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,itemno FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
and id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>

<cfquery name="getminimumprice" datasource="#dts#">
SELECT price2,ucost FROM icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getprice.itemno#">
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select gpricemin from gsetup
</cfquery>

<cfquery name="getdealermenu" datasource="#dts#">
select selling_below_cost from dealer_menu
</cfquery>


<cfoutput>
<!--- <form name="changepriceform" id="changepriceform" method="post" action="changepriceprocess.cfm?uuid=#url.uuid#&trancode=#url.trancode#"> --->
<table border="0" align="center" width="80%" class="data">
<tr height="30">
<td height="30" style="font-size:3em"><strong><div style="vertical-align:bottom">Price</div></strong></td>
<td>
<cfif getgsetup.gpricemin eq '1'>
<input type="hidden" name="minimumprice2" id="minimumprice2" value="#numberformat(val(getminimumprice.price2),'.__')#"/>
<cfelse>
<input type="hidden" name="minimumprice2" id="minimumprice2" value="0"/>
</cfif>

<cfif getdealermenu.selling_below_cost eq 'Y'>
<input type="hidden" name="sellingbelowcost" id="sellingbelowcost" value="#numberformat(val(getminimumprice.ucost),'.__')#"/>
<cfelse>
<input type="hidden" name="sellingbelowcost" id="sellingbelowcost" value="0"/>
</cfif>

<input type="hidden" id="changepriceuuid" name="changepriceuuid" value="#url.uuid#" />
<input type="hidden" id="changepricetrancode" name="changepricetrancode" value="#url.trancode#" />

<input type="hidden" id="changehighlight" name="changehighlight" value="1" />

<input style="font-size:2em" type="text" name="price_bil1" id="price_bil1" value="#numberformat(val(getprice.price_bil),'.__')#" onkeyup="updateprice2(event,'#url.uuid#','#url.trancode#',document.getElementById('price_bil1').value);" onmouseout="doSomethingWithSelectedText();"/>
</td>
</tr>
<tr>
<td align="center" colspan="2" style="font-size:1.5em">
<input type="button" name="sub_btn" id="sub_btn" value="Update" onclick="updateprice('#url.uuid#','#url.trancode#',document.getElementById('price_bil1').value);" />
</td>
</tr>
</table>


<!--- </form> --->
</cfoutput>
