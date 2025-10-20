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
<title>Chart Report - Sales By Agent</title>
</head>

<body>
<cfif isdefined('form.chart')>
  <cfset charttype=form.chart>
  <cfelse>
  <cfset charttype='bar'>
</cfif>
<cfoutput>
  <form name="chartform" id="chartform" action="salesByAgentGraph.cfm?alown=#url.alown#" method="post">
    <input type="hidden" id="agentfrom" name="agentfrom" value="#form.agentfrom#">
    <input type="hidden" id="agentto" name="agentto" value="#form.agentto#">
    <input type="hidden" id="periodfrom" name="periodfrom" value="#form.periodfrom#">
    <input type="hidden" id="periodto" name="periodto" value="#form.periodto#">
    <input type="hidden" id="datefrom" name="datefrom" value="#form.datefrom#">
    <input type="hidden" id="dateto" name="dateto" value="#form.dateto#">
    <input type="hidden" id="chart" name="chart" value="#charttype#">

    <input type="button" name="Bar" id="Bar" value="Bar" onClick="document.getElementById('chart').value=this.value;chartform.submit();">
    &nbsp;&nbsp;
    <input type="button" name="Pie" id="Pie" value="Pie" onClick="document.getElementById('chart').value=this.value;form.submit();">
    &nbsp;&nbsp;
    <input type="button" name="Line" id="Line" value="Line" onClick="document.getElementById('chart').value=this.value;form.submit();">
    &nbsp;&nbsp;
    <input type="button" name="horizontalbar" id="horizontalbar" value="horizontalbar" onClick="document.getElementById('chart').value=this.value;form.submit();">
  </form>
</cfoutput>

<cfif isdefined('form.monthly')>

<cfquery name="getagent" datasource="#dts#">
SELECT agenno as agent FROM artran WHERE (type='DN' OR type='CS' OR type='INV')
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
AND invgross <> 0
AND agenno<> ''
GROUP BY agenno
</cfquery>

<cfloop query="getagent">

<cfquery name="getagentdata" datasource="#dts#">
				select a.fperiod,a.agenno as agent,(select desp from #target_icagent# where agent=a.agenno)as desp,b.suminvamt,c.sumcsamt,d.sumdnamt,e.sumcnamt,(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)) as total,
				(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) as net from artran as a
				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross) as suminvamt<cfelse>sum(invgross)-sum(discount)as suminvamt</cfif> from artran where type = 'INV' and (void = '' or void is null)
				and agenno='#getagent.agent#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by fperiod) as b on a.fperiod=b.fperiod

				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross)as sumcsamt<cfelse>sum(invgross)-sum(discount)as sumcsamt</cfif> from artran where type = 'CS' and (void = '' or void is null)

				and agenno='#getagent.agent#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by fperiod) as c on a.fperiod=c.fperiod

				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross)as sumdnamt<cfelse>sum(invgross)-sum(discount)as sumdnamt</cfif> from artran where type = 'DN' and (void = '' or void is null)
				
				and agenno='#getagent.agent#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by fperiod) as d on a.fperiod=d.fperiod

				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross)as sumcnamt<cfelse>sum(invgross)-sum(discount)as sumcnamt</cfif> from artran where type = 'CN' and (void = '' or void is null)
				and agenno='#getagent.agent#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by fperiod) as e on a.fperiod=e.fperiod
				where 0=0
                
				and a.agenno='#getagent.agent#'
                <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(a.agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
						</cfif>
						<cfelse>
						
						</cfif>
                <cfif isdefined('form.include0')>
                <cfelse>
               and (ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) <>0
                </cfif>
				
				
                group by a.fperiod 
                order by a.fperiod
               
			</cfquery>
<cfoutput>            
<h1>By Agent Chart #getagent.agent#</h1>
</cfoutput>
<cfchart backgroundcolor="eff8ff" fontsize="12" xAxisTitle="Month" yAxisTitle="Sales" title="" showborder="no" show3d="no" chartheight="500" chartwidth="1080">

<cfchartseries type="#charttype#" query="getagentdata" valueColumn="total" itemColumn="fperiod" colorlist="1E90FF,48D1CC,F08080,DDA0DD,008000,996699,CCCC99,FFCCCC,333366,FFFF33"/>

</cfchart>
<br>
</cfloop>


<cfelse>

<cfquery name="getagentdata" datasource="#dts#">
				select a.fperiod,a.agenno as agent,(select desp from #target_icagent# where agent=a.agenno)as desp,b.suminvamt,c.sumcsamt,d.sumdnamt,e.sumcnamt,(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)) as total,
				(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) as net from artran as a
				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross) as suminvamt<cfelse>sum(invgross)-sum(discount)as suminvamt</cfif> from artran where type = 'INV' and (void = '' or void is null)
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as b on a.agenno=b.agenno

				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross)as sumcsamt<cfelse>sum(invgross)-sum(discount)as sumcsamt</cfif> from artran where type = 'CS' and (void = '' or void is null)

				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as c on a.agenno=c.agenno

				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross)as sumdnamt<cfelse>sum(invgross)-sum(discount)as sumdnamt</cfif> from artran where type = 'DN' and (void = '' or void is null)
				
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as d on a.agenno=d.agenno

				left join
				(select fperiod,agenno,<cfif isdefined('form.excludetax')>sum(invgross)as sumcnamt<cfelse>sum(invgross)-sum(discount)as sumcnamt</cfif> from artran where type = 'CN' and (void = '' or void is null)
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as e on a.agenno=e.agenno
				where 0=0
                
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
				</cfif>               
                <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(a.agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
						</cfif>
						<cfelse>
						
						</cfif>
                <cfif isdefined('form.include0')>
                <cfelse>
               and (ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) <>0
                </cfif>
				
				
                group by a.agenno 
                order by a.agenno
               
			</cfquery>
<h1>By Agent Chart</h1>
<cfchart backgroundcolor="eff8ff" fontsize="12" xAxisTitle="agent" yAxisTitle="net" title="" showborder="no" show3d="no" chartheight="500" chartwidth="1080">

<cfchartseries type="#charttype#" query="getagentdata" valueColumn="total" itemColumn="agent" colorlist="1E90FF,48D1CC,F08080,DDA0DD,008000,996699,CCCC99,FFCCCC,333366,FFFF33"/>
</cfchart>
</cfif>

</body>
</html>