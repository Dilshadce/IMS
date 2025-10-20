<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Chart Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<h1><center>Chart Report Menu</center></h1>
<br><br>
Click on the following to select reports.
<br><br>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
select * from modulecontrol
</cfquery>

<table width="75%" border="0" class="data" align="center">
	<tr> 
    	<td colspan="4"><div align="center">Sales Chart</div></td>
  	</tr>
  	<tr> 
    	<td><a href="default/report-chart/saleschart.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Customer Sales Chart by Month</a></td>
    	<td><a href="default/report-chart/salesbybrand.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Brand Sales Chart</a></td>
  		<td><a href="default/report-chart/salesbybusiness.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Business Sales Chart</a></td>
    	<td><a href="default/report-chart/salesbybusinessagent.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Business Agent Chart</a></td>
    </tr>
  	<tr> 
    	<td colspan="4"><div align="center">Purchase Chart</div></td>
  	</tr>
  	<tr> 
 
    	<td><a href="default/report-chart/purchasebybrand.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Brand Purchase Chart</a></td>
  	</tr>
  	<tr> 
    	<td colspan="4" height="20"></td>
  	</tr>
  	
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>