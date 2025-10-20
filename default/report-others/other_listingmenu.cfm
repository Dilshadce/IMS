<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Others Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<h1><center>
    Others Report Menu 
  </center></h1>

<br><br>
Click on the following to select reports.
<br><br>
<!--- <table width="75%" border="0" class="data" align="center">
  <tr> 
    <td colspan="4"><div align="center"> Report</div></td>
  </tr>
  <tr> 
    <td width="25%"><a href="../report-others/other_listingreport.cfm?type=1"><img name="Cash Sales" src="../../images/reportlogo.gif">Flash 
      Reports </a></td>
    <td width="25%"><a href="../report-others/other_listingreport.cfm?type=2"><img src="../../images/reportlogo.gif" name="Cash Sales">Aging 
      Reports </a></td>
    <td width="25%"><a href="../report-others/other_listingreport.cfm?type=3"><img name="Cash Sales" src="../../images/reportlogo.gif">Baraton 
      Reports </a></td>
    <td width="25%"><a href="../report-others/other_listingreport.cfm?type=4"><img name="Cash Sales" src="../../images/reportlogo.gif">Market 
      Mix </a></td>
  </tr>
  <tr> 
    <td><a href="../report-others/other_listingreport.cfm?type=5" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Top 
      20 Customers</a></td>
    <td><a href="../report-others/other_listingreport.cfm?type=6"><img src="../../images/reportlogo.gif" name="Cash Sales">Product 
      Mix </a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p> --->
<!--- <table width="75%" border="0" align="center" class="data">
  <tr> 
    <td colspan="4"><div align="center">Project Reports</div></td>
  </tr>
  <tr> 
    <td width="24%"><a href="../report-billing/bill_listingreport.cfm?type=8" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Project 
      Sales Report</a></td>
    <td width="26%"><a href="../report-billing/bill_listingreport.cfm?type=9" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Project 
      Purchase Report</a></td>
    <td width="25%"><a href="../report-billing/bill_listingreport.cfm?type=10" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Project 
      - Item Report</a></td>
    <td width="25%"><a href="../report-billing/bill_listingreport.cfm?type=11" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Project 
      - Agent Report</a></td>
  </tr>
</table> --->

<p>&nbsp;</p>
<table width="75%" border="0" align="center" class="data">
<cfquery name="getgeneral" datasource="#dts#">
select * from gsetup
</cfquery>
  <tr> 
    <td colspan="4"><div align="center"><cfoutput>#getgeneral.lserial# REPORTS</cfoutput></div></td>
  </tr>
  
  <!--- <tr> 
    <td width="25%"><a href="serial_reportmenu.cfm?type=1" target="mainFrame"><img name="Serial Number" src="../../images/reportlogo.gif">Retrieve 
      Serial Number by Invoice</a></td>
    <td width="26%"><a href="../report-billing/bill_listingreport.cfm?type=9" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Retrieve 
      Serial Number by Customer ID</a></td>
    <td width="24%"><a href="../report-billing/bill_listingreport.cfm?type=10" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">View 
      Stock Card by Serial Number</a></td>
    <td width="25%"><a href="../report-billing/bill_listingreport.cfm?type=11" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Check 
      Validity of warranty </a></td>
  </tr> --->
  <tr>
    <cfif getpin2.h4610 eq 'T'><td><a href="serialreport1.cfm?type=ref" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transaction 
      Listing by Refno No</a></td></cfif>
    <cfif getpin2.h4620 eq 'T'><td><a href="serialreport1.cfm?type=item" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transaction 
      Listing by Item</a></td></cfif>
    <cfif getpin2.h4630 eq 'T'><td><a href="serialreport1.cfm?type=status" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item 
      - <cfoutput>#getgeneral.lserial#</cfoutput>. Status</a></td></cfif>
    <cfif getpin2.h4640 eq 'T'><td><a href="serialreport1.cfm?type=sale" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#getgeneral.lserial#</cfoutput>. Sales Listing</a></td></cfif>
  </tr>
</table>
</body>
</html>
