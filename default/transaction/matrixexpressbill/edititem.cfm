<cfset itemno = url.itemno>
<cfif url.type eq 'TR'>
<cfset url.type ='TROU'>
</cfif>
<cfquery name="getitemno" datasource="#dts#">
SELECT * from ictrantemp where type="#url.type#" and uuid="#uuid#" and itemno = "#itemno#"
</cfquery>
<cfoutput>
<h1>Edit Item no</h1>
<form name="form" action="">

<table width="400px">
<tr></tr>
<th>Type</th>
<td>#url.type#</td>
<th>Ref No</th>
<td>#getitemno.refno#</td>
<tr>
<th width="70px">Itemno</th>
<td width="70px">#listgetat(itemno,1,'-')#</td>
<th width="70px">Colour</th>
<td width="190px"><cftry>#listgetat(itemno,2,'-')#<cfcatch></cfcatch></cftry></td>
</tr>
<tr>
<th>Quantity</th>
<td><input type="text" name="itemqty" id="itemqty" value="#lsnumberformat(getitemno.qty_bil,",")#" /></td>
<td>Price</td>
<td><input type="text" name="itemprice" id="itemprice" value="#lsnumberformat(getitemno.price_bil,",_.__")#"/></td>
</tr>
<tr>
<th>Discount</th>
<td colspan="3">
<input type="text" name="itemdispec1" id="itemdispec1" size="4" value="#lsnumberformat(getitemno.dispec1,",")#" />%
<input type="text" name="itemdispec2" id="itemdispec2" size="4" value="#lsnumberformat(getitemno.dispec2,",")#" />%
<input type="text" name="itemdispec3" id="itemdispec3" size="4" value="#lsnumberformat(getitemno.dispec3,",")#" />%
</td>
</tr>
<tr><td colspan="4" align="center"><input type="button" name="submitbtn" id="submitbtn" value="SUBMIT" onclick="ajaxFunction(document.getElementById('ajaxField3'),'edititemProcess.cfm?type=#url.type#&uuid=#url.uuid#&itemno=#url.itemno#&qty='+document.getElementById('itemqty').value+'&price='+document.getElementById('itemprice').value+'&dispec1='+document.getElementById('itemdispec1').value+'&dispec2='+document.getElementById('itemdispec2').value+'&dispec3='+document.getElementById('itemdispec3').value);setTimeout('refreshlist();',1000);setTimeout('recalculateamt();',1500);ColdFusion.Window.hide('edititem');"  /></td></tr>
</table>
<div id="ajaxField3" name="ajaxField3">
                </div>

</form>
</cfoutput>