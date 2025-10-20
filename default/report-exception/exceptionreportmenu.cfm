<html>
<head>
<title>Exception Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<h1><center>Exception Report Menu</center></h1>
<br><br>Click on the following to select reports.<br><br>
<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<table width="85%" border="0" class="data" align="center">
	<tr>
    	<td colspan="5"><div align="center">EXCEPTION REPORTS</div></td>
  	</tr>
  	<tr>
    	<td><a href="../report-exception/nolocationreport.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transaction with item without location report</a></td>
        <td><a href="../report-exception/noagentreport.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transaction with no agent report</a></td>
        <cfif getmodule.job eq "1">
        <td><a href="../report-exception/nojobreport.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transaction with no job report</a></td>
        </cfif>
        <cfif getmodule.project eq "1">
        <td><a href="../report-exception/noprojectreport.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transaction - no Project Report</a></td>
        </cfif>
        <td><a href="../report-exception/nobatchcodereport.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transaction with item without batch code report</a></td>
		<cfif getpin2.h3740 eq "T">
        <td><a href="../report-exception/itemnosymbol.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item No Symbol</a></td>
    	</cfif>
  	</tr>
    <tr>
    	<cfif getpin2.h3740 eq "T">
        <td><a href="../report-exception/imspostedbillcheck.cfm" target="_blank"><img name="Cash Sales" src="../../images/reportlogo.gif">Posted IMS Bill Not in AMS</a></td>
    	</cfif>
    </tr>
</table>

</body>
</html>