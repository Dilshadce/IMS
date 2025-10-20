<html>
<head>
<title>Store Keeper Report Menu</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><center>Store Keeper Report Menu</center></h1>
<br><br>Click on the following to select reports.<br><br>

<table width="75%" border="0" class="data" align="center">

  	<tr> 
    	<cfif getpin2.h4E10 eq "T">
			<cftry>
				<cfquery name="getrecord" datasource="#dts#">
					SELECT lastaccdate FROM icitem_last_year limit 1
				</cfquery>
				<td><a href="../report-store/stockcard0.cfm?type=1" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Stock Card</a></td>
			<cfcatch type="any">
				<td><a href="../report-store/stockcard.cfm?type=1" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Stock Card</a></td>
			</cfcatch>
			</cftry>
			<!--- <cfif hcomid eq "idi_i" or hcomid eq "demo_i" or hcomid eq "saehan_i" or hcomid eq "ge_i" or hcomid eq "redd_i" or lcase(hcomid) eq "mhsl_i">
				<td><a href="../report-stock/stockcard0.cfm?type=1" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Stock Card</a></td>
			<cfelse>
				<td><a href="../report-stock/stockcard.cfm?type=1" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Stock Card</a></td>
			</cfif> --->
		</cfif>
    	
		<cfif getpin2.h4E20 eq "T">
			<td><a href="../report-store/saleslisting.cfm" target="mainFrame"><img name="Customer Item Sales Listing" src="../../images/reportlogo.gif">Customer Item Sales Listing</a></td>
	  </cfif>
      
    	<cfif getpin2.h4E30 eq "T"><td><a href="../report-store/invdetaillisting.cfm" target="mainFrame"><img name="Customer Invoice Detail Listing" src="../../images/reportlogo.gif">Customer Invoice Detail Listing</a></td>
  </cfif>	</tr>
  
 	<tr><cfif getpin2.h4E40 eq "T">
		<td><a href="../report-store/supplieritem.cfm" target="mainFrame"><img name="Supplier Ite Transaction Listing" src="../../images/reportlogo.gif">Supplier Item Transaction Listing</a></td> </cfif>
        
		<cfif getpin2.h4E50 eq "T"><td><a href="../report-store/supplierbill.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Supplier Bill Detail Listing</a></td></cfif>
		
</table>

<br><br><br>

</body>
</html>