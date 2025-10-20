<cfsetting showdebugoutput="no">
<cfset uuid = url.uuid>
<cfoutput>
<table width="100%">
<tr>
<th width="2%">No</th>
<th width="15%">Item Code</th>
<th width="30%">Description</th>
<th width="10%">Collection Type</th>
<th width="10%">Quantity</th>
<th width="8%">Price</th>
<th width="8%">Discount</th>
<th width="8%">Amount</th>
<th width="10%">Action</th>
</tr>
<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
</cfquery>
<cfloop query="getictrantemp">
<tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictrantemp.currentrow#</td>
<td nowrap>#getictrantemp.itemno#</td>
<td nowrap>#getictrantemp.desp#</td>
<td nowrap>
<!--- <select name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" onChange="if(this.value != '#getictrantemp.brem1#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}">
<option value="Cash n Carry" <cfif getictrantemp.brem1 eq "Cash n Carry">Selected</cfif>>Cash & Carry</option>
<option value="Cash n Delivery" <cfif getictrantemp.brem1 eq "Cash n Delivery">Selected</cfif>>Cash & Delivery</option> 
</select> ---><input type="text" name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" value="#getictrantemp.brem1#" onClick="if(this.value=='Collection'){this.value = 'Delivery';updaterow('#getictrantemp.trancode#');} else {this.value = 'Collection';updaterow('#getictrantemp.trancode#');}" readonly="readonly"></td>
<td nowrap align="right"><input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}"></td>
<td nowrap align="right"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changeprice');getfocus4();">#numberformat(val(getictrantemp.price_bil),',.__')#</a></td>
<td nowrap align="right"><input type="text" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem4#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" ></td>
<td nowrap align="right">#numberformat(val(getictrantemp.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#')" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>

</table>
</cfoutput>
