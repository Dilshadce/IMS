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
<h1><center><cfoutput>Service</cfoutput> Report Menu</center></h1>
<br><br>
Click on the following to select reports.
<br><br>

<table width="75%" border="0" class="data" align="center">
  	<tr> 
		<cfif getpin2.h4D10 eq "T">
    	<td>
			<a href="servicereportform.cfm?type=listprojitem" target="mainFrame"><img name="Service Listing" src="/images/reportlogo.gif">
				List By <cfoutput>Service</cfoutput> Item
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4D20 eq "T">
    	<td>
			<a href="servicereportform1.cfm?type=salesiss" target="mainFrame"><img name="Service Income report" src="../../images/reportlogo.gif">
				<cfoutput>Service</cfoutput> Income report
			</a>
		</td>
		</cfif>
        
        		<cfif getpin2.h4D30 eq "T">
    	<td>
			<a href="servicereportform2.cfm?type=salesiss" target="mainFrame"><img name="Customer - ServiceReport" src="../../images/reportlogo.gif">
				Customer - ServiceReport
			</a>
		</td>
		</cfif>
  	</tr>
  	<tr> 
    	<td height="20"></td>
  	</tr>
  	<tr>
		<cfif getpin2.h4D40 eq "T"> 
		<td>
			<a href="servicereportform3.cfm?type=projitemiss" target="mainFrame"><img name="Agent - ServiceReport" src="../../images/reportlogo.gif">
				Agent - ServiceReport
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4D50 eq "T">
    	<td>
			<a href="servicereportform4.cfm" target="mainFrame"><img name="Supplier - ServiceReport" src="../../images/reportlogo.gif">
				Supplier - ServiceReport
			</a>
		</td>
		</cfif>
        
    	<td>

		</td>

	</tr>
    
    	<tr>
		<cfif getpin2.h4D60 eq "T"> 
		<td>
			<a href="servicereportform5.cfm" target="mainFrame"><img name="Service Profit Margin - Transactions" src="../../images/reportlogo.gif">
				Service Profit Margin - Transactions
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4D70 eq "T">
    	<td>
			<a href="servicereportform6.cfm" target="mainFrame"><img name="Service Profit Margin - Service Code" src="../../images/reportlogo.gif">
				Service Profit Margin - Service Code
			</a>
		</td>
		</cfif>
    		<cfif getpin2.h4D80 eq "T">
    	<td>
			<a href="servicemonth.cfm" target="mainFrame"><img name="Service Part Report - By Month" src="../../images/reportlogo.gif">
				Service Part Report - By Month
			</a>
		</td>
		</cfif>
        </tr><tr>
        	<cfif getpin2.h4D90 eq "T">
    	<td>
			<a href="productivitymonth.cfm" target="mainFrame"><img name="Productivity Report - By Month" src="../../images/reportlogo.gif">
				Productivity Report - By Month
			</a>
		</td>
		</cfif>
        	<cfif getpin2.h4D90 eq "T">
    	<td>
			<a href="p_servicereportproject.cfm" target="mainFrame"><img name="Service Report - By Project" src="../../images/reportlogo.gif">
				Service Report - By Project
			</a>
		</td>
		</cfif>
	</tr>
    
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>