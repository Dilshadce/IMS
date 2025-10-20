<html>
<head>
<title>Batch Code Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
<body>
<h1><center><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>Batch Code</cfif> Report Menu</center></h1>
<br><br>
Click on the following to select reports.
<br><br>

<table width="75%" border="0" class="data" align="center">
  	<tr> 
		<cfif getpin2.h4910 eq "T">
    		<td><a href="batchreportform.cfm?type=itembatchopening" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Opening</a></td>
		</cfif>
		<cfif getpin2.h4920 eq "T">
    		<td><a href="batchreportform.cfm?type=itembatchsales" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Sales</a></td>
    	</cfif>
		<cfif getpin2.h4930 eq "T">
			<td><a href="batchreportform.cfm?type=itembatchstatus" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Status</a></td>
  		</cfif>
	</tr>
  	<tr> 
    	<td colspan="4" height="20"></td>
  	</tr>
  	<tr> 
		<cfif getpin2.h4940 eq "T">
			<td><a href="batchreportform.cfm?type=itembatchstockcard" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Stock Card</a></td>
		</cfif>
        <cfif getpin2.h4940 eq "T">
			<td><a href="batchreportform.cfm?type=itembatchstockcard&stockcard2=1" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Stock Card 2</a></td>
		</cfif>
    	
    	<cfif getpin2.h4960 eq "T">
			<td><a href="batchreportform.cfm?type=locationitembatchopening" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Opening</a></td>
		</cfif>
	</tr>
  	<tr> 
    	<td colspan="4" height="20"></td>
  	</tr>
  	<tr> 
		<cfif getpin2.h4970 eq "T">
			<td><a href="batchreportform.cfm?type=locationitembatchsales" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Sales</a></td>
		</cfif>
		<cfif getpin2.h4980 eq "T">
    		<td><a href="batchreportform.cfm?type=locationitembatchstatus" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Status</a></td>
		</cfif>
		<cfif getpin2.h4990 eq "T">
    		<td><a href="batchreportform.cfm?type=locationitembatchstockcard" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Stock Card</a></td>
		</cfif>
  	</tr>
	<tr>
    <cfif getpin2.h4950 eq "T">
			<td><a href="batchreportform.cfm?type=batchlisting" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfif checkcustom.customcompany eq "Y">Lot Number -<cfelse>Batch</cfif> Item Listing</a></td>
		</cfif>
    </tr>
		<tr> 
	    	<td colspan="4" height="20"></td>
	  	</tr>
	  	<tr> 
        <cfif checkcustom.customcompany eq "Y">
			<cfif getpin2.HC401 eq "T">
				<td><a href="batchreportform.cfm?type=itembatchstockcard2" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Stock Card 2</a></td>
			</cfif>
       	<cfelse>
        <td><a href="batchreportform.cfm?type=itembatchstockcard2" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Stock Card 2</a></td>
        </cfif>
        
         <cfif checkcustom.customcompany eq "Y">
			<cfif getpin2.HC402 eq "T">
	    		<td><a href="batchreportform.cfm?type=locationitembatchstockcard2" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Stock Card 2</a></td>
			</cfif>
            <cfelse>
            <td><a href="batchreportform.cfm?type=locationitembatchstockcard2" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Stock Card 2</a></td>
            </cfif>
            <cfif checkcustom.customcompany eq "Y">
			<cfif getpin2.HC403 eq "T">
	    		<td><a href="batchreportform.cfm?type=locationitembatchstatus2" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Stock Balance Report</a></td>
			</cfif>
            <cfelse>
            <td><a href="batchreportform.cfm?type=locationitembatchstatus2" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Location Stock Balance Report</a></td>
            </cfif>
	  	</tr>
	  	<tr> 
	    	<td colspan="4" height="20"></td>
	  	</tr>
	  	<tr> 
         <cfif checkcustom.customcompany eq "Y">
		  	<cfif getpin2.HC404 eq "T">
				<td><a href="batchreportform2.cfm?type=monthly" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Lot Number Monthly Report</a></td>
			</cfif>
            <cfelse>
            <td><a href="batchreportform2.cfm?type=monthly" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Lot Number Monthly Report</a></td>
            </cfif>
            <cfif checkcustom.customcompany eq "Y">
			<cfif getpin2.HC405 eq "T">
				<td><a href="batchreportform2.cfm?type=bydate_tran" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Lot Number - Stock Movement Report</a></td>
			</cfif>		
            <cfelse>
            <td><a href="batchreportform2.cfm?type=bydate_tran" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Lot Number - Stock Movement Report</a></td>
            </cfif>
             	  
			<td><a href="batchreportform2.cfm?type=salesreport" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Outstanding Sales Order Report</a></td>  		
 
	  	</tr>

</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>