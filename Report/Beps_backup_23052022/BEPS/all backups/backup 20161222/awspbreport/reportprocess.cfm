<cfif isdefined('form.datefrom')>
<cfoutput>
  <cfset datestart = createdate(listlast(form.datefrom,'/'),listgetat(form.datefrom,'2','/'),listfirst(form.datefrom,'/'))>
  <cfset dateend = createdate(listlast(form.dateto,'/'),listgetat(form.dateto,'2','/'),listfirst(form.dateto,'/'))>
<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement
WHERE
1=1
<cfif form.comfrm neq "" and form.comto neq "">
and custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comfrm#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
and empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
and (awsdate BETWEEN "#dateformat(datestart,'yyyy-mm-dd')#" and "#dateformat(dateend,'yyyy-mm-dd')#" or bonusdate BETWEEN "#dateformat(datestart,'yyyy-mm-dd')#" and "#dateformat(dateend,'yyyy-mm-dd')#")
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
ORDER BY CUSTNO,empno 
</cfquery>
<h3>AWS & PB Report</h3>
<table border="1">
<tr>
<th valign="top" nowrap="nowrap">SN</th>
<th valign="top" nowrap="nowrap">User</th>
<th valign="top" nowrap="nowrap">Customer No</th>
<th valign="top" nowrap="nowrap">Customer Name</th>
<th valign="top" nowrap="nowrap">Employee No</th>
<th valign="top" nowrap="nowrap">Employee Name</th>
<th valign="top" nowrap="nowrap">PB / AWS</th>
<th valign="top" nowrap="nowrap">Amount</th>
<th valign="top" nowrap="nowrap">Payment Date</th>
<th valign="top" nowrap="nowrap">Admin</th>
<th valign="top" nowrap="nowrap">CPF</th>
<th valign="top" nowrap="nowrap">SDF</th>
<th valign="top" nowrap="nowrap">WI</th>
</tr>


<cfloop query="getplacement">
<cfif getplacement.awsdate neq "">
<cfif getplacement.awsdate gte datestart and getplacement.awsdate lte dateend>
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td>#getplacement.currentrow#</td>
<td>#getplacement.created_by#</td>
<td>#getplacement.custno#</td>
<td>#getplacement.custname#</td>
<td>#getplacement.empno#</td>
<td>#getplacement.empname#</td>
<td>AWS</td>
<td>#numberformat(getplacement.awsamt,'.__')#</td>
<td>#dateformat(getplacement.awsdate,'mm/dd/yyyy')#</td>
<td>#getplacement.awsadmable#</td>
<td>#getplacement.awscpfable#</td>
<td>#getplacement.awssdfable#</td>
<td>#getplacement.awswiable#</td>
</tr>
</cfif>
</cfif>

<cfif getplacement.bonusdate neq "">
<cfif getplacement.bonusdate gte datestart and getplacement.bonusdate lte dateend>
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td>#getplacement.currentrow#</td>
<td>#getplacement.created_by#</td>
<td>#getplacement.custno#</td>
<td>#getplacement.custname#</td>
<td>#getplacement.empno#</td>
<td>#getplacement.empname#</td>
<td>PB</td>
<td>#numberformat(getplacement.bonusamt,'.__')#</td>
<td>#dateformat(getplacement.bonusdate,'mm/dd/yyyy')#</td>
<td>#getplacement.bonusadmable#</td>
<td>#getplacement.bonuscpfable#</td>
<td>#getplacement.bonussdfable#</td>
<td>#getplacement.bonuswiable#</td>
</tr>
</cfif>
</cfif>

</cfloop>
</table>
</cfoutput>
</cfif>