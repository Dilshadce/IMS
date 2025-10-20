<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Sales Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<h1>
  <center>
    Cash Sales Report Menu
  </center>
</h1>
<br>
<br>
Click on the following to select reports. <br>
<br>
<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup;
</cfquery>
<table width="75%" border="0" class="data" align="center">
  <tr>
    <td colspan="4"><div align="center">Cash Sales report</div></td>
  </tr>
  <tr>
  	<cfif getpin2.H4I20 eq 'T'>
    	<td><a href="../report-sales/cashsales.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Cash Sales Report By User</a></td>
    </cfif>
    
    <cfif getpin2.H4I40 eq 'T'>
    <td><a href="../report-sales/cashsalessummary.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Cash Sales Summary Report </a></td>
    </cfif>
    
    <cfif getpin2.H4I30 eq 'T'>
    <td><a href="../report-sales/cashsalesbycounter.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Cash Sales Report By Counter </a></td>
    </cfif>
    
    <cfif getpin2.H4I10 eq 'T'>
    <td><a href="../report-sales/cashsalesreport.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">General Cash Sales Report</a></td>
    </cfif>
  </tr>
  <tr>
  	<cfif getpin2.H4I50 eq 'T'>
    <td><a href="../report-sales/dailycheckout.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Daily Checkout Report 1</a></td>
    </cfif>
    
    <cfif getpin2.H4I60 eq 'T'>
    <td><a href="../report-sales/dailycheckoutA.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Daily Checkout Report 2</a></td>
    </cfif>
    
    <cfif getpin2.H4I70 eq 'T'>
    <td><a href="../report-sales/salesreportitem.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Product Sales Report 1</a></td>
    </cfif>
    
    <cfif getpin2.H4I80 eq 'T'>
    <td><a href="../report-sales/cashsalesbycashier.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Daily Sales Report</a></td>
    </cfif>
  </tr>
  <tr>
  	<cfif getpin2.H4I90 eq 'T'>
    <td><a href="../report-sales/dailycashsales.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Daily Sales Report Detail</a></td>
    </cfif>
    <cfif getpin2.H4IA0 eq 'T'>
      <td><a href="../report-sales/salesdetailbyrefnoB.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Sales Detail by Ref No 2</a></td>
    </cfif>
    <cfif getpin2.H4IB0 eq 'T'>
    <td><a href="../report-sales/cashsalesvoucher.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Cash Sales Voucher Report</a></td>
    </cfif>
  </tr>

</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>