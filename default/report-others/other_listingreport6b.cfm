<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Others Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfquery datasource="#dts#" name="getitem">
	select desp from icitem where itemno = "#url.itemno#"
</cfquery>
<cfoutput>
  <h2 align="left">Product: </h2>
  <h2 align="left">#url.itemno# - #getitem.desp#</h2>
</cfoutput>
<body>
<table border="0" align="center" class="data">
  <tr>
    <th>5th Week Shipping</th>
    <th>4th Week Shipping</th>
    <th>3rd Week Shipping</th>
    <th>2nd Week Shipping</th>
    <th>1st Week Shipping</th>
    <th>Month to Date Shipping</th>
  </tr>
  <cfoutput>
	<cfquery datasource="#dts#" name="getsales">
		select sum(price) as sumprice from ictran where (month(wos_date) = "now" and year(wos_date) = "now") and type = "SO"
	</cfquery>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </cfoutput>
</table>
</body>
</html>
