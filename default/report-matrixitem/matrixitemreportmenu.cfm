<html>
<head>
<title>Matrix Item Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<h1><center>Matrix Item Report Menu</center></h1>
<br><br>
Click on the following to select reports.
<br><br>

<table width="75%" border="0" class="data" align="center">
  	<tr> 
		<cfif getpin2.h4B10 eq "T">
    	<td>
			<a href="matrixreportform.cfm?type=opening" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Matrix Item Opening
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4B20 eq "T">
    	<td>
			<a href="matrixreportform.cfm?type=sales" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Matrix Item Sales
			</a>
		</td>
		</cfif>
  	</tr>
  	<tr> 
    	<td height="20"></td>
  	</tr>
  	<tr>
		<cfif getpin2.h4B30 eq "T"> 
		<td>
			<a href="matrixreportform.cfm?type=purchase" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Matrix Item Purchase
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4B40 eq "T">
    	<td>
			<a href="matrixreportform.cfm?type=stockbalance" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Matrix Stock Balance
			</a>
		</td>
		</cfif>
    	<td></td>
	</tr>
    <cfif lcase(HcomID) eq "verjas_i" or lcase(HcomID) eq "supervalu_i">
    <tr> 
    	<td height="20"></td>
  	</tr>
    <tr>
    <cfif getpin2.h4B40 eq "T">
    	<td>
			<a href="mitemphysical_worksheet_menu.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				<cfif lcase(HcomID) eq "supervalu_i">Supervalu Physical WorkSheet<cfelse>Verjas Physical WorkSheet</cfif>
			</a>
		</td>
		</cfif>
    	<cfif getpin2.h4B40 eq "T">
    	<td>
			<a href="mitemstocklocation_menu.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				<cfif lcase(HcomID) eq "supervalu_i">Supervalu Stock Card<cfelse>Verjas Stock Card</cfif>
			</a>
		</td>
		</cfif>
	</tr>
    <tr> 
    	<td height="20"></td>
  	</tr>
    <tr>
    <cfif getpin2.h4B40 eq "T">
    	<td>
			<a href="matrix_status_form.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				<cfif lcase(HcomID) eq "supervalu_i">Supervalu Matrix Status & Value Report<cfelse>Verjas Matrix Status & Value Report</cfif>
			</a>
		</td>
		</cfif>
     <cfif getpin2.h4B40 eq "T">
    	<td>
			<a href="matrixitemlocationstock_card.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				<cfif lcase(HcomID) eq "supervalu_i">Supervalu Matrix Balance Stock Report<cfelse>Verjas Matrix Balance Stock Report</cfif>
			</a>
		</td>
		</cfif>
    </tr>
    </cfif>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>