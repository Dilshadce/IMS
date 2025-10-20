<html>
<head>
<title>Edit Location - Item Record</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="document.edit_location_item.qtybf.focus()">

<cfoutput>
<h1 align="center">Edit Location <font color="red">#url.location#</font> - Item <font color="red">#url.itemno#</font> Record</h1>

<cfquery name="get_edit_location_item" datasource="#dts#">
	select location,itemno,locqfield,lminimum,lreorder 
	from locqdbf  
	where location='#url.location#' and itemno='#url.itemno#';
</cfquery>

<cfform name="edit_location_item" action="location_opening_qty_maintenance.cfm?type=edit&modeaction=#url.modeaction#&location=#URLEncodedFormat(url.location)#&itemno=#URLEncodedFormat(url.itemno)#">	
	<table align="center">
		<tr align="justify">
			<th>Location</th>
			<td nowrap><cfinput name="location" type="text" size="24" maxlength="24" value="#url.location#" readonly></td>
		</tr>
		<tr align="justify">
			<th>Item No</th>
			<td nowrap><cfinput name="items" type="text" size="15" maxlength="15" value="#get_edit_location_item.itemno#" readonly></td>
		</tr>
		<tr align="justify">
			<th>QTY B/F</th>
			<td nowrap><cfinput name="qtybf" type="text" size="5" maxlength="18" required="yes" validate="float" message="The Qty B/F Must Be Integer !" value="#get_edit_location_item.locqfield#"></td>
		</tr>
		<tr align="justify">
			<th>Minimum</th>
			<td nowrap>
				<!--- <cfinput name="reorder" type="text" size="8" maxlength="18" validate="float" message="Please Enter Correct Reorder Value !" value="#get_edit_location_item.lreorder#"> --->
				<cfinput name="minimum" type="text" size="8" maxlength="18" value="#get_edit_location_item.lminimum#">
			</td>
		</tr>
		<tr align="justify">
			<th>Reorder</th>
			<td nowrap>
				<!--- <cfinput name="minimum" type="text" size="8" maxlength="18" validate="float" message="Please Enter Correct Minimum Value !" value="#get_edit_location_item.lminimum#"> --->
				<cfinput name="reorder" type="text" size="8" maxlength="18" value="#get_edit_location_item.lreorder#">
			</td>
		</tr>
		
	</table>
	<table align="center">
		<tr>
			<td><input type="submit" name="Edit" value="Edit"></td>
			<td><input type="button" name="Back" value="Back" onClick="window.location='location_opening_qty_maintenance.cfm?modeaction=#url.modeaction#'"></td>
		</tr>
	</table>
</cfform>
</cfoutput>
</body>
</html>