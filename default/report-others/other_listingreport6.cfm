<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Others Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfif form.itemfrom neq "" and form.itemto neq "" and form.groupfrom neq "" and form.groupto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where itemno >= "#form.itemfrom#" and itemno <= "#form.itemto#" and wos_group >= "#form.groupfrom#"
		and wos_group <= "#form.groupto#" and type = "INV" group by itemno order by wos_group
	</cfquery>
<cfelseif form.itemfrom neq "" and form.itemto neq "" and form.groupfrom eq "" and form.groupto eq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where itemno >= "#form.itemfrom#" and itemno <= "#form.itemto#" and type = "INV" group by itemno order by wos_group
	</cfquery>
<cfelseif form.itemfrom eq "" and form.itemto eq "" and form.groupfrom neq "" and form.groupto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where wos_group >= "#form.groupfrom#" and wos_group <= "#form.groupto#" and type = "INV" group by itemno order by wos_group
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where type = "INV" group by itemno order by wos_group
	</cfquery>
</cfif>
<cfoutput>
  <p align="left">Product: #form.itemfrom# - #form.itemto#</p>
</cfoutput>
<table border="0" align="center" class="data">
  <tr>
    <th width="50">Group</th>
    <th width="100">Product No.</th>
    <th width="265">Description</th>
    <th colspan="2">Booking</th>
    <th colspan="2">Shipment</th>
  </tr>
  <cfoutput query="getinfo">
    <cfquery datasource="#dts#" name="getdesp">
    select desp from icitem where itemno = "#getinfo.itemno#"
    </cfquery>
    <tr>
      <td><div align="left">#getinfo.wos_group#</div></td>
      <td><div align="left">#getinfo.itemno#</div></td>
      <td>#getdesp.desp#</td>
      <td width="85"><div align="center"><a href="../report-others/other_listingreport6a.cfm?itemno=#getinfo.itemno#&wos_group=#getinfo.wos_group#">Local
          </a></div></td>
      <td width="92"><div align="center"><a href="../report-others/other_listingreport6b.cfm?itemno=#getinfo.itemno#&wos_group=#getinfo.wos_group#">Foreign
          </a></div></td>
      <td width="81"><div align="center"><a href="../report-others/other_listingreport6a.cfm?itemno=#getinfo.itemno#&wos_group=#getinfo.wos_group#">Local
          </a></div></td>
      <td width="92"><div align="center"><a href="../report-others/other_listingreport6b.cfm?itemno=#getinfo.itemno#&wos_group=#getinfo.wos_group#">Foreign</a></div></td>
    </tr>
  </cfoutput>
</table>
</body>
</html>
