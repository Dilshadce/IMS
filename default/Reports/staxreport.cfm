<html>
<head>
<title>STANDARD-RATED SALES & SALES TAX</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="totalnet" default="0.00">
<cfparam name="totaltax" default="0.00">
<cfparam name="totalnet2" default="0.00">
<cfparam name="totaltax2" default="0.00">
<!--- <cfquery name='getS_Tax1' datasource='#dts#'>
  select sum(net) as sumnet, sum(tax) as sumtax from artran where (type = 'INV' or type = 'DN' or type = 'CS') and note = 'STAX'

  <cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  </cfif>
  group by note
</cfquery>
<cfif #getS_Tax1.recordcount# gt 0>
  <cfif #getS_Tax1.sumtax# neq ''>
	<cfset S_TAX1 = #getS_Tax1.sumtax#>
  </cfif>
  <cfif #getS_Tax1.sumnet# neq ''>
	<cfset S_net1 = #getS_Tax1.sumnet#>
  </cfif>

</cfif> --->

<cfquery name='getSTax1detail' datasource='#dts#'>
  	select type,refno, fperiod, wos_date,desp,net,tax from artran where (type = 'INV' or type = 'DN' or type = 'CS') and note = 'STAX'
	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  </cfif>
  order by wos_date,refno
</cfquery>

<cfquery name='getS_Tax2' datasource='#dts#'>
  	select sum(net) as sumnet, sum(tax)as sumtax from artran where type = 'CN' and note = 'STAX'
	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
  	group by note
</cfquery>

<cfif getS_Tax2.recordcount gt 0>
  	<cfif getS_Tax2.sumtax neq ''>
		<cfset S_TAX2 = getS_Tax2.sumtax>
  	</cfif>

	<cfif getS_Tax2.sumnet neq ''>
		<cfset S_net2 = getS_Tax2.sumnet>
  	</cfif>
</cfif>

<cfquery name='getSTax2detail' datasource='#dts#'>
  	select refno, fperiod, wos_date, net, tax from artran where type = 'CN' and note = 'STAX'
  	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
  	order by wos_date,refno
</cfquery>

<cfloop query="getstax2detail">
	<cfset xnet2 = net>
	<cfset xtax2 = tax>
	<cfset totalnet2 = totalnet2 + numberformat(xnet2,".__")>
    <cfset totaltax2 = totaltax2 + numberformat(xtax2,".__")>
</cfloop>

<body>
<div align="center"><font size="3" face="Arial, Helvetica, sans-serif" color="#000000"><strong>STANDARD-RATED SALES & SALES TAX</strong></font></div>
<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
  	<tr>
    	<td colspan="7"><HR></td>
  	</tr>
  	<tr>
    	<td><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">PERIOD</font></strong></div></td>
    	<td><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">DATE</font></strong></div></td>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">TYPE</font></strong></td>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">REF NO.</font></strong></td>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">DESCIPTION</font></strong></td>
    	<td><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">TAXABLE</font></strong></div></td>
    	<td><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">TAX AMT</font></strong></div></td>
  	</tr>
  	<tr>
    	<td colspan="7"><HR></td>
  	</tr>

	<cfloop query="getstax1detail">
    	<cfset xnet = net>
    	<cfset xtax = tax>
    	<cfset totalnet = totalnet + numberformat(xnet,".__")>
    	<cfset totaltax = totaltax + numberformat(xtax,".__")>

		<cfoutput>
		<tr>
      		<td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">#ceiling(fperiod)#</font></div></td>
      		<td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">#dateformat(wos_date,"dd/mm/yyyy")#</font></div></td>
      		<td><font size="2" face="Arial, Helvetica, sans-serif">#type#</font></td>
      		<td><font size="2" face="Arial, Helvetica, sans-serif">#refno#</font></td>
      		<td><font size="2" face="Arial, Helvetica, sans-serif">#desp#</font></td>
      		<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(xnet,",_.__")#</font></div></td>
      		<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(xtax,",_.__")#</font></div></td>
    	</tr>
		</cfoutput>
  	</cfloop>

	<cfoutput>
    <tr>
      	<td colspan="7"><hr></td>
    </tr>
    <tr>
      	<td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif">TOTAL STD-RATED SALES</font></td>
      	<td colspan="2"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALNET,",_.__")#</font></div></td>
      	<td>&nbsp;</td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">TOTAL TAX</font></td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALTAX,",_.__")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif">LESS</font></td>
      	<td colspan="2"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALNET2,",_.__")#</font></div></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp; </font></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">LESS </font></td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALTAX2,",_.__")#</font></div></td>
    </tr>
  </cfoutput>
</table>
</body>
</html>