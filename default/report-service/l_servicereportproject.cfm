<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>


		<cfset stDecl_UPrice = getgeneral.decl_uprice>

<html>
<head>
<title>Product Service By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> SERVICE REPORT BY PROJECT</strong></font></div></td>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		
	  	</font></div>
	  	</td>
    </tr>

    <cfquery name="getproject" datasource="#dts#">
    select source from ictran where 0=0 and linecode='SV'
    <cfif form.servicefrom neq "" and form.serviceto neq "">
    and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
    </cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
    and source >='#form.projectfrom#' and source <= '#form.projectto#'
    </cfif>
    group by source
    </cfquery>
    
   
   <cfif form.servicefrom neq "" and form.serviceto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service: #form.servicefrom# - #form.serviceto#</font></div></td>
        </tr>
    </cfif>
  
    <cfif form.projectfrom neq "" and form.projectto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">Project: #form.projectfrom# - #form.projectto#</font></div></td>
        </tr>
    </cfif>

	
    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
      	<td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">REF No</font></td>
		<td><font size="2" face="Times New Roman, Times, serif">Customer Name</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Service Cost</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Quantity</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Price</font></td>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Amount</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>

	<cfloop query="getproject">
    <cfset sumqty=0>
    <cfset sumamt=0>
    <td><font size="2" face="Times New Roman, Times, serif"><u><b>#getproject.source#</b></u></font></td>
   <cfquery name="getitem" datasource="#dts#">
    select * from ictran where linecode='SV'
    <cfif form.servicefrom neq "" and form.serviceto neq "">
    and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
    </cfif>
    and source = '#getproject.source#'
    </cfquery>
    
    <cfloop query="getitem">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
             <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.sercost,',_.__')#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
      
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.price_bil,',_.__')#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
         <cfset sumqty = sumqty + getitem.qty_bil>
          <cfset sumamt = sumamt + getitem.amt1_bil>
</cfloop>
<tr>
    	<td colspan="25"><hr></td>
    </tr>
    <tr>
    <td></td>
    <td></td>
<td></td>
    <td colspan="3">Total</td>

    <td>#sumqty#</td>
<td></td>
<td>#lsnumberformat(sumamt,',_.__')#</td>
    </tr>
    <tr>
    <td colspan='10'>
    <hr>
    </td>
    </tr>
	</cfloop>
    
    
	
</table>
</cfoutput>

<cfif getproject.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>