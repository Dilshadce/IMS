<cfoutput>
<cfoutput>
<h3>Add Project Item</h3>
<table>
<tr>
<th>Item</th>
<td>:</td>
<td>
<cfquery name='getproduct' datasource='#dts#'>
	select itemno, desp,<cfif url.tran eq "INV" or url.tran eq "SO" or url.tran eq "DO" or url.tran eq "QUO" or url.tran eq "CN" or url.tran eq "DN">price<cfelse>ucost</cfif> as price from icitem where (nonstkitem<>'T' or nonstkitem is null) 
		order by itemno
</cfquery>
<select style="width:250px" name='projectitemlist' id="projectitemlist" onChange="document.getElementById('projectitemdesp').value = this.options[this.selectedIndex].id;if(parseFloat(this.options[this.selectedIndex].title) != 0){for(var a=1;a<=10;a++){document.getElementById('projectprice'+a).value=this.options[this.selectedIndex].title;})}">
        	<option value=''>Choose a Product</option>
          	<cfloop query='getproduct'>
				<option value='#URLEncodedFormat(getproduct.itemno)#' id="#getproduct.desp#" title="#val(getproduct.price)#">#getproduct.itemno# - #getproduct.desp#</option>
          	</cfloop>
		</select>
</td>
</tr>
<tr>
<th>Desp</th>
<td>:</td>
<td>
<input type="text" name="projectitemdesp" id="projectitemdesp" size="60" >
</td>
</tr>
</table>
<cfset glac = "creditsales">
<cfif URLEncodedFormat(url.tran) eq "INV">
<cfset glac = "creditsales">
<cfelseif URLEncodedFormat(url.tran) eq "RC">
<cfset glac = "purchase">
<cfelseif URLEncodedFormat(url.tran) eq "PR" or URLEncodedFormat(tran) eq "PO">
<cfset glac = "purchasereturn">
<cfelseif URLEncodedFormat(url.tran) eq "CN">
<cfset glac = "salesreturn">
<cfelseif URLEncodedFormat(url.tran) eq "CS">
<cfset glac = "cashsales">
</cfif>
<cfquery name="getProject" datasource="#dts#">
				  select source,project, #glac# as glacc from #target_project# where porj = "P" order by source
</cfquery>


<table>
<tr>
<th>Project</th>
<th>GL A/C</th>
<th>Qty</th>
<th>Price</th>
<th>Amount</th>
</tr>
<cfloop from="1" to="10" index="a">
<tr>
<td>
<select style="width:160px" name="project#a#" id="project#a#" onChange="if(this.options[this.selectedIndex].id != '0000/000' && this.options[this.selectedIndex].id !=''){document.getElementById('projectglac#a#').value = this.options[this.selectedIndex].id}">
<option value="">Choose a Project</option>
<cfloop query="getproject">
<option value="#getproject.source#" id="#getproject.glacc#">#getproject.source# - #getproject.project#</option>
</cfloop>
</select>
</td>
<td>
<input type="text" name="projectglac#a#" id="projectglac#a#" size="10">
</td>
<td>
<input type="text" name="projectqty#a#" id="projectqty#a#" size="6" value="0">
</td>
<td>
<input type="text" name="projectprice#a#" id="projectprice#a#" size="10" value="0.00">
</td>
<td>
<input type="text" name="projectamt#a#" id="projectamt#a#" size="10" value="0.00" readonly>
</td>
</tr>
</cfloop>
</table>

</cfoutput>
</cfoutput>