<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getGroup" datasource="#dts#">
  select * from iccostcode
  <cfif form.groupfrom neq "" and form.groupto neq "">
	where costcode >= '#form.groupfrom#' and costcode <= '#form.groupto#'
  </cfif>
  order by costcode
</cfquery>

<cfquery datasource='#dts#' name="getgeneral">
	Select lrating as layer from gsetup
</cfquery>

<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>#getgeneral.layer#</cfoutput> Listing</strong></font></div>

  <cfif getGroup.recordCount gt 0>

	<table width="95%" border="0" class="" align="center">
  	  <tr><td colspan="8"><hr></td></tr>
	  <tr>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>#getgeneral.layer#</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Description</font></strong></td>
        <cfif left(dts,8) eq "manpower">
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Claimable</font></strong></td>
		</cfif>
      </tr>
  	  <tr><td colspan="8"><hr></td></tr>
      <cfset i = 1>
	  <cfloop query="getGroup">
	  	<cfoutput>
	    <tr>
	      <td><div align="center">#i#</div></td>
	      <td><cfif getpin2.h1511 eq 'T'><a href="costcodetable2.cfm?type=Edit&costcode=#costcode#">#costcode#</a><cfelse>#costcode#</cfif></td>
	      <td>#desp#</td>
	      <cfif left(dts,8) eq "manpower">
        <td>#getGroup.claimable#</td>
		</cfif>
		</tr>
 		</cfoutput>
	    <cfset i = incrementvalue(#i#)>
	  </cfloop>
	</table>

  <cfelse>
  <strong><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.
  </font> </strong>
</cfif>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>


</body>
</html>
