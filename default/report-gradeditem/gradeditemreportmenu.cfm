<html>
<head>
<title>Graded Item Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<h1><center>Graded Item Report Menu</center></h1>
<br><br>
Click on the following to select reports.
<br><br>

<table width="75%" border="0" class="data" align="center">
  	<tr> 
		<cfif getpin2.h4A10 eq "T">
    	<td>
			<a href="physical_worksheet_form.cfm?type=physical" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item Physical Worksheet
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4A20 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=opening" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item Opening
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4A30 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=sales" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item Sales
			</a>
		</td>
		</cfif>
  	</tr>
  	<tr> 
    	<td height="20"></td>
  	</tr>
  	<tr> 
		<cfif getpin2.h4A40 eq "T">
		<td>
			<a href="gradedreportform.cfm?type=status" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item Status
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4A50 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=stockcard" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item Stock Card
			</a>
		</td>
		</cfif>
        <cfif getpin2.h4A20 eq "T">
    	<td>
			<a href="grade_openingqty2.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">
				Graded Item Opening Check
			</a>
		</td>
		</cfif>
	</tr>
  	<tr> 
    	<td height="20"></td>
  	</tr>
  	<tr> 
		<cfif getpin2.h4A60 eq "T">
		<td>
			<a href="gradedreportform.cfm?type=itemlocopening" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item - Location Opening
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4A70 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=itemlocsales" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item - Location Sales
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4A80 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=itemlocstatus" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Graded Item - Location Status
			</a>
		</td>
		</cfif>
  	</tr>
	<tr> 
    	<td height="20"></td>
  	</tr>
	<tr>
		<cfif getpin2.h4A90 eq "T"> 
    	<td>
			<a href="locationphysical_worksheet_form.cfm?type=locitemphysical" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Location - Graded Item Physical Worksheet
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4AA0 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=locitemopening" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Location - Graded Item Opening
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4AB0 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=locitemsales" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Location - Graded Item Sales
			</a>
		</td>
		</cfif>
  	</tr>
  	<tr> 
    	<td height="20"></td>
  	</tr>
  	<tr>
		<cfif getpin2.h4AC0 eq "T"> 
		<td>
			<a href="gradedreportform.cfm?type=locitemstatus" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Location - Graded Item Status
			</a>
		</td>
		</cfif>
		<cfif getpin2.h4AD0 eq "T">
    	<td>
			<a href="gradedreportform.cfm?type=locitemstockcard" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Location - Graded Item Stock Card
			</a>
		</td>
		</cfif>
        
        <cfif getpin2.h4A50 eq "T">
    	<td>
			<a href="gradedstockcheck.cfm?type=gradedcheckstock" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Location - Graded Stock Check
			</a>
		</td>
		</cfif>
    	<td></td>
	</tr>
    <tr>
    <cfif getpin2.h4A50 eq "T">
    	<td>
			<a href="grade_openingqty.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Location - Graded Stock Opening Check
			</a>
		</td>
	</cfif>
    </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>