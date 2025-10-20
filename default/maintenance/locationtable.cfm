<html>
<head>
<title>View <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif></title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--- ADD ON 15-07-2009 --->
<cfquery name="getGsetup" datasource="#dts#">
  Select lLOCATION from GSetup
</cfquery>	
	
<cfquery datasource='#dts#' name="getPersonnel">
	Select * from iclocation order by location
</cfquery>			
			
<h1>View <cfoutput>#getGsetup.lLOCATION#</cfoutput> Informations</h1>

<cfoutput>
  	<h4>
	<cfif getpin2.h1D10 eq 'T'><a href="locationtable2.cfm?type=Create">Creating a New #getGsetup.lLOCATION#</a> </cfif>
	<cfif getpin2.h1D20 eq 'T'>|| <a href="locationtable.cfm">List All #getGsetup.lLOCATION#</a> </cfif>
	<cfif getpin2.h1D30 eq 'T'>|| <a href="s_locationtable.cfm?type=Icitem">Search For #getGsetup.lLOCATION#</a></cfif>
    
     <cfif getpin2.h1630 eq 'T'>|| <a href="p_location.cfm"> #getGsetup.lLOCATION# Listing</a></cfif>
     <cfif getpin2.h1630 eq 'T'>|| <a href="itemlocationenquire.cfm">Item #getGsetup.lLOCATION# Balance Listing</a></cfif>
	</h4>
</cfoutput>

<table align="center">
<tr>
<td>
	<cfform name="display" format="html" width="1000" height="800">
		<cfgrid name="usersgrid" align="middle" format="html" 
			bind="cfc:Maintenance.getlocation({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},'#dts#')"
			onchange="cfc:Maintenance.editlocation({cfgridaction}, {cfgridrow}, {cfgridchanged},'#dts#','#HUserID#')"
			selectonload="false" selectmode="edit" delete="yes" deletebutton="Delete">
	        	
			<cfgridcolumn name="location" header="Location Code" width="80"  select="no" href="locationtable2.cfm?type=edit&location=location" hrefkey="location">
		      <cfgridcolumn name="desp" header="Description" width="250" select="no">
			<cfgridcolumn name="outlet" header="Consignment" select="no">
			<cfgridcolumn name="custno" header="Customer No" select="no">
		      <cfgridcolumn name="addr1" header="Address 1">
			<cfgridcolumn name="addr2" header="Address 2">
			<cfgridcolumn name="addr3" header="Address 3">
			<cfgridcolumn name="addr4" header="Address 4">

			<!----<cfgridcolumn name="avcost" header="Mth. Av. Cost" width="100">
			<cfgridcolumn name="avcost2" header="Mov. Av. Cost" width="100">
			<cfgridcolumn name="itemno" header="Action" select="No" href="fifoopq1.cfm?itemno=#getitem.itemno#"width="100" values="Action">--->
		</cfgrid>
	</cfform>
</td>
</tr>
</table>
		
</body>
</html>