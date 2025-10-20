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
<title>Purchase By Brand Graph</title>
</head>

<body>

<cfif isdefined('form.chart')>
<cfset charttype=form.chart>
<cfelse>
<cfset charttype='bar'>
</cfif>

<cfoutput>
<form name="chartform" id="chartform" action="salesbybrandGraph.cfm?alown=#url.alown#" method="post">
<input type="hidden" id="catefrom" name="catefrom" value="#form.catefrom#">
<input type="hidden" id="cateto" name="cateto" value="#form.cateto#">
<input type="hidden" id="groupfrom" name="groupfrom" value="#form.groupfrom#">
<input type="hidden" id="groupto" name="groupto" value="#form.groupto#">
<input type="hidden" id="brandfrom" name="brandfrom" value="#form.brandfrom#">
<input type="hidden" id="brandto" name="brandto" value="#form.brandto#">
<input type="hidden" id="agentfrom" name="agentfrom" value="#form.agentfrom#">
<input type="hidden" id="agentto" name="agentto" value="#form.agentto#">
<input type="hidden" id="teamfrom" name="teamfrom" value="#form.teamfrom#">
<input type="hidden" id="teamto" name="teamto" value="#form.teamto#">
<input type="hidden" id="areafrom" name="areafrom" value="#form.areafrom#">
<input type="hidden" id="areato" name="areato" value="#form.areato#">

<input type="hidden" id="userfrom" name="userfrom" value="#form.userfrom#">
<input type="hidden" id="userto" name="userto" value="#form.userto#">

<input type="hidden" id="periodfrom" name="periodfrom" value="#form.periodfrom#">
<input type="hidden" id="periodto" name="periodto" value="#form.periodto#">
<input type="hidden" id="datefrom" name="datefrom" value="#form.datefrom#">
<input type="hidden" id="dateto" name="dateto" value="#form.dateto#">
<input type="hidden" id="chart" name="chart" value="#charttype#">
<!---<div style="display:none"><input type="submit" id="submit" name="submit" value="submit"></div>--->
<input type="button" name="Bar" id="Bar" value="Bar" onClick="document.getElementById('chart').value=this.value;chartform.submit();"> &nbsp;&nbsp;<input type="button" name="Pie" id="Pie" value="Pie" onClick="document.getElementById('chart').value=this.value;form.submit();"> &nbsp;&nbsp;<input type="button" name="Line" id="Line" value="Line" onClick="document.getElementById('chart').value=this.value;form.submit();">&nbsp;&nbsp;<input type="button" name="horizontalbar" id="horizontalbar" value="horizontalbar" onClick="document.getElementById('chart').value=this.value;form.submit();">
</form>
</cfoutput>


				<cfquery name="getbrand" datasource="#dts#">
				select a.brand,b.desp,a.itemno,sum(ifnull(c.suminvamt,0)-ifnull(d.suminvamt,0)) as suminvamt from icitem as a
				left join
				(select brand,desp from brand) as b on a.brand=b.brand
                
                left join
				(select itemno,sum(amt) as suminvamt from ictran where type in ('RC')
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
                <cfif form.userfrom neq "" and form.userto neq "">
				and van >='#form.userfrom#' and van <='#form.userto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				<!---Agent from Customer Profile--->
			<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
            <cfelse>
       <!---Agent from Bill--->
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
			</cfif>
			<cfelse>
            <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
			<cfelse>
			<cfif Huserloc neq "All_loc">
			and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
            </cfif>
			</cfif>
            </cfif>
				group by itemno) as c on a.itemno=c.itemno
                
                
                 left join
				(select itemno,sum(amt) as suminvamt from ictran where type in ('PR')
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
                <cfif form.userfrom neq "" and form.userto neq "">
				and van >='#form.userfrom#' and van <='#form.userto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				<!---Agent from Customer Profile--->
			<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
            <cfelse>
       <!---Agent from Bill--->
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
			</cfif>
			<cfelse>
            <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
			<cfelse>
			<cfif Huserloc neq "All_loc">
			and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
            </cfif>
			</cfif>
            </cfif>
				group by itemno) as d on a.itemno=d.itemno
                group by a.brand
</cfquery>

<h1>Purchase By Brand</h1>
    <cfchart backgroundcolor="eff8ff" fontsize="12" xAxisTitle="Brand" yAxisTitle="Sales" title="" showborder="no" show3d="no" chartheight="500" chartwidth="600">
	<cfchartseries type="#charttype#" query="getbrand" valueColumn="suminvamt" itemColumn="brand" colorlist="1E90FF,48D1CC,F08080,DDA0DD,008000,996699,CCCC99,FFCCCC,333366,FFFF33"/></cfchart>
    
</body>
</html>