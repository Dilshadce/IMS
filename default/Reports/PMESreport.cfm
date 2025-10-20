<html>
<head>
<title>MAJOR EXPORTER SCHEME PURCHASES</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="totalnet" default="0.00">
<cfparam name="totaltax" default="0.00">
<cfparam name="totalnet2" default="0.00">
<cfparam name="totaltax2" default="0.00">

<cfquery name='getP_MES1detail' datasource='#dts#'>
  	select type,refno, fperiod, wos_date,desp,net,frem9 from artran where type = 'RC' and frem9 <> ''
	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
  	order by wos_date,refno
</cfquery>

<cfquery name='getP_MES2' datasource='#dts#'>
  	select sum(net) as sumnet,sum(frem9)as sumtax from artran where type = 'PR' and frem9 <> ''
	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
  	group by note
</cfquery>

<cfif getP_MES2.recordcount gt 0>
	<cfif getP_MES2.sumtax neq ''>
	    <cfset P_MES2 = numberformat(getP_MES2.sumtax,".__")>
	</cfif>

	<cfif getP_MES2.sumnet neq ''>
		<cfset P_MESnet2 = numberformat(getP_MES2.sumnet,".__")>
	</cfif>
</cfif>

<cfquery name='getP_MES2detail' datasource='#dts#'>
	select refno, fperiod, wos_date,desp,net,frem9 from artran where type = 'PR' and frem9 <> ''
  	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
  	order by wos_date,refno
</cfquery>

<cfloop query="getP_MES2detail">
	<cfset xnet2 = net>
	<cfset xtax2 = frem9>
	<cfset totalnet2 = totalnet2 + numberformat(xnet2,".__")>
    <cfset totaltax2 = totaltax2 + numberformat(xtax2,".__")>
</cfloop>

<body>
<div align="center"><font size="3" face="Arial, Helvetica, sans-serif" color="#000000"><strong>MAJOR EXPORTER SCHEME PURCHASES</strong></font></div>
<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
  	<tr>
    	<td colspan="7"><HR></td>
  	</tr>
  	<tr>
    	<td><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">PERIOD</font></strong></div></td>
    	<td><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">DATE</font></strong></div></td>
    	<td><font size="2" face="Arial, Helvetica, sans-serif"><strong>TYPE</strong></font></td>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">REF NO.</font></strong></td>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">DESCIPTION</font></strong></td>
    	<td><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">TAXABLE</font></strong></div></td>
    	<td><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">MES AMT</font></strong></div></td>
  	</tr>
  	<tr>
    	<td colspan="7"><HR></td>
  	</tr>
  	<cfloop query="getP_MES1detail">
    	<cfset xnet = net>
    	<cfset xtax = frem9>
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
      	<td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif">TOTAL MES PURCHASES&nbsp;</font></td>
      	<td>&nbsp;</td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALNET,",_.__")#</font></div></td>
      	<td>&nbsp;</td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">TOTAL MES</font></td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALTAX,",_.__")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif">LESS</font></td>
      	<td>&nbsp;</td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALNET2,",_.__")#</font></div></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp; </font></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">LESS </font></td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALTAX2,",_.__")#</font></div></td>
    </tr>
  	</cfoutput>
</table>
</body>
</html>