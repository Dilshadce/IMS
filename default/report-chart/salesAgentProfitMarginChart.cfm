<cfif getpin2.h4G00 eq "T">
  <script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfif isdefined('form.agentbycust')>
  <cfif form.agentfrom neq "" and form.agentto neq "">
    <cfquery name="getagentlist" datasource="#dts#">
select custno from #target_arcust# where 0=0
and agent >='#form.agentfrom#' and agent <= '#form.agentto#'
</cfquery>
    <cfset agentlist=valuelist(getagentlist.custno)>
  </cfif>
  <cfif form.teamfrom neq "" and form.teamto neq "">
    <cfquery name="getteamlist" datasource="#dts#">
select custno from #target_arcust# where agent in (select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')

</cfquery>
    <cfset teamlist=valuelist(getteamlist.custno)>
  </cfif>
</cfif>
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
  <cfset dd = dateformat(form.datefrom, "DD")>
  <cfif dd greater than '12'>
    <cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
    <cfelse>
    <cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
  </cfif>
  <cfset dd = dateformat(form.dateto, "DD")>
  <cfif dd greater than '12'>
    <cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
    <cfelse>
    <cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
  </cfif>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Chart Report - By Agent Profit Margin Chart</title>
</head>

<body>
<cfif isdefined('form.chart')>
  <cfset charttype=form.chart>
  <cfelse>
  <cfset charttype='bar'>
</cfif>
<cfoutput>
  <form name="chartform" id="chartform" action="salesAgentProfitMarginChart.cfm?alown=#url.alown#" method="post">
  	<input type="hidden" id="agentfrom" name="agentfrom" value="#form.agentfrom#">
	<input type="hidden" id="agentto" name="agentto" value="#form.agentto#">
    <input type="hidden" id="periodfrom" name="periodfrom" value="#form.periodfrom#">
    <input type="hidden" id="periodto" name="periodto" value="#form.periodto#">
    <input type="hidden" id="datefrom" name="datefrom" value="#form.datefrom#">
    <input type="hidden" id="dateto" name="dateto" value="#form.dateto#">
    <input type="hidden" id="chart" name="chart" value="#charttype#">
    <!---<div style="display:none"><input type="submit" id="submit" name="submit" value="submit"></div>--->
    <input type="button" name="Bar" id="Bar" value="Bar" onClick="document.getElementById('chart').value=this.value;chartform.submit();">
    &nbsp;&nbsp;
    <input type="button" name="Pie" id="Pie" value="Pie" onClick="document.getElementById('chart').value=this.value;form.submit();">
    &nbsp;&nbsp;
    <input type="button" name="Line" id="Line" value="Line" onClick="document.getElementById('chart').value=this.value;form.submit();">
    &nbsp;&nbsp;
    <input type="button" name="horizontalbar" id="horizontalbar" value="Horizontalbar" onClick="document.getElementById('chart').value=this.value;form.submit();">
  </form>
</cfoutput>

<cfquery name="getagentdata" datasource="#dts#">
select agenno as agent,sum(qty) as sumqty, sum(amt) as sumSales,sum(it_cos) as sumCost,sum(amt)- sum(it_cos) as sumProfit 
from ictran
where (type = 'inv' or type = 'cs' or type = 'dn') 
and (void = '' or void is null)

<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
<cfelse>
and wos_date > #getgeneral.lastaccyear#
</cfif>
group by agenno
order by agenno
</cfquery>

<h1>By Agent Profit Margin Chart</h1>
<cfchart backgroundcolor="eff8ff" fontsize="12" xAxisTitle="agent" yAxisTitle="Sales / Cost / Profit" title="" showborder="no" show3d="no" chartheight="500" chartwidth="1500">
<cfchartseries type="#charttype#" query="getagentdata" valueColumn="sumSales" itemColumn="agent" colorlist="34ABEF"/>
<cfchartseries type="#charttype#" query="getagentdata" valueColumn="sumCost" itemColumn="agent" colorlist="97150A"/>
<cfchartseries type="#charttype#" query="getagentdata" valueColumn="sumProfit" itemColumn="agent" colorlist="43C94E"/>
<font style="background-color:#">
</cfchart>
</body>
</html>