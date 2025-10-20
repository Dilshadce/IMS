<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Others Report Menu</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfif form.custfrom neq "" and form.custto neq "" and form.groupfrom neq "" and form.groupto neq "" and form.periodfrom neq "" and form.periodto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where custno >= "#form.custfrom#" and custno <= "#form.custto#" and wos_group >= "#form.groupfrom#" 
		and wos_group <= "#form.groupto#" and fperiod >= "#form.periodfrom#" and fperiod <= "#form.periodto#" and type = "INV" 
		group by itemno order by custno 
	</cfquery>
<cfelseif form.custfrom neq "" and form.custto neq "" and form.groupfrom eq "" and form.groupto eq "" and form.periodfrom eq "" and form.periodto eq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where custno >= "#form.custfrom#" and custno <= "#form.custto#" and type = "INV" group by itemno order by custno 
	</cfquery>
<cfelseif form.custfrom eq "" and form.custto eq "" and form.groupfrom neq "" and form.groupto neq "" and form.periodfrom eq "" and form.periodto eq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where wos_group >= "#form.groupfrom#" and wos_group <= "#form.groupto#" and type = "INV" group by itemno 
		order by custno 
	</cfquery>
<cfelseif form.custfrom neq "" and form.custto neq "" and form.groupfrom neq "" and form.groupto neq "" and form.periodfrom eq "" and form.periodto eq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where custno >= "#form.custfrom#" and custno <= "#form.custto#" and wos_group >= "#form.groupfrom#" and 
		wos_group <= "#form.groupto#" and type = "INV" group by itemno order by custno 
	</cfquery>
<cfelseif form.custfrom neq "" and form.custto neq "" and form.groupfrom eq "" and form.groupto eq "" and form.periodfrom neq "" and form.periodto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where custno >= "#form.custfrom#" and custno <= "#form.custto#" and fperiod >= "#form.periodfrom#" and 
		fperiod <= "#form.periodto#" and type = "INV" group by itemno order by custno 
	</cfquery>
<cfelseif form.custfrom eq "" and form.custto eq "" and form.groupfrom neq "" and form.groupto neq "" and form.periodfrom neq "" and form.periodto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where wos_group >= "#form.groupfrom#" and wos_group <= "#form.groupto#" and fperiod >= "#form.periodfrom#" and 
		fperiod <= "#form.periodto#" and type = "INV" group by itemno order by custno 
	</cfquery>	
<cfelseif form.custfrom eq "" and form.custto eq "" and form.groupfrom eq "" and form.groupto eq "" and form.periodfrom neq "" and form.periodto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where fperiod >= "#form.periodfrom#" and fperiod <= "#form.periodto#" and type = "INV" group by itemno order by custno 
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where type = "INV" group by itemno order by custno
	</cfquery>
</cfif>
<cfoutput>
  <p align="left">Customer: #form.custfrom# - #form.custto#</p>
</cfoutput> 
<table width="673" border="0" align="center" class="data">
  <tr> 
    <th width="85">Customer No.</th>
    <th width="280">Name</th>
    <th width="93">Item No.</th>
    <th width="40">Quantity</th>
    <th width="93">Date Sold</th>
    <th width="70">Inv No.</th>
  </tr>
  <cfoutput query="getinfo"> 
    <cfquery datasource="#dts#" name="getname">
    select name from #target_arcust# where custno = "#getinfo.custno#" 
    </cfquery>
    <tr> 
      <td><div align="center">#getinfo.custno#</div></td>
      <td>#getname.name#</td>
      <td>#itemno#</td>
      <td><div align="center">#qty#</div></td>
      <td><div align="center">#dateformat(wos_date,"DD-MM-YYYY")#</div></td>
      <td><div align="center">#refno#</div></td>
    </tr>
  </cfoutput> 
</table>
</body>
</html>
