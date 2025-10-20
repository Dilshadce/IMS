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
  select * from iclocation where 0=0
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and location >= '#form.groupfrom#' and location <= '#form.groupto#'
  </cfif>
  <cfif lcase(HcomID) eq "simplysiti_i">    
	and cluster >= '#form.clusterfrom#' and cluster <= '#form.clusterto#'
  </cfif>
  order by location
</cfquery>

<cfquery name="getGsetup" datasource="#dts#">
  Select lLOCATION from GSetup
</cfquery>

<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>#getGsetup.lLOCATION#</cfoutput> Listing</strong></font></div>

  <cfif getGroup.recordCount gt 0>

	<table width="95%" border="0" class="" align="center">
  	  <tr><td colspan="100%"><hr></td></tr>
	  <tr>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>#getGsetup.lLOCATION#</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Description</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADDR1</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADDR2</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADDR3</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADDR4</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">CUST NO</font></strong></td>
        <cfif lcase(HcomID) eq "simplysiti_i">
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">CLUSTER</font></strong></td>
        </cfif>
        
      </tr>
  	  <tr><td colspan="100%"><hr></td></tr>
      <cfset i = 1>
	  <cfloop query="getGroup">
	  	<cfoutput>
	    <tr>
	      <td><div align="center">#i#</div></td>
	      <td><cfif getpin2.h1511 eq 'T'><a href="locationtable2.cfm?type=Edit&location=#location#">#location#</a><cfelse>#location#</cfif></td>
	      <td>#desp#</td>
          <td>#addr1#</td>
          <td>#addr2#</td>
          <td>#addr3#</td>
          <td>#addr4#</td>
          <td>#custno#</td>
          <cfif lcase(HcomID) eq "simplysiti_i">
	      <td align="center">#cluster#</td>
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
