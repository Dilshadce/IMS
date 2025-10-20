<html>
<head>
<title>Transfer Limit Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getGroup" datasource="#dts#">
  select * from monthlytransfer
  <cfif form.groupfrom neq "" and form.groupto neq "">
	where itemno >= '#form.groupfrom#' and itemno <= '#form.groupto#'
  </cfif>
  order by itemno
</cfquery>

<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Transfer Limit</cfoutput> Listing</strong></font></div>

  <cfif getGroup.recordCount gt 0>

	<table width="95%" border="0" class="" align="center">
  	  <tr><td colspan="100%"><hr></td></tr>
	  <tr>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif"><center>No</center></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Item No</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Period</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Date from</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Date To</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Cluster A</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Cluster B</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Cluster C</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Cluster D</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Cluster A1</font></strong></td>
      </tr>
  	  <tr><td colspan="100%"><hr></td></tr>
      <cfset i = 1>
	  <cfloop query="getGroup">
	  	<cfoutput>
	    <tr>
	      <td><div align="center">#i#</div></td>
	      <td><cfif getpin2.h1511 eq 'T'><a href="monthlytransfertable2.cfm?type=Edit&id=#id#">#itemno#</a><cfelse>#itemno#</cfif></td>
	      <td>#fperiod#</td>
          <td>#dateformat(datefrom,'dd/mm/yyyy')#</td>
          <td>#dateformat(dateto,'dd/mm/yyyy')#</td>
          <td>#qty#</td>
          <td>#qty2#</td>
          <td>#qty3#</td>
          <td>#qty4#</td>
          <td>#qty5#</td>
	      
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
