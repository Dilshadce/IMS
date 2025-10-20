
<cfoutput>
<cfset datestart = createdate(listlast(form.datefrom,'/'),listgetat(form.datefrom,'2','/'),listfirst(form.datefrom,'/'))>
  <cfset dateend = createdate(listlast(form.dateto,'/'),listgetat(form.dateto,'2','/'),listfirst(form.dateto,'/'))>
<cfquery name="getassign" datasource="#dts#">
SELECT * FROM assignmentslip
WHERE (batches = "" or batches is null)
and assignmentslipdate BETWEEN "#dateformat(datestart,'YYYY-MM-DD')#" and "#dateformat(dateend,'YYYY-MM-DD')#"
<cfif form.comfrm neq "" and form.comto neq "">
and custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comfrm#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
and empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
<cfif form.placementfrom neq "" and form.placementto neq "">
and Placementno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementto#">
</cfif>
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
ORDER BY custno,refno,assignmentslipdate
</cfquery>
<h1>Assign Batches</h1>
<form name="markassignment" id="markassignment" action="markassign.cfm" method="post">
<table>
<tr>
<th>No.</th>
<th>Ref No</th>
<th>Date</th>
<th>Customer</th>
<th>Emp No</th>
<th>Name</th>
<th>Action</th>
</tr>
<cfloop query="getassign">
<tr>
<td>#getassign.currentrow#</td>
<td>#getassign.refno#</td>
<td>#dateformat(getassign.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getassign.custname#</td>
<td>#getassign.empno#</td>
<td>#getassign.empname#</td>
<td>
<input type="checkbox" name="asnrefno" id="asnrefno" value="#getassign.refno#" />
</td>
</tr>
</cfloop>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Assign" />
</td>
</tr>
</table>
</form>
</cfoutput>