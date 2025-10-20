<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Serial No Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfquery datasource="#dts#" name="getitem">
	select * from icitem where wserialno = 1 order by edi_id
</cfquery>
<cfquery datasource="#dts#" name="getcust">
	select * from #target_arcust#
</cfquery>
<cfquery datasource="#dts#" name="getgrp">
	select * from icgroup
</cfquery>

<cfif #url.type# eq 1>
	<cfset typename = "Retrieve Serial No by Invoice Number">
</cfif>
<cfif #url.type# eq 2>
	<cfset typename = "Retrieve Serial No by Customer ID">
</cfif>

<body>
<h1><center><cfoutput>#typename# Report</cfoutput></center></h1>

<cfif #url.type# eq 1>
  <cfform action="serial_report1.cfm" method="post" name="form" target="_blank">
    <table border="0" align="center" width="54%" class="data">
      <tr> 
        <th>Product</th>
        <td><div align="center">From</div></td>
        <td colspan="2"><select name="itemfrom">
            <option value="">Choose a Item</option>
            <cfoutput query="getitem"> 
              <option value="#itemno#">#itemno# - #desp#</option>
            </cfoutput> </select></td>
      </tr>
      <tr> 
        <th width="13%">Product</th>
        <td width="6%"> <div align="center">To</div></td>
        <td colspan="2"><select name="itemto">
            <option value="">Choose a Item</option>
            <cfoutput query="getitem"> 
              <option value="#itemno#">#itemno# - #desp#</option>
            </cfoutput> </select> </td>
      </tr>
      <tr> 
        <td colspan="4"><hr></td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">From</div></td>
        <td><select name="groupfrom">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">To</div></td>
        <td><select name="groupto">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="13%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="70%">&nbsp;</td>
        <td width="11%"><input type="submit" name="Submit1222" value="Submit"></td>
      </tr>
    </table>
  </cfform>
</cfif>
</body>
</html>
