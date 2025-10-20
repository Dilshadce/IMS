<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid,fifocal,costingcn,costingoai from gsetup
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
select * from modulecontrol
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfif isdefined('form.dodate')>
<cfquery name="createtable" datasource="#dts#">
CREATE TABLE IF NOT EXISTS `dolink`  (
  `useddo` VARCHAR(50)
)
ENGINE = MyISAM;
</cfquery>
<cfquery name="truncatedolink" datasource="#dts#">
truncate dolink
</cfquery>
<cfquery name="getdoupdated" datasource="#dts#">
INSERT INTO dolink SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>

</cfif>

<cfswitch expression="#form.result#">
	<cfcase value="HTML">
<html>
<head>
<title>Item Status & Value Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="i" default="1" type="numeric">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">
<cfparam name="OAIqty" default="0">
<cfparam name="OARqty" default="0">
<cfparam name="TRINqty" default="0">
<cfparam name="TROUqty" default="0">
<cfparam name="CTqty" default="0">
<cfparam name="xucost" default="0.0000000">
<cfparam name="balonhand" default="0">
<cfparam name="lastbalonhand" default="0">
<cfparam name="grandstkval" default="0">
<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandqty" default="0">

<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU','CT'">
    <cfset outtrantypewithinv1="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU'">
    <cfset outtrantypewithinv1="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(form.dateto, "DD")>

	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION 
	from gsetup;
</cfquery>

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
</cfif>

<cfswitch expression="#getgeneral.cost#">
	<cfcase value="FIXED">
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfcase value="MONTH">
		<cfset costingmethod = "Month Average Method">
	</cfcase>
	<cfcase value="MOVING">
		<cfset costingmethod = "Moving Average Method">
	</cfcase>
	<cfcase value="FIFO">
		<cfset costingmethod = "First In First Out Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Last In First Out Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	select * 
	from gsetup2;
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ",.">
</cfif>


<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfloop index="LoopCount" from="1" to="#iDecl_TPrice#">
  	<cfset stDecl_TPrice = stDecl_TPrice & "_">
</cfloop>

<body>

<h3 align="center"><font face="Times New Roman, Times, serif">Item Status and Value Summary</font></h3>
<h4 align="center"><font face="Times New Roman, Times, serif">Calculated by <cfoutput>#costingmethod#</cfoutput></font></h4>

<cfif getgeneral.cost neq "FIFO" and getgeneral.cost neq "LIFO">
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">	
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem_last_year as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
				</cfif>
                 <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse> 
                    and wos_date <= #getdate.ThisAccDate# 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                 <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
                    </cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                     and wos_date <= #getdate.ThisAccDate# 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
                </cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem_last_year as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99'
				and (linecode <> 'SV' or linecode is null)
		     		and wos_date <= #getdate.LastAccDate# 
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null)
					and (linecode <> 'SV' or linecode is null)
		     		and wos_date <= #getdate.LastAccDate#
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					group by itemno
				) as cc on aa.itemno=cc.itemno
				
				where aa.LastAccDate = #form.thislastaccdate#
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			and LastAccDate = #form.thislastaccdate#
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
				and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif>
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif>
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif> 
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
				<!--- <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >= 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase>
					<!--- REMARK ON 07-04-2009 --->
					<!--- <cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase> --->
				</cfswitch> --->
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno;
		</cfquery>
	</cfif>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<cfoutput>
		<cfif form.brandfrom neq "" and form.brandto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Brand: #form.brandfrom# - #form.brandto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">#getgeneral.lCATEGORY#: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">#getgeneral.lGROUP#: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Item: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Supplier: #form.suppfrom# - #form.suppto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Period: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">
					<!--- #form.monthfrom# - #form.monthto# --->
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						#ucase(dateformat(dateadd('m',val(form.periodfrom),form.thislastaccdate),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),form.thislastaccdate),"mmm yy"))#
					<cfelse>
						#ucase(dateformat(dateadd('m',val(form.periodfrom),getgeneral.lastaccyear),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),getgeneral.lastaccyear),"mmm yy"))#
					</cfif>
				</font></div></td>
			</tr>
		</cfif>
        <cfif datefrom neq "" and dateto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #datefrom# To #dateto#</font></div></td>
      	</tr>
    </cfif>
	</cfoutput>
	</table>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
		<cfoutput>
		<tr>
      		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      		<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    	</tr>
		</cfoutput>
    	<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
  		<tr>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">No</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Item No.</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Unit Cost</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Qty Bf</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">In</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Out</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Balance</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Stock Value ($)</font></div></td>
  		</tr>
  		<tr>
      		<td colspan="9"><hr></td>
    	</tr>
        <cfset pagebreak = 0>
    	<cfset rowlimit = 40>
  		<cfoutput query="getitem">
              <cfif isdefined('form.printform')>
        <cfif len(getitem.itemno) lte 15 and len(getitem.desp) lte 50>
        <cfset pagebreak = pagebreak + 1>
        <cfelse>
        <cfset pagebreak = pagebreak + 2>
        </cfif>
		<!--- <cfset roundamount = int(getitem.currentrow / 35)>
        <cfset rowdata = getitem.currentrow / 35>
        <cfif rouountndam eq rowdata> --->
        <cfif pagebreak gt rowlimit>
        <cfset pagebreak = 0>
        <cfset rowlimit = 50>
        </table>
        <p style="page-break-after:always">&nbsp;</p>
        
		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
        <tr>
      		<td colspan="100%"><hr></td>
    	</tr>
  		<tr>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">No</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Item No.</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Unit Cost</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Qty Bf</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">In</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Out</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Balance</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Stock Value ($)</font></div></td>
  		</tr>
  		<tr>
      		<td colspan="9"><hr></td>
    	</tr>
        </cfif>
        </cfif>
        
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.ucost),stDecl_UPrice)#</font></div></td>
					</cfcase>
					<cfcase value="MONTH,MOVING" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.unitcost),stDecl_UPrice)#</font></div></td>
					</cfcase>
				</cfswitch>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(qin)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(qout)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(balance)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "meisei_i" >#numberformat(val(stockbalance),',.__')#<cfelse>#numberformat(val(stockbalance),stDecl_UPrice)#</cfif></font></div></td>
			</tr>
			<cfset grandstkval = grandstkval + val(stockbalance)>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + val(getitem.qin)>
            <cfset grandqtyout = grandqtyout + val(getitem.qout)>
            <cfset grandqty = grandqty + val(getitem.balance)>
  		</cfoutput>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
       <!---  <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
		</tr> --->
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyout,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqty,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
		</tr>
	</table>

<!--- FIFO Costing Method --->
<cfelseif getgeneral.cost eq "FIFO">
	<cfparam name="form.includetr" default="yes">
	<cfset periodfr = val(form.periodfrom) + 10>
	<cfset periodto = val(form.periodto) + 10>
	<cfflush>
	
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.unit,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.trin,e.trout,f.innow,g.outnow,h.fqty,i.pamt,
			((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)) as bfqty,
			(((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) as balancenow
			from icitem_last_year as a
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="x">
						<cfif x eq 11>
							ifnull(qin#x#,0)
						<cfelse>
							+ifnull(qin#x#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastin,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as b on a.itemno=b.itemno
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="y">
						<cfif y eq 11>
							ifnull(qout#y#,0)
						<cfelse>
							+ifnull(qout#y#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastout,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as trin,itemno 
				from ictran
				where type ='TRIN' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        		and operiod+0 <= '#form.periodto#'
	      		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif> 
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno 
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as trout,itemno 
				from ictran
				where type ='TROU' and (void = '' or void is null) and (toinv='' or toinv is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and operiod+0 <= '#form.periodto#'
	     		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif> 
	     		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="z">
					<cfif z eq periodfr>
						ifnull(qin#z#,0)
					<cfelse>
						+ifnull(qin#z#,0)
					</cfif>
				</cfloop>
				as innow,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as f on a.itemno=f.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="a">
					<cfif a eq periodfr>
						ifnull(qout#a#,0)
					<cfelse>
						+ifnull(qout#a#,0)
					</cfif>
				</cfloop>
				as outnow,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as g on a.itemno=g.itemno
	
			left join
			(
				select (<cfloop index="i" from="50" to="11" step="-1">
							<cfset ffq = "ffq"&"#i#">
							<cfoutput>#ffq#</cfoutput><cfif i lte 50 and i gt 11>+</cfif>
					 	</cfloop>) as fqty,itemno 
				from fifoopq_last_year 
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as pamt,aa.itemno 
				from icitem_last_year as aa
				
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
		     		and wos_date <= #getdate.LastAccDate#
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
		     		and wos_date <= #getdate.LastAccDate#
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as i on a.itemno = i.itemno
	
			where a.itemno <> ''
			and a.LastAccDate = #form.thislastaccdate#
			<cfif isdefined("form.include0")>
			<cfelse>
				and (((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	<cfelse>
		<!--- ADD ON 03-04-2009, FOR QIN QOUT RECALCULATE --->
		<cfquery name="getictranin" datasource="#dts#">
			select sum(qty) as qin , itemno, fperiod
			from ictran 
			where type in (#PreserveSingleQuotes(intrantype)#)
			and fperiod<>'99' 
			and (void = '' or void is null) 
			and (linecode <> 'SV' or linecode is null)
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by itemno, fperiod
		</cfquery>
		
		<cfquery name="getictranout" datasource="#dts#">
			select sum(qty) as qout , itemno, fperiod
			from ictran as a
			where (void = '' or void is null)
			and fperiod<>'99' 
            <cfif ndateto neq ''>
            and wos_date<='#ndateto#'
            </cfif>
			and (linecode <> 'SV' or linecode is null)
            and
            
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)  and (toinv='' or toinv is null) 
                </cfif>  
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by itemno, fperiod
		</cfquery>
        
        
		<!--- INITIALIZE THE QIN/QOUT IN ICITEM --->
		<cfquery name="InitializeIcitem" datasource="#dts#">
			update icitem 
			set qin11= 0,
			qin12= 0,
			qin13= 0,
			qin14= 0,
			qin15= 0,
			qin16= 0,
			qin17= 0,
			qin18= 0,
			qin19= 0,
			qin20= 0,
			qin21= 0,
			qin22= 0,
			qin23= 0,
			qin24= 0,
			qin25= 0,
			qin26= 0,
			qin27= 0,
			qin28= 0, 
			qout11 = 0,
			qout12 = 0,
			qout13 = 0,
			qout14 = 0,
			qout15 = 0,
			qout16 = 0,
			qout17 = 0,
			qout18 = 0,
			qout19 = 0,
			qout20 = 0,
			qout21 = 0,
			qout22 = 0,
			qout23 = 0,
			qout24 = 0,
			qout25 = 0,
			qout26 = 0,
			qout27 = 0,
			qout28 = 0
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				where itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
		</cfquery>
		
		<cftry>
			<cfloop query="getictranin">
				
				<cfset qname = 'QIN'&(getictranin.fperiod+10)>
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#= #getictranin.qin# 
					where itemno = '#getictranin.itemno#'
				</cfquery>
			</cfloop>
			<cfcatch type="any">
				<cfoutput>Failed to update QIN. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfloop query="getictranout">
				<cfset qname = 'QOUT'&(getictranout.fperiod+10)>
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#= #getictranout.qout# 
					where itemno = '#getictranout.itemno#'
				</cfquery>
			</cfloop>
			<cfcatch type="any">
				<cfoutput>Failed to update QOUT. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
			</cfcatch>
		</cftry>
		<!--- ADD ON 03-04-2009, FOR QIN QOUT RECALCULATE --->

		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.unit,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.trin,e.trout,f.innow,g.outnow,h.fqty,i.pamt,
			((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)) as bfqty,
			(((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) as balancenow
			from icitem as a
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="x">
						<cfif x eq 11>
							ifnull(qin#x#,0)
						<cfelse>
							+ifnull(qin#x#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastin,itemno 
				from icitem
			) as b on a.itemno=b.itemno
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="y">
						<cfif y eq 11>
							ifnull(qout#y#,0)
						<cfelse>
							+ifnull(qout#y#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastout,itemno 
				from icitem
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as trin,itemno 
				from ictran
				where type ='TRIN' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and fperiod+0 <= '#form.periodto#'
	      		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif> 
				group by itemno 
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as trout,itemno 
				from ictran
				where type ='TROU' and (void = '' or void is null) and (toinv='' or toinv is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and fperiod+0 <= '#form.periodto#'
	     		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="z">
					<cfif z eq periodfr>
						ifnull(qin#z#,0)
					<cfelse>
						+ifnull(qin#z#,0)
					</cfif>
				</cfloop>
				as innow,itemno 
				from icitem
			) as f on a.itemno=f.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="a">
					<cfif a eq periodfr>
						ifnull(qout#a#,0)
					<cfelse>
						+ifnull(qout#a#,0)
					</cfif>
				</cfloop>
				as outnow,itemno 
				from icitem
			) as g on a.itemno=g.itemno
	
			left join
			(
				select (<cfloop index="i" from="50" to="11" step="-1">
							<cfset ffq = "ffq"&"#i#">
							<cfoutput>#ffq#</cfoutput><cfif i lte 50 and i gt 11>+</cfif>
					 	</cfloop>) as fqty,itemno 
				from fifoopq 
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as pamt,aa.itemno 
				from icitem as aa
				
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
				and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as i on a.itemno = i.itemno
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
			<cfelse>
			and (((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	</cfif>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<cfoutput>
		<cfif form.brandfrom neq "" and form.brandto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Brand: #form.brandfrom# - #form.brandto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Category: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Group: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Item: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Supplier: #form.suppfrom# - #form.suppto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Period: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">
					<!--- #form.monthfrom# - #form.monthto# --->
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						#ucase(dateformat(dateadd('m',val(form.periodfrom),form.thislastaccdate),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),form.thislastaccdate),"mmm yy"))#
					<cfelse>
						#ucase(dateformat(dateadd('m',val(form.periodfrom),getgeneral.lastaccyear),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),getgeneral.lastaccyear),"mmm yy"))#
					</cfif>
				</font></div></td>
			</tr>
		</cfif>
        <cfif datefrom neq "" and dateto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #datefrom# To #dateto#</font></div></td>
      	</tr>
    </cfif>
	</cfoutput>
	</table>
    <cfset pagebreak = 0>
    <cfset rowlimit = 50>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    	<cfoutput>
		<tr>
        	<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
      	</tr>
    	</cfoutput>
    	<tr>
      		<td colspan="10"><hr></td>
    	</tr>
    	<tr>
			<td><font size="2" face="Times New Roman, Times, serif">NO.</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif isdefined('form.fifocost')>Unit Cost<cfelse>LAST COST</cfif></font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td>
    	</tr>
    	<tr>
      		<td colspan="10"><hr></td>
    	</tr>
	
		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			 <cfset fifotable="fifoopq_last_year">
		<cfelse>	
			<cfset fifotable="fifoopq">
		</cfif>
		
		<cfflush>
		<cfloop query="getitem">
      		<cfset balqty =  val(getitem.qtybf) + val(getitem.lastin) - val(getitem.lastout) + val(getitem.innow) - val(getitem.outnow)>
	  		<!--- <cfset balnowqty = val(getitem.qtybf) + val(getitem.innow) - val(getitem.outnow)> --->
      		<cfset lastcost = 0>
	  		<cfset fifoqty = 0>
      		<cfset ttnewffstkval =0>
      		<!--- <cfset qqout = val(getitem.qout)> --->
			<cfset qqout = val(getitem.lastout) + val(getitem.outnow) - val(getitem.trout)>

	 		<cfif val(getitem.fqty) neq 0>
	  			<cfset lastcost = 0>

				<cfloop index="i" from="50" to="11" step="-1">
          			<cfset ffq = "ffq"&"#i#">
          			<cfset ffc = "ffc"&"#i#">

		  			<cfquery name="getfifoopq" datasource="#dts#">
          				select #ffq# as xffq, #ffc# as xffc from #fifotable# where itemno = '#getitem.itemno#'
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
          			</cfquery>

		  			<cfif getfifoopq.xffq gt 0>
            			<cfset lastcost = getfifoopq.xffc>
          			</cfif>

		  			<cfset fifoqty = fifoqty + val(getfifoopq.xffq)>
          			<cfset newffstkval = val(getfifoopq.xffq) * val(getfifoopq.xffc)>
          			<cfset ttnewffstkval = ttnewffstkval + newffstkval>

		  			<cfif fifoqty gte val(qqout)>
            			<!--- <cfset minusfifoqty = fifoqty - val(getitem.qout)> --->
						<cfset minusfifoqty = fifoqty - val(qqout)>

						<cfif minusfifoqty gt 0>
              				<cfset stkvalff = minusfifoqty * val(getfifoopq.xffc)>
              			<cfelse>
              				<cfset stkvalff = 0>
            			</cfif>

						<cfset fifocnt = i - 1>
            			<cfbreak>
          			</cfif>
        		</cfloop>
				
				<!--- REMARK ON 17-12-2008 --->
				<!--- <cfset totalout = val(getitem.qout) + val(getitem.lastout)> --->
				<!--- <cfset totalout = val(getitem.qout)> --->
				<!--- REMARK ON 05-11-2009 --->
				<!--- <cfset totalout = val(getitem.lastout) + val(getitem.outnow)> --->
				<cfset totalout = val(getitem.lastout) + val(getitem.outnow) - val(getitem.trout)>
				
        		<cfif fifoqty gte totalout >
          			<cfset ttnewffstkval = 0>

					<cfloop index="i" from="#fifocnt#" to="11" step="-1">
            			<cfset ffq = "ffq"&"#i#">
            			<cfset ffc = "ffc"&"#i#">

						<cfquery name="getfifoopq2" datasource="#dts#">
            				select #ffq# as xffq, #ffc# as xffc from #fifotable# where itemno = '#getitem.itemno#'
							<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
								and LastAccDate = #form.thislastaccdate#
							</cfif>
            			</cfquery>

						<cfif getfifoopq2.xffq gt 0>
              				<cfset lastcost = val(getfifoopq2.xffc)>
            			</cfif>

						<cfset newffstkval = val(getfifoopq2.xffq) * val(getfifoopq2.xffc)>
            			<cfset ttnewffstkval = ttnewffstkval + newffstkval>
          			</cfloop>

		  			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  			<cfquery name="getallrc" datasource="#dts#">
							select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem_last_year as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(amt/qty) as price1,sum(amt_bil/qty_bil)as price_bil1 
								from ictran 
								where itemno='#getitem.itemno#' and type in ('RC','OAI') and (void = '' or void is null)
					     		and wos_date > #getdate.LastAccDate#
								and wos_date <= #getdate.ThisAccDate# 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and operiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitem.itemno#' and type='CN' and (void = '' or void is null) 
					     		and wos_date > #getdate.LastAccDate#
								and wos_date <= #getdate.ThisAccDate# 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and operiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitem.itemno#'
							and LastAccDate = #form.thislastaccdate#
	          			</cfquery>

						<cfquery name="getrc" datasource="#dts#">
							select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
							and wos_date = (select max(wos_date) 
											from ictran 
											where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
											and wos_date > #getdate.LastAccDate#
											and wos_date <= #getdate.ThisAccDate# 
											)
							and wos_date > #getdate.LastAccDate#
							and wos_date <= #getdate.ThisAccDate# 
							<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and operiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
						</cfquery>	
					<cfelse>
			  			<cfquery name="getallrc" datasource="#dts#">
							select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(amt/qty) as price1,sum(amt_bil/qty_bil)as price_bil1 
								from ictran 
								where itemno='#getitem.itemno#' and type in ('RC','OAI') and (void = '' or void is null)
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitem.itemno#' and type='CN' and (void = '' or void is null) 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitem.itemno#';
	          			</cfquery>

						<cfquery name="getrc" datasource="#dts#">
							select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
							and wos_date = (select max(wos_date) from ictran where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null))
							<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and fperiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
						</cfquery>	
					</cfif>

					<!--- <cfquery name="getrc" datasource="#dts#">
          				select qty, amt, amt_bil, price, price_bil from ictran where itemno = '#getitem.itemno#' and type = 'RC' and (void = '' or void is null)
          				<cfif form.periodfrom neq "" and form.periodto neq "">
             			and fperiod <= '#form.periodto#'
          				</cfif>
          				order by trdatetime
          			</cfquery> --->

		  			<cfif getrc.recordcount gt 0>
              			<cfset lastcost = getrc.price>
          			</cfif>

		  			<cfset totalstkval = stkvalff + ttnewffstkval + val(getallrc.sumamt)>
		  			
          		<cfelse>
          			<cfset totalrcqty = fifoqty>
          			<cfset stkval = 0>

		  			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  			<cfquery name="getrc" datasource="#dts#">
	          				select qty,
							if(type='CN',it_cos,amt)as amt,
							if(type='CN',(it_cos/currrate),
							amt_bil) as amt_bil,
							if(type='CN',(it_cos/qty),
							(amt/qty)) as price,
							if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
							and wos_date > #getdate.LastAccDate#
							and wos_date <= #getdate.ThisAccDate#
	          				<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and operiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
	          			</cfquery>
					<cfelse>	
			  			<cfquery name="getrc" datasource="#dts#">
	          				select qty,
							if(type='CN',it_cos,amt)as amt,
							if(type='CN',(it_cos/currrate),
							amt_bil) as amt_bil,
							if(type='CN',(it_cos/qty),
							(amt/qty)) as price,
							if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
	          				<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and fperiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
	          			</cfquery>
					</cfif>

		  			<cfset cnt = 0>

		  			<cfloop query="getrc">
            			<cfset cnt = cnt + 1>

						<cfif getrc.qty neq "">
              				<cfset rcqty = getrc.qty>
              			<cfelse>
              				<cfset rcqty = 0>
            			</cfif>

						<cfset lastcost = getrc.price>
            			<cfset totalrcqty = totalrcqty + rcqty>

						<cfif totalrcqty gte qqout>
              				<cfset minusqty = totalrcqty - qqout>

							<cfif minusqty gt 0>
                				<cfset stkval = minusqty * getrc.price>
                			<cfelse>
                				<cfset stkval = 0>
              				</cfif>

							<cfbreak>
            			</cfif>
          			</cfloop>

          			<cfif getrc.recordcount gt cnt>
            			<cfset cnt = cnt + 1>
            			<!--- next record --->
            			<cfset newstkval = 0>

						<cfloop query="getrc" startrow="#cnt#">
              				<cfset lastcost = getrc.price>
              				<cfset newstkval = newstkval + getrc.amt>
            			</cfloop>
            		<cfelse>
            			<cfset newstkval = 0>
          			</cfif>

					<cfset totalstkval = stkval + newstkval>
        		</cfif>
        	<cfelse><!--- if qtybf eq 0 --->
        		<cfset totalrcqty = 0>
        		<cfset stkval = 0>

				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="getrc" datasource="#dts#">
	        			select qty,
						if(type='CN',it_cos,amt)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						(amt/qty)) as price,
						if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
						from ictran 
						where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#
	          			<cfif form.periodfrom neq "" and form.periodto neq "">
	             			and operiod+0 <= '#form.periodto#'
	          			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date <= '#ndateto#' 
						</cfif> 
	          			order by wos_date,trdatetime;
	        		</cfquery>
				<cfelse>
					<cfquery name="getrc" datasource="#dts#">
	        			select qty,
						if(type='CN',it_cos,amt)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						(amt/qty)) as price,
						if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
						from ictran 
						where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
	          			<cfif form.periodfrom neq "" and form.periodto neq "">
	             		and fperiod+0 <= '#form.periodto#'
	          			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date <= '#ndateto#' 
						</cfif> 
	          			order by wos_date,trdatetime;
	        		</cfquery>
				</cfif>

				<cfset cnt = 0>

				<cfloop query="getrc">
          			<cfset cnt = cnt + 1>

					<cfset rcqty = val(getrc.qty)>

					<cfset lastcost = getrc.price>
          			<cfset totalrcqty = totalrcqty + rcqty>

					<cfif totalrcqty gte qqout>
            			<cfset minusqty = totalrcqty - qqout>

						<cfif minusqty neq 0>
              				<cfset stkval = minusqty * getrc.price>
              			<cfelse>
              				<cfset stkval = 0>
            			</cfif>
            			<cfbreak>
          			</cfif>
        		</cfloop>
				
				<cfif getrc.recordcount gt cnt>
          			<cfset cnt = cnt + 1>
          			<!--- next record --->
          			<cfset newstkval = 0>

					<cfloop query="getrc" startrow="#cnt#">
            			<cfset lastcost = getrc.price>
            			<cfset newstkval = newstkval + getrc.amt>
         	 		</cfloop>
          		<cfelse>
          			<cfset newstkval = 0>
        		</cfif>

				<cfset totalstkval = stkval + newstkval>
				
      		</cfif>
		
		<cfoutput>
        
		<cfif isdefined('form.fifocost')>
        <cfset divby = getitem.balancenow>
        <cfif getitem.balancenow eq "-">
        <cfset divby = 1>
		</cfif>
        <cfif getitem.balancenow eq 0 or getitem.balancenow eq "">
        <cfset divby = 1>
        </cfif>
		<cfset lastcost = val(totalstkval) / divby >
		</cfif>
        
        <cfif isdefined('form.printform')>
        <cfif len(getitem.itemno) lte 15 and len(getitem.desp) lte 50>
        <cfset pagebreak = pagebreak + 1>
        <cfelse>
        <cfset pagebreak = pagebreak + 2>
        </cfif>
		<!--- <cfset roundamount = int(getitem.currentrow / 35)>
        <cfset rowdata = getitem.currentrow / 35>
        <cfif rouountndam eq rowdata> --->
        <cfif pagebreak gt rowlimit>
        <cfset pagebreak = 0>
        <cfset rowlimit = 60>
        </table>
        <p style="page-break-after:always">&nbsp;</p>
        
		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
        <tr>
        <td colspan="10"><hr></td>
        </tr>
        <tr>
			<td><font size="2" face="Times New Roman, Times, serif">NO.</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif isdefined('form.fifocost')>Unit Cost<cfelse>LAST COST</cfif></font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td>
    	</tr>
    	<tr>
      		<td colspan="10"><hr></td>
    	</tr>
		</cfif>
        </cfif>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getitem.bfqty)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(innow)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(outnow)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(balancenow)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(lastcost,stDecl_UPrice)#</font></div></td>
				<cfif lcase(hcomid) eq "gecn_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "ge_i" or lcase(hcomid) eq "meisei_i">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,"_.__")#</font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,stDecl_TPrice)#</font></div></td>
				</cfif>
			</tr>
			<cfif lcase(hcomid) eq "gecn_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "ge_i">
				<cfset totalstkval = numberformat(totalstkval,"_.__")>
			</cfif>
			<cfset grandstkval = grandstkval + totalstkval>
            <cfset grandqtybf =grandqtybf+val(getitem.bfqty)>
            <cfset grandqtyin = grandqtyin + val(innow)>
            <cfset grandqtyout = grandqtyout + val(outnow)>
            <cfset grandqty = grandqty + val(balancenow)>
      	</cfoutput>
    </cfloop>
	
	<tr>
        <td colspan="10"><hr></td>
	</tr>
    <!--- <tr>
		<td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
    </tr> --->
    <tr>
		<td></td>
        <td></td>
        <td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyout,"0")#</cfoutput></font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqty,"0")#</cfoutput></font></div></td>
        <td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
    </tr>
</table>

<!-- LIFO Costing Method -->
<cfelseif getgeneral.cost eq "LIFO">
	<cfset stkvalff=0>
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,unit,qtybf 
		from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">icitem_last_year<cfelse>icitem</cfif> 
		where itemno <> ''
		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			and LastAccDate = #form.thislastaccdate#
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and category between '#form.catefrom#' and '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and wos_group betwwen '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		order by itemno;
	</cfquery>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<cfoutput>
		<cfif form.brandfrom neq "" and form.brandto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Brand: #form.brandfrom# - #form.brandto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">#getgeneral.lCATEGORY#: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">#getgeneral.lGROUP#: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Item: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Supplier: #form.suppfrom# - #form.suppto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Period: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">
					<!--- #form.monthfrom# - #form.monthto# --->
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						#ucase(dateformat(dateadd('m',val(form.periodfrom),form.thislastaccdate),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),form.thislastaccdate),"mmm yy"))#
					<cfelse>
						#ucase(dateformat(dateadd('m',val(form.periodfrom),getgeneral.lastaccyear),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),getgeneral.lastaccyear),"mmm yy"))#
					</cfif>
				</font></div></td>
			</tr>
		</cfif>
        <cfif datefrom neq "" and dateto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #datefrom# To #dateto#</font></div></td>
      	</tr>
    </cfif>
	</cfoutput>
	</table>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    	<cfoutput>
		<tr>
        	<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
      	</tr>
    	</cfoutput>
    	<tr>
      		<td colspan="9"><hr></td>
    	</tr>
    	<tr>
      		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">LAST COST</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td>
    	</tr>
        
    	<tr>
      		<td colspan="9"><hr></td>
    	</tr>
		<cfset pagebreak = 0>
    	<cfset rowlimit = 50>
    	<cfloop query="getitem">
      		<cfset lastbal= 0>
      		<cfset lastin=0>
      		<cfset lastout=0>
      		<cfset lastdo=0>
      		
			<cfif form.periodfrom neq '01'>
        		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetin" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(intrantype)#) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate# 
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and operiod+0 < '#form.periodfrom#'
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				<cfelse>
					<cfquery name="lastgetin" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(intrantype)#) and itemno='#itemno#' and (void = '' or void is null)
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and fperiod+0 < '#form.periodfrom#'
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				</cfif>
        		
				<cfif lastgetin.sumqty neq "">
          			<cfset lastin = lastgetin.sumqty>
        		</cfif>
        		
				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetout" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#  
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and operiod+0 < '#form.periodfrom#' 
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				<cfelse>
					<cfquery name="lastgetout" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and itemno='#itemno#' and (void = '' or void is null) 
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and fperiod+0 < '#form.periodfrom#' 
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				</cfif>
        		
				<cfif lastgetout.sumqty neq "">
				  	<cfset lastout = lastgetout.sumqty>
				</cfif>
				
				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetdo" datasource="#dts#">
						select sum(qty)as sumqty 
						from ictran 
						where type='DO' and (toinv='' or toinv is null) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#  
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and operiod+0 < '#form.periodfrom#'
						</cfif> 
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
						group by itemno
					</cfquery>
				<cfelse>
					<cfquery name="lastgetdo" datasource="#dts#">
						select sum(qty)as sumqty 
						from ictran 
						where type='DO' and (toinv='' or toinv is null) and itemno='#itemno#' and (void = '' or void is null)
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and fperiod+0 < '#form.periodfrom#'
						</cfif> 
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
						group by itemno
					</cfquery>
				</cfif>
				
				<cfif lastgetdo.sumqty neq "">
				  	<cfset lastdo = lastgetdo.sumqty>
				</cfif>
				
				<cfset lastbal = lastin - lastdo - lastout>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="check" datasource="#dts#">
				  	select itemno 
					from fifoopq_last_year 
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
					and LastAccDate = #form.thislastaccdate#
				</cfquery>
			<cfelse>
				<cfquery name="check" datasource="#dts#">
				  	select itemno 
					from fifoopq 
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
				</cfquery>
			</cfif>
			
			<cfset lastcost = 0>
			
			<cfif getitem.qtybf neq "">
				<cfset bfqty = getitem.qtybf + lastbal>
			<cfelse>
				<cfset bfqty = lastbal>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getin" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 
				</cfquery>
			<cfelse>
				<cfquery name="getin" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 
				</cfquery>
			</cfif>
			
			<cfif getin.qty neq "">
				<cfset inqty = getin.qty>
			<cfelse>
				<cfset inqty = 0>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getinnow" datasource="#dts#">
					select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) 
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 >= '#form.periodfrom#' and operiod <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
				</cfquery>
			<cfelse>
				<cfquery name="getinnow" datasource="#dts#">
					select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) 
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
				</cfquery>
			</cfif>
			
			<cfif getinnow.qty neq "">
				<cfset innowqty = getinnow.qty>
			<cfelse>
				<cfset innowqty = 0>
			</cfif>
      
	  		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
		  		<cfquery name="getdo" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 

			  	</cfquery>	
			<cfelse>
		  		<cfquery name="getdo" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 

			  	</cfquery>	
			</cfif>
	  
		  	<cfif getdo.qty neq "">
				<cfset doqty = getdo.qty>
			<cfelse>
				<cfset doqty = 0>
		  	</cfif>
			
		  	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  	<cfquery name="getdonow" datasource="#dts#">
			  		select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif>
					group by itemno
			  	</cfquery>	
			<cfelse>
			  	<cfquery name="getdonow" datasource="#dts#">
			  		select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif>
					group by itemno
			  	</cfquery>	
			</cfif>
			
			<cfif getdonow.qty neq "">
        		<cfset donowqty = getdonow.qty>
        	<cfelse>
        		<cfset donowqty = 0>
      		</cfif>
      	
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getout" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(outtrantypewodo)#) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      		</cfquery>
			<cfelse>
				<cfquery name="getout" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(outtrantypewodo)#) and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      		</cfquery>
			</cfif>
      
		  	<cfif getout.qty neq "">
				<cfset outqty = getout.qty>
			<cfelse>
				<cfset outqty = 0>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getoutnow" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewodo)#)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#   
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 between '#form.periodfrom#' and '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
					group by itemno
			  	</cfquery>
			<cfelse>
				<cfquery name="getoutnow" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewodo)#) 
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
					group by itemno
			  	</cfquery>
			</cfif>
			
			<cfif getoutnow.qty neq "">
        		<cfset outnowqty = getoutnow.qty>
        	<cfelse>
        		<cfset outnowqty = 0>
      		</cfif>
      		
			<cfset ttoutnowqty = outnowqty + donowqty>
		  	<cfset ttoutqty = outqty + doqty>
		  	<cfset balqty =  bfqty + inqty - ttoutqty>
		  	<cfset balnowqty =  bfqty + innowqty - ttoutnowqty>
		  	<cfset fifoqty = 0>
		  	<cfset ttnewffstkval =0>
      		
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#   
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      			order by trdatetime desc
	      		</cfquery>
			<cfelse>
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      			order by trdatetime desc
	      		</cfquery>
			</cfif>
			
			<cfif getrc.recordcount gt 0 and check.recordcount gt 0>
        		<cfset totalrcqty = 0>
        		<cfset cnt = 0>
        		
				<cfloop query="getrc">
          			<cfset cnt = cnt + 1>
          			
					<cfif getrc.qty neq "">
            			<cfset rcqty = getrc.qty>
            		<cfelse>
            			<cfset rcqty = 0>
          			</cfif>
          			
					<cfset lastcost = getrc.price>
          			<cfset totalrcqty = totalrcqty + rcqty>
          			
					<cfif totalrcqty gte ttoutqty>
            			<cfset minusqty = totalrcqty - ttoutqty>
            			
						<cfif minusqty gt 0>
              				<cfset stkval = minusqty * lastcost>
              			<cfelse>
              				<cfset stkval = 0>
            		</cfif>
            		<cfbreak>
          		</cfif>
        	</cfloop>
        	
			<cfif totalrcqty gte ttoutqty>
          		<cfset cnt = cnt + 1>
          		<!--- next record --->
          		<cfset newstkval = 0>
          		
				<cfoutput query="getrc" startrow="#cnt#">
            		<cfset lastcost = getrc.price>
            		<cfset newstkval = newstkval + getrc.amt>
          		</cfoutput>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif> 
						where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
            		
					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
          		</cfloop>
          		
				<cfset totalstkval = stkval + newstkval + ttnewffstkval>
          	<cfelse>
          		<!--- rc less than out --->
          		<cfset ttnewffstkval = 0>
          		<cfset fifoqty = totalrcqty>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>  
						where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
					
					<cfset fifoqty = fifoqty + getfifoopq.xffq>
            		<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		
					<cfif fifoqty gte ttoutqty>
              			<cfset minusfifoqty = fifoqty - ttoutqty>
              			
						<cfif minusfifoqty gt 0>
                			<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
                		<cfelse>
                			<cfset stkvalff = 0>
              			</cfif>
              			
						<cfset fifocnt = i + 1>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif fifoqty gte ttoutqty>
            		<cfset ttnewffstkval = 0>
            		
					<cfloop index="i" from="#fifocnt#" to="50">
              			<cfset ffq = "ffq"&"#i#">
              			<cfset ffc = "ffc"&"#i#">
              			
						<cfquery name="getfifoopq2" datasource="#dts#">
              				select #ffq# as xffq, #ffc# as xffc 
							from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>  
							where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
							<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
								and LastAccDate = #form.thislastaccdate#
							</cfif>
              			</cfquery>
              			
						<cfif getfifoopq2.xffq gt 0>
                			<cfset lastcost = getfifoopq2.xffc>
              			</cfif>
              				
						<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
              			<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		</cfloop>
          		</cfif>
          		
				<cfset totalstkval = stkvalff + ttnewffstkval>
        	</cfif>
    
        <cfelseif getrc.recordcount eq 0 and check.recordcount gt 0>
        	<cfset ttnewffstkval = 0>
        	<cfset lastcost = 0>
        		
			<cfloop index="i" from="11" to="50">
          		<cfset ffq = "ffq"&"#i#">
          		<cfset ffc = "ffc"&"#i#">
          		
				<cfquery name="getfifoopq2" datasource="#dts#">
          			select #ffq# as xffq, #ffc# as xffc 
					from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>   
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						and LastAccDate = #form.thislastaccdate#
					</cfif>
          		</cfquery>
				
          		<cfif getfifoopq2.xffq gt 0>
            		<cfset lastcost = getfifoopq2.xffc>
          		</cfif>
          		
				<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
          		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
        	</cfloop>
        	
			<cfset totalstkval = ttnewffstkval>
        <cfelse>
        	<cfset totalrcqty = 0>
        	<cfset cnt = 0>
        	<cfset stkval = 0>
        	<cfset newstkval = 0>
        	
			<cfif getrc.recordcount gt 0>
          		<cfloop query="getrc">
            		<cfset cnt = cnt + 1>
            		
					<cfif getrc.qty neq "">
              			<cfset rcqty = getrc.qty>
              		<cfelse>
              			<cfset rcqty = 0>
            		</cfif>
            		
					<cfset lastcost = getrc.price>
            		<cfset totalrcqty = totalrcqty + rcqty>
            		
					<cfif totalrcqty gte ttoutqty>
              			<cfset minusqty = totalrcqty - ttoutqty>
              			
						<cfif minusqty gt 0>
                			<cfset stkval = minusqty * getrc.price>
                		<cfelse>
                			<cfset stkval = 0>
              			</cfif>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif getrc.recordcount gt cnt>
            		<cfset cnt = cnt + 1>
            		<!--- next record --->
            		<cfset newstkval = 0>
            		
					<cfoutput query="getrc" startrow="#cnt#">
              			<cfset lastcost = getrc.price>
              			<cfset newstkval = newstkval + getrc.amt>
            		</cfoutput>
            	<cfelse>
            		<cfset newstkval = 0>
          		</cfif>
        	</cfif>
        	
			<cfset totalstkval = stkval + newstkval>
      	</cfif>
      	<cfoutput>
        <cfif isdefined('form.printform')>
        <cfif len(getitem.itemno) lte 15 and len(getitem.desp) lte 50>
        <cfset pagebreak = pagebreak + 1>
        <cfelse>
        <cfset pagebreak = pagebreak + 2>
        </cfif>
		<!--- <cfset roundamount = int(getitem.currentrow / 35)>
        <cfset rowdata = getitem.currentrow / 35>
        <cfif rouountndam eq rowdata> --->
        <cfif pagebreak gt rowlimit>
        <cfset pagebreak = 0>
        <cfset rowlimit = 60>
        </table>
        <p style="page-break-after:always">&nbsp;</p>
        
		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
<tr>
      		<td colspan="9"><hr></td>
    	</tr>
    	<tr>
      		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">LAST COST</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td>
    	</tr>
        
    	<tr>
      		<td colspan="9"><hr></td>
    	</tr>
        </cfif>
        </cfif>
        
        	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
          		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#unit#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtybf#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#innowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttoutnowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balnowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(lastcost,",_.__")#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,",_.__")#</font></div></td>
        	</tr>
			<cfset grandstkval = grandstkval + totalstkval>         
            <cfset grandqtybf =grandqtybf+val(qtybf)>
            <cfset grandqtyin = grandqtyin + val(innowqty)>
            <cfset grandqtyout = grandqtyout + val(ttoutnowqty)>
            <cfset grandqty = grandqty + val(balnowqty)>
      	</cfoutput>
    </cfloop>
	
		<tr>
			<td colspan="9"><hr></td>
		</tr>
		<!--- <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
		</tr> --->
        <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyout,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqty,"0")#</cfoutput></font></div></td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
		</tr>
	</table>
</cfif>

<br><br>
<div align="right">
	<font size="1" face="Arial, Helvetica, sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>
<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>
</body>
</html>

</cfcase>

<cfcase value="EXCELDEFAULT">

<cfset currentDirectory = GetDirectoryFromPath(GetTemplatePath()) & "..\..\Excel_Report\"&dts&"\">
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "00">
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
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
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
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
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
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		  		</Style>
                <Style ss:ID="s40">
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Item Status and Value">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
                    <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="9">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>

<cfparam name="i" default="1" type="numeric">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">
<cfparam name="OAIqty" default="0">
<cfparam name="OARqty" default="0">
<cfparam name="TRINqty" default="0">
<cfparam name="TROUqty" default="0">
<cfparam name="CTqty" default="0">
<cfparam name="xucost" default="0.0000000">
<cfparam name="balonhand" default="0">
<cfparam name="lastbalonhand" default="0">
<cfparam name="grandstkval" default="0">
<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandqty" default="0">

<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU','CT'">
    <cfset outtrantypewithinv1="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU'">
    <cfset outtrantypewithinv1="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(form.dateto, "DD")>

	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,fifocal ,costingcn,costingoai
	from gsetup;
</cfquery>

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
</cfif>

<cfswitch expression="#getgeneral.cost#">
	<cfcase value="FIXED">
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfcase value="MONTH">
		<cfset costingmethod = "Month Average Method">
	</cfcase>
	<cfcase value="MOVING">
		<cfset costingmethod = "Moving Average Method">
	</cfcase>
	<cfcase value="FIFO">
		<cfset costingmethod = "First In First Out Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Last In First Out Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	select * 
	from gsetup2;
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ",.">
</cfif>


<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfloop index="LoopCount" from="1" to="#iDecl_TPrice#">
  	<cfset stDecl_TPrice = stDecl_TPrice & "_">
</cfloop>
<cfoutput>
<cfwddx action = "cfml2wddx" input = "Item Status and Value Summary" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
<cfwddx action = "cfml2wddx" input = "#costingmethod#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Calculated by #wddxText#</Data></Cell>
					</Row>
          </cfoutput>          
<cfif getgeneral.cost neq "FIFO" and getgeneral.cost neq "LIFO">
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">	
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem_last_year as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
				</cfif>
                 <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse> 
                    and wos_date <= #getdate.ThisAccDate# 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                 <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
                    </cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                     and wos_date <= #getdate.ThisAccDate# 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
                </cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem_last_year as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99'
				and (linecode <> 'SV' or linecode is null)
		     		and wos_date <= #getdate.LastAccDate# 
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null)
					and (linecode <> 'SV' or linecode is null)
		     		and wos_date <= #getdate.LastAccDate#
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					group by itemno
				) as cc on aa.itemno=cc.itemno
				
				where aa.LastAccDate = #form.thislastaccdate#
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			and LastAccDate = #form.thislastaccdate#
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
				and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif>
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif>
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif> 
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
				<!--- <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >= 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase>
					<!--- REMARK ON 07-04-2009 --->
					<!--- <cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase> --->
				</cfswitch> --->
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno;
		</cfquery>
	</cfif>
	
	<cfoutput>
    
		<cfif form.brandfrom neq "" and form.brandto neq "">
            <cfwddx action = "cfml2wddx" input = "Brand: #form.brandfrom# - #form.brandto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
             <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY#: #form.catefrom# - #form.cateto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
            <cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP#: #form.groupfrom# - #form.groupto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
             <cfwddx action = "cfml2wddx" input = "Item: #form.productfrom# - #form.productto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
        <cfif lcase(hcomid) eq "hyray_i">
        <cfquery name="getsuppliername" datasource="#dts#">
        select name from #target_apvend# where custno='#form.suppfrom#'
        </cfquery>
        <cfquery name="getsuppliername1" datasource="#dts#">
        select name from #target_apvend# where custno='#form.suppto#'
        </cfquery>
        </cfif>

            <cfwddx action = "cfml2wddx" input = "Supplier: #form.suppfrom# - #form.suppto#" output = "wddxText">

						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
            <cfwddx action = "cfml2wddx" input = "Period: #form.periodfrom# - #form.periodto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
			
					<!--- #form.monthfrom# - #form.monthto# --->
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						<cfwddx action = "cfml2wddx" input = "#ucase(dateformat(dateadd('m',val(form.periodfrom),form.thislastaccdate),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),form.thislastaccdate),"mmm yy"))#" output = "wddxText">
					<cfelse>
					<cfwddx action = "cfml2wddx" input = "#ucase(dateformat(dateadd('m',val(form.periodfrom),getgeneral.lastaccyear),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),getgeneral.lastaccyear),"mmm yy"))#" output = "wddxText">
					</cfif>
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>

		</cfif>
	</cfoutput>
	
		<cfoutput>
        <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
		
    	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Item No.</Data></Cell>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Product Code</Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Description</Data></Cell>
                    <cfif lcase(hcomid) eq "mphcranes_i">
            <Cell ss:StyleID="s27"><Data ss:Type="String">Description 2</Data></Cell>
            </cfif>
                     <cfif lcase(hcomid) eq "hyray_i">
					<Cell ss:StyleID="s27"><Data ss:Type="String">UOM</Data></Cell>
                    </cfif>
                    <cfif getpin2.h42A0 eq 'T'>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Unit Cost</Data></Cell>
					</cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Qty Bf</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">In</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Out</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Balance</Data></Cell>
                    <cfif getpin2.h42A0 eq 'T'>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Stock Value ($)</Data></Cell>
                    <cfelse>
                    <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
					</cfif>				
				</Row>
  		</cfoutput>
        
		<!--- <cfset roundamount = int(getitem.currentrow / 35)>
        <cfset rowdata = getitem.currentrow / 35>
        <cfif rouountndam eq rowdata> --->
        <cfloop query="getitem">
         <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#." output = "wddxText">
          <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
           <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
            <cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText3">
            <cfwddx action = "cfml2wddx" input = "#getitem.despa#" output = "wddxText4">
			<cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText5">
                <Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText1#</Data></Cell>
                       <cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        </cfif>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                        <cfif lcase(hcomid) eq "mphcranes_i">
				<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
				</cfif>
                        <cfif lcase(hcomid) eq "hyray_i">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        </cfif>
				<!---New Moving calculation--->
            
            <cfif getgeneral.cost eq "MOVING">
            	
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getqtybf" datasource="#dts#">
			select LastAccDate,ThisAccDate,avcost2,qtybf FROM icitem_last_year
			where itemno='#getitem.itemno#' and LastAccDate = #thislastaccdate# 
			limit 1
            </cfquery>
            
            <cfelse>
            <cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#getitem.itemno#'
			 limit 1
            </cfquery>
           
            </cfif>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    amt,qty,
            type,refno,itemno,trancode
			from ictran

			where itemno='#getitem.itemno#' 
			and (void = '' or void is null)
			and (linecode = '' or linecode is null)
			and type not in ('QUO','SO','PO','SAM')
			and fperiod='99'
			and wos_date > #getdate.LastAccDate#
			and wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date <= '#ndateto#'
			</cfif>
			order by a.wos_date,b.created_on,b.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			amt,qty,
            type,refno,itemno,trancode
			from ictran
            
			where itemno='#getitem.itemno#' 
			and (void = '' or void is null) 
			and (linecode = '' or linecode is null)
			and type not in ('QUO','SO','PO','SAM')
			and fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date <= '#ndateto#'
			<cfelse>
				and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by wos_date,<!---created_on,--->trdatetime
		</cfquery>
		</cfif>
        
        <cfloop query="getmovingictran">
        <cfif isdefined('form.dodate')>
  		<cfif type eq "INV">
  		<cfquery name="checkexist2" datasource="#dts#">
  		select toinv,refno,type,itemno from ictran a  where refno ='#getmovingictran.refno#' and itemno =			
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmovingictran.itemno#"> and type = "#getmovingictran.type#" and 
        trancode = "#getmovingictran.trancode#" and (dono = "" or dono is null or dono not in (select 
        frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  		</cfquery>
  		</cfif>
  		</cfif>
        <!---exclude CN --->
        <cfif getgeneral.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        </cfif>
        
        <cfif getgeneral.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>
        
        <cfif isdefined('form.dodate')>
                    
        <cfif getmovingictran.type eq "DO">
        <cfset movingbal=movingbal-getmovingictran.qty>
		<cfelseif getmovingictran.type eq "INV" and checkexist2.recordcount eq 0>
        <cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        
        </cfloop>
        
		<cfset movingstockbal=movingbal*movingunitcost>
        
        </cfif>
            <!--- --->
                        
                        <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					<cfif getpin2.h42A0 eq 'T'>
						<Cell ss:StyleID="s33"><Data ss:Type="Number">#getitem.ucost#</Data></Cell>
						</cfif>
                        </cfcase>
                           <cfcase value="MONTH">
                           <cfif getpin2.h42A0 eq 'T'>
                   <Cell ss:StyleID="s33"><Data ss:Type="Number">#getitem.unitcost#</Data></Cell>
						</cfif>
                    </cfcase>
                    <cfcase value="MOVING">
                           <cfif getpin2.h42A0 eq 'T'>
                   <Cell ss:StyleID="s33"><Data ss:Type="Number">#movingunitcost#</Data></Cell>
						</cfif>
                    </cfcase>
                    </cfswitch>
						<Cell ss:StyleID="s33"><Data ss:Type="Number">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</Data></Cell>
                        <Cell ss:StyleID="s40"><Data ss:Type="Number">#getitem.qin#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qout)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.balance)#</Data></Cell>
                        <cfif getpin2.h42A0 eq 'T'>
                        <cfif getgeneral.cost eq "MOVING">
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val(movingstockbal),stDecl_UPrice)#</Data></Cell>
                        <cfelse>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val(getitem.stockbalance),stDecl_UPrice)#</Data></Cell>
                        </cfif>
	<cfelse>
    <Cell ss:StyleID="s33"><Data ss:Type="Number"></Data></Cell>
    </cfif>
					
					</Row>
                    
			<cfif getgeneral.cost eq "MOVING">
            <cfset grandstkval = grandstkval + val(movingstockbal)>
            <cfelse>
			<cfset grandstkval = grandstkval + val(getitem.stockbalance)>
            
            </cfif>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + val(getitem.qin)>
            <cfset grandqtyout = grandqtyout + val(getitem.qout)>
            <cfset grandqty = grandqty + val(getitem.balance)>
  		</cfloop>
		

		<Row ss:AutoFitHeight="0" ss:Height="12">
					<cfif lcase(hcomid) eq "hyray_i">
					<Cell ss:Index="5" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <Cell ss:Index="4" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <Cell ss:Index="3" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    </cfif>
                    </cfif>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtybf)#</Data></Cell>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtyin)#</Data></Cell>
                    <Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtyout)#</Data></Cell>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqty)#</Data></Cell>
                    <cfif getpin2.h42A0 eq 'T'>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(grandstkval,",_.__")#</Data></Cell><cfelse><Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
                    </cfif>
					
				</Row>

<!--- FIFO Costing Method --->
<cfelseif getgeneral.cost eq "FIFO">
	<cfparam name="form.includetr" default="yes">
	<cfset periodfr = val(form.periodfrom) + 10>
	<cfset periodto = val(form.periodto) + 10>
	
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.desp,a.despa,a.unit,a.unit,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.trin,e.trout,f.innow,g.outnow,h.fqty,i.pamt,
			((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)) as bfqty,
			(((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) as balancenow
			from icitem_last_year as a
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="x">
						<cfif x eq 11>
							ifnull(qin#x#,0)
						<cfelse>
							+ifnull(qin#x#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastin,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as b on a.itemno=b.itemno
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="y">
						<cfif y eq 11>
							ifnull(qout#y#,0)
						<cfelse>
							+ifnull(qout#y#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastout,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as trin,itemno 
				from ictran
				where type ='TRIN' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        		and operiod+0 <= '#form.periodto#'
	      		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
	    		</cfif> 
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno 
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as trout,itemno 
				from ictran
				where type ='TROU' and (void = '' or void is null) and (toinv='' or toinv is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and operiod+0 <= '#form.periodto#'
	     		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
	    		</cfif> 
	     		and wos_date > #getdate.LastAccDate#
				
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="z">
					<cfif z eq periodfr>
						ifnull(qin#z#,0)
					<cfelse>
						+ifnull(qin#z#,0)
					</cfif>
				</cfloop>
				as innow,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as f on a.itemno=f.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="a">
					<cfif a eq periodfr>
						ifnull(qout#a#,0)
					<cfelse>
						+ifnull(qout#a#,0)
					</cfif>
				</cfloop>
				as outnow,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as g on a.itemno=g.itemno
	
			left join
			(
				select (<cfloop index="i" from="50" to="11" step="-1">
							<cfset ffq = "ffq"&"#i#">
							<cfoutput>#ffq#</cfoutput><cfif i lte 50 and i gt 11>+</cfif>
					 	</cfloop>) as fqty,itemno 
				from fifoopq_last_year 
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as pamt,aa.itemno 
				from icitem_last_year as aa
				
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
		     		and wos_date <= #getdate.LastAccDate#
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
		     		and wos_date <= #getdate.LastAccDate#
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as i on a.itemno = i.itemno
	
			where a.itemno <> ''
			and a.LastAccDate = #form.thislastaccdate#
			<cfif isdefined("form.include0")>
			<cfelse>
				and (((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	<cfelse>
		<!--- ADD ON 03-04-2009, FOR QIN QOUT RECALCULATE --->
		<cfquery name="getictranin" datasource="#dts#">
			select sum(qty) as qin , itemno, fperiod
			from ictran 
			where type in (#PreserveSingleQuotes(intrantype)#)
			and fperiod<>'99' 
			and (void = '' or void is null) 
			and (linecode <> 'SV' or linecode is null)
            <cfif ndateto neq ''>
            and wos_date<='#ndateto#'
            </cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by itemno, fperiod
		</cfquery>
		<cfquery name="getictranout" datasource="#dts#">
			select sum(qty) as qout , itemno, fperiod
			from ictran as a
			where (void = '' or void is null)
			and fperiod<>'99' 
            <cfif ndateto neq ''>
            and wos_date<='#ndateto#'
            </cfif>
			and (linecode <> 'SV' or linecode is null)
            and
            
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)  and (toinv='' or toinv is null) 
                </cfif>  
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by itemno, fperiod
		</cfquery>
		
		<!--- INITIALIZE THE QIN/QOUT IN ICITEM --->
		<cfquery name="InitializeIcitem" datasource="#dts#">
			update icitem 
			set qin11= 0,
			qin12= 0,
			qin13= 0,
			qin14= 0,
			qin15= 0,
			qin16= 0,
			qin17= 0,
			qin18= 0,
			qin19= 0,
			qin20= 0,
			qin21= 0,
			qin22= 0,
			qin23= 0,
			qin24= 0,
			qin25= 0,
			qin26= 0,
			qin27= 0,
			qin28= 0, 
			qout11 = 0,
			qout12 = 0,
			qout13 = 0,
			qout14 = 0,
			qout15 = 0,
			qout16 = 0,
			qout17 = 0,
			qout18 = 0,
			qout19 = 0,
			qout20 = 0,
			qout21 = 0,
			qout22 = 0,
			qout23 = 0,
			qout24 = 0,
			qout25 = 0,
			qout26 = 0,
			qout27 = 0,
			qout28 = 0
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				where itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
		</cfquery>
		
		<cftry>
			<cfloop query="getictranin">
				
				<cfset qname = 'QIN'&(getictranin.fperiod+10)>
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#= #getictranin.qin# 
					where itemno = '#getictranin.itemno#'
				</cfquery>
			</cfloop>
			<cfcatch type="any">
				<cfoutput>Failed to update QIN. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfloop query="getictranout">
				<cfset qname = 'QOUT'&(getictranout.fperiod+10)>
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#= #getictranout.qout# 
					where itemno = '#getictranout.itemno#'
				</cfquery>
			</cfloop>
			<cfcatch type="any">
				<cfoutput>Failed to update QOUT. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
			</cfcatch>
		</cftry>
		<!--- ADD ON 03-04-2009, FOR QIN QOUT RECALCULATE --->

		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.desp,a.despa,a.unit,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.trin,e.trout,f.innow,g.outnow,h.fqty,i.pamt,
			((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)) as bfqty,
			(((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) as balancenow
			from icitem as a
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="x">
						<cfif x eq 11>
							ifnull(qin#x#,0)
						<cfelse>
							+ifnull(qin#x#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastin,itemno 
				from icitem
			) as b on a.itemno=b.itemno
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="y">
						<cfif y eq 11>
							ifnull(qout#y#,0)
						<cfelse>
							+ifnull(qout#y#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastout,itemno 
				from icitem
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as trin,itemno 
				from ictran
				where type ='TRIN' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and fperiod+0 <= '#form.periodto#'
	      		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno 

			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as trout,itemno 
				from ictran
				where type ='TROU' and (void = '' or void is null) and (toinv='' or toinv is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and fperiod+0 <= '#form.periodto#'
	     		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="z">
					<cfif z eq periodfr>
						ifnull(qin#z#,0)
					<cfelse>
						+ifnull(qin#z#,0)
					</cfif>
				</cfloop>
				as innow,itemno 
				from icitem
			) as f on a.itemno=f.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="a">
					<cfif a eq periodfr>
						ifnull(qout#a#,0)
					<cfelse>
						+ifnull(qout#a#,0)
					</cfif>
				</cfloop>
				as outnow,itemno 
				from icitem
			) as g on a.itemno=g.itemno
	
			left join
			(
				select (<cfloop index="i" from="50" to="11" step="-1">
							<cfset ffq = "ffq"&"#i#">
							<cfoutput>#ffq#</cfoutput><cfif i lte 50 and i gt 11>+</cfif>
					 	</cfloop>) as fqty,itemno 
				from fifoopq 
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as pamt,aa.itemno 
				from icitem as aa
				
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
				and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as i on a.itemno = i.itemno
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
			<cfelse>
			and (((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	</cfif>
	<cfoutput>
    
		<cfif form.brandfrom neq "" and form.brandto neq "">
            <cfwddx action = "cfml2wddx" input = "Brand: #form.brandfrom# - #form.brandto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
             <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY#: #form.catefrom# - #form.cateto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
            <cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP#: #form.groupfrom# - #form.groupto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
             <cfwddx action = "cfml2wddx" input = "Item: #form.productfrom# - #form.productto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
        <cfif lcase(hcomid) eq "hyray_i">
        <cfquery name="getsuppliername" datasource="#dts#">
        select name from #target_apvend# where custno='#form.suppfrom#'
        </cfquery>
        <cfquery name="getsuppliername1" datasource="#dts#">
        select name from #target_apvend# where custno='#form.suppto#'
        </cfquery>
        </cfif>
       
            <cfwddx action = "cfml2wddx" input = "Supplier: #form.suppfrom# - #form.suppto#" output = "wddxText">

						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
            <cfwddx action = "cfml2wddx" input = "Period: #form.periodfrom# - #form.periodto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
			
					<!--- #form.monthfrom# - #form.monthto# --->
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						<cfwddx action = "cfml2wddx" input = "#ucase(dateformat(dateadd('m',val(form.periodfrom),form.thislastaccdate),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),form.thislastaccdate),"mmm yy"))#" output = "wddxText">
					<cfelse>
					<cfwddx action = "cfml2wddx" input = "#ucase(dateformat(dateadd('m',val(form.periodfrom),getgeneral.lastaccyear),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),getgeneral.lastaccyear),"mmm yy"))#" output = "wddxText">
					</cfif>
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>

		</cfif>
	</cfoutput>
    
	<cfoutput>
        <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
		
    	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Item No.</Data></Cell>
                    <!---<cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Product Code</Data></Cell>
                    </cfif>--->
                    <cfif getmodule.auto eq '1'>
               		<Cell ss:StyleID="s27"><Data ss:Type="String">Supplier</Data></Cell>
            		</cfif>
                    
					<Cell ss:StyleID="s27"><Data ss:Type="String">Description</Data></Cell>
                    <cfif lcase(hcomid) eq "mphcranes_i">
            <Cell ss:StyleID="s27"><Data ss:Type="String">Description 2</Data></Cell>
            </cfif>
                     <cfif lcase(hcomid) eq "hyray_i">
					<Cell ss:StyleID="s27"><Data ss:Type="String">UOM</Data></Cell>
                    </cfif>
                    
					<Cell ss:StyleID="s27"><Data ss:Type="String">Qty Bf</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">In</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Out</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Balance</Data></Cell>
                    <cfif getpin2.h42A0 eq 'T'>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Last Cost</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Stock Value ($)</Data></Cell>
                    <cfelse>
                    <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
                    </cfif>
					
				</Row>
                </cfoutput>
	
		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			 <cfset fifotable="fifoopq_last_year">
		<cfelse>	
			<cfset fifotable="fifoopq">
		</cfif>
		
		<cfloop query="getitem">
      		<cfset balqty =  val(getitem.qtybf) + val(getitem.lastin) - val(getitem.lastout) + val(getitem.innow) - val(getitem.outnow)>
	  		<!--- <cfset balnowqty = val(getitem.qtybf) + val(getitem.innow) - val(getitem.outnow)> --->
      		<cfset lastcost = 0>
	  		<cfset fifoqty = 0>
      		<cfset ttnewffstkval =0>
      		<!--- <cfset qqout = val(getitem.qout)> --->
			<cfset qqout = val(getitem.lastout) + val(getitem.outnow) - val(getitem.trout)>

	 		<cfif val(getitem.fqty) neq 0>
	  			<cfset lastcost = 0>

				<cfloop index="i" from="50" to="11" step="-1">
          			<cfset ffq = "ffq"&"#i#">
          			<cfset ffc = "ffc"&"#i#">

		  			<cfquery name="getfifoopq" datasource="#dts#">
          				select #ffq# as xffq, #ffc# as xffc from #fifotable# where itemno = '#getitem.itemno#'
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
          			</cfquery>

		  			<cfif getfifoopq.xffq gt 0>
            			<cfset lastcost = getfifoopq.xffc>
          			</cfif>

		  			<cfset fifoqty = fifoqty + val(getfifoopq.xffq)>
          			<cfset newffstkval = val(getfifoopq.xffq) * val(getfifoopq.xffc)>
          			<cfset ttnewffstkval = ttnewffstkval + newffstkval>

		  			<cfif fifoqty gte val(qqout)>
            			<!--- <cfset minusfifoqty = fifoqty - val(getitem.qout)> --->
						<cfset minusfifoqty = fifoqty - val(qqout)>

						<cfif minusfifoqty gt 0>
              				<cfset stkvalff = minusfifoqty * val(getfifoopq.xffc)>
              			<cfelse>
              				<cfset stkvalff = 0>
            			</cfif>

						<cfset fifocnt = i - 1>
            			<cfbreak>
          			</cfif>
        		</cfloop>
				
				<!--- REMARK ON 17-12-2008 --->
				<!--- <cfset totalout = val(getitem.qout) + val(getitem.lastout)> --->
				<!--- <cfset totalout = val(getitem.qout)> --->
				<!--- REMARK ON 05-11-2009 --->
				<!--- <cfset totalout = val(getitem.lastout) + val(getitem.outnow)> --->
				<cfset totalout = val(getitem.lastout) + val(getitem.outnow) - val(getitem.trout)>
				
        		<cfif fifoqty gte totalout >
          			<cfset ttnewffstkval = 0>

					<cfloop index="i" from="#fifocnt#" to="11" step="-1">
            			<cfset ffq = "ffq"&"#i#">
            			<cfset ffc = "ffc"&"#i#">

						<cfquery name="getfifoopq2" datasource="#dts#">
            				select #ffq# as xffq, #ffc# as xffc from #fifotable# where itemno = '#getitem.itemno#'
							<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
								and LastAccDate = #form.thislastaccdate#
							</cfif>
            			</cfquery>

						<cfif getfifoopq2.xffq gt 0>
              				<cfset lastcost = val(getfifoopq2.xffc)>
            			</cfif>

						<cfset newffstkval = val(getfifoopq2.xffq) * val(getfifoopq2.xffc)>
            			<cfset ttnewffstkval = ttnewffstkval + newffstkval>
          			</cfloop>

		  			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  			<cfquery name="getallrc" datasource="#dts#">
							select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem_last_year as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(amt/qty) as price1,sum(amt_bil/qty_bil)as price_bil1 
								from ictran 
								where itemno='#getitem.itemno#' and type in ('RC','OAI') and (void = '' or void is null)
					     		and wos_date > #getdate.LastAccDate#
								and wos_date <= #getdate.ThisAccDate# 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and operiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitem.itemno#' and type='CN' and (void = '' or void is null) 
					     		and wos_date > #getdate.LastAccDate#
								and wos_date <= #getdate.ThisAccDate# 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and operiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitem.itemno#'
							and LastAccDate = #form.thislastaccdate#
	          			</cfquery>

						<cfquery name="getrc" datasource="#dts#">
							select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
							and wos_date = (select max(wos_date) 
											from ictran 
											where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
											and wos_date > #getdate.LastAccDate#
											and wos_date <= #getdate.ThisAccDate# 
											)
							and wos_date > #getdate.LastAccDate#
							and wos_date <= #getdate.ThisAccDate# 
							<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and operiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
						</cfquery>	
					<cfelse>
			  			<cfquery name="getallrc" datasource="#dts#">
							select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(amt/qty) as price1,sum(amt_bil/qty_bil)as price_bil1 
								from ictran 
								where itemno='#getitem.itemno#' and type in ('RC','OAI') and (void = '' or void is null)
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitem.itemno#' and type='CN' and (void = '' or void is null) 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitem.itemno#';
	          			</cfquery>

						<cfquery name="getrc" datasource="#dts#">
							select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
							and wos_date = (select max(wos_date) from ictran where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null))
							<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and fperiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
						</cfquery>	
					</cfif>

					<!--- <cfquery name="getrc" datasource="#dts#">
          				select qty, amt, amt_bil, price, price_bil from ictran where itemno = '#getitem.itemno#' and type = 'RC' and (void = '' or void is null)
          				<cfif form.periodfrom neq "" and form.periodto neq "">
             			and fperiod <= '#form.periodto#'
          				</cfif>
          				order by trdatetime
          			</cfquery> --->

		  			<cfif getrc.recordcount gt 0>
              			<cfset lastcost = getrc.price>
          			</cfif>

		  			<cfset totalstkval = stkvalff + ttnewffstkval + val(getallrc.sumamt)>
		  			
          		<cfelse>
          			<cfset totalrcqty = fifoqty>
          			<cfset stkval = 0>

		  			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  			<cfquery name="getrc" datasource="#dts#">
	          				select qty,
							if(type='CN',it_cos,amt)as amt,
							if(type='CN',(it_cos/currrate),
							amt_bil) as amt_bil,
							if(type='CN',(it_cos/qty),
							(amt/qty)) as price,
							if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
							and wos_date > #getdate.LastAccDate#
							and wos_date <= #getdate.ThisAccDate#
	          				<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and operiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
	          			</cfquery>
					<cfelse>	
			  			<cfquery name="getrc" datasource="#dts#">
	          				select qty,
							if(type='CN',it_cos,amt)as amt,
							if(type='CN',(it_cos/currrate),
							amt_bil) as amt_bil,
							if(type='CN',(it_cos/qty),
							(amt/qty)) as price,
							if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
	          				<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and fperiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
	          			</cfquery>
					</cfif>

		  			<cfset cnt = 0>

		  			<cfloop query="getrc">
            			<cfset cnt = cnt + 1>

						<cfif getrc.qty neq "">
              				<cfset rcqty = getrc.qty>
              			<cfelse>
              				<cfset rcqty = 0>
            			</cfif>

						<cfset lastcost = getrc.price>
            			<cfset totalrcqty = totalrcqty + rcqty>

						<cfif totalrcqty gte qqout>
              				<cfset minusqty = totalrcqty - qqout>

							<cfif minusqty gt 0>
                				<cfset stkval = minusqty * getrc.price>
                			<cfelse>
                				<cfset stkval = 0>
              				</cfif>

							<cfbreak>
            			</cfif>
          			</cfloop>

          			<cfif getrc.recordcount gt cnt>
            			<cfset cnt = cnt + 1>
            			<!--- next record --->
            			<cfset newstkval = 0>

						<cfloop query="getrc" startrow="#cnt#">
              				<cfset lastcost = getrc.price>
              				<cfset newstkval = newstkval + getrc.amt>
            			</cfloop>
            		<cfelse>
            			<cfset newstkval = 0>
          			</cfif>

					<cfset totalstkval = stkval + newstkval>
        		</cfif>
        	<cfelse><!--- if qtybf eq 0 --->
        		<cfset totalrcqty = 0>
        		<cfset stkval = 0>

				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="getrc" datasource="#dts#">
	        			select qty,
						if(type='CN',it_cos,amt)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						(amt/qty)) as price,
						if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
						from ictran 
						where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#
	          			<cfif form.periodfrom neq "" and form.periodto neq "">
	             			and operiod+0 <= '#form.periodto#'
	          			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date <= '#ndateto#' 
						</cfif> 
	          			order by wos_date,trdatetime;
	        		</cfquery>
				<cfelse>
					<cfquery name="getrc" datasource="#dts#">
	        			select qty,
						if(type='CN',it_cos,amt)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						(amt/qty)) as price,
						if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
						from ictran 
						where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
	          			<cfif form.periodfrom neq "" and form.periodto neq "">
	             		and fperiod+0 <= '#form.periodto#'
	          			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date <= '#ndateto#' 
						</cfif> 
	          			order by wos_date,trdatetime;
	        		</cfquery>
				</cfif>

				<cfset cnt = 0>

				<cfloop query="getrc">
          			<cfset cnt = cnt + 1>

					<cfset rcqty = val(getrc.qty)>

					<cfset lastcost = getrc.price>
          			<cfset totalrcqty = totalrcqty + rcqty>

					<cfif totalrcqty gte qqout>
            			<cfset minusqty = totalrcqty - qqout>

						<cfif minusqty neq 0>
              				<cfset stkval = minusqty * getrc.price>
              			<cfelse>
              				<cfset stkval = 0>
            			</cfif>
            			<cfbreak>
          			</cfif>
        		</cfloop>
				
				<cfif getrc.recordcount gt cnt>
          			<cfset cnt = cnt + 1>
          			<!--- next record --->
          			<cfset newstkval = 0>

					<cfloop query="getrc" startrow="#cnt#">
            			<cfset lastcost = getrc.price>
            			<cfset newstkval = newstkval + getrc.amt>
         	 		</cfloop>
          		<cfelse>
          			<cfset newstkval = 0>
        		</cfif>

				<cfset totalstkval = stkval + newstkval>
				
      		</cfif>
		
		<cfoutput>
        
		<cfif isdefined('form.fifocost')>
        <cfset divby = getitem.balancenow>
        <cfif getitem.balancenow eq "-">
        <cfset divby = 1>
		</cfif>
        <cfif getitem.balancenow eq 0 or getitem.balancenow eq "">
        <cfset divby = 1>
        </cfif>
		<cfset lastcost = val(totalstkval) / divby >
		</cfif>
        
 <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#." output = "wddxText">
          <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
           <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
            <cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText3">
             <cfwddx action = "cfml2wddx" input = "#getitem.despa#" output = "wddxText4">
             <!---<cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText5">--->
            
				
                <Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText1#</Data></Cell>
                        <!---<cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        </cfif>--->
                        <cfif getmodule.auto eq '1'>
                         <cfquery name="getsuppliercode" datasource="#dts#">
                select custno,name from ictran where itemno='#getitem.itemno#' and type in ('RC','PO') and (void is null or void ='') and fperiod!=99
                		</cfquery>
                        <cfwddx action = "cfml2wddx" input = "#getsuppliercode.custno# - #getsuppliercode.name#" output = "wddxText6">
               		<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
            		</cfif>
                        
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                        <cfif lcase(hcomid) eq "mphcranes_i">
				<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
				</cfif>
                        <cfif lcase(hcomid) eq "hyray_i">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        </cfif>

						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</Data></Cell>
                        <Cell ss:StyleID="s40"><Data ss:Type="Number">#innow#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#outnow#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#balancenow#</Data></Cell>
                        <cfif getpin2.h42A0 eq 'T'>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(lastcost,stDecl_UPrice)#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(totalstkval,stDecl_UPrice)#</Data></Cell>
<cfelse>
<Cell ss:StyleID="s33"><Data ss:Type="Number"></Data></Cell>
</cfif>
	
					
					</Row>

			<cfset grandstkval = grandstkval + val(totalstkval)>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + innow>
            <cfset grandqtyout = grandqtyout + outnow>
            <cfset grandqty = grandqty + balancenow>
  		</cfoutput>
			
    </cfloop>
	
    <!--- <tr>
		<td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
    </tr> --->
    <Row ss:AutoFitHeight="0" ss:Height="12">
					<cfif lcase(hcomid) eq "hyray_i">
					<Cell ss:Index="5" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <cfif <!---getdisplaydetail.report_aitemno eq 'Y' or --->getmodule.auto eq '1'>
                    <Cell ss:Index="4" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <Cell ss:Index="3" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    </cfif>
                    </cfif>
                    
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtybf)#</Data></Cell>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtyin)#</Data></Cell>
                    <Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtyout)#</Data></Cell>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqty)#</Data></Cell>
                    <cfif getpin2.h42A0 eq 'T'>
                    <Cell ss:StyleID="s39"><Data ss:Type="String"></Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(grandstkval,",_.__")#</Data></Cell><cfelse><Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
                    </cfif>
					
				</Row>

<!-- LIFO Costing Method -->
<cfelseif getgeneral.cost eq "LIFO">
	<cfset stkvalff=0>
	<cfquery name="getitem" datasource="#dts#">
		select itemno,aitemno,desp,despa,unit,qtybf 
		from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">icitem_last_year<cfelse>icitem</cfif> 
		where itemno <> ''
		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			and LastAccDate = #form.thislastaccdate#
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and category between '#form.catefrom#' and '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and wos_group betwwen '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		order by itemno;
	</cfquery>
	<cfoutput>
    
		<cfif form.brandfrom neq "" and form.brandto neq "">
            <cfwddx action = "cfml2wddx" input = "Brand: #form.brandfrom# - #form.brandto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
             <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY#: #form.catefrom# - #form.cateto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
            <cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP#: #form.groupfrom# - #form.groupto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
             <cfwddx action = "cfml2wddx" input = "Item: #form.productfrom# - #form.productto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
        <cfif lcase(hcomid) eq "hyray_i">
        <cfquery name="getsuppliername" datasource="#dts#">
        select name from #target_apvend# where custno='#form.suppfrom#'
        </cfquery>
        <cfquery name="getsuppliername1" datasource="#dts#">
        select name from #target_apvend# where custno='#form.suppto#'
        </cfquery>
        </cfif>

            <cfwddx action = "cfml2wddx" input = "Supplier: #form.suppfrom# - #form.suppto#" output = "wddxText">

						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
            <cfwddx action = "cfml2wddx" input = "Period: #form.periodfrom# - #form.periodto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
			
					<!--- #form.monthfrom# - #form.monthto# --->
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						<cfwddx action = "cfml2wddx" input = "#ucase(dateformat(dateadd('m',val(form.periodfrom),form.thislastaccdate),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),form.thislastaccdate),"mmm yy"))#" output = "wddxText">
					<cfelse>
					<cfwddx action = "cfml2wddx" input = "#ucase(dateformat(dateadd('m',val(form.periodfrom),getgeneral.lastaccyear),"mmm yy"))# - #ucase(dateformat(dateadd('m',val(form.periodto),getgeneral.lastaccyear),"mmm yy"))#" output = "wddxText">
					</cfif>
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>

		</cfif>
	</cfoutput>
	
	<cfoutput>
        <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
    	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Item No.</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Description</Data></Cell>
                    <cfif lcase(hcomid) eq "mphcranes_i">
            <Cell ss:StyleID="s27"><Data ss:Type="String">Description 2</Data></Cell>
            </cfif>
                     <cfif lcase(hcomid) eq "hyray_i">
					<Cell ss:StyleID="s27"><Data ss:Type="String">UOM</Data></Cell>
                    </cfif>
                    <cfif getpin2.h42A0 eq 'T'>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Unit Cost</Data></Cell>
					</cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Qty Bf</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">In</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Out</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Balance</Data></Cell>
                    <cfif getpin2.h42A0 eq 'T'>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Stock Value ($)</Data></Cell>
                    <cfelse>
                    <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
                    </cfif>
					
				</Row>
                </cfoutput>
		
    	<cfloop query="getitem">
      		<cfset lastbal= 0>
      		<cfset lastin=0>
      		<cfset lastout=0>
      		<cfset lastdo=0>
      		
			<cfif form.periodfrom neq '01'>
        		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetin" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(intrantype)#) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate# 
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and operiod+0 < '#form.periodfrom#'
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				<cfelse>
					<cfquery name="lastgetin" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(intrantype)#) and itemno='#itemno#' and (void = '' or void is null)
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and fperiod+0 < '#form.periodfrom#'
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				</cfif>
        		
				<cfif lastgetin.sumqty neq "">
          			<cfset lastin = lastgetin.sumqty>
        		</cfif>
        		
				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetout" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#  
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and operiod+0 < '#form.periodfrom#' 
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				<cfelse>
					<cfquery name="lastgetout" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and itemno='#itemno#' and (void = '' or void is null) 
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and fperiod+0 < '#form.periodfrom#' 
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				</cfif>
        		
				<cfif lastgetout.sumqty neq "">
				  	<cfset lastout = lastgetout.sumqty>
				</cfif>
				
				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetdo" datasource="#dts#">
						select sum(qty)as sumqty 
						from ictran 
						where type='DO' and (toinv='' or toinv is null) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#  
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and operiod+0 < '#form.periodfrom#'
						</cfif> 
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
						group by itemno
					</cfquery>
				<cfelse>
					<cfquery name="lastgetdo" datasource="#dts#">
						select sum(qty)as sumqty 
						from ictran 
						where type='DO' and (toinv='' or toinv is null) and itemno='#itemno#' and (void = '' or void is null)
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and fperiod+0 < '#form.periodfrom#'
						</cfif> 
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
						group by itemno
					</cfquery>
				</cfif>
				
				<cfif lastgetdo.sumqty neq "">
				  	<cfset lastdo = lastgetdo.sumqty>
				</cfif>
				
				<cfset lastbal = lastin - lastdo - lastout>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="check" datasource="#dts#">
				  	select itemno 
					from fifoopq_last_year 
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
					and LastAccDate = #form.thislastaccdate#
				</cfquery>
			<cfelse>
				<cfquery name="check" datasource="#dts#">
				  	select itemno 
					from fifoopq 
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
				</cfquery>
			</cfif>
			
			<cfset lastcost = 0>
			
			<cfif getitem.qtybf neq "">
				<cfset bfqty = getitem.qtybf + lastbal>
			<cfelse>
				<cfset bfqty = lastbal>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getin" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 
				</cfquery>
			<cfelse>
				<cfquery name="getin" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 
				</cfquery>
			</cfif>
			
			<cfif getin.qty neq "">
				<cfset inqty = getin.qty>
			<cfelse>
				<cfset inqty = 0>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getinnow" datasource="#dts#">
					select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) 
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 >= '#form.periodfrom#' and operiod <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
				</cfquery>
			<cfelse>
				<cfquery name="getinnow" datasource="#dts#">
					select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) 
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
				</cfquery>
			</cfif>
			
			<cfif getinnow.qty neq "">
				<cfset innowqty = getinnow.qty>
			<cfelse>
				<cfset innowqty = 0>
			</cfif>
      
	  		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
		  		<cfquery name="getdo" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 

			  	</cfquery>	
			<cfelse>
		  		<cfquery name="getdo" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 

			  	</cfquery>	
			</cfif>
	  
		  	<cfif getdo.qty neq "">
				<cfset doqty = getdo.qty>
			<cfelse>
				<cfset doqty = 0>
		  	</cfif>
			
		  	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  	<cfquery name="getdonow" datasource="#dts#">
			  		select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif>
					group by itemno
			  	</cfquery>	
			<cfelse>
			  	<cfquery name="getdonow" datasource="#dts#">
			  		select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif>
					group by itemno
			  	</cfquery>	
			</cfif>
			
			<cfif getdonow.qty neq "">
        		<cfset donowqty = getdonow.qty>
        	<cfelse>
        		<cfset donowqty = 0>
      		</cfif>
      	
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getout" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(outtrantypewodo)#) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      		</cfquery>
			<cfelse>
				<cfquery name="getout" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(outtrantypewodo)#) and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      		</cfquery>
			</cfif>
      
		  	<cfif getout.qty neq "">
				<cfset outqty = getout.qty>
			<cfelse>
				<cfset outqty = 0>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getoutnow" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewodo)#)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#   
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 between '#form.periodfrom#' and '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
					group by itemno
			  	</cfquery>
			<cfelse>
				<cfquery name="getoutnow" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewodo)#) 
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
					group by itemno
			  	</cfquery>
			</cfif>
			
			<cfif getoutnow.qty neq "">
        		<cfset outnowqty = getoutnow.qty>
        	<cfelse>
        		<cfset outnowqty = 0>
      		</cfif>
      		
			<cfset ttoutnowqty = outnowqty + donowqty>
		  	<cfset ttoutqty = outqty + doqty>
		  	<cfset balqty =  bfqty + inqty - ttoutqty>
		  	<cfset balnowqty =  bfqty + innowqty - ttoutnowqty>
		  	<cfset fifoqty = 0>
		  	<cfset ttnewffstkval =0>
      		
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#   
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      			order by trdatetime desc
	      		</cfquery>
			<cfelse>
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      			order by trdatetime desc
	      		</cfquery>
			</cfif>
			
			<cfif getrc.recordcount gt 0 and check.recordcount gt 0>
        		<cfset totalrcqty = 0>
        		<cfset cnt = 0>
        		
				<cfloop query="getrc">
          			<cfset cnt = cnt + 1>
          			
					<cfif getrc.qty neq "">
            			<cfset rcqty = getrc.qty>
            		<cfelse>
            			<cfset rcqty = 0>
          			</cfif>
          			
					<cfset lastcost = getrc.price>
          			<cfset totalrcqty = totalrcqty + rcqty>
          			
					<cfif totalrcqty gte ttoutqty>
            			<cfset minusqty = totalrcqty - ttoutqty>
            			
						<cfif minusqty gt 0>
              				<cfset stkval = minusqty * lastcost>
              			<cfelse>
              				<cfset stkval = 0>
            		</cfif>
            		<cfbreak>
          		</cfif>
        	</cfloop>
        	
			<cfif totalrcqty gte ttoutqty>
          		<cfset cnt = cnt + 1>
          		<!--- next record --->
          		<cfset newstkval = 0>
          		
				<cfoutput query="getrc" startrow="#cnt#">
            		<cfset lastcost = getrc.price>
            		<cfset newstkval = newstkval + getrc.amt>
          		</cfoutput>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif> 
						where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
            		
					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
          		</cfloop>
          		
				<cfset totalstkval = stkval + newstkval + ttnewffstkval>
          	<cfelse>
          		<!--- rc less than out --->
          		<cfset ttnewffstkval = 0>
          		<cfset fifoqty = totalrcqty>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>  
						where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
					
					<cfset fifoqty = fifoqty + getfifoopq.xffq>
            		<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		
					<cfif fifoqty gte ttoutqty>
              			<cfset minusfifoqty = fifoqty - ttoutqty>
              			
						<cfif minusfifoqty gt 0>
                			<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
                		<cfelse>
                			<cfset stkvalff = 0>
              			</cfif>
              			
						<cfset fifocnt = i + 1>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif fifoqty gte ttoutqty>
            		<cfset ttnewffstkval = 0>
            		
					<cfloop index="i" from="#fifocnt#" to="50">
              			<cfset ffq = "ffq"&"#i#">
              			<cfset ffc = "ffc"&"#i#">
              			
						<cfquery name="getfifoopq2" datasource="#dts#">
              				select #ffq# as xffq, #ffc# as xffc 
							from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>  
							where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
							<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
								and LastAccDate = #form.thislastaccdate#
							</cfif>
              			</cfquery>
              			
						<cfif getfifoopq2.xffq gt 0>
                			<cfset lastcost = getfifoopq2.xffc>
              			</cfif>
              				
						<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
              			<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		</cfloop>
          		</cfif>
          		
				<cfset totalstkval = stkvalff + ttnewffstkval>
        	</cfif>
    
        <cfelseif getrc.recordcount eq 0 and check.recordcount gt 0>
        	<cfset ttnewffstkval = 0>
        	<cfset lastcost = 0>
        		
			<cfloop index="i" from="11" to="50">
          		<cfset ffq = "ffq"&"#i#">
          		<cfset ffc = "ffc"&"#i#">
          		
				<cfquery name="getfifoopq2" datasource="#dts#">
          			select #ffq# as xffq, #ffc# as xffc 
					from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>   
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						and LastAccDate = #form.thislastaccdate#
					</cfif>
          		</cfquery>
				
          		<cfif getfifoopq2.xffq gt 0>
            		<cfset lastcost = getfifoopq2.xffc>
          		</cfif>
          		
				<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
          		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
        	</cfloop>
        	
			<cfset totalstkval = ttnewffstkval>
        <cfelse>
        	<cfset totalrcqty = 0>
        	<cfset cnt = 0>
        	<cfset stkval = 0>
        	<cfset newstkval = 0>
        	
			<cfif getrc.recordcount gt 0>
          		<cfloop query="getrc">
            		<cfset cnt = cnt + 1>
            		
					<cfif getrc.qty neq "">
              			<cfset rcqty = getrc.qty>
              		<cfelse>
              			<cfset rcqty = 0>
            		</cfif>
            		
					<cfset lastcost = getrc.price>
            		<cfset totalrcqty = totalrcqty + rcqty>
            		
					<cfif totalrcqty gte ttoutqty>
              			<cfset minusqty = totalrcqty - ttoutqty>
              			
						<cfif minusqty gt 0>
                			<cfset stkval = minusqty * getrc.price>
                		<cfelse>
                			<cfset stkval = 0>
              			</cfif>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif getrc.recordcount gt cnt>
            		<cfset cnt = cnt + 1>
            		<!--- next record --->
            		<cfset newstkval = 0>
            		
					<cfoutput query="getrc" startrow="#cnt#">
              			<cfset lastcost = getrc.price>
              			<cfset newstkval = newstkval + getrc.amt>
            		</cfoutput>
            	<cfelse>
            		<cfset newstkval = 0>
          		</cfif>
        	</cfif>
        	
			<cfset totalstkval = stkval + newstkval>
      	</cfif>
      	<cfoutput>
         <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#." output = "wddxText">
          <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
           <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
            <cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText3">
            <cfwddx action = "cfml2wddx" input = "#getitem.despa#" output = "wddxText4">
          <!---  <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText5">--->
            
				
                <Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText1#</Data></Cell>
                       <!--- <cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        </cfif>--->
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                        <cfif lcase(hcomid) eq "mphcranes_i">
				<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
				</cfif>
                        <cfif lcase(hcomid) eq "hyray_i">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        </cfif>
				<!---New Moving calculation--->
            
            <cfif getgeneral.cost eq "MOVING">
            	
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getqtybf" datasource="#dts#">
			select LastAccDate,ThisAccDate,avcost2,qtybf FROM icitem_last_year
			where itemno='#getitem.itemno#' and LastAccDate = #thislastaccdate# 
			limit 1
            </cfquery>
            
            <cfelse>
            <cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#getitem.itemno#'
			 limit 1
            </cfquery>
           
            </cfif>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    amt,qty,
            type,refno,itemno,trancode
			from ictran

			where itemno='#getitem.itemno#' 
			and (void = '' or void is null)
			and (linecode = '' or linecode is null)
			and type not in ('QUO','SO','PO','SAM')
			and fperiod='99'
			and wos_date > #getdate.LastAccDate#
			and wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date <= '#ndateto#'
			</cfif>
			order by a.wos_date,b.created_on,b.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			amt,qty,
            type,refno,itemno,trancode
			from ictran
            
			where itemno='#getitem.itemno#' 
			and (void = '' or void is null) 
			and (linecode = '' or linecode is null)
			and type not in ('QUO','SO','PO','SAM')
			and fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date <= '#ndateto#'
			<cfelse>
				and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date,b.created_on,b.trdatetime
		</cfquery>
		</cfif>
        
        <cfloop query="getmovingictran">
        <cfif isdefined('form.dodate')>
  		<cfif type eq "INV">
  		<cfquery name="checkexist2" datasource="#dts#">
  		select toinv,refno,type,itemno from ictran a  where refno ='#getmovingictran.refno#' and itemno =			
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmovingictran.itemno#"> and type = "#getmovingictran.type#" and 
        trancode = "#getmovingictran.trancode#" and (dono = "" or dono is null or dono not in (select 
        frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  		</cfquery>
  		</cfif>
  		</cfif>
        <!---exclude CN --->
        <cfif getgeneral.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        </cfif>
        
        <cfif getgeneral.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>
        
        <cfif isdefined('form.dodate')>
                    
        <cfif getmovingictran.type eq "DO">
        <cfset movingbal=movingbal-getmovingictran.qty>
		<cfelseif getmovingictran.type eq "INV" and checkexist2.recordcount eq 0>
        <cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        
        </cfloop>
        
		<cfset movingstockbal=movingbal*movingunitcost>
        
        </cfif>
            <!--- --->
                        
                        
						  <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					<cfif getpin2.h42A0 eq 'T'>
						<Cell ss:StyleID="s33"><Data ss:Type="Number">#getitem.ucost#</Data></Cell>
                    
					</cfif>
                        </cfcase>
                           <cfcase value="MONTH">
                           <cfif getpin2.h42A0 eq 'T'>
                   <Cell ss:StyleID="s33"><Data ss:Type="Number">#getitem.unitcost#</Data></Cell>
                 
                   </cfif>
                    </cfcase>
                    
                    <cfcase value="MOVING">
                           <cfif getpin2.h42A0 eq 'T'>
                   <Cell ss:StyleID="s33"><Data ss:Type="Number">#movingunitcost#</Data></Cell>
                 
                   </cfif>
                    </cfcase>
                    </cfswitch>	
					
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</Data></Cell>
                        <Cell ss:StyleID="s40"><Data ss:Type="Number">#getitem.qin#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qout)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.balance)#</Data></Cell>
                             
                        
                        <cfif getpin2.h42A0 eq 'T'>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number"><cfif getgeneral.cost eq "MOVING">#numberformat(val(movingstockbal),stDecl_UPrice)#<cfelse>#numberformat(val(getitem.stockbalance),stDecl_UPrice)#</cfif></Data></Cell>
<cfelse>
<Cell ss:StyleID="s33"><Data ss:Type="Number"></Data></Cell>
</cfif>

					
					</Row>
			<cfif getgeneral.cost eq "MOVING">
            <cfset grandstkval = grandstkval + val(movingstockbal)>
            <cfelse>
			<cfset grandstkval = grandstkval + val(stockbalance)>
            </cfif>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + val(getitem.qin)>
            <cfset grandqtyout = grandqtyout + val(getitem.qout)>
            <cfset grandqty = grandqty + val(getitem.balance)>
  		</cfoutput>
    </cfloop>
	
		
		
<Row ss:AutoFitHeight="0" ss:Height="12">
					<cfif lcase(hcomid) eq "hyray_i">
					<Cell ss:Index="5" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <Cell ss:Index="4" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <Cell ss:Index="3" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    </cfif>
                    </cfif>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtybf)#</Data></Cell>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtyin)#</Data></Cell>
                    <Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqtyout)#</Data></Cell>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(grandqty)#</Data></Cell>
                    <cfif getpin2.h42A0 eq 'T'>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(grandstkval,",_.__")#</Data></Cell>
					<cfelse>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
					</cfif>
					
				</Row>
</cfif>
<Row ss:AutoFitHeight="0" ss:Height="12"/>
			</Table></cfoutput>
		 	
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
</cfcase>

<!---PDF--->
<cfcase value="PDF">

<cfquery name="truncatecolumn" datasource="#dts#">
        		truncate itemstatustemp
        		</cfquery> 

<cfparam name="i" default="1" type="numeric">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">
<cfparam name="OAIqty" default="0">
<cfparam name="OARqty" default="0">
<cfparam name="TRINqty" default="0">
<cfparam name="TROUqty" default="0">
<cfparam name="CTqty" default="0">
<cfparam name="xucost" default="0.0000000">
<cfparam name="balonhand" default="0">
<cfparam name="lastbalonhand" default="0">
<cfparam name="grandstkval" default="0">
<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandqty" default="0">

<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU','CT'">
    <cfset outtrantypewithinv1="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU'">
    <cfset outtrantypewithinv1="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(form.dateto, "DD")>

	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,fifocal
,costingcn,costingoai	from gsetup;
</cfquery>

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
</cfif>

<cfswitch expression="#getgeneral.cost#">
	<cfcase value="FIXED">
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfcase value="MONTH">
		<cfset costingmethod = "Month Average Method">
	</cfcase>
	<cfcase value="MOVING">
		<cfset costingmethod = "Moving Average Method">
	</cfcase>
	<cfcase value="FIFO">
		<cfset costingmethod = "First In First Out Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Last In First Out Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	select * 
	from gsetup2;
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ",.">
</cfif>


<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfloop index="LoopCount" from="1" to="#iDecl_TPrice#">
  	<cfset stDecl_TPrice = stDecl_TPrice & "_">
</cfloop>

<cfif getgeneral.cost neq "FIFO" and getgeneral.cost neq "LIFO">
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">	
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem_last_year as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
				</cfif>
                 <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse> 
                    and wos_date <= #getdate.ThisAccDate# 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                 <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
                    </cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                     and wos_date <= #getdate.ThisAccDate# 
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
                </cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem_last_year as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99'
				and (linecode <> 'SV' or linecode is null)
		     		and wos_date <= #getdate.LastAccDate# 
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null)
					and (linecode <> 'SV' or linecode is null)
		     		and wos_date <= #getdate.LastAccDate#
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					group by itemno
				) as cc on aa.itemno=cc.itemno
				
				where aa.LastAccDate = #form.thislastaccdate#
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			and LastAccDate = #form.thislastaccdate#
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
				and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif>
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif>
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif> 
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
				<!--- <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >= 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase>
					<!--- REMARK ON 07-04-2009 --->
					<!--- <cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase> --->
				</cfswitch> --->
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno;
		</cfquery>
	</cfif>
	
      
    
        <cfset pagebreak = 0>
    	<cfset rowlimit = 40>
  		<cfoutput query="getitem">
              <cfif isdefined('form.printform')>
        <cfif len(getitem.itemno) lte 15 and len(getitem.desp) lte 50>
        <cfset pagebreak = pagebreak + 1>
        <cfelse>
        <cfset pagebreak = pagebreak + 2>
        </cfif>
		<!--- <cfset roundamount = int(getitem.currentrow / 35)>
        <cfset rowdata = getitem.currentrow / 35>
        <cfif rouountndam eq rowdata> --->
        <cfif pagebreak gt rowlimit>
        <cfset pagebreak = 0>
        <cfset rowlimit = 50>
        </cfif>
        </cfif>
				<cfif getpin2.h42A0 eq 'T'>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
                        <cfset xucost=val(getitem.ucost)>
					</cfcase>
					<cfcase value="MONTH,MOVING" delimiters=",">
					<cfset xucost=val(getitem.unitcost)>
					</cfcase>
				</cfswitch>
                <cfelse>
                <cfset xucost=''>
                </cfif>
                <cfif getpin2.h42A0 eq 'T'>
				<cfset xstockbalance=val(stockbalance)>
                <cfelse>
                <cfset xstockbalance=''>
                </cfif>
                <cfquery name="insertcolumn" datasource="#dts#">
        		insert into itemstatustemp (itemno,aitemno,desp,despa,unit,cost,qtybf,qin,qout,balance,stockvalue) values ('#getitem.itemno#','#getitem.aitemno#','#getitem.desp#','#getitem.despa#','#getitem.unit#','#xucost#','#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#','#val(qin)#','#val(qout)#','#val(balance)#','#val(xstockbalance)#')
        		</cfquery> 
</cfoutput>
<cfquery name="MyQuery" datasource="#dts#">
select * from itemstatustemp
</cfquery>
<cfreport template="itemstatus.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getgeneral.compro#">
   
	<cfreportparam name="brandfrom" value="#form.brandfrom#">
    <cfreportparam name="brandto" value="#form.brandto#">
    
    <cfreportparam name="catefrom" value="#form.catefrom#">
    <cfreportparam name="cateto" value="#form.cateto#">
    
    <cfreportparam name="groupfrom" value="#form.groupfrom#">
    <cfreportparam name="groupto" value="#form.groupto#">
    
    <cfreportparam name="productfrom" value="#form.productfrom#">
    <cfreportparam name="productto" value="#form.productto#">
    
    <cfreportparam name="suppfrom" value="#form.suppfrom#">
    <cfreportparam name="suppto" value="#form.suppto#">
    <cfreportparam name="calcu" value="Calculated by #costingmethod#">
    
    
    <cfreportparam name="periodfrom" value="#form.periodfrom#">
    <cfreportparam name="periodto" value="#form.periodto#">
    <cfreportparam name="datefrom" value="#datefrom#">
    <cfreportparam name="dateto" value="#dateto#">
    <cfreportparam name="dts" value="#dts#">
    
	</cfreport>


<!--- FIFO Costing Method --->
<cfelseif getgeneral.cost eq "FIFO">
	<cfparam name="form.includetr" default="yes">
	<cfset periodfr = val(form.periodfrom) + 10>
	<cfset periodto = val(form.periodto) + 10>
	
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.desp,a.despa,a.unit,a.unit,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.trin,e.trout,f.innow,g.outnow,h.fqty,i.pamt,
			((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)) as bfqty,
			(((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) as balancenow
			from icitem_last_year as a
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="x">
						<cfif x eq 11>
							ifnull(qin#x#,0)
						<cfelse>
							+ifnull(qin#x#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastin,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as b on a.itemno=b.itemno
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="y">
						<cfif y eq 11>
							ifnull(qout#y#,0)
						<cfelse>
							+ifnull(qout#y#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastout,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as trin,itemno 
				from ictran
				where type ='TRIN' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        		and operiod+0 <= '#form.periodto#'
	      		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
	    		</cfif> 
	      		and wos_date > #getdate.LastAccDate#
				
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno 
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as trout,itemno 
				from ictran
				where type ='TROU' and (void = '' or void is null) and (toinv='' or toinv is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and operiod+0 <= '#form.periodto#'
	     		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= #getdate.ThisAccDate# 
	    		</cfif> 
	     		and wos_date > #getdate.LastAccDate#
				
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="z">
					<cfif z eq periodfr>
						ifnull(qin#z#,0)
					<cfelse>
						+ifnull(qin#z#,0)
					</cfif>
				</cfloop>
				as innow,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as f on a.itemno=f.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="a">
					<cfif a eq periodfr>
						ifnull(qout#a#,0)
					<cfelse>
						+ifnull(qout#a#,0)
					</cfif>
				</cfloop>
				as outnow,itemno 
				from icitem_last_year
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
			) as g on a.itemno=g.itemno
	
			left join
			(
				select (<cfloop index="i" from="50" to="11" step="-1">
							<cfset ffq = "ffq"&"#i#">
							<cfoutput>#ffq#</cfoutput><cfif i lte 50 and i gt 11>+</cfif>
					 	</cfloop>) as fqty,itemno 
				from fifoopq_last_year 
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as pamt,aa.itemno 
				from icitem_last_year as aa
				
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
		     		and wos_date <= #getdate.LastAccDate#
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
		     		and wos_date <= #getdate.LastAccDate#
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				where LastAccDate = #form.thislastaccdate#
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as i on a.itemno = i.itemno
	
			where a.itemno <> ''
			and a.LastAccDate = #form.thislastaccdate#
			<cfif isdefined("form.include0")>
			<cfelse>
				and (((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	<cfelse>
		<!--- ADD ON 03-04-2009, FOR QIN QOUT RECALCULATE --->
		<cfquery name="getictranin" datasource="#dts#">
			select sum(qty) as qin , itemno, fperiod
			from ictran 
			where type in (#PreserveSingleQuotes(intrantype)#)
			and fperiod<>'99' 
			and (void = '' or void is null) 
			and (linecode <> 'SV' or linecode is null)
            <cfif ndateto neq ''>
            and wos_date<='#ndateto#'
            </cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by itemno, fperiod
		</cfquery>
		<cfquery name="getictranout" datasource="#dts#">
			select sum(qty) as qout , itemno, fperiod
			from ictran as a
			where (void = '' or void is null)
			and fperiod<>'99' 
            <cfif ndateto neq ''>
            and wos_date<='#ndateto#'
            </cfif>
			and (linecode <> 'SV' or linecode is null)
            and
            
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)  and (toinv='' or toinv is null) 
                </cfif>  
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by itemno, fperiod
		</cfquery>
		
		<!--- INITIALIZE THE QIN/QOUT IN ICITEM --->
		<cfquery name="InitializeIcitem" datasource="#dts#">
			update icitem 
			set qin11= 0,
			qin12= 0,
			qin13= 0,
			qin14= 0,
			qin15= 0,
			qin16= 0,
			qin17= 0,
			qin18= 0,
			qin19= 0,
			qin20= 0,
			qin21= 0,
			qin22= 0,
			qin23= 0,
			qin24= 0,
			qin25= 0,
			qin26= 0,
			qin27= 0,
			qin28= 0, 
			qout11 = 0,
			qout12 = 0,
			qout13 = 0,
			qout14 = 0,
			qout15 = 0,
			qout16 = 0,
			qout17 = 0,
			qout18 = 0,
			qout19 = 0,
			qout20 = 0,
			qout21 = 0,
			qout22 = 0,
			qout23 = 0,
			qout24 = 0,
			qout25 = 0,
			qout26 = 0,
			qout27 = 0,
			qout28 = 0
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				where itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
		</cfquery>
		
		<cftry>
			<cfloop query="getictranin">
				
				<cfset qname = 'QIN'&(getictranin.fperiod+10)>
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#= #getictranin.qin# 
					where itemno = '#getictranin.itemno#'
				</cfquery>
			</cfloop>
			<cfcatch type="any">
				<cfoutput>Failed to update QIN. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfloop query="getictranout">
				<cfset qname = 'QOUT'&(getictranout.fperiod+10)>
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#= #getictranout.qout# 
					where itemno = '#getictranout.itemno#'
				</cfquery>
			</cfloop>
			<cfcatch type="any">
				<cfoutput>Failed to update QOUT. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
			</cfcatch>
		</cftry>
		<!--- ADD ON 03-04-2009, FOR QIN QOUT RECALCULATE --->

		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.desp,a.despa,a.unit,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.trin,e.trout,f.innow,g.outnow,h.fqty,i.pamt,
			((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)) as bfqty,
			(((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) as balancenow
			from icitem as a
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="x">
						<cfif x eq 11>
							ifnull(qin#x#,0)
						<cfelse>
							+ifnull(qin#x#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastin,itemno 
				from icitem
			) as b on a.itemno=b.itemno
	
			left join
			(
				select 
				<cfif periodfr eq 11>
				0
				<cfelse>
					<cfloop from="11" to="#periodfr-1#" index="y">
						<cfif y eq 11>
							ifnull(qout#y#,0)
						<cfelse>
							+ifnull(qout#y#,0)
						</cfif>
					</cfloop>
				</cfif>
				
				as lastout,itemno 
				from icitem
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as trin,itemno 
				from ictran
				where type ='TRIN' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and fperiod+0 <= '#form.periodto#'
	      		</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif>  
				group by itemno 
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as trout,itemno 
				from ictran
				where type ='TROU' and (void = '' or void is null) and (toinv='' or toinv is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
	        	and fperiod+0 <= '#form.periodto#'
	     		</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="z">
					<cfif z eq periodfr>
						ifnull(qin#z#,0)
					<cfelse>
						+ifnull(qin#z#,0)
					</cfif>
				</cfloop>
				as innow,itemno 
				from icitem
			) as f on a.itemno=f.itemno
	
			left join
			(
				select 
				<cfloop from="#periodfr#" to="#periodto#" index="a">
					<cfif a eq periodfr>
						ifnull(qout#a#,0)
					<cfelse>
						+ifnull(qout#a#,0)
					</cfif>
				</cfloop>
				as outnow,itemno 
				from icitem
			) as g on a.itemno=g.itemno
	
			left join
			(
				select (<cfloop index="i" from="50" to="11" step="-1">
							<cfset ffq = "ffq"&"#i#">
							<cfoutput>#ffq#</cfoutput><cfif i lte 50 and i gt 11>+</cfif>
					 	</cfloop>) as fqty,itemno 
				from fifoopq 
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as pamt,aa.itemno 
				from icitem as aa
				
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty,sum(amt) as sumamt,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
				<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and aa.supp between '#form.suppfrom#' and '#form.suppto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
				and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as i on a.itemno = i.itemno
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
			<cfelse>
			and (((ifnull(a.qtybf,0))+ifnull(lastin,0)-ifnull(lastout,0))+ifnull(f.innow,0)-ifnull(g.outnow,0)) > 0
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			order by a.itemno
		</cfquery>
	</cfif>


    <cfset pagebreak = 0>
    <cfset rowlimit = 50>
	
		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			 <cfset fifotable="fifoopq_last_year">
		<cfelse>	
			<cfset fifotable="fifoopq">
		</cfif>
		
		<cfloop query="getitem">
      		<cfset balqty =  val(getitem.qtybf) + val(getitem.lastin) - val(getitem.lastout) + val(getitem.innow) - val(getitem.outnow)>
	  		<!--- <cfset balnowqty = val(getitem.qtybf) + val(getitem.innow) - val(getitem.outnow)> --->
      		<cfset lastcost = 0>
	  		<cfset fifoqty = 0>
      		<cfset ttnewffstkval =0>
      		<!--- <cfset qqout = val(getitem.qout)> --->
			<cfset qqout = val(getitem.lastout) + val(getitem.outnow) - val(getitem.trout)>

	 		<cfif val(getitem.fqty) neq 0>
	  			<cfset lastcost = 0>

				<cfloop index="i" from="50" to="11" step="-1">
          			<cfset ffq = "ffq"&"#i#">
          			<cfset ffc = "ffc"&"#i#">

		  			<cfquery name="getfifoopq" datasource="#dts#">
          				select #ffq# as xffq, #ffc# as xffc from #fifotable# where itemno = '#getitem.itemno#'
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
          			</cfquery>

		  			<cfif getfifoopq.xffq gt 0>
            			<cfset lastcost = getfifoopq.xffc>
          			</cfif>

		  			<cfset fifoqty = fifoqty + val(getfifoopq.xffq)>
          			<cfset newffstkval = val(getfifoopq.xffq) * val(getfifoopq.xffc)>
          			<cfset ttnewffstkval = ttnewffstkval + newffstkval>

		  			<cfif fifoqty gte val(qqout)>
            			<!--- <cfset minusfifoqty = fifoqty - val(getitem.qout)> --->
						<cfset minusfifoqty = fifoqty - val(qqout)>

						<cfif minusfifoqty gt 0>
              				<cfset stkvalff = minusfifoqty * val(getfifoopq.xffc)>
              			<cfelse>
              				<cfset stkvalff = 0>
            			</cfif>

						<cfset fifocnt = i - 1>
            			<cfbreak>
          			</cfif>
        		</cfloop>
				
				<!--- REMARK ON 17-12-2008 --->
				<!--- <cfset totalout = val(getitem.qout) + val(getitem.lastout)> --->
				<!--- <cfset totalout = val(getitem.qout)> --->
				<!--- REMARK ON 05-11-2009 --->
				<!--- <cfset totalout = val(getitem.lastout) + val(getitem.outnow)> --->
				<cfset totalout = val(getitem.lastout) + val(getitem.outnow) - val(getitem.trout)>
				
        		<cfif fifoqty gte totalout >
          			<cfset ttnewffstkval = 0>

					<cfloop index="i" from="#fifocnt#" to="11" step="-1">
            			<cfset ffq = "ffq"&"#i#">
            			<cfset ffc = "ffc"&"#i#">

						<cfquery name="getfifoopq2" datasource="#dts#">
            				select #ffq# as xffq, #ffc# as xffc from #fifotable# where itemno = '#getitem.itemno#'
							<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
								and LastAccDate = #form.thislastaccdate#
							</cfif>
            			</cfquery>

						<cfif getfifoopq2.xffq gt 0>
              				<cfset lastcost = val(getfifoopq2.xffc)>
            			</cfif>

						<cfset newffstkval = val(getfifoopq2.xffq) * val(getfifoopq2.xffc)>
            			<cfset ttnewffstkval = ttnewffstkval + newffstkval>
          			</cfloop>

		  			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  			<cfquery name="getallrc" datasource="#dts#">
							select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem_last_year as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(amt/qty) as price1,sum(amt_bil/qty_bil)as price_bil1 
								from ictran 
								where itemno='#getitem.itemno#' and type in ('RC','OAI') and (void = '' or void is null)
					     		and wos_date > #getdate.LastAccDate#
								and wos_date <= #getdate.ThisAccDate# 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and operiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitem.itemno#' and type='CN' and (void = '' or void is null) 
					     		and wos_date > #getdate.LastAccDate#
								and wos_date <= #getdate.ThisAccDate# 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and operiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitem.itemno#'
							and LastAccDate = #form.thislastaccdate#
	          			</cfquery>

						<cfquery name="getrc" datasource="#dts#">
							select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
							and wos_date = (select max(wos_date) 
											from ictran 
											where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
											and wos_date > #getdate.LastAccDate#
											and wos_date <= #getdate.ThisAccDate# 
											)
							and wos_date > #getdate.LastAccDate#
							and wos_date <= #getdate.ThisAccDate# 
							<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and operiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
						</cfquery>	
					<cfelse>
			  			<cfquery name="getallrc" datasource="#dts#">
							select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(amt/qty) as price1,sum(amt_bil/qty_bil)as price_bil1 
								from ictran 
								where itemno='#getitem.itemno#' and type in ('RC','OAI') and (void = '' or void is null)
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitem.itemno#' and type='CN' and (void = '' or void is null) 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
                                <cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date <= '#ndateto#' 
								</cfif> 
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitem.itemno#';
	          			</cfquery>

						<cfquery name="getrc" datasource="#dts#">
							select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
							and wos_date = (select max(wos_date) from ictran where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null))
							<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and fperiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
						</cfquery>	
					</cfif>

					<!--- <cfquery name="getrc" datasource="#dts#">
          				select qty, amt, amt_bil, price, price_bil from ictran where itemno = '#getitem.itemno#' and type = 'RC' and (void = '' or void is null)
          				<cfif form.periodfrom neq "" and form.periodto neq "">
             			and fperiod <= '#form.periodto#'
          				</cfif>
          				order by trdatetime
          			</cfquery> --->

		  			<cfif getrc.recordcount gt 0>
              			<cfset lastcost = getrc.price>
          			</cfif>

		  			<cfset totalstkval = stkvalff + ttnewffstkval + val(getallrc.sumamt)>
		  			
          		<cfelse>
          			<cfset totalrcqty = fifoqty>
          			<cfset stkval = 0>

		  			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  			<cfquery name="getrc" datasource="#dts#">
	          				select qty,
							if(type='CN',it_cos,amt)as amt,
							if(type='CN',(it_cos/currrate),
							amt_bil) as amt_bil,
							if(type='CN',(it_cos/qty),
							(amt/qty)) as price,
							if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
							and wos_date > #getdate.LastAccDate#
							and wos_date <= #getdate.ThisAccDate#
	          				<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and operiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
	          			</cfquery>
					<cfelse>	
			  			<cfquery name="getrc" datasource="#dts#">
	          				select qty,
							if(type='CN',it_cos,amt)as amt,
							if(type='CN',(it_cos/currrate),
							amt_bil) as amt_bil,
							if(type='CN',(it_cos/qty),
							(amt/qty)) as price,
							if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
							from ictran 
							where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
	          				<cfif form.periodfrom neq "" and form.periodto neq "">
	             				and fperiod+0 <= '#form.periodto#'
	          				</cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
							and wos_date <= '#ndateto#' 
							</cfif> 
	          				order by wos_date,trdatetime;
	          			</cfquery>
					</cfif>

		  			<cfset cnt = 0>

		  			<cfloop query="getrc">
            			<cfset cnt = cnt + 1>

						<cfif getrc.qty neq "">
              				<cfset rcqty = getrc.qty>
              			<cfelse>
              				<cfset rcqty = 0>
            			</cfif>

						<cfset lastcost = getrc.price>
            			<cfset totalrcqty = totalrcqty + rcqty>

						<cfif totalrcqty gte qqout>
              				<cfset minusqty = totalrcqty - qqout>

							<cfif minusqty gt 0>
                				<cfset stkval = minusqty * getrc.price>
                			<cfelse>
                				<cfset stkval = 0>
              				</cfif>

							<cfbreak>
            			</cfif>
          			</cfloop>

          			<cfif getrc.recordcount gt cnt>
            			<cfset cnt = cnt + 1>
            			<!--- next record --->
            			<cfset newstkval = 0>

						<cfloop query="getrc" startrow="#cnt#">
              				<cfset lastcost = getrc.price>
              				<cfset newstkval = newstkval + getrc.amt>
            			</cfloop>
            		<cfelse>
            			<cfset newstkval = 0>
          			</cfif>

					<cfset totalstkval = stkval + newstkval>
        		</cfif>
        	<cfelse><!--- if qtybf eq 0 --->
        		<cfset totalrcqty = 0>
        		<cfset stkval = 0>

				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="getrc" datasource="#dts#">
	        			select qty,
						if(type='CN',it_cos,amt)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						(amt/qty)) as price,
						if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
						from ictran 
						where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#
	          			<cfif form.periodfrom neq "" and form.periodto neq "">
	             			and operiod+0 <= '#form.periodto#'
	          			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date <= '#ndateto#' 
						</cfif> 
	          			order by wos_date,trdatetime;
	        		</cfquery>
				<cfelse>
					<cfquery name="getrc" datasource="#dts#">
	        			select qty,
						if(type='CN',it_cos,amt)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						(amt/qty)) as price,
						if(type='CN',((it_cos/currrate)/qty),(amt_bil/qty_bil)) as price_bil 
						from ictran 
						where itemno='#getitem.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
	          			<cfif form.periodfrom neq "" and form.periodto neq "">
	             		and fperiod+0 <= '#form.periodto#'
	          			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date <= '#ndateto#' 
						</cfif> 
	          			order by wos_date,trdatetime;
	        		</cfquery>
				</cfif>

				<cfset cnt = 0>

				<cfloop query="getrc">
          			<cfset cnt = cnt + 1>

					<cfset rcqty = val(getrc.qty)>

					<cfset lastcost = getrc.price>
          			<cfset totalrcqty = totalrcqty + rcqty>

					<cfif totalrcqty gte qqout>
            			<cfset minusqty = totalrcqty - qqout>

						<cfif minusqty neq 0>
              				<cfset stkval = minusqty * getrc.price>
              			<cfelse>
              				<cfset stkval = 0>
            			</cfif>
            			<cfbreak>
          			</cfif>
        		</cfloop>
				
				<cfif getrc.recordcount gt cnt>
          			<cfset cnt = cnt + 1>
          			<!--- next record --->
          			<cfset newstkval = 0>

					<cfloop query="getrc" startrow="#cnt#">
            			<cfset lastcost = getrc.price>
            			<cfset newstkval = newstkval + getrc.amt>
         	 		</cfloop>
          		<cfelse>
          			<cfset newstkval = 0>
        		</cfif>

				<cfset totalstkval = stkval + newstkval>
				
      		</cfif>
		
		<cfoutput>
        
		<cfif isdefined('form.fifocost')>
        <cfset divby = getitem.balancenow>
        <cfif getitem.balancenow eq "-">
        <cfset divby = 1>
		</cfif>
        <cfif getitem.balancenow eq 0 or getitem.balancenow eq "">
        <cfset divby = 1>
        </cfif>
		<cfset lastcost = val(totalstkval) / divby >
		</cfif>
        
        <cfif isdefined('form.printform')>
        <cfif len(getitem.itemno) lte 15 and len(getitem.desp) lte 50>
        <cfset pagebreak = pagebreak + 1>
        <cfelse>
        <cfset pagebreak = pagebreak + 2>
        </cfif>
		<!--- <cfset roundamount = int(getitem.currentrow / 35)>
        <cfset rowdata = getitem.currentrow / 35>
        <cfif rouountndam eq rowdata> --->
        <cfif pagebreak gt rowlimit>
        <cfset pagebreak = 0>
        <cfset rowlimit = 60>
        <p style="page-break-after:always">&nbsp;</p>
		</cfif>
        </cfif>
        
        <cfquery name="insertcolumn" datasource="#dts#">
        		insert into itemstatustemp (itemno,aitemno,desp,despa,unit,cost,qtybf,qin,qout,balance,stockvalue) values ('#getitem.itemno#','#getitem.aitemno#','#getitem.desp#','#getitem.despa#','#getitem.unit#','#lastcost#','#val(getitem.qtybf)#','#val(innow)#','#val(outnow)#','#val(balancenow)#','#val(totalstkval)#')
        		</cfquery>
      	</cfoutput>
    </cfloop>
    <cfquery name="MyQuery" datasource="#dts#">
select * from itemstatustemp
</cfquery>
		<cfreport template="itemstatus.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getgeneral.compro#">
   
	<cfreportparam name="brandfrom" value="#form.brandfrom#">
    <cfreportparam name="brandto" value="#form.brandto#">
    <cfreportparam name="calcu" value="Calculated by #costingmethod#">
    <cfreportparam name="catefrom" value="#form.catefrom#">
    <cfreportparam name="cateto" value="#form.cateto#">
    
    <cfreportparam name="groupfrom" value="#form.groupfrom#">
    <cfreportparam name="groupto" value="#form.groupto#">
    
    <cfreportparam name="productfrom" value="#form.productfrom#">
    <cfreportparam name="productto" value="#form.productto#">
    
    <cfreportparam name="suppfrom" value="#form.suppfrom#">
    <cfreportparam name="suppto" value="#form.suppto#">
    
    <cfreportparam name="periodfrom" value="#form.periodfrom#">
    <cfreportparam name="periodto" value="#form.periodto#">
    <cfreportparam name="datefrom" value="#datefrom#">
    <cfreportparam name="dateto" value="#dateto#">
    <cfreportparam name="dts" value="#dts#">
    
	</cfreport>

<!-- LIFO Costing Method -->
<cfelseif getgeneral.cost eq "LIFO">
	<cfset stkvalff=0>
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,unit,qtybf 
		from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">icitem_last_year<cfelse>icitem</cfif> 
		where itemno <> ''
		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			and LastAccDate = #form.thislastaccdate#
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and category between '#form.catefrom#' and '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and wos_group betwwen '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		order by itemno;
	</cfquery>

		<cfset pagebreak = 0>
    	<cfset rowlimit = 50>
    	<cfloop query="getitem">
      		<cfset lastbal= 0>
      		<cfset lastin=0>
      		<cfset lastout=0>
      		<cfset lastdo=0>
      		
			<cfif form.periodfrom neq '01'>
        		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetin" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(intrantype)#) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate# 
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and operiod+0 < '#form.periodfrom#'
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				<cfelse>
					<cfquery name="lastgetin" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(intrantype)#) and itemno='#itemno#' and (void = '' or void is null)
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and fperiod+0 < '#form.periodfrom#'
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				</cfif>
        		
				<cfif lastgetin.sumqty neq "">
          			<cfset lastin = lastgetin.sumqty>
        		</cfif>
        		
				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetout" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#  
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and operiod+0 < '#form.periodfrom#' 
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				<cfelse>
					<cfquery name="lastgetout" datasource="#dts#">
	        			select sum(qty)as sumqty 
						from ictran 
						where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and itemno='#itemno#' and (void = '' or void is null) 
	        			<cfif form.periodfrom neq "" and form.periodto neq "">
	          				and fperiod+0 < '#form.periodfrom#' 
	        			</cfif>
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
	        		</cfquery>
				</cfif>
        		
				<cfif lastgetout.sumqty neq "">
				  	<cfset lastout = lastgetout.sumqty>
				</cfif>
				
				<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
					<cfquery name="lastgetdo" datasource="#dts#">
						select sum(qty)as sumqty 
						from ictran 
						where type='DO' and (toinv='' or toinv is null) and itemno='#itemno#' and (void = '' or void is null)
						and wos_date > #getdate.LastAccDate#
						and wos_date <= #getdate.ThisAccDate#  
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and operiod+0 < '#form.periodfrom#'
						</cfif> 
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
						group by itemno
					</cfquery>
				<cfelse>
					<cfquery name="lastgetdo" datasource="#dts#">
						select sum(qty)as sumqty 
						from ictran 
						where type='DO' and (toinv='' or toinv is null) and itemno='#itemno#' and (void = '' or void is null)
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and fperiod+0 < '#form.periodfrom#'
						</cfif> 
                        <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#' 
						</cfif> 
						group by itemno
					</cfquery>
				</cfif>
				
				<cfif lastgetdo.sumqty neq "">
				  	<cfset lastdo = lastgetdo.sumqty>
				</cfif>
				
				<cfset lastbal = lastin - lastdo - lastout>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="check" datasource="#dts#">
				  	select itemno 
					from fifoopq_last_year 
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
					and LastAccDate = #form.thislastaccdate#
				</cfquery>
			<cfelse>
				<cfquery name="check" datasource="#dts#">
				  	select itemno 
					from fifoopq 
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
				</cfquery>
			</cfif>
			
			<cfset lastcost = 0>
			
			<cfif getitem.qtybf neq "">
				<cfset bfqty = getitem.qtybf + lastbal>
			<cfelse>
				<cfset bfqty = lastbal>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getin" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 
				</cfquery>
			<cfelse>
				<cfquery name="getin" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 
				</cfquery>
			</cfif>
			
			<cfif getin.qty neq "">
				<cfset inqty = getin.qty>
			<cfelse>
				<cfset inqty = 0>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getinnow" datasource="#dts#">
					select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) 
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 >= '#form.periodfrom#' and operiod <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
				</cfquery>
			<cfelse>
				<cfquery name="getinnow" datasource="#dts#">
					select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) 
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
				</cfquery>
			</cfif>
			
			<cfif getinnow.qty neq "">
				<cfset innowqty = getinnow.qty>
			<cfelse>
				<cfset innowqty = 0>
			</cfif>
      
	  		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
		  		<cfquery name="getdo" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 

			  	</cfquery>	
			<cfelse>
		  		<cfquery name="getdo" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif> 

			  	</cfquery>	
			</cfif>
	  
		  	<cfif getdo.qty neq "">
				<cfset doqty = getdo.qty>
			<cfelse>
				<cfset doqty = 0>
		  	</cfif>
			
		  	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			  	<cfquery name="getdonow" datasource="#dts#">
			  		select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 between '#form.periodfrom#' and '#form.periodto#'
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif>
					group by itemno
			  	</cfquery>	
			<cfelse>
			  	<cfquery name="getdonow" datasource="#dts#">
			  		select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type='DO' and (toinv='' or toinv is null) and (void = '' or void is null)
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif>
					group by itemno
			  	</cfquery>	
			</cfif>
			
			<cfif getdonow.qty neq "">
        		<cfset donowqty = getdonow.qty>
        	<cfelse>
        		<cfset donowqty = 0>
      		</cfif>
      	
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getout" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(outtrantypewodo)#) and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      		</cfquery>
			<cfelse>
				<cfquery name="getout" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and type in (#PreserveSingleQuotes(outtrantypewodo)#) and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      		</cfquery>
			</cfif>
      
		  	<cfif getout.qty neq "">
				<cfset outqty = getout.qty>
			<cfelse>
				<cfset outqty = 0>
			</cfif>
			
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getoutnow" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewodo)#)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#   
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 between '#form.periodfrom#' and '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
					group by itemno
			  	</cfquery>
			<cfelse>
				<cfquery name="getoutnow" datasource="#dts#">
	      			select sum(qty) as qty 
					from ictran 
					where itemno='#getitem.itemno#' and (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewodo)#) 
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    			</cfif> 
					group by itemno
			  	</cfquery>
			</cfif>
			
			<cfif getoutnow.qty neq "">
        		<cfset outnowqty = getoutnow.qty>
        	<cfelse>
        		<cfset outnowqty = 0>
      		</cfif>
      		
			<cfset ttoutnowqty = outnowqty + donowqty>
		  	<cfset ttoutqty = outqty + doqty>
		  	<cfset balqty =  bfqty + inqty - ttoutqty>
		  	<cfset balnowqty =  bfqty + innowqty - ttoutnowqty>
		  	<cfset fifoqty = 0>
		  	<cfset ttnewffstkval =0>
      		
			<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#   
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      			order by trdatetime desc
	      		</cfquery>
			<cfelse>
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt, amt_bil, amt/qty as price, amt_bil/qty_bil as price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
					</cfif>
	      			order by trdatetime desc
	      		</cfquery>
			</cfif>
			
			<cfif getrc.recordcount gt 0 and check.recordcount gt 0>
        		<cfset totalrcqty = 0>
        		<cfset cnt = 0>
        		
				<cfloop query="getrc">
          			<cfset cnt = cnt + 1>
          			
					<cfif getrc.qty neq "">
            			<cfset rcqty = getrc.qty>
            		<cfelse>
            			<cfset rcqty = 0>
          			</cfif>
          			
					<cfset lastcost = getrc.price>
          			<cfset totalrcqty = totalrcqty + rcqty>
          			
					<cfif totalrcqty gte ttoutqty>
            			<cfset minusqty = totalrcqty - ttoutqty>
            			
						<cfif minusqty gt 0>
              				<cfset stkval = minusqty * lastcost>
              			<cfelse>
              				<cfset stkval = 0>
            		</cfif>
            		<cfbreak>
          		</cfif>
        	</cfloop>
        	
			<cfif totalrcqty gte ttoutqty>
          		<cfset cnt = cnt + 1>
          		<!--- next record --->
          		<cfset newstkval = 0>
          		
				<cfoutput query="getrc" startrow="#cnt#">
            		<cfset lastcost = getrc.price>
            		<cfset newstkval = newstkval + getrc.amt>
          		</cfoutput>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif> 
						where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
            		
					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
          		</cfloop>
          		
				<cfset totalstkval = stkval + newstkval + ttnewffstkval>
          	<cfelse>
          		<!--- rc less than out --->
          		<cfset ttnewffstkval = 0>
          		<cfset fifoqty = totalrcqty>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>  
						where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
						<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
							and LastAccDate = #form.thislastaccdate#
						</cfif>
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
					
					<cfset fifoqty = fifoqty + getfifoopq.xffq>
            		<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		
					<cfif fifoqty gte ttoutqty>
              			<cfset minusfifoqty = fifoqty - ttoutqty>
              			
						<cfif minusfifoqty gt 0>
                			<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
                		<cfelse>
                			<cfset stkvalff = 0>
              			</cfif>
              			
						<cfset fifocnt = i + 1>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif fifoqty gte ttoutqty>
            		<cfset ttnewffstkval = 0>
            		
					<cfloop index="i" from="#fifocnt#" to="50">
              			<cfset ffq = "ffq"&"#i#">
              			<cfset ffc = "ffc"&"#i#">
              			
						<cfquery name="getfifoopq2" datasource="#dts#">
              				select #ffq# as xffq, #ffc# as xffc 
							from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>  
							where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
							<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
								and LastAccDate = #form.thislastaccdate#
							</cfif>
              			</cfquery>
              			
						<cfif getfifoopq2.xffq gt 0>
                			<cfset lastcost = getfifoopq2.xffc>
              			</cfif>
              				
						<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
              			<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		</cfloop>
          		</cfif>
          		
				<cfset totalstkval = stkvalff + ttnewffstkval>
        	</cfif>
    
        <cfelseif getrc.recordcount eq 0 and check.recordcount gt 0>
        	<cfset ttnewffstkval = 0>
        	<cfset lastcost = 0>
        		
			<cfloop index="i" from="11" to="50">
          		<cfset ffq = "ffq"&"#i#">
          		<cfset ffc = "ffc"&"#i#">
          		
				<cfquery name="getfifoopq2" datasource="#dts#">
          			select #ffq# as xffq, #ffc# as xffc 
					from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">fifoopq_last_year<cfelse>fifoopq</cfif>   
					where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
					<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
						and LastAccDate = #form.thislastaccdate#
					</cfif>
          		</cfquery>
				
          		<cfif getfifoopq2.xffq gt 0>
            		<cfset lastcost = getfifoopq2.xffc>
          		</cfif>
          		
				<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
          		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
        	</cfloop>
        	
			<cfset totalstkval = ttnewffstkval>
        <cfelse>
        	<cfset totalrcqty = 0>
        	<cfset cnt = 0>
        	<cfset stkval = 0>
        	<cfset newstkval = 0>
        	
			<cfif getrc.recordcount gt 0>
          		<cfloop query="getrc">
            		<cfset cnt = cnt + 1>
            		
					<cfif getrc.qty neq "">
              			<cfset rcqty = getrc.qty>
              		<cfelse>
              			<cfset rcqty = 0>
            		</cfif>
            		
					<cfset lastcost = getrc.price>
            		<cfset totalrcqty = totalrcqty + rcqty>
            		
					<cfif totalrcqty gte ttoutqty>
              			<cfset minusqty = totalrcqty - ttoutqty>
              			
						<cfif minusqty gt 0>
                			<cfset stkval = minusqty * getrc.price>
                		<cfelse>
                			<cfset stkval = 0>
              			</cfif>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif getrc.recordcount gt cnt>
            		<cfset cnt = cnt + 1>
            		<!--- next record --->
            		<cfset newstkval = 0>
            		
					<cfoutput query="getrc" startrow="#cnt#">
              			<cfset lastcost = getrc.price>
              			<cfset newstkval = newstkval + getrc.amt>
            		</cfoutput>
            	<cfelse>
            		<cfset newstkval = 0>
          		</cfif>
        	</cfif>
        	
			<cfset totalstkval = stkval + newstkval>
      	</cfif>
      	<cfoutput>
        <cfif isdefined('form.printform')>
        <cfif len(getitem.itemno) lte 15 and len(getitem.desp) lte 50>
        <cfset pagebreak = pagebreak + 1>
        <cfelse>
        <cfset pagebreak = pagebreak + 2>
        </cfif>
		<!--- <cfset roundamount = int(getitem.currentrow / 35)>
        <cfset rowdata = getitem.currentrow / 35>
        <cfif rouountndam eq rowdata> --->
        <cfif pagebreak gt rowlimit>
        <cfset pagebreak = 0>
        <cfset rowlimit = 60>
        <p style="page-break-after:always">&nbsp;</p>

        </cfif>
        </cfif>
        
        <cfquery name="insertcolumn" datasource="#dts#">
        		insert into itemstatustemp (itemno,aitemno,desp,despa,unit,cost,qtybf,qin,qout,balance,stockvalue) values ('#getitem.itemno#','#getitem.aitemno#','#getitem.desp#','#getitem.despa#','#getitem.unit#','#lastcost#','#val(getitem.qtybf)#','#val(innowqty)#','#val(ttoutnowqty)#','#val(balnowqty)#','#val(totalstkval)#')
        		</cfquery>
</cfoutput>
    </cfloop>
</cfif>
<cfquery name="MyQuery" datasource="#dts#">
select * from itemstatustemp
</cfquery>
<cfreport template="itemstatus.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getgeneral.compro#">
   
	<cfreportparam name="brandfrom" value="#form.brandfrom#">
    <cfreportparam name="brandto" value="#form.brandto#">
    <cfreportparam name="calcu" value="Calculated by #costingmethod#">
    <cfreportparam name="catefrom" value="#form.catefrom#">
    <cfreportparam name="cateto" value="#form.cateto#">
    
    <cfreportparam name="groupfrom" value="#form.groupfrom#">
    <cfreportparam name="groupto" value="#form.groupto#">
    
    <cfreportparam name="productfrom" value="#form.productfrom#">
    <cfreportparam name="productto" value="#form.productto#">
    
    <cfreportparam name="suppfrom" value="#form.suppfrom#">
    <cfreportparam name="suppto" value="#form.suppto#">
    
    <cfreportparam name="periodfrom" value="#form.periodfrom#">
    <cfreportparam name="periodto" value="#form.periodto#">
    <cfreportparam name="datefrom" value="#datefrom#">
    <cfreportparam name="dateto" value="#dateto#">
    <cfreportparam name="dts" value="#dts#">
    
	</cfreport>

</cfcase>
<!--- --->


</cfswitch>