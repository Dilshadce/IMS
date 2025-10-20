<html>
<head>
<title>Package Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getGroup" datasource="#dts#">
  select * from package
  <cfif form.groupfrom neq "" and form.groupto neq "">
	where Package >= '#form.groupfrom#' and Package <= '#form.groupto#'
  </cfif>
  order by packcode
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from package order by packcode
</cfquery>
<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Package</cfoutput> Listing</strong></font></div>

  <cfif getGroup.recordCount gt 0>

	<table width="95%" border="0" class="" align="center">
  	  <tr><td colspan="8"><hr></td></tr>
	  <tr>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif"><center>No</center></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Package</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Description</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Amount</font></strong></td>
        
      </tr>
  	  <tr><td colspan="8"><hr></td></tr>
      <cfset i = 1>
	  <cfloop query="getGroup">
	  	<cfoutput>
	    <tr>
	      <td><div align="center">#i#</div></td>
	      <td><cfif getpin2.h1511 eq 'T'><a href="Packagetable2.cfm?type=Edit&packcode=#packcode#">#packcode#</a><cfelse>#packcode#</cfif></td>
	      <td>#packdesp#</td>
          <td>#numberformat(grossamt,',_.__')#</td>
	      
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
