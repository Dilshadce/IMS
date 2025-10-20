<html>
<head>
<title>Stock Card3</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="totalin" default="0">
<cfparam name="totalout" default="0">
<cfparam name="totalPO" default="0">
<cfparam name="totalSO" default="0">
<cfparam name="totalAll" default="0">
<cfparam name="poqty" default="0">
<cfparam name="soqty" default="0">

<cfif df neq "" and dt neq "">
	<cfset dd=#dateformat(df, "DD")#>	
	<cfif dd greater than '12'>
		<cfset ndatefrom=#dateformat(df,"YYYYMMDD")#>
	<cfelse>
		<cfset ndatefrom=#dateformat(df,"YYYYDDMM")#>
	</cfif>
	
	<cfset dd=#dateformat(dt, "DD")#>	
	<cfif dd greater than '12'>
		<cfset ndateto=#dateformat(dt,"YYYYMMDD")#>
	<cfelse>
		<cfset ndateto=#dateformat(dt,"YYYYDDMM")#>
	</cfif>	
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery>
<cfquery name="getictran" datasource="#dts#">	
		select itemno, refno, type, wos_date, name, qty, toinv, price from ictran where 
		itemno = '#itemno#' and (void = '' or void is null) and (type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS' or type = 'PR' 
		or type = 'RC' or type = 'DO' or type = 'ISS' or type = 'OAR' or type = 'OAI' or type = 'TRIN' or type = 'TROU')
		<cfif pef neq "" and pet neq "">
		and fperiod >= '#pef#' and fperiod <= '#pet#' 
		</cfif>
		<cfif df neq "" and dt neq "">
		and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#' 
		<cfelse>
		and wos_date > #getgeneral.lastaccyear#
		</cfif>
		order by wos_date, trdatetime	
</cfquery>
<cfquery name="getpo" datasource="#dts#">	
		select sum(qty-shipped)as qty from ictran where 
		itemno = '#itemno#' and (void = '' or void is null) and type = 'PO'			
</cfquery>
<cfif getpo.qty neq "">
	<cfset poqty = getpo.qty>
</cfif>
<cfquery name="getso" datasource="#dts#">	
		select sum(qty-shipped)as qty from ictran where 
		itemno = '#itemno#' and (void = '' or void is null) and type = 'SO'			
</cfquery>
<cfif getso.qty neq "">
	<cfset soqty = getso.qty>
</cfif>
<!--- Control The Decimal Point --->
<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = #getgsetup2.Decl_Uprice#>
<cfset stDecl_UPrice = ",_.">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = #stDecl_UPrice# & "_">
</cfloop>

<cfquery name="geticitem" datasource="#dts#">
	select desp from icitem where itemno = '#itemno#'
</cfquery>

<body>
<div align="center">
  <h1>Stock Card Details </h1>
  <p><font size="2"><strong><cfoutput>
      <div align="left">Item No : #itemno# - #geticitem.desp#</div>
    </cfoutput></strong></font></p>
</div>
<table width="80%" border="0" class="data" align="center">
  <tr> 
    <th>Date</th>
    <th>Refno</th>
    <th>Description</th>
    <th>In</th>
    <th>Out</th>
    <th>Balance</th>
    <th>PO</th>
    <th>SO</th>
    <th>Total</th>
    <th>Unit Price</th>
  </tr>
  <cfset totalAll = #itembal#>  
  <tr> 
    <td></td>
    <td></td>
    <td>Balance B/F:</td>
    <td></td>
    <td></td>
    <td><div align="center"><cfoutput>#itembal#</cfoutput></div></td>
    <td></td>
    <td></td>
    <td><div align="center"><cfoutput>#totalAll#</cfoutput></div></td>
    <td></td>
  </tr>
  <cfoutput>
  <tr>
    <td></td>
    <td></td>
    <td>&nbsp;</td>
    <td></td>
    <td></td>
    <td>&nbsp;</td>
    <td><div align="center">#poqty#</div></td>
    <td><div align="center">#soqty#</div></td>
    <td>&nbsp;</td>
    <td></td>
  </tr>  
  </cfoutput>  
  <cfloop query="getictran"> 
    <cfoutput>
	<tr> 
      <td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
      <td><div align="left">#type# #refno#</div></td>
      <td>#name#</td>
      <td> 
        <cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN">
          <cfset itembal = #itembal# + #qty#>
          <cfset totalin = #totalin# + #qty#>
          <cfset totalAll = #totalAll# + #qty#>
          <div align="center">#qty#</div>
        </cfif> </td>
      <td> <cfif type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU">
          <cfif type eq "DO" and toinv neq "">
            <div align="center">INV #toinv#</div>
            <cfelse>
            <cfset itembal = #itembal# - #qty#>
            <cfset totalout = #totalout# + #qty#>
            <cfset totalAll = #totalAll# - #qty#>
            <div align="center">#qty#</div>
          </cfif>
        </cfif> </td>
      <td> <cfif type eq "DO" and toinv neq "">
          <cfelse>
          <div align="center">#itembal#</div>
        </cfif> </td>
      <!--- <cfset totalAll = #itembal#> --->
      <td> <!--- <cfif type eq "PO">
          <cfset totalAll = #totalAll# + #qty#>
          <cfset totalPO = #totalPO# + #qty#>
          <div align="center">#qty#</div>
        </cfif> ---> </td>
      <td> <!--- <cfif type eq "SO">
          <cfset totalAll = #totalAll# - #qty#>
          <cfset totalSO = #totalSO# + #qty#>
          <div align="center">#qty#</div>
        </cfif> ---> </td>
      <td> <cfset totalAll = itembal + poqty - soqty> <div align="center"><!--- #totalAll# ---></div></td>
      <td><div align="right">#numberformat(price,stDecl_UPrice)#</div></td>
    </tr>
	</cfoutput>
  </cfloop> 
  <tr> 
    <td colspan="10"><hr></td>
  </tr>
  <cfoutput> 
    <tr> 
      <td></td>
      <td></td>
      <td><div align="right">Total:</div></td>
      <td><div align="center">#totalin#</div></td>
      <td><div align="center">#totalout#</div></td>
      <td><div align="center">#itembal#</div></td>
      <td><div align="center">#totalPO#</div></td>
      <td><div align="center">#totalSO#</div></td>
      <td><div align="center">#totalAll#</div></td>
      <td></td>
    </tr>
  </cfoutput> 
</table>

</body>
</html>
