<html>
<head>
<title>Placement Leave Detail Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">


<cfquery name="getmonthyear" datasource="payroll_main">
SELECT myear,mmonth FROM gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset datelastnow = daysinmonth(createdate("#getmonthyear.myear#","#getmonthyear.mmonth#","1"))>
<cfset datenow = createdate("#getmonthyear.myear#","#getmonthyear.mmonth#","#datelastnow#")>
<cfquery name="getplacementlist" datasource="#dts#">
SELECT * FROM placement
WHERE 1=1
<cfif form.result eq 'active'>
  and completedate > '#dateformat(datenow,'yyyy-mm-dd')#'
  <cfelseif form.result eq 'ended'>
  and completedate <= '#dateformat(datenow,'yyyy-mm-dd')#'
  <cfelse>
  </cfif>
<cfif form.custfrom neq "" and form.custto neq "">
AND custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
</cfif>
<cfif form.departmentfrom neq "" and form.departmentto neq "">
AND department Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.departmentfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.departmentto#">
</cfif>
<cfif form.supervisorfrom neq "" and form.supervisorto neq "">
AND supervisor Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisorfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisorto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
AND empno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
ORDER BY custname,empname
</cfquery>
<cfoutput>
<h1>Choose Employee</h1>
<form action="l_placementleave2.cfm" method="post">
<table width="70%">
<tr>
<th>Employee Number</th>
<th>Employee Name</th>
<th>Action</th>
</tr>
<cfloop query="getplacementlist">
<tr>
<td>#getplacementlist.empno#</td>
<td>#getplacementlist.empname#</td>
<td>
<input type="checkbox" name="empnofield" id="empnofield" value="#getplacementlist.empno#" checked>
</td>
</tr>
</cfloop>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Submit">
</td>
</tr>
</table>
</form>
</cfoutput>

</body>
</html>
