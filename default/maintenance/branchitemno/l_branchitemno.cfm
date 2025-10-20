<html>
<head>
<title>Branch Item No Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getGroup" datasource="#dts#">
  select * from icbranchitemno
  <cfif form.groupfrom neq "" and form.groupto neq "">
	where branchitemno >= '#form.groupfrom#' and branchitemno <= '#form.groupto#'
  </cfif>
  order by branchitemno
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from icbranchitemno order by branchitemno
</cfquery>
<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Branch Item No</cfoutput> Listing</strong></font></div>

  <cfif getGroup.recordCount gt 0>

	<table width="95%" border="0" class="" align="center">
  	  <tr><td colspan="8"><hr></td></tr>
	  <tr>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif"><center>No</center></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Branch Item No</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Item No</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Description</font></strong></td>
        
      </tr>
  	  <tr><td colspan="8"><hr></td></tr>
      <cfset i = 1>
	  <cfloop query="getGroup">
	  	<cfoutput>
	    <tr>
	      <td><div align="center">#i#</div></td>
	      <td><cfif getpin2.h1511 eq 'T'><a href="branchitemno2.cfm?type=Edit&branchitemno=#branchitemno#">#branchitemno#</a><cfelse>#branchitemno#</cfif></td>
          <td>#itemno#</td>
	      <td>#desp#</td>
	      
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
