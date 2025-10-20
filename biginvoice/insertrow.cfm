<cfif isdefined('url.uuid')>

<cfquery name="getmax" datasource="#dts#">
SELECT max(orderno) as maxorderno FROM tempcreatebi WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfif val(getmax.maxorderno) eq 0>
	<cfset currentno = 1>
<cfelse>
	<cfset currentno = val(getmax.maxorderno) + 1>
</cfif>

<cfquery name="insertintotemp" datasource="#dts#">
INSERT INTO tempcreatebi (desp,refno,uuid,orderno)
VALUES
<cfloop list="#URLDECODE(url.refnolist)#" index="a">
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.desp)#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#a#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">,
"#currentno#"
)
<cfif a neq listlast(URLDECODE(url.refnolist))>
,
</cfif>
</cfloop>
</cfquery>

<cfquery name="getallrefno" datasource="#dts#">
SELECT refno,orderno FROM tempcreatebi WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#"> ORDER by orderno,refno
</cfquery>

<cfquery name="getinvlist" datasource="#dts#">
select refno,assignmentslipdate,custno,custname,custtotal,created_by,empno,empname from assignmentslip where assignmenttype = "sinvoice" and combine <> "Y" and custno = "#URLDECODE(url.custno)#" and refno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getallrefno.refno)#" separator="," list="yes">)
ORDER BY refno,assignmentslipdate
</cfquery>
<cfoutput>
<div id="ajaxfield">
<table align="center" width="1000px">
<tr>
<th colspan="100%">
<div align="left">
Item Description&nbsp;&nbsp;&nbsp;<input type="text" name="desp" id="desp" value="" size="100"></div></th>
</tr>
<tr>
<th colspan="100%">
<div align="center">
Group List
</div>
</th>
<tr>
<th>No</th>
<th colspan="4">Description</th>
<th colspan="3">Invoice List</th>
</tr>
<cfset liststart = 1>

<cfquery name="getgroup" datasource="#dts#">
SELECT refno,orderno,desp FROM tempcreatebi WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">  group by orderno order by orderno
</cfquery>

<cfloop query="getgroup">
<cfquery name="getinv" datasource="#dts#">
SELECT refno FROM tempcreatebi WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#"> and orderno = "#getgroup.orderno#" ORDER BY refno
</cfquery>
<tr>
<td>#getgroup.currentrow#</td>
<td colspan="4">#getgroup.desp#</td>
<td colspan="3">
<cfloop query="getinv">#getinv.refno#<br />
</cfloop></td>
</tr>
</cfloop>
</tr>
<tr>
<th align="center" colspan="100%"><div align="center">Choose Invoice To Group & Combine</div></th>
</tr>
<tr>
<th>No</th>
<th>Refno</th>
<th>Date</th>
<th>Customer</th>
<th>Employee</th>
<th align="right">Amount</th>
<th>User ID</th>
<th>Action</th>
</tr>
<cfloop query="getinvlist">
<tr>
<td>#getinvlist.currentrow#</td>
<td>#getinvlist.refno#</td>
<td>#dateformat(getinvlist.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getinvlist.custname#</td>
<td>#getinvlist.empno# - #getinvlist.empname#</td>
<td align="right">#numberformat(getinvlist.custtotal,'.__')#</td>
<td>#getinvlist.created_by#</td>
<td>
<input type="checkbox" name="checklist" id="checklist" value="#getinvlist.refno#">
</td>
</tr>
</cfloop>
<tr>
<th colspan="100%">
<div align="center">
<cfif getinvlist.recordcount neq 0>
<input type="button" name="groupitem" id="groupitem" value="Group Invoice" onclick="groupitemfunc();" /></cfif>
<input type="submit" name="sub_btn" id="sub_btn" value="Generate">
</div>
</th>
</tr>
</table>
</div>
</cfoutput>
</cfif>