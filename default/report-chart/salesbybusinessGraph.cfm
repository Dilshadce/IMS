<html>
<head>
<title><cfoutput>Customer Sales Chart</cfoutput> Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body>
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

<h1>Business Sales Chart</h1>

<cfif isdefined('form.chart')>
<cfset charttype=form.chart>
<cfelse>
<cfset charttype='bar'>
</cfif>

<cfoutput>
<form name="chartform" id="chartform" action="salesbybusinessGraph.cfm?alown=#url.alown#" method="post">
<input type="hidden" id="agentfrom" name="agentfrom" value="#form.agentfrom#">
<input type="hidden" id="businessfrom" name="businessfrom" value="#form.businessfrom#">
<input type="hidden" id="businessto" name="businessto" value="#form.businessto#">
<input type="hidden" id="periodfrom" name="periodfrom" value="#form.periodfrom#">
<input type="hidden" id="periodto" name="periodto" value="#form.periodto#">
<input type="hidden" id="datefrom" name="datefrom" value="#form.datefrom#">
<input type="hidden" id="dateto" name="dateto" value="#form.dateto#">
<input type="hidden" id="chart" name="chart" value="#charttype#">
<!---<div style="display:none"><input type="submit" id="submit" name="submit" value="submit"></div>--->
<input type="button" name="Bar" id="Bar" value="Bar" onClick="document.getElementById('chart').value=this.value;chartform.submit();"> &nbsp;&nbsp;<input type="button" name="Pie" id="Pie" value="Pie" onClick="document.getElementById('chart').value=this.value;form.submit();"> &nbsp;&nbsp;<input type="button" name="Line" id="Line" value="Line" onClick="document.getElementById('chart').value=this.value;form.submit();">&nbsp;&nbsp;<input type="button" name="horizontalbar" id="horizontalbar" value="horizontalbar" onClick="document.getElementById('chart').value=this.value;form.submit();">
</form>
</cfoutput>

	<cfquery name="getInfo" datasource="#dts#">
		SELECT a.custno,a.business,sum(ifnull(b.grand,0))as grand from #target_arcust# as a
        left join(
        select sum(grand) as grand,custno FROM artran 
        where fperiod<>'99' and (void='' or void is null) and type in ('CS','INV')
        	<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
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
            <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
        GROUP BY custno) as b on a.custno=b.custno
        where 0=0
        <cfif form.businessfrom neq "" and form.businessto neq "">
			and business >='#form.businessfrom#' and business <= '#form.businessto#'
		</cfif>
        and business <>''
        group by business
	</cfquery>
    

    
    <cfchart backgroundcolor="eff8ff" fontsize="12" xAxisTitle="Month" yAxisTitle="Value" title="" showborder="no" show3d="no" chartheight="500" chartwidth="600">
	<cfchartseries type="#charttype#" query="getInfo" valueColumn="grand" itemColumn="business" colorlist="1E90FF,48D1CC,F08080,DDA0DD,008000,996699,CCCC99,FFCCCC,333366,FFFF33"/></cfchart>
    
</body>
</html>