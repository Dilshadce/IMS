<html>
<head>
<title>Stock Card2</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="i" default="1" type="numeric">
<!--- <cfparam name="lastINqty" default="0">
<cfparam name="lastOUTqty" default="0">
<cfparam name="lastDOqty" default="0">
<cfparam name="lastPOqty" default="0">
<cfparam name="lastSOqty" default="0">
<cfparam name="INqty" default="0">
<cfparam name="OUTqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="POqty" default="0">
<cfparam name="SOqty" default="0"> --->
<cfparam name="balonhand" default="0">
<cfparam name="Total" default="0">

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=#dateformat(form.datefrom, "DD")#>
	<cfif dd greater than '12'>
		<cfset ndatefrom=#dateformat(form.datefrom,"YYYYMMDD")#>
	<cfelse>
		<cfset ndatefrom=#dateformat(form.datefrom,"YYYYDDMM")#>
	</cfif>

	<cfset dd=#dateformat(form.dateto, "DD")#>
	<cfif dd greater than '12'>
		<cfset ndateto=#dateformat(form.dateto,"YYYYMMDD")#>
	<cfelse>
		<cfset ndateto=#dateformat(form.dateto,"YYYYDDMM")#>
	</cfif>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery>
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp, qtybf,price from icitem
	where itemno <>''
	<cfif form.productfrom neq "" and form.productto neq "">
	and itemno >= '#form.productfrom#' and itemno <= '#form.productto#'
	</cfif>
	<cfif form.catefrom neq "" and form.cateto neq "">
	and category >= '#form.catefrom#' and category <= '#form.cateto#'
	</cfif>
	<cfif form.sizeidfrom neq "" and form.sizeidto neq "">
	and sizeid >= '#form.sizeidfrom#' and sizeid <= '#form.sizeidto#'
	</cfif>
	<cfif form.costcodefrom neq "" and form.costcodeto neq "">
	and costcode >= '#form.costcodefrom#' and costcode <= '#form.costcodeto#'
	</cfif>
	<cfif form.coloridfrom neq "" and form.coloridto neq "">
	and colorid >= '#form.coloridfrom#' and colorid <= '#form.coloridto#'
	</cfif>
	<cfif form.shelffrom neq "" and form.shelfto neq "">
	and shelf >= '#form.shelffrom#' and shelf <= '#form.shelfto#'
	</cfif>
	<cfif form.groupfrom neq "" and form.groupto neq "">
	and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
	</cfif>
	order by itemno
</cfquery>

<body>
<h1 align="center">Stock Card Summary</h1>
<form name="form" action="">
  <table width="90%" border="0" class="data" align="center">
    <tr>
      <th>No</th>
      <th>Product</th>
      <th>Qty Bf</th>
      <th>In</th>
      <th>Out</th>
      <th>Balance</th>
      <th>PO</th>
      <th>SO</th>
      <th>Total</th>
      <th>Action</th>
    </tr>
    <cfloop query="getitem">
	  <cfset lastitembal = 0>
	  <cfset itembal = 0>
      <cfset inqty = 0>
      <cfset outqty = 0>
      <cfset doqty = 0>
      <cfset poqty = 0>
      <cfset soqty = 0>

	  <cfif form.periodfrom neq "" and form.periodto neq "" and form.periodfrom neq "01">
      <cfset lastinqty = 0>
      <cfset lastoutqty = 0>
      <cfset lastdoqty = 0>
      <cfset lastpoqty = 0>
      <cfset lastsoqty = 0>

	  <cfquery name="getlastin" datasource="#dts#">
      select sum(qty)as sumqty from ictran where itemno = '#itemno#' and (type
      = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') and (void = '' or void is null) and
      fperiod < '#form.periodfrom#'
      <cfif form.datefrom neq "" and form.dateto neq "">
        and wos_date < '#ndatefrom#'
      </cfif>
      </cfquery>
      <cfif getlastin.sumqty neq "">
        <cfset lastinqty = #getlastin.sumqty#>
      </cfif>
      <cfquery name="getlastout" datasource="#dts#">
      select sum(qty)as sumqty from ictran where itemno = '#itemno#' and (type
      = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or
      type = 'OAR' or type = 'TROU') and (void = '' or void is null) and fperiod < '#form.periodfrom#'
      <cfif form.datefrom neq "" and form.dateto neq "">
        and wos_date < '#ndatefrom#'
      </cfif>
      </cfquery>
      <cfif getlastout.sumqty neq "">
        <cfset lastoutqty = #getlastout.sumqty#>
      </cfif>
      <cfquery name="getlastdo" datasource="#dts#">
      select sum(qty)as sumqty from ictran where type = 'DO' and itemno = '#itemno#'
      and toinv = '' and (void = '' or void is null) and fperiod < '#form.periodfrom#'
      <cfif form.datefrom neq "" and form.dateto neq "">
        and wos_date < '#ndatefrom#'
      </cfif>
      </cfquery>
      <cfif getlastdo.sumqty neq "">
        <cfset lastDOqty = #getlastdo.sumqty#>
      </cfif>
      <cfset lastitembal = #lastinqty# - #lastoutqty# - #lastdoqty#>
    </cfif>

	<cfquery name="getin" datasource="#dts#">
    select sum(qty)as sumqty from ictran where itemno = '#itemno#' and (type =
    'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') and (void = '' or void is null)
    <cfif form.periodfrom neq "" and form.periodto neq "">
      and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
      and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
	<cfelse>
	  and wos_date > #getgeneral.lastaccyear#
    </cfif>
    </cfquery>
    <cfif getin.sumqty neq "">
      <cfset inqty = #getin.sumqty#>
    </cfif>
    <cfquery name="getout" datasource="#dts#">
    select sum(qty)as sumqty from ictran where itemno = '#itemno#' and (type =
    'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type
    = 'OAR' or type = 'TROU') and (void = '' or void is null)
    <cfif form.periodfrom neq "" and form.periodto neq "">
      and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
      and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
	<cfelse>
	  and wos_date > #getgeneral.lastaccyear#
    </cfif>
    </cfquery>
    <cfif getout.sumqty neq "">
      <cfset outqty = #getout.sumqty#>
    </cfif>
    <cfquery name="getdo" datasource="#dts#">
    select sum(qty)as sumqty from ictran where type = 'DO' and itemno = '#itemno#'
    and toinv = '' and (void = '' or void is null)
    <cfif form.periodfrom neq "" and form.periodto neq "">
      and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
      and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
	<cfelse>
	  and wos_date > #getgeneral.lastaccyear#
    </cfif>
    </cfquery>
    <cfif getdo.sumqty neq "">
      <cfset DOqty = #getdo.sumqty#>
    </cfif>
    <cfif getitem.qtybf neq "">
      <cfset itembal = #getitem.qtybf# + #lastitembal#>
      <cfelse>
      <cfset itembal = #lastitembal#>
    </cfif>
    <cfset stockin = #inqty#>
    <cfset stockout = #doqty# + #outqty#>
    <cfset balonhand = #itembal# + #stockin# - #stockout#>

      <cfquery name="getpo" datasource="#dts#">
      select sum(qty-shipped)as sumqty from ictran where type = 'PO' and itemno = '#itemno#' and (void = '' or void is null)
      </cfquery>

        <cfif getpo.sumqty neq "">
          <cfset POqty = #getpo.sumqty#>
        </cfif>

      <cfquery name="getso" datasource="#dts#">
      select sum(qty-shipped)as sumqty from ictran where type = 'SO' and itemno = '#itemno#' and (void = '' or void is null)
      </cfquery>

        <cfif getso.sumqty neq "">
          <cfset SOqty = #getso.sumqty#>
        </cfif>

      <cfset total = #balonhand# + #poqty# - #soqty#>
	  <cfoutput>
      <tr>
        <td><div align="center">#i#</div></td>
        <td nowrap>#itemno# - #desp#</td>
        <td><div align="center">#itembal#</div></td>
        <td><div align="center">#stockin#</div></td>
        <td><div align="center">#stockout#</div></td>
        <td><div align="center">#balonhand#</div></td>
        <td><div align="center">#POqty#</div></td>
        <td><div align="center">#SOqty#</div></td>
        <td><div align="center">#Total#</div></td>
        <!---     <td><div align="center"><a href="C_stockcard3.cfm?itemno=#itemno#&itembal=#itembal#&pf=#productfrom#&pt=#productto#&cf=#catefrom#&ct=#cateto#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#">View
          Details</a></div></td> --->
        <td><div align="center"><a href="C_stockcard3.cfm?itemno=#urlencodedformat(itemno)#&itembal=#itembal#&pf=#productfrom#&pt=#productto#&cf=#catefrom#&ct=#cateto#&sif=#sizeidfrom#&sit=#sizeidto#&ccf=#costcodefrom#&cct=#costcodeto#&cif=#coloridfrom#&cit=#coloridto#&sff=#shelffrom#&sft=#shelfto#&gpf=#groupfrom#&gpt=#groupto#&pef=#periodfrom#&pet=#periodto#&df=#datefrom#&dt=#dateto#">View
            Details</a></div></td>
      </tr>
	  </cfoutput>
      <cfset i = incrementvalue(#i#)>

    </cfloop>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <!---     <td><div align="center"><cfoutput><a href="C_stockcard_report.cfm?pf=#productfrom#&pt=#productto#&cf=#catefrom#&ct=#cateto#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#">Print All Details</a></cfoutput></div></td> --->
      <td><div align="center"><cfoutput><a href="C_stockcard_report.cfm?pf=#productfrom#&pt=#productto#&cf=#catefrom#&ct=#cateto#&sif=#sizeidfrom#&sit=#sizeidto#&ccf=#costcodefrom#&cct=#costcodeto#&cif=#coloridfrom#&cit=#coloridto#&sff=#shelffrom#&sft=#shelfto#&gpf=#groupfrom#&gpt=#groupto#&pef=#periodfrom#&pet=#periodto#&df=#datefrom#&dt=#dateto#" target="_blank">Print
            All Details</a></cfoutput></div></td>
    </tr>
  </table>
</form>
</body>

</html>
