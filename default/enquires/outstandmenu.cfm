<html>
<head>
<title>Outstanding Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<body>
<h1><center>
    Outstanding Report Menu 
  </center></h1>
Click on the following to select reports.
<br><br>
<table width="75%" border="0" class="data" align="center">
  <tr> 
    <td colspan="4"><div align="center">OUTSTANDING REPORTS</div></td>
  </tr>
  <tr> 
    <cfif getpin2.h3210 eq 'T'><td width="25%"><a href="../enquires/outreport.cfm?type=DO"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lDO#</cfoutput></a></td></cfif>
    <cfif getpin2.h3220 eq 'T'><td width="25%"><a href="../enquires/outreport.cfm?type=QUO"><img src="../../images/reportlogo.gif" name="Cash Sales"><cfoutput>#gettranname.lQUO#</cfoutput></a></td></cfif>
    <cfif getpin2.h3230 eq 'T'><td width="25%"><a href="../enquires/outreport.cfm?type=3"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lPO#</cfoutput></a></td></cfif>
    <cfif getpin2.h3240 eq 'T'><td width="25%"><a href="../enquires/outreport.cfm?type=4"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lPO#</cfoutput> 
      Details</a></td></cfif>
  </tr>
  <tr> 
    <cfif getpin2.h3250 eq 'T'><td><a href="../enquires/outreport.cfm?type=5"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lSO#</cfoutput></a></td></cfif>
    <cfif getpin2.h3260 eq 'T'><td><a href="../enquires/outreport.cfm?type=6"><img src="../../images/reportlogo.gif" name="Cash Sales"><cfoutput>#gettranname.lSO#</cfoutput>
      Details</a></td></cfif>
    <cfif getpin2.h3270 eq 'T'><td><a href="../enquires/outreport.cfm?type=7"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lSO#</cfoutput> 
      to <cfoutput>#gettranname.lPO#</cfoutput></a></td>
      <td><a href="../enquires/outreport.cfm?type=8"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lSO#</cfoutput> 
      to <cfoutput>#gettranname.lPO#</cfoutput> Material</a></td>
      </cfif>
    <td>&nbsp;</td>
  </tr>
	<tr><td height="10"></td></tr>
	<tr> 
		<td colspan="4"><div align="center">UPDATED BILL</div></td>
	</tr>
	<tr>
    <cfif getpin2.h3290 eq 'T'>
		<td>
        
			<a href="../enquires/updatedbill_form.cfm?frtype=SO&totype=INV"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lSO#</cfoutput> To <cfoutput>#gettranname.lINV#</cfoutput></a>
		</td>
    </cfif>
    <cfif getpin2.h32A0 eq 'T'>
		<td>
			<a href="../enquires/updatedbill_form.cfm?frtype=SO&totype=PO"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lSO#</cfoutput> To <cfoutput>#gettranname.lPO#</cfoutput></a>
		</td>
   </cfif>
   <cfif getpin2.h32B0 eq 'T'>
		<td>
			<a href="../enquires/updatedbill_form.cfm?frtype=QUO&totype="><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lQUO#</cfoutput></a>
		</td>
   </cfif>
   <cfif getpin2.h32C0 eq 'T'>
		<td>
			<a href="../enquires/updatedbill_form.cfm?frtype=PO&totype=RC"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lPO#</cfoutput> To <cfoutput>#gettranname.lRC#</cfoutput></a>
		</td>
  	</cfif>
	</tr>
	<tr>
    <cfif getpin2.h32D0 eq 'T'>
		<td>
			<a href="../enquires/updatedbill_form.cfm?frtype=DO&totype=INV"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lDO#</cfoutput> To <cfoutput>#gettranname.lINV#</cfoutput></a>
		</td>
     </cfif>
	</tr>
</table>
</body>
</html>
