<cfswitch expression="#form.result#">
<cfcase value="HTML">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.usecostiniss" default="">
<cfparam name="totalinv" default="0">
<cfparam name="totaldn" default="0">
<cfparam name="totalcs" default="0">
<cfparam name="totaltt" default="0">
<cfparam name="totaliss" default="0">
<cfparam name="totalnet" default="0">
<html>
<head>
<title><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#url.type#">
	<cfcase value="listprojitem">
		<cfset title = ucase(getgeneral.lPROJECT)&" TRANSACTION LISTING">
	</cfcase>
	<cfcase value="salesiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" SALES - ISSUE REPORT">
		<cfquery name="getinfo" datasource="#dts#">
			select p.source,p.project,ifnull(b.suminvamt,0) as suminvamt,ifnull(c.sumdnamt,0) as sumdnamt,
			ifnull(d.sumcsamt,0) as sumcsamt,ifnull(e.sumissamt,0) as sumissamt,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)) as sumtotal,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)-ifnull(e.sumissamt,0)) as sumnet
			from project p
			
			left join(
				select sum(amt) as suminvamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='INV'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as b on b.source=p.source
			
			left join(
				select sum(amt) as sumdnamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='DN'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as c on c.source=p.source
			
			left join(
				select sum(amt) as sumcsamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='CS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as d on d.source=p.source
			
			left join(
				select <cfif form.usecostiniss neq "">sum(qty*it_cos)<cfelse>sum(amt)</cfif> as sumissamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='ISS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as e on e.source=p.source
			
			where p.porj='P'
			and (ifnull(b.suminvamt,0) <> 0 or ifnull(c.sumdnamt,0) <> 0 or ifnull(d.sumcsamt,0) <> 0 or ifnull(e.sumissamt,0) <> 0)
			<cfif form.projectfrom neq "" and form.projectto neq "">
				and p.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
			</cfif>
			order by p.source
		</cfquery>
	</cfcase>
	<cfcase value="projitemiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" PRODUCT ISSUE REPORT">
	</cfcase>
	<cfcase value="itemprojiss">
		<cfset title = "ITEM "&ucase(getgeneral.lPROJECT)&" ISSUE REPORT">
	</cfcase>
</cfswitch>
<body>
<table align="center" width="80%" border="0" cellspacing="0" cellpadding="1">
	<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#title#</strong></font></div>
		</td>
	</tr>
	<cfif isdefined("form.projectfrom") and form.projectfrom neq "" and form.projectto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lPROJECT# From #form.projectfrom# To #form.projectto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product From #form.productfrom# To #form.productto#</font></div></td>
		</tr>
	</cfif>
    <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Job From #form.jobfrom# To #form.jobto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #form.Catefrom# To #form.Cateto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lGROUP# From #form.groupfrom# To #form.groupto#</font></div></td>
		</tr>
	</cfif>
    <cfif periodfrom neq "" and periodto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Period From #periodfrom# To #periodto#</font></div></td>
      	</tr>
    </cfif>
    <cfif datefrom neq "" and dateto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #datefrom# To #dateto#</font></div></td>
      	</tr>
    </cfif>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5" colspan="100%"><hr></td></tr>
	<tr>
		<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#ucase(getgeneral.lPROJECT)#</cfoutput></font></td>
		<td><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">INV</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DN</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CS</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">ISS</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">NET</font></div></td>
	</tr>
	<tr><td height="5" colspan="100%"><hr></td></tr>
	<cfoutput query="getinfo">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.source#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.project#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.suminvamt),stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.sumdnamt),stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.sumcsamt),stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.sumtotal),stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.sumissamt),stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.sumnet),stDecl_UPrice)#</font></div></td>
		</tr>
		<cfset totalinv=totalinv+val(getinfo.suminvamt)>
		<cfset totaldn=totaldn+val(getinfo.sumdnamt)>
		<cfset totalcs=totalcs+val(getinfo.sumcsamt)>
		<cfset totaltt=totaltt+val(getinfo.sumtotal)>
		<cfset totaliss=totaliss+val(getinfo.sumissamt)>
		<cfset totalnet=totalnet+val(getinfo.sumnet)>
	</cfoutput>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalinv,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totaldn,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalcs,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totaltt,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totaliss,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalnet,",.__")#</cfoutput></strong></font></div></td>
	</tr>
</table>
</body>
</html>
</cfcase>

<cfcase value="EXCELDEFAULT">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.usecostiniss" default="">
<cfparam name="totalinv" default="0">
<cfparam name="totaldn" default="0">
<cfparam name="totalcs" default="0">
<cfparam name="totaltt" default="0">
<cfparam name="totaliss" default="0">
<cfparam name="totalnet" default="0">

<cfoutput>
<cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #getgeneral.lPROJECT#" output = "wddxText">
<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText# Report</Data></Cell></cfoutput>

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>
<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#url.type#">
	<cfcase value="listprojitem">
		<cfset title = ucase(getgeneral.lPROJECT)&" TRANSACTION LISTING">
	</cfcase>
	<cfcase value="salesiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" SALES - ISSUE REPORT">
		<cfquery name="getinfo" datasource="#dts#">
			select p.source,p.project,ifnull(b.suminvamt,0) as suminvamt,ifnull(c.sumdnamt,0) as sumdnamt,
			ifnull(d.sumcsamt,0) as sumcsamt,ifnull(e.sumissamt,0) as sumissamt,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)) as sumtotal,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)-ifnull(e.sumissamt,0)) as sumnet
			from project p
			
			left join(
				select sum(amt) as suminvamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='INV'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as b on b.source=p.source
			
			left join(
				select sum(amt) as sumdnamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='DN'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as c on c.source=p.source
			
			left join(
				select sum(amt) as sumcsamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='CS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as d on d.source=p.source
			
			left join(
				select <cfif form.usecostiniss neq "">sum(qty*it_cos)<cfelse>sum(amt)</cfif> as sumissamt,source
				from ictran
				where (void = '' or void is null) and source<>'' and type='ISS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source
			)as e on e.source=p.source
			
			where p.porj='P'
			and (ifnull(b.suminvamt,0) <> 0 or ifnull(c.sumdnamt,0) <> 0 or ifnull(d.sumcsamt,0) <> 0 or ifnull(e.sumissamt,0) <> 0)
			<cfif form.projectfrom neq "" and form.projectto neq "">
				and p.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
			</cfif>
			order by p.source
		</cfquery>
	</cfcase>
	<cfcase value="projitemiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" PRODUCT ISSUE REPORT">
	</cfcase>
	<cfcase value="itemprojiss">
		<cfset title = "ITEM "&ucase(getgeneral.lPROJECT)&" ISSUE REPORT">
	</cfcase>
</cfswitch>
				
		<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>Netiquette Technology</Author>
				<LastAuthor>Netiquette Technology</LastAuthor>
				<Company>Netiquette Technology</Company>
			</DocumentProperties>
			<Styles>
		  		<Style ss:ID="Default" ss:Name="Normal">
			   		<Alignment ss:Vertical="Bottom"/>
			   		<Borders/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
			   		<Interior/>
			   		<NumberFormat/>
			   		<Protection/>
		  		</Style>
		  		<Style ss:ID="s22">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  		</Style>
			 	<Style ss:ID="s24">
			   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
			  	</Style>
		  		<Style ss:ID="s26">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s27">
		  		</Style>
		  		<Style ss:ID="s30">
		   			<NumberFormat ss:Format="dd-mm-yy;@"/>
		  		</Style>
		  		<Style ss:ID="s31">
		  			<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s32">
		  	 		<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s33">
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s34">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="dd/mm/yyyy;@"/>
		  		</Style>
		  		<Style ss:ID="s35">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
		  		<Style ss:ID="s36">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s37">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
                <Style ss:ID="s50">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                <Style ss:ID="s51">
				<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                <Style ss:ID="s52">
		   			<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                 <Style ss:ID="s53">
		   			<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="150.5"/>
					<Column ss:Width="150.25"/>
					<Column ss:Width="80.75"/>

					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="50.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
                    <cfset d="8">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                         <cfset d=d+1>
                         </cfoutput>
		<cfoutput>
        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<cfwddx action = "cfml2wddx" input = "#title#" output = "wddxText">
			<Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
	</Row>
	<cfif isdefined("form.projectfrom") and form.projectfrom neq "" and form.projectto neq "">
		 <Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.lPROJECT# From #form.projectfrom# To #form.projectto#" output = "wddxText">
            <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfwddx action = "cfml2wddx" input = "#form.productfrom# To #form.productto#" output = "wddxText">
            <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Product From #wddxText#</Data></Cell>
		</Row>
	</cfif>
    <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfwddx action = "cfml2wddx" input = "#form.jobfrom# To #form.jobto#" output = "wddxText">
            <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Job From #wddxText#</Data></Cell>
	</cfif>
	<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #form.Catefrom# To #form.Cateto#" output = "wddxText">
             <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
         </Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP# From #form.groupfrom# To #form.groupto#" output = "wddxText">
            <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
            </Row>
	</cfif>
    <cfif periodfrom neq "" and periodto neq "">
      	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        	<cfwddx action = "cfml2wddx" input = "#periodfrom# To #periodto#" output = "wddxText">
            <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Period From #wddxText#</Data></Cell>
            </Row>
          </cfif>
    <cfif datefrom neq "" and dateto neq "">
      	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#datefrom# To #dateto#" output = "wddxText">
        <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Date From #wddxText#</Data></Cell>
      	</Row>
    </cfif>
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
     <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
     <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd-mm-yyyy")#" output = "wddxText2">
		<Cell  ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
        <Cell  ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <Cell  ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <Cell  ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <Cell  ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <Cell  ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <Cell  ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		<Cell  ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
	</Row>
	</cfoutput>
       
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
                <cfwddx action = "cfml2wddx" input = "#ucase(getgeneral.lPROJECT)#" output = "wddxText">
					<Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
					<Cell ss:StyleID="s50"><Data ss:Type="String">DESCRIPTION</Data></Cell>
					<Cell ss:StyleID="s52"><Data ss:Type="String">INV</Data></Cell>
					<Cell ss:StyleID="s52"><Data ss:Type="String">DN</Data></Cell>
					<Cell ss:StyleID="s52"><Data ss:Type="String">CS</Data></Cell>
                    <Cell ss:StyleID="s52"><Data ss:Type="String">TOTAL</Data></Cell>
					<Cell ss:StyleID="s52"><Data ss:Type="String">ISS</Data></Cell>
                    <Cell ss:StyleID="s52"><Data ss:Type="String">NET</Data></Cell>
				</Row>
                <cfoutput query="getinfo">
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
             <cfwddx action = "cfml2wddx" input = "#getinfo.source#" output = "wddxText">
             <cfwddx action = "cfml2wddx" input = "#getinfo.project#" output = "wddxText2">
             <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.suminvamt),stDecl_UPrice)#" output = "wddxText3">
             <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.sumdnamt),stDecl_UPrice)#" output = "wddxText4">
             <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.sumcsamt),stDecl_UPrice)#" output = "wddxText5">
             <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.sumtotal),stDecl_UPrice)#" output = "wddxText6">
             <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.sumissamt),stDecl_UPrice)#" output = "wddxText7">
             <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.sumnet),stDecl_UPrice)#" output = "wddxText8">
            <Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText2#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText3#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText4#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText5#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText6#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText7#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText8#</Data></Cell>
            </Row>	
            
        <cfset totalinv=totalinv+val(getinfo.suminvamt)>
		<cfset totaldn=totaldn+val(getinfo.sumdnamt)>
		<cfset totalcs=totalcs+val(getinfo.sumcsamt)>
		<cfset totaltt=totaltt+val(getinfo.sumtotal)>
		<cfset totaliss=totaliss+val(getinfo.sumissamt)>
		<cfset totalnet=totalnet+val(getinfo.sumnet)>
        	</cfoutput>

<Row ss:AutoFitHeight="0" ss:Height="23.0625">
<cfwddx action = "cfml2wddx" input = "#numberformat(totalinv,",.__")#" output = "wddxText">
<cfwddx action = "cfml2wddx" input = "#numberformat(totaldn,",.__")#" output = "wddxText2">
<cfwddx action = "cfml2wddx" input = "#numberformat(totalcs,",.__")#" output = "wddxText3">
<cfwddx action = "cfml2wddx" input = "#numberformat(totaltt,",.__")#" output = "wddxText4">
<cfwddx action = "cfml2wddx" input = "#numberformat(totaliss,",.__")#" output = "wddxText5">
<cfwddx action = "cfml2wddx" input = "#numberformat(totalnet,",.__")#" output = "wddxText6">
<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL</Data></Cell>
        <Cell ss:StyleID="s51"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
        <Cell ss:StyleID="s51"><Data ss:Type="String"><cfoutput>#wddxText2#</cfoutput></Data></Cell>
        <Cell ss:StyleID="s51"><Data ss:Type="String"><cfoutput>#wddxText3#</cfoutput></Data></Cell>
        <Cell ss:StyleID="s51"><Data ss:Type="String"><cfoutput>#wddxText4#</cfoutput></Data></Cell>
        <Cell ss:StyleID="s51"><Data ss:Type="String"><cfoutput>#wddxText5#</cfoutput></Data></Cell>
        <Cell ss:StyleID="s51"><Data ss:Type="String"><cfoutput>#wddxText6#</cfoutput></Data></Cell>
</Row>
			</Table>

			<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		   	<Unsynced/>
		   	<Print>
				<ValidPrinterInfo/>
				<Scale>60</Scale>
				<HorizontalResolution>600</HorizontalResolution>
				<VerticalResolution>600</VerticalResolution>
		   	</Print>
		   	<Selected/>
		   	<Panes>
				<Pane>
					<Number>3</Number>
			 		<ActiveRow>20</ActiveRow>
			 		<ActiveCol>3</ActiveCol>
				</Pane>
		   	</Panes>
		   	<ProtectObjects>False</ProtectObjects>
		   	<ProtectScenarios>False</ProtectScenarios>
		  	</WorksheetOptions>
		 	</Worksheet>
			</Workbook>
		</cfxml>

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase></cfswitch>
