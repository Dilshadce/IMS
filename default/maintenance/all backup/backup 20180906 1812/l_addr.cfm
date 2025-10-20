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
  select * from address
  <cfif form.groupfrom neq "" and form.groupto neq "">
	where code >= '#form.groupfrom#' and code <= '#form.groupto#'
  </cfif>
  order by code
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from Address order by Code
  </cfquery>

<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Address</cfoutput> Listing</strong></font></div>

  <cfif getGroup.recordCount gt 0>

	<table width="95%" border="0" class="" align="center">
  	  <tr><td colspan="8"><hr></td></tr>
	  <tr>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif"><center>No</center></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>CODE</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">NAME</font></strong></td>
         <td><strong><font size="2" face="Arial, Helvetica, sans-serif">CUST NO</font></strong></td>
         <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADD1</font></strong></td>
           <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADD2</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADD3</font></strong></td>
             <td><strong><font size="2" face="Arial, Helvetica, sans-serif">ADD4</font></strong></td>
        
      </tr>
  	  <tr><td colspan="8"><hr></td></tr>
      <cfset i = 1>
	  <cfloop query="getGroup">
	  	<cfoutput>
	    <tr>
	      <td><div align="center">#i#</div></td>
	      <td><cfif getpin2.h1511 eq 'T'><a href="addresstable2.cfm?type=Edit&code=#code#">#code#</a><cfelse>#code#</cfif></td>
	      <td>#name#</td>
          <td>#custno#</td>
          <td>#add1#</td>
          <td>#add2#</td>
          <td>#add3#</td>
          <td>#add4#</td>
          
	      
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
