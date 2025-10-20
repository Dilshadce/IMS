<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Others Report Menu</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfquery datasource="#dts#" name="getitem">
	select desp from icitem where itemno = "#form.getfrom#"
</cfquery>

<cfif #form.getfrom# neq "" and #form.period# neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where itemno = "#form.getfrom#" and fperiod = "#form.period#" and custno like "3%" and type = "DN" group by custno
	</cfquery>
<cfelseif #form.getfrom# neq "" and #form.period# eq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where itemno = "#form.getfrom#" and custno like "3%" and type = "DN" group by custno
	</cfquery>
<cfelseif #form.getfrom# eq "" and #form.period# neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where fperiod = "#form.period#" and custno like "3%" and type = "DN" group by custno
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where custno like "3%" and type = "DN" group by custno
	</cfquery>
</cfif>

<body>
<h1><center><p>Aging Report</p></center></h1>

<cfoutput>
  <p align="left">Product: #form.getfrom# - #getitem.desp#</p>
</cfoutput>

<table border="0" align="center" class="data">
  <tr> 
    <th>Customer No.</th>
    <th>Name</th>
    <th>Total Balance</th>
    <th>Current</th>
    <th>Past Due</th>
  </tr>
 <cfoutput query="getinfo">
 <cfquery datasource="#dts#" name="getname">
 	select name from #target_arcust# where custno = "#getinfo.custno#"
 </cfquery>
  <tr> 
    <td>#getinfo.custno#</td>
    <td>#getname.name#</td>
    <td>#numberformat(getinfo.price,"___.__")#</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 </cfoutput> 
</table>

</body>
</html>
