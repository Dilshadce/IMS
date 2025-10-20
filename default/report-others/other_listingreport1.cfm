<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Others Report Menu</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfquery datasource="#dts#" name="getitem">
	select desp from icitem where itemno = "#form.itemno#"
</cfquery>
<body>
<h1>
<center>
<p>Top 20 Customers Report</p>
</center>
</h1>

<cfparam name="i" default="1" type="numeric">
<cfoutput>
  <p align="left">Product: #itemno# - #getitem.desp#</p>
</cfoutput>

<cfquery datasource="#dts#" name="getinfo">
	select sum(price) as sumprice, custno from ictran where itemno = "#form.itemno#" and custno like "3%" group by custno order by sumprice desc
</cfquery>

  <table border="0" align="center" class="data">
    <tr> 
	  <th>No.</th>
      <th>Customer No.</th>
      <th>Name</th>
      <th>Amount</th>
    </tr>
	<cfoutput query="getinfo" startrow="1" maxrows="20">
		<cfquery name="getname" datasource="#dts#">
		select * from #target_arcust# where custno = "#getinfo.custno#" 
		</cfquery>		
		<tr> 
		  <td>#i#</td>
		  <td>#custno#</td>
		  <td>#getname.name#</td>
		  <td>#sumprice#</td>
		</tr>
		<cfset i = incrementvalue(#i#)>
	</cfoutput>
  </table>

</body>
</html>
