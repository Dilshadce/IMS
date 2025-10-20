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
<h3>
	<a href="/default/maintenance/openqtymaintenance/openqtymenu.cfm">Opening Quantity Menu</a> >> 
	<a><font size="2">Item Opening Quantity</font></a>
</h3>
<h1 align="center">Item Opening Quantity</h1>
<!----- replace with CFGRID by edwin
<table width="75%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
	<tr>
    	<th>Item No.</th>
    	<th>Unit</th>
    	<th>Qty B/f</th>
    	<th>Fixed Cost</th>
    	<th>Mth.Ave.Cost</th>
    	<th>Mov.Ave.Cost</th>
    	<th>Action</th>
  	</tr>
  	<cfoutput query="getitem">
  		<tr>
    		<td>#itemno# - #desp#</td>
    		<td><div align="center">#unit#</div></td>
    		<td><div align="right">#qtybf#</div></td>
    		<td><div align="right">#numberformat(ucost,",_.____")#</div></td>
    		<td><div align="right">#numberformat(avcost,",_.____")#</div></td>
    		<td><div align="right">#numberformat(avcost2,",_.____")#</div></td>
    		<td align="center"><a href="fifoopq1.cfm?itemno=#urlencodedformat(itemno)#">Edit</a></td>
  		</tr>
  	</cfoutput>
	
</table>
------->
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
			<cfgridcolumn name="itemno" header="FIFO TAB" select="No" href="fifoopq1.cfm" width="100" hrefkey="escape(itemno)">
		
		</cfgrid>
	</cfform>
</td>
</tr>
</table>

</body>
</html>