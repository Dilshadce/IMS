<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Others Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfif form.custfrom neq "" and form.custto neq "" and form.groupfrom neq "" and form.groupto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where custno >= "#form.custfrom#" and custno <= "#form.custto#" and wos_group >= "#form.groupfrom#"
		and wos_group <= "#form.groupto#" and type = "INV" group by custno order by custno
	</cfquery>
<cfelseif form.custfrom neq "" and form.custto neq "" and form.groupfrom eq "" and form.groupto eq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where custno >= "#form.custfrom#" and custno <= "#form.custto#" and type = "INV" group by custno order by custno
	</cfquery>
<cfelseif form.custfrom eq "" and form.custto eq "" and form.groupfrom neq "" and form.groupto neq "">
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where wos_group >= "#form.groupfrom#" and wos_group <= "#form.groupto#" and type = "INV" group by custno order by custno
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getinfo">
		select * from ictran where type = "INV" group by itemno order by custno
	</cfquery>
</cfif>
<cfoutput>
  <p align="left">Customer: #form.custfrom# - #form.custto#</p>
</cfoutput>
<table width="637" border="0" align="center" class="data">
  <tr>
    <th width="107">Customer No.</th>
    <th width="229">Name</th>
    <th width="91">Group</th>
    <th width="89">Local Amount</th>
    <th width="99">Foreign Amount</th>
  </tr>
  <cfoutput query="getinfo">
    <cfquery datasource="#dts#" name="getname">
    select name from #target_arcust# where custno = "#getinfo.custno#"
    </cfquery>
    <tr>
      <td><div align="center">#getinfo.custno#</div></td>
      <td>#getname.name#</td>
      <td>#getinfo.wos_group#</td>
      <td><div align="center"><a href="../report-others/other_listingreport5a.cfm?custno=#getinfo.custno#&wos_group=#getinfo.wos_group#">View
          Details</a></div></td>
      <td><div align="center"><a href="../report-others/other_listingreport5b.cfm?custno=#getinfo.custno#&wos_group=#getinfo.wos_group#">View
          Details</a></div></td>
    </tr>
  </cfoutput>
</table>
</body>
</html>
