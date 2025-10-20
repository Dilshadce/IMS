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
<cfquery datasource="#dts#" name="getdate">
	select wos_date from ictran where type = "SO"
</cfquery>
<cfoutput>
  <h2 align="left">Product: </h2>
  <h2 align="left">#url.itemno# - #getitem.desp#</h2>
</cfoutput>
<body>
<table border="0" align="center" class="data">
  <tr>
    <th>5th Week Booking</th>
    <th>4th Week Booking</th>
    <th>3rd Week Booking</th>
    <th>2nd Week Booking</th>
    <th>1st Week Booking</th>
    <th>Month to Date Booking</th>
  </tr>
  <cfoutput>
 	<cfquery datasource="#dts#" name="getsales">
		select sum(price) as sumprice from ictran where (month(wos_date) = "now" and year(wos_date) = "now") and type = "SO"
		group by #datepart("ww", getdate.wos_date)#
	</cfquery>
    <tr>
      <td>&nbsp;</td>
      <td>#sumprice#</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </cfoutput>
</table>
</body>
</html>
