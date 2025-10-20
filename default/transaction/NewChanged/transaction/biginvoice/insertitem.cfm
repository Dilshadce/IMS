<cfif isdefined('url.uuid')>
<cfoutput>
<cfquery name="getmax" datasource="#dts#">
SELECT max(orderno) as maxorderno FROM tempcreatebiitem WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfif val(getmax.maxorderno) eq 0>
	<cfset currentno = 1>
<cfelse>
	<cfset currentno = val(getmax.maxorderno) + 1>
</cfif>

<cfquery name="markorderno" datasource="#dts#">
UPDATE tempcreatebiitem SET orderno = "#currentno#",invdesp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.desp)#"> WHERE id in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refnolist)#" list="yes" separator=",">)
</cfquery>

<cfquery name="getitemlist" datasource="#dts#">
SELECT * FROM tempcreatebiitem WHERE uuid = "#uuid#" and (orderno = "" or orderno is null) ORDER BY refno,id
</cfquery>

<table width="1000px" align="center">
<tr>
<th colspan="100%"><div align="left">Grouped Item List</div></th>
</tr>
<cfquery name="getitemlistgrouped" datasource="#dts#">
SELECT * FROM tempcreatebiitem WHERE uuid = "#uuid#" and (orderno <> "" or orderno is not null) ORDER BY orderno,refno,id
</cfquery>
<cfset startrefnoa = "">
<cfset startcounta = 1>

<cfloop query="getitemlistgrouped">
<cfif startrefnoa neq getitemlistgrouped.orderno>
<cfset startrefnoa = getitemlistgrouped.orderno>

<cfset startcountb = 1>
<tr>
<td>#startcounta#</td>
<th width="5%"><div align="left">No</div></th>
<th width="50%"><div align="left">Item Description</div></th>
<th width="5%"><div align="left">Qty</div></th>
<th width="10%"><div align="right">Price</div></th>
<th width="10%"><div align="right">Amount</div></th>
</tr>
<tr>
<td></td>
<th colspan="6"><div align="left">Invoice Description : #getitemlistgrouped.invdesp#</div></th>
</tr>
<cfset startcounta = startcounta + 1>
</cfif>
<tr>
<td></td>
<td>#startcountb#</td>
<td><div align="left">#getitemlistgrouped.desp#<cfif getitemlistgrouped.desp2 neq ""><br/>#getitemlistgrouped.desp2#</cfif></div></td>
<td><div align="left">#val(getitemlistgrouped.qty)#</div></td>
<td><div align="right">#numberformat(val(getitemlistgrouped.price),'.__')#</div></td>
<td><div align="right">#numberformat(val(getitemlistgrouped.amount),'.__')#</div></td>
</tr>
<cfset startcountb = startcountb + 1>
</cfloop>
<cfif getitemlist.recordcount neq 0>
<tr>
<th colspan="100%"><div align="left">Invoice Description : <input type="text" name="desp" id="desp" value="" size="100" ></div></th>
</tr>
<tr><th colspan="100%"><div align="center">Assignment Slip List Item</div></th></tr>
<tr>
<th><div align="left">Refno</div></th>
<th colspan="100%"><div align="left">Item List</div></th>
</tr>
</cfif>
<cfset startrefno = "">
<cfloop query="getitemlist">
<cfif startrefno neq getitemlist.refno>
<cfset startrefno = getitemlist.refno>
<cfset startcount = 1>
<tr>
<td>#getitemlist.refno#</td>
<th width="5%"><div align="left">No</div></th>
<th width="50%"><div align="left">Item Description</div></th>
<th width="5%"><div align="left">Qty</div></th>
<th width="10%"><div align="right">Price</div></th>
<th width="10%"><div align="right">Amount</div></th>
<th width="10%"><div align="left">Action</div></th>
</tr>
</cfif>

<tr>
<td></td>
<td>#startcount#</td>
<td><div align="left">#getitemlist.desp#<cfif getitemlist.desp2 neq ""><br/>#getitemlist.desp2#</cfif></div></td>
<td><div align="left">#val(getitemlist.qty)#</div></td>
<td><div align="right">#numberformat(val(getitemlist.price),'.__')#</div></td>
<td><div align="right">#numberformat(val(getitemlist.amount),'.__')#</div></td>
<td><input type="checkbox" name="checklist" id="checklist" value="#getitemlist.id#" checked="checked"></td>
</tr>
<cfset startcount = startcount + 1>
</cfloop>
<tr>
<td colspan="100%"><div align="center"><cfif getitemlist.recordcount neq 0><input type="button" name="groupitem" id="groupitem" value="Group Item" onclick="groupitemfunc();"><cfelse>&nbsp;<input type="submit" name="sub_btn" id="sub_btn" value="Create Big Invoice"></cfif></div> </td>
</tr>
</table>
</cfoutput>
</cfif>