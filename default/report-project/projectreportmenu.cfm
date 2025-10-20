<cfquery datasource="#dts#" name="getgeneral">
	Select lPROJECT,lJOB from gsetup
</cfquery>
<html>
<head>
<title><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<h1><center><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report Menu</center></h1>
<br><br>
Click on the following to select reports.
<br><br>

<table width="75%" border="0" class="data" align="center">
  	<tr> 
		<cfif getpin2.h4C10 eq "T">
    	<td>
			<a href="projectreportform.cfm?type=listprojitem" target="mainFrame"><img name="List By Project Item" src="../../images/reportlogo.gif">
				List By <cfoutput>#getgeneral.lPROJECT#</cfoutput> Item
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4C20 eq "T">
    	<td>
			<a href="projectreportform.cfm?type=salesiss" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				<cfoutput>#getgeneral.lPROJECT#</cfoutput> Sales & Issue
			</a>
		</td>
		</cfif>
  	</tr>
  	<tr> 
    	<td height="20"></td>
  	</tr>
  	<tr>
		<cfif getpin2.h4C30 eq "T"> 
		<td>
			<a href="projectreportform.cfm?type=projitemiss" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				<cfoutput>#getgeneral.lPROJECT#</cfoutput> - Item Issue
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4C40 eq "T">
    	<td>
			<a href="projectreportform.cfm?type=itemprojiss" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Item - <cfoutput>#getgeneral.lPROJECT#</cfoutput> Issue
			</a>
		</td>
		</cfif>
    	<td></td>
	</tr>
    <tr> 
    	<td height="20"></td>
  	</tr>
      	<tr>
		<cfif getpin2.h4C30 eq "T"> 
		<td>
			<a href="projectreportform1.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				<cfoutput>#getgeneral.lPROJECT#</cfoutput> - Cost & Sales
			</a>
		</td>
		</cfif>
    	<td></td>
	</tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>