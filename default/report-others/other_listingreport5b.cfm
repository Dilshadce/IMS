<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Others Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfquery datasource="#dts#" name="getcust">
	select name from #target_arcust# where custno = "#url.custno#"
</cfquery>
<cfoutput>
  <h2 align="left">Customer: </h2>
  <h2 align="left">#url.custno# - #getcust.name#</h2>
</cfoutput>
<body>
<table border="0" align="center" class="data">
  <tr>
    <th>Q1</th>
    <th>Q2</th>
	<th>Q3</th>
    <th>Q4</th>
	<th>Total (SD)</th>
  </tr>
	<cfquery datasource="#dts#" name="getlastyr">
		select lastaccyear from gsetup
	</cfquery>
	<cfquery datasource="#dts#" name="getperiod1">
		select sum(price) as sumperiod1 from ictran where custno = "#url.custno#" and wos_group = "#url.wos_group#" and currrate like "1.65%" and type = "INV"
		and fperiod >= 0 and fperiod <= 3 group by itemno
	</cfquery>
	<cfquery datasource="#dts#" name="getperiod2">
		select sum(price) as sumperiod2 from ictran where custno = "#url.custno#" and wos_group = "#url.wos_group#" and currrate like "1.65%" and type = "INV"
		and fperiod >= 3 and fperiod <= 6 group by itemno
	</cfquery>
	<cfquery datasource="#dts#" name="getperiod3">
		select sum(price) as sumperiod3 from ictran where custno = "#url.custno#" and wos_group = "#url.wos_group#" and currrate like "1.65%" and type = "INV"
		and fperiod >= 7 and fperiod <= 9 group by itemno
	</cfquery>
	<cfquery datasource="#dts#" name="getperiod4">
		select sum(price) as sumperiod4 from ictran where custno = "#url.custno#" and wos_group = "#url.wos_group#" and currrate like "1.65%" and type = "INV"
		and fperiod >= 10 and fperiod <= 12 group by itemno
	</cfquery>
	<cfquery datasource="#dts#" name="getinv1">
		select sum(price) as sumprice from ictran where custno = "#url.custno#" and wos_group = "#url.wos_group#" and currrate like "1.65%" and type = "INV" group by itemno
	</cfquery>
	<cfoutput>
    <tr>
      <td>#getperiod1.sumperiod1#</td>
      <td>#getperiod2.sumperiod2#</td>
	  <td>#getperiod3.sumperiod3#</td>
      <td>#getperiod4.sumperiod4#</td>
	  <td>#getinv1.sumprice#</td>
    </tr>
	</cfoutput>
</table>
</body>
</html>
