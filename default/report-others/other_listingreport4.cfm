<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Others Report Menu</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfoutput>
  <p align="left">Products: #form.itemfrom# - #form.itemto#</p>
</cfoutput> 

<cfif form.itemfrom neq "" and form.itemto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where itemno >= "#form.itemfrom#" and itemno <= "#form.itemto#" group by itemno 
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran group by itemno 
	</cfquery>
</cfif>
<table width="646" border="0" align="center" class="data">
  <tr> 
    <th width="127">Item No.</th>
    <th width="276">Desp</th>
    <th width="108">Local Amount</th>
    <th width="109">Foreign Amount</th>
  </tr>
  <cfoutput query="getinfo"> 
    <cfquery datasource="#dts#" name="getname">
    select desp from icitem where itemno = "#getinfo.itemno#" 
    </cfquery>
    <tr> 
      <td><div align="left">#getinfo.itemno#</div></td>
      <td>#getname.desp#</td>
      <td><div align="center"><a href="../report-others/other_listingreport4a.cfm?itemno=#getinfo.itemno#">View Details</a></div></td>
      <td><div align="center"><a href="../report-others/other_listingreport4b.cfm?itemno=#getinfo.itemno#">View Details</a></div></td>
    </tr>
  </cfoutput> 
</table>
</body>
</html>
