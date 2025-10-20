<cfsetting showdebugoutput="no">
<cfset uuid = url.uuid>
<cfquery datasource="#dts#" name="getlocation">
	select 
	location,
	desp 
	from iclocation 
    where 0=0
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    <cfelse>
    <cfif Huserloc neq "All_loc">
	and location='#Huserloc#'
	</cfif>
    </cfif>
	order by location;
</cfquery>

<cfquery datasource="#dts#" name="getgsetup">
	select * from Gsetup
</cfquery>

<cfquery datasource="#dts#" name="getdisplay">
	select * from displaysetup
</cfquery>
<cfoutput>
<table width="100%">
<tr>
<th width="2%">No</th>
<th width="15%" <cfif getdisplay.simple_itemno neq 'Y'>style="visibility:hidden"</cfif>>Item Code</th>
<th width="30%" <cfif getdisplay.simple_desp neq 'Y'>style="visibility:hidden"</cfif>>Description</th>
<th width="10%" <cfif getdisplay.simple_qty neq 'Y'>style="visibility:hidden"</cfif>>Quantity</th>

<th width="10%" <cfif getdisplay.simple_brand neq 'Y'>style="display:none"</cfif>>Brand</th>
<th width="10%" <cfif getdisplay.simple_group neq 'Y'>style="display:none"</cfif>>#getgsetup.lgroup#</th>
<th width="10%" <cfif getdisplay.simple_category neq 'Y'>style="display:none"</cfif>>#getgsetup.lcategory#</th>
<th width="10%" <cfif getdisplay.simple_model neq 'Y'>style="display:none"</cfif>>#getgsetup.lmodel#</th>
<th width="10%" <cfif getdisplay.simple_rating neq 'Y'>style="display:none"</cfif>>#getgsetup.lrating#</th>
<th width="10%" <cfif getdisplay.simple_sizeid neq 'Y'>style="display:none"</cfif>>#getgsetup.lsize#</th>
<th width="10%" <cfif getdisplay.simple_material neq 'Y'>style="display:none"</cfif>>#getgsetup.lmaterial#</th>

<th width="8%" <cfif getdisplay.simple_price neq 'Y'>style="visibility:hidden"</cfif>>Price</th>
<th width="8%" <cfif getdisplay.simple_disc neq 'Y'>style="visibility:hidden"</cfif>>Discount</th>
<th width="8%" <cfif getdisplay.simple_amt neq 'Y'>style="visibility:hidden"</cfif>>Amount</th>
<th width="10%">Action</th>
</tr>
<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> and type='TROU' order by trancode desc
</cfquery>
<cfloop query="getictrantemp">

<cfquery name="getiteminfo" datasource="#dts#">
select sizeid,colorid,brand,category,wos_group,shelf,costcode from icitem where itemno='#getictrantemp.itemno#'
</cfquery>

<tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictrantemp.currentrow#</td>
<td nowrap <cfif getdisplay.simple_itemno neq 'Y'>style="visibility:hidden"</cfif>>#getictrantemp.itemno#</td>
<td nowrap <cfif getdisplay.simple_desp neq 'Y'>style="visibility:hidden"</cfif>><a onmouseover="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('itemdesp');">#getictrantemp.desp#</a></td>

<td nowrap align="right" <cfif getdisplay.simple_qty neq 'Y'>style="visibility:hidden"</cfif>> <input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}"></td>
<td width="10%" <cfif getdisplay.simple_brand neq 'Y'>style="display:none"</cfif>>#getiteminfo.brand#</td>
<td width="10%" <cfif getdisplay.simple_group neq 'Y'>style="display:none"</cfif>>#getiteminfo.wos_group#</td>
<td width="10%" <cfif getdisplay.simple_category neq 'Y'>style="display:none"</cfif>>#getiteminfo.category#</td>
<td width="10%" <cfif getdisplay.simple_model neq 'Y'>style="display:none"</cfif>>#getiteminfo.shelf#</td>
<td width="10%" <cfif getdisplay.simple_rating neq 'Y'>style="display:none"</cfif>>#getiteminfo.costcode#</td>
<td width="10%" <cfif getdisplay.simple_sizeid neq 'Y'>style="display:none"</cfif>>#getiteminfo.sizeid#</td>
<td width="10%" <cfif getdisplay.simple_material neq 'Y'>style="display:none"</cfif>>#getiteminfo.colorid#</td>


<td nowrap align="right" <cfif getdisplay.simple_price neq 'Y'>style="visibility:hidden"</cfif>><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changeprice');getfocus4();">#numberformat(val(getictrantemp.price_bil),',.__')#</a></td>
<td nowrap align="right" <cfif getdisplay.simple_disc neq 'Y'>style="visibility:hidden"</cfif>><input type="text" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem4#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" ></td>
<td nowrap align="right" <cfif getdisplay.simple_amt neq 'Y'>style="visibility:hidden"</cfif>>#numberformat(val(getictrantemp.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#')" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>

</table>
</cfoutput>
