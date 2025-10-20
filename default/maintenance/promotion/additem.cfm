<h2>Assign Item For Promotion</h2>
<cfquery name="getpromo" datasource="#dts#">
SELECT * FROM promotion WHERE promoid = "#url.promoid#"
</cfquery>
<cfoutput>
<table>
<tr>
<th>
Promotion ID:
</th>
<td>
#url.promoid#
</td>
<th>
Promotion type:
</th>
<td>
#getpromo.type#
</td>
</tr>
<tr>
<th>
Period From:
</th>
<td>
#getpromo.periodfrom#
</td>
<th>
Period To:
</th>
<td>
#getpromo.periodto#
</td>
</tr>
</table>
</cfoutput>
<cfform action="" name="assignitem" method="post">
<cfoutput><input type="hidden" name="promoidlist" id="promoidlist" value="#url.promoid#" /></cfoutput>
<table>
<tr>
<th>
Itemno</th>
<td>
<cfselect name="itemno" id="itemno" bind="cfc:itemno.getitem({filtercolumn2},{filter2},'#dts#')" value="itemno" display="itemdesp" bindonload="yes" /></td>
<td>
<input type="Button" name="additem" id="additem" value="ADD ITEM" onClick="additem1('itemno');" />
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');" value="Add Multi Item" align="right" />
</td>
<td><cfselect name="filtercolumn2" id="filtercolumn2">
<option value="itemno">Item No</option>
<option value="desp">Description</option>
<option value="wos_group">Group</option>
<option value="category">Category</option>
<option value="brand">Brand</option>
</cfselect></td>
<td><input type="text" name="filter2" id="filter2" value="" /></td>
<td>
<input type="Button" name="Search" id="Search" value="Filter" /></td>

</tr>
<tr>
  <th>Group</th>
  <td><cfselect name="group" id="group" bind="cfc:itemno.getgroup('#dts#')" value="wos_group" display="groupdesp" bindonload="yes" /></td>
  <td><input type="Button" name="addgroup2" id="addgroup2" value="ADD GROUP" onClick="additem1('group');" /></td>
  <cfif getpromo.pricedistype eq "Varprice">
  <th>Price</th>
  <td><input type="text" name="newpricing" id="newpricing" value="" /></td>
  <cfset display = "yes" >
  <cfelse>
  <cfset display = "no" >
  <td><input type="hidden" name="newpricing" id="newpricing" value="" /></td>
  <td>&nbsp;</td>
  </cfif>
  <td>&nbsp;</td>
</tr>
<tr>
  <th>Brand</th>
  <td><cfselect name="brand" id="brand" bind="cfc:itemno.getbrand('#dts#')" value="brand" display="branddesp" bindonload="yes" /></td>
  <td><input type="Button" name="addgroup" id="addgroup" value="ADD BRAND" onClick="additem1('brand');" /></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <th>Category</th>
  <td><cfselect name="category" id="category" bind="cfc:itemno.getcate('#dts#')" value="cate" display="catedesp" bindonload="yes" /></td>
  <td><input type="Button" name="addcate" id="addcate" value="ADD CATEGORY" onClick="additem1('category');" /></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
</table>
<hr />
<br />
<table width="100%">
<tr>
					<td>
						Filer By: <cfselect id="filtercolumn1" name="filtercolumn1" bind="cfc:itemlist.getPromoItemColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter1" name="filter1">
						<cfinput type="button" name="filterbutton1" value="Go" id="filterbutton1"
							onclick="ColdFusion.Grid.refresh('itemlist',false)">					</td>
				</tr>
<tr>
<td>
<div style="min-heigh:200px;">
  <cfgrid name="itemlist" pagesize="5" format="html" width="950" height="160"
								bind="cfc:itemlist.getPromoItem({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn1},{filter1},'#dts#',{promoidlist})"
                                onchange="cfc:itemlist.editPromoItem({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete" appendkey="no">
    <cfgridcolumn name="promoitemid" header="Promotion Item ID" select="No" width="100" >
    <cfgridcolumn name="itemno" header="Item No" select="no" width="150">
    <cfgridcolumn name="desp" header="Description" select="no" width="220">
    <cfgridcolumn name="itemprice" header="Price" select="no" width="100" display="#display#" >
    <cfgridcolumn name="Created_by" header="Created By" select="no" width="100">
    <cfgridcolumn name="Created_on" header="Created On" select="no" width="100">
  </cfgrid>
</div></td>
</tr>
</table>
<div id="ajaxFieldPro">
</div>
</cfform>
