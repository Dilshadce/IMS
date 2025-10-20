<html>
<head>
<title>Print Location Opening Quantity</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="get_location_item" datasource="#dts#">
	select location,itemno,locqfield,lreorder,lminimum 
	from locqdbf 
	order by location,itemno;
</cfquery>

<table align="center" width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
		<td colspan="5"><div align="center"><font size="4" face="Times New Roman,Times,serif"><strong>Print Location Opening Quantity</strong></font></div></td>
	</tr>
	<tr>
		<td colspan="5"><hr/></td>
	</tr>
	<tr>
		<th><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Location</strong></font></div></th>
		<th><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Item No.</strong></font></div></th>
		<th><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Qty B/f</strong></font></div></th>
		<th><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Reorder</strong></font></div></th>
		<th><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Minimum</strong></font></div></th>
	</tr>
	<tr>
		<td colspan="5"><hr/></td>
	</tr>
	<cfoutput query="get_location_item">
	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td nowrap><div align="left"><font size="2" face="Times New Roman,Times,serif">#get_location_item.location#</font></div></td>
		<td nowrap><div align="left"><font size="2" face="Times New Roman,Times,serif">#get_location_item.itemno#</font></div></td>
		<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(get_location_item.locqfield,0)#</font></div></td>
		<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#get_location_item.lreorder#</font></div></td>
		<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#get_location_item.lminimum#</font></div></td>
	</tr>
	</cfoutput>
</table>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>

</body>
</html>