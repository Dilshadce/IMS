<cfoutput>
<html>
<head>
<title>Finished Good Report</title>
</head>
<body>
<cfquery name="getproject" datasource="#dts#">
SELECT * FROM finishedgoodar WHERE
1=1
<cfif form.projectfrom neq "" and form.projectto neq "">
and project between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and fperiod between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodto#">
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
and created_on between "#dateformat(ndate,'YYYY-MM-DD')#" and "#dateformat(ndate1,'YYYY-MM-DD')#"
</cfif>
order by project
</cfquery>
<table width="80%" align="center">
<tr>
<th colspan="100%"><h3>Finished Goods Report</h3></th>
</tr>
<tr>
<td colspan="100%" align="center"> 
<cfif form.projectfrom neq "" and form.projectto neq "">
SALES ORDER FROM #form.projectfrom# TO #form.projectto#
</cfif>
</td>
</tr>
<tr>
<td colspan="100%" align="center"> 
<cfif form.periodfrom neq "" and form.periodto neq "">
PERIOD FROM #form.periodfrom# TO #form.periodto#
</cfif>
</td>
</tr>
<tr>
<td colspan="100%" align="center"> 
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
DATE FROM #dateformat(ndate,'YYYY-MM-DD')# TO #dateformat(ndate1,'YYYY-MM-DD')#
</cfif>
</td>
</tr>
<cfloop query="getproject">
<tr><td colspan="100%"><hr /></td></tr>
<tr>
<th align="left">Sales Order</th>
<td colspan="2">#getproject.project#</td>
<th align="left">Itemno</th>
<td colspan="2">#getproject.itemno#</td>
<th align="left">Quantity</th>
<td colspan="2">#getproject.quantity#</td>
</tr>
<tr>
<th align="left">SI No</th>
<th align="left">Item No</th>
<th align="left">Job</th>
<th align="left">Heat</th>
<th align="left">Status</th>
<th align="right">Used Qty</th>
<th align="right">Reject Qty</th>
<th align="right">Reject Code</th>
<th align="right">Return Qty</th>
<th align="right">Write Off Qty</th>
</tr>
<cfquery name="getprojectitem" datasource="#dts#">
SELECT * FROM finishedgoodic WHERE arid = "#getproject.id#"
</cfquery>
<cfloop query="getprojectitem">
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td>#getprojectitem.refno#</td>
<td>#getprojectitem.itemno#</td>
<td>#getprojectitem.job#</td>
<td>#getprojectitem.brem1#</td>
<td>#getprojectitem.status#</td>
<td align="right">#getprojectitem.usedqty#</td>
<td align="right">#getprojectitem.rejectqty#</td>
<td align="right">#getprojectitem.rejectcode#</td>
<td align="right">#getprojectitem.returnqty#</td>
<td align="right">#getprojectitem.writeoffqty#</td>
</tr>
</cfloop>
<tr>
<td>&nbsp;&nbsp;</td>
</tr>
</cfloop>
</table>
</body>
</html>
</cfoutput>
