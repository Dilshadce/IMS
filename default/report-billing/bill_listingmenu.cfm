<html>
<head>
<title>Billing Listing Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>


<body>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>
<h1><center>Bill Listing Menu</center></h1>
<br><br>Click on the following to select reports.<br><br>
 <cfoutput>
<table width="85%" border="0" class="data" align="center">
	<tr>
    	<td colspan="5"><div align="center">BILL LISTING REPORTS</div></td>
  	</tr>
  	<tr>
   
    	<cfif getpin2.h4110 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=1" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lRC#</a></td></cfif>
    	<cfif getpin2.h4120 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=2" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lPR#</a></td></cfif>
    	<cfif getpin2.h4130 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=3" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lDO#</a></td></cfif>
    	<cfif getpin2.h4140 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=4" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lINV#</a></td></cfif>
    	<cfif getpin2.h4150 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=9" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lQUO#</a></td></cfif>
  	</tr>
  	<tr>
    	<cfif getpin2.h4160 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=5" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lCN#</a></td></cfif>
    	<cfif getpin2.h4170 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=6" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lDN#</a></td></cfif>
    	<cfif getpin2.h4180 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=7" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lCS#</a></td></cfif>
    	<cfif getpin2.h4190 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=8" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lPO#</a></td></cfif>
    	<cfif getpin2.h41A0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=10" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lSO#</a></td></cfif>
  	</tr>
  	<tr>
    	<cfif getpin2.h41C0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=11" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lSAM#</a></td></cfif>
		<cfif getpin2.h41B0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=12" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lISS#</a></td></cfif>
   		<cfif getpin2.h41D0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=13" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lOAI#</a></td></cfif>
    	<cfif getpin2.h41E0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=14" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">#getGeneralInfo.lOAR#</a></td></cfif>
    	<cfif getpin2.h41F0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=15" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transfer Note</a></td></cfif>
  	</tr>
    <tr>
    	<cfif getpin2.h41F0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=16" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Consignment Return</a></td></cfif>
        <cfif getpin2.h41F0 eq 'T'><td><a href="../report-billing/bill_listingreport.cfm?type=17" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Consignment Out</a></td></cfif>
  	</tr>
    
</table>
</cfoutput>
</body>
</html>