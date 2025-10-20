<cfif isdefined('url.id')>
<cfoutput>
<cfquery name="getgeneral" datasource="#dts#">
	select filterall,displayaitemno from gsetup
</cfquery>

<h1>Finished Good Item Assemble List</h1>
<cfquery name="getproject" datasource="#dts#">
SELECT * FROM finishedgoodar WHERE id = "#url.id#"
</cfquery>
<cfform name="reinsert" id="reinsert" action="process.cfm" method="post">
<input type="hidden" name="arid" id="arid" value="#url.id#" />
<table width="800px">
<tr>
<th>Sales Order</th>
<td>#getproject.project#</td>
<th>Quantity</th>
<td>
<cfinput type="text" name="quantity" id="quantity" value="#getproject.quantity#" required="yes" validate="float" validateat="onsubmit" message="Quantity is required / invalid!" /></td>
<th>Location</th>
<td>
<cfquery name="getlocation" datasource="#dts#">
select location, concat(location,' - ',desp) as desp from iclocation order by location
</cfquery>
<cfselect name="location" id="location" query="getlocation" value="location" display="desp" selected="#getproject.location#"></cfselect></td>
</tr>
<tr>
<th>Itemno</th>
<td colspan="9">
<cfif getgeneral.displayaitemno eq 'Y'>
<cfquery name="getitem" datasource="#dts#">
select itemno, concat(aitemno,' - ',desp) as desp from icitem order by itemno
</cfquery>
<cfelse>
<cfquery name="getitem" datasource="#dts#">
select itemno, concat(itemno,' - ',desp) as desp from icitem order by itemno
</cfquery>
</cfif>
<cfselect name="itemno" id="itemno" query="getitem" value="itemno" display="desp" selected="#trim(getproject.itemno)#"></cfselect></td>
</tr>
<tr>
<th>Item No</th>
<th>Product Code</th>
<th>Job</th>
<th>Heat</th>
<th>Status</th>
<th>Used Qty</th>
<th>Reject Qty</th>
<th>Reject Code</th>
<th>Return Qty</th>
<th>Write Off Qty</th>
<th>Other Code</th>
</tr>
<cfquery name="getprojectitem" datasource="#dts#">
SELECT * FROM finishedgoodic WHERE arid = "#url.id#" order by itemno
</cfquery>
<cfquery name="getitem" datasource="#dts#">
SELECT "" as itemno, "Choose an Item" as desp
union all
select itemno, concat(itemno,' - ',desp) as desp from icitem order by itemno
</cfquery>
<cfloop query="getprojectitem">
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td>#getprojectitem.itemno#</td>
<cfquery name="getitemproductcode" datasource="#dts#">
select aitemno from icitem where itemno='#getprojectitem.itemno#'
</cfquery>
<td>#getitemproductcode.aitemno#</td>
<td>#getprojectitem.job#</td>
<td>#getprojectitem.brem1#</td>
<cfset fieldname = "_#getprojectitem.itemno#_#getprojectitem.batchcode#">
<cfset fieldname = replace(fieldname,'-','_','all')>
<td><select name="status#fieldname#" id="status#fieldname#" onchange="if(this.value == 'partial'){document.getElementById('returnqty#fieldname#').disabled=true;document.getElementById('returnqty#fieldname#').style.display='none';}else{document.getElementById('returnqty#fieldname#').disabled=false;document.getElementById('returnqty#fieldname#').style.display='block';}">
<option value="partial" <cfif getprojectitem.status eq "Partial">selected="selected" </cfif>>Partial</option>
<option value="finish" <cfif getprojectitem.status eq "finish">selected="selected" </cfif>>Finish</option>
</select></td>
<td><input type="text" name="usedqty#fieldname#" id="usedqty#fieldname#" value="#getprojectitem.usedqty#" size="10" /></td> 
<td><input type="text" name="rejectqty#fieldname#" id="rejectqty#fieldname#" value="#getprojectitem.rejectqty#" size="10" /></td>
<td>

<cfselect name="rejectcode#fieldname#" id="rejectcode#fieldname#" selected="#getprojectitem.rejectcode#" query="getitem" value="itemno" display="itemno" ></cfselect>
<!--- <input type="text" name="rejectcode#fieldname#" id="rejectcode#fieldname#" value="#getprojectitem.rejectcode#" size="10" /> ---></td>
<td><input type="text" name="returnqty#fieldname#" id="returnqty#fieldname#" size="10" value="#getprojectitem.returnqty#"<cfif getprojectitem.status eq "partial"> style="display:none" </cfif> /></td>
<td><input type="text" name="writeoffqty#fieldname#" id="writeoffqty#fieldname#" size="10" value="#getprojectitem.writeoffqty#"/></td>
<td>
<input type="button" name="othercode" id="othercode" value="Add" onclick="document.getElementById('fgicid').value='#getprojectitem.id#';ColdFusion.Window.show('addothercode');" />
</td>
</tr>
</cfloop>
<cfif getproject.rcno eq "">
<tr>
<td align="center" colspan="100%"><input type="button" name="submitbtn" id="submitbtn" value="Save & Process" onclick="document.reinsert.action='process.cfm';formsubmit();"/>&nbsp;&nbsp;<input type="button" name="submitbtn" id="submitbtn" value="Completed" onclick="document.reinsert.action='process.cfm?process=1';formsubmit();" /></td>
</tr>
</cfif>
</table>
</cfform>
</cfoutput>
</cfif>