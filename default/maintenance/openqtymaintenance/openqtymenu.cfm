<html>
<head>
<title>Open Quantity Maintenance Menu</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
    select * from gsetup
</cfquery>
<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>
<body>
<h1><center>Open Quantity Maintenance Menu</center></h1>
<br><br>
Please select a function.
<br><br>

<table width="60%" border="0" class="data" align="center">
  	<tr> 
    	<cfif getpin2.h1K10 eq "T">
			<td nowrap><a href="../openqtymaintenance/fifoopq.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit Item Opening Quantity/Cost</a></td>
    	</cfif>
		<cfif getpin2.h1K20 eq "T">
			<td nowrap>
            	<a href="../openqtymaintenance/batch.cfm?modeaction=no" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">
            		Edit <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Opening Quantity
                </a>
            </td>
  		</cfif>
	</tr>
  	<tr> 
    	<td colspan="4" height="20"></td>
  	</tr>
  	<tr>
    <cfif getmodule.location eq "1">

		<cfif getpin2.h1K30 eq "T">
			<td nowrap><a href="../openqtymaintenance/location_opening_qty_maintenance.cfm?modeaction=no" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit Location Opening Quantity</a></td>
		</cfif>
        
        
        <cfif getpin2.h1K30 eq "T">
			<td nowrap><a href="../openqtymaintenance/location_opening_qty_maintenance-new.cfm?modeaction=no" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">New Edit Location Opening Quantity</a></td>
		</cfif>
		<cfif getpin2.h1K40 eq "T">
			<td nowrap>
            	<a href="../openqtymaintenance/locationbatch.cfm?modeaction=no" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">
                	Edit Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Opening Quantity
                </a>
            </td>
		</cfif>
        </cfif>
	</tr>
    	<!---<td><a href="../openqtymaintenance/fifoopq.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit Batch Opening Quantity</a></td>
  	</tr>
  	<tr> 
    	<td colspan="4" height="20"></td>
  	</tr>
  	<tr> 
    	<td><a href="../openqtymaintenance/fifoopq.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit Batch Opening Quantity</a></td>
    	<td><a href="../openqtymaintenance/fifoopq.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit Batch Opening Quantity</a></td>
    	<td><a href="../openqtymaintenance/fifoopq.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit Batch Opening Quantity</a></td>
  	</tr> --->
	<tr> 
    	<td colspan="4" height="20"></td>
  	</tr>
  	<tr>
    <cfif getmodule.serialno eq "1" >
		<cfif getpin2.h1K50 eq "T">
			<td nowrap><a href="../openqtymaintenance/serialno_opening_qty_maintenance.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit <cfoutput>#getgsetup.lserial#</cfoutput>. Opening Quantity</a></td>
		</cfif>
        </cfif>
        <cfif getmodule.grade eq "1" >
		<cfif getpin2.h1K60 eq "T">
			<td nowrap><a href="../openqtymaintenance/grade_opening_qty_maintenance.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Edit Item - Grade Opening Quantity</a></td>
		</cfif>
        </cfif>
        <cfif getmodule.grade eq "1" >
        <cfif getpin2.h1K60 eq "T">
			<td nowrap><a href="/default/maintenance/openqtymaintenance/grade.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">New Edit Item - Grade Opening Quantity</a></td>
		</cfif>
        </cfif>
	</tr>
	<tr> 
    	<td colspan="4" height="20"></td>
  	</tr>
  	<tr>
		<cfif getpin2.h1K70 eq "T">
			<td nowrap><a href="../openqtymaintenance/s_opvalue.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Enquiry Opening Value</a></td>
	  	</cfif>
        <cfif getpin2.h1K70 eq "T">
			<td nowrap><a href="../openqtymaintenance/checkopeningqty.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Check Opening Value with Fifo</a></td>
	  	</cfif>
		<td></td>
	</tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>