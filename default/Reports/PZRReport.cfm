<html>
<head>
<title>ZERO-RATED PURCHASES</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="totalnet" default="0.00">
<!--- <cfparam name="totaltax" default="0.00"> --->
<cfparam name="totalnet2" default="0.00">
<!--- <cfparam name="totaltax2" default="0.00"> --->

<!--- <cfquery name='getP_ZR1' datasource='#dts#'>
  select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'RC' and note = 'ZR'

  <cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  </cfif>
</cfquery>
<cfif #getP_ZR1.recordcount# gt 0>
  <cfif #getP_ZR1.sumtax# neq ''>
	<cfset P_ZR1 = #numberformat(getP_ZR1.sumtax,".__")#>
  </cfif>
  <cfif #getP_ZR1.sumnet# neq ''>
	<cfset P_ZRnet1 = #numberformat(getP_ZR1.sumnet,".__")#>
  </cfif>
</cfif> --->

<cfquery name='getP_ZR1detail' datasource='#dts#'>
  	select type,refno,desp,fperiod,wos_date,net from artran where type = 'RC' and note = 'ZR'
  	<cfif pfrom neq '' and pto neq ''>
  	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
</cfquery>

<cfquery name='getP_ZR2' datasource='#dts#'>
  	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'PR' and note = 'ZR'
	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
</cfquery>

<cfif getP_ZR2.recordcount gt 0>
  	<cfif getP_ZR2.sumtax neq ''>
		<cfset P_ZR2 = numberformat(getP_ZR2.sumtax,".__")>
  	</cfif>

	<cfif getP_ZR2.sumnet neq ''>
		<cfset P_ZRnet2 = numberformat(getP_ZR2.sumnet,".__")>
  	</cfif>
</cfif>

<cfquery name='getP_ZR2detail' datasource='#dts#'>
  	select refno,desp,fperiod,wos_date,net from artran where type = 'PR' and note = 'ZR'
	<cfif pfrom neq '' and pto neq ''>
	and fperiod >= '#pfrom#' and fperiod <= '#pto#'
  	</cfif>
</cfquery>

<cfloop query="getP_ZR2detail">
	<cfset xnet2 = net>
	<!--- <cfset xtax2 = #tax#> --->
	<cfset totalnet2 = totalnet2 + numberformat(xnet2,".__")>
    <!--- <cfset totaltax2 = totaltax2 + numberformat(xtax2,".__")> --->
</cfloop>

<body>
<div align="center"><font size="3" face="Arial, Helvetica, sans-serif" color="#000000"><strong>ZERO-RATED PURCHASES</strong></font></div>
<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
  	<tr>
    	<td colspan="6"><HR></td>
  	</tr>
  	<tr>
    	<td><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">PERIOD</font></strong></div></td>
    	<td><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">DATE</font></strong></div></td>
    	<td><font size="2" face="Arial, Helvetica, sans-serif"><strong>TYPE</strong></font></td>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">REF NO.</font></strong></td>
    	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">DESCIPTION</font></strong></td>
    	<td><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">TAXABLE</font></strong></div></td>
  	</tr>
  	<tr>
    	<td colspan="6"><HR></td>
  	</tr>

	<cfloop query="getP_ZR1detail">
    	<cfset xnet = net>
    	<!--- <cfset xtax = #tax#> --->
    	<cfset totalnet = totalnet + numberformat(xnet,".__")>
    	<!--- <cfset totaltax = totaltax + numberformat(xtax,".__")> --->
    	<cfoutput>
	<tr>
      	<td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">#ceiling(fperiod)#</font></div></td>
      	<td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">#dateformat(wos_date,"dd/mm/yyyy")#</font></div></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">#type#</font></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">#refno#</font></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">#desp#</font></td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(xnet,",_.__")#</font></div></td>
    </tr>
	</cfoutput>
	</cfloop>

	<cfoutput>
    <tr>
      	<td colspan="6"><hr></td>
    </tr>
    <tr>
      	<td colspan="2">&nbsp;</td>
      	<td>&nbsp;</td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif"></font></div></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">TOTAL ZERO-RATED PURCHASES</font></td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALNET,",_.__")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="2">&nbsp;</td>
      	<td></td>
      	<td></td>
      	<td><font size="2" face="Arial, Helvetica, sans-serif">LESS </font></td>
      	<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">#numberformat(TOTALNET2,",_.__")#</font></div></td>
    </tr>
	</cfoutput>
</table>
</body>
</html>