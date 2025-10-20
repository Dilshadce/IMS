<html>
<head>
<title>Edit Item Opening Quantity/Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp,unit,qtybf,ucost,avcost,avcost2 
	from icitem 
	order by itemno;
</cfquery>

<body>

<h1 align="center">Item Opening Quantity</h1>

<table align="center">
<tr>
<th>Filter By</th>
<td>
<select name="filtercolumn" id="filtercolumn">
<option value="itemno">Itemno</option>
<option value="desp">Description</option>
<option value="ucost">Cost</option>
</select>
</td>
<th>Filter Text</th>
<td>
<input type="text" name="filter" id="filter" value="" />
	<input type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('usersgrid',false)">
</td>
<td width="50%"></td>
</tr>
<tr>
<td colspan="5">
	<cfform name="display" format="html" width="1000" height="800">
		<cfgrid name="usersgrid" align="middle" format="html" 
			bind="cfc:Maintenance.getitem({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
			onchange="cfc:Maintenance.editItemOP({cfgridaction}, {cfgridrow}, {cfgridchanged},'#dts#','#HUserID#')"
			selectonload="false" selectmode="edit" maxrows="20">
	        
			<cfgridcolumn name="itemno" header="Itemno" width="80"  select="no">
		      <cfgridcolumn name="desp" header="Description" width="250" select="no">
			<cfgridcolumn name="unit" header="U.O.M" width="100">
			<cfgridcolumn name="qtybf" header="B/F Qty" width="100">
		      <cfgridcolumn name="ucost" header="Fixed Cost" width="100">
			<cfgridcolumn name="avcost" header="Mth. Av. Cost" width="100">
			<cfgridcolumn name="avcost2" header="Mov. Av. Cost" width="100">
			<cfgridcolumn name="itemno1" header="FIFO TAB" select="No" href="fifoopq1.cfm" width="100" hrefkey="itemno1">
		
		</cfgrid>
	</cfform>
</td>
</tr>
</table>

</body>
</html>