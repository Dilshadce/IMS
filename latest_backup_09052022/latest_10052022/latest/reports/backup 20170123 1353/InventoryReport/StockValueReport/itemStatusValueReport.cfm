<!---
<cfinclude template="/readaccess.cfm">--->
<!---<cfsetting showdebugoutput="no">--->
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid,fifocal,costingcn,costingoai from gsetup
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<!---
<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif form.productfrom neq "" and form.productto neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>
--->

<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol
</cfquery>

<cfquery name="getdolistall" datasource="#dts#">
    select 
    frrefno from iclink where frtype='DO' and type='INV' group by frrefno
</cfquery>
        
<cfset runno=1>

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

<cfset uuid=createuuid()>

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
	select cost,compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,fifocal,costingcn,costingoai
	from gsetup;
</cfquery>

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
    <cfcase value="WEIGHT">
		<cfset costingmethod = "WEIGHT Average Method">
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
	<cfset stDecl_UPrice = ".">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ".">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ".">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ".">
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

<cfif getgeneral.cost neq "LIFO">
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">	
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING,WEIGHT">
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) as unitcost,
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem_last_year as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
                <cfif form.datefrom eq "" and form.dateto eq "">
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
                <cfelse>
                	and operiod < '' 
				</cfif> 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)  and (toinv='' or toinv is null) 
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
                <cfif form.datefrom eq "" and form.dateto eq ""> 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
                <cfelse>
                	and operiod < '' 
				</cfif>
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null) 
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
				select sum(qty) as rcqty,<cfif getgeneral.cost eq "weight">sum(if(type = "CN",it_cos,amt))<cfelse>sum(amt)</cfif> as rcamt,itemno 
				from ictran
				where <cfif getgeneral.cost eq "weight">(type='RC' or type = "CN" or type = "OAI")<cfelse>type='RC'</cfif> and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
			<!---
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
		     		and wos_date <= '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#' 
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
		     		and wos_date <= '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					group by itemno
				) as cc on aa.itemno=cc.itemno
				
				where aa.LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
				<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
					and aa.supp between '#form.supplierfrom#' and '#form.supplierto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and aa.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno--->
	
			where a.itemno <> ''
			and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >0
					</cfcase>
					<cfcase value="WEIGHT">
					and ((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
				and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) >0
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            and (a.itemtype <> "SV" or a.itemtype is null) 
			order by a.itemno
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING,WEIGHT">
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) as unitcost,
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as stockbalance
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
                <cfelse>
                	and fperiod < '' 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
                <cfelse>
                	and fperiod < '' 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
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
				select sum(qty) as rcqty,<cfif getgeneral.cost eq "weight">sum(if(type = "CN",it_cos,amt))<cfelse>sum(amt)</cfif> as rcamt,itemno 
				from ictran
				where <cfif getgeneral.cost eq "weight">(type='RC' or type = "CN" or type = "OAI")<cfelse>type='RC'</cfif> and (void = '' or void is null)
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
			<!---
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
	
				<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
					and aa.supp between '#form.supplierfrom#' and '#form.supplierto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and aa.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno--->
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="WEIGHT">
					and ((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) >0
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
			and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            and (a.itemtype <> "SV" or a.itemtype is null) 
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
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">#getgeneral.lCATEGORY#: #form.categoryfrom# - #form.categoryto#</font></div></td>
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
		<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
        <cfif lcase(hcomid) eq "hyray_i">
        <cfquery name="getsuppliername" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierfrom#'
        </cfquery>
        <cfquery name="getsuppliername1" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierto#'
        </cfquery>
        </cfif>
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif"> <cfif lcase(hcomid) eq "hyray_i">Supplier: #getsuppliername.name# - #getsuppliername1.name#<cfelse>Supplier: #form.supplierfrom# - #form.supplierto#</cfif></font></div></td>
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
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Product Code</font></div></td>
            </cfif>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description</font></div></td>
             <cfif lcase(hcomid) eq "mphcranes_i">
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description 2</font></div></td>
            </cfif>
            <cfif lcase(hcomid) eq "hyray_i">
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">UOM</font></div></td>
            </cfif>
            <cfif getpin2.h42A0 eq 'T'>
            <cfif getgeneral.cost eq "FIXED">

			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Unit Cost</font></div></td>
            <cfelseif getgeneral.cost eq "MONTH">
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">Month Average</font></div></td>
            <cfelseif getgeneral.cost eq "MOVING">
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">Moving Average</font></div></td>
            <cfelseif getgeneral.cost eq "WEIGHT">
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">Weight Average</font></div></td>
            <cfelseif getgeneral.cost eq "FIFO">
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">Fifo Cost</font></div></td>
            </cfif>            
            </cfif>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Qty Bf</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">In</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Out</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Balance</font></div></td><cfif getpin2.h42A0 eq 'T'>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Stock Value ($)</font></div></td></cfif>
  		</tr>
  		<tr>
      		<td colspan="100%"><hr></td>
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
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Product Code</font></div></td>
            </cfif>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description</font></div></td>
            <cfif lcase(hcomid) eq "mphcranes_i">
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description 2</font></div></td>
            </cfif>
			<cfif lcase(hcomid) eq "hyray_i">
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">UOM</font></div></td>
            </cfif>
			<cfif getpin2.h42A0 eq 'T'>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Unit Cost</font></div></td></cfif>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Qty Bf</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">In</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Out</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Balance</font></div></td><cfif getpin2.h42A0 eq 'T'>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Stock Value ($)</font></div></td></cfif>
  		</tr>
  		<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
        </cfif>
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
		    if(a.taxincl="T" || b.taxincl="T",a.amt-taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b

			where a.itemno='#getitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and 
             <cfif isdefined('form.dodate')>
                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (select useddo from dolink))))
                <cfelse>
                a.type not in ('QUO','SO','PO','SAM')
                and (a.toinv='' or a.toinv is null) 
			</cfif>
			and a.fperiod='99'
			and a.wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
			and a.wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by b.wos_date,b.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			if(a.taxincl="T" || b.taxincl="T",a.amt-taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#getitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and 
             <cfif isdefined('form.dodate')>
                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (select useddo from dolink))))
                <cfelse>
                a.type not in ('QUO','SO','PO','SAM')
                and (a.toinv='' or a.toinv is null) 
			</cfif>
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by b.wos_date,b.trdatetime
		</cfquery>
		</cfif>
        
        
        <cfloop query="getmovingictran">
        
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
	    <cfset movingbal=movingbal-getmovingictran.qty>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        <!---
        <cfif huserid eq 'ultralung'>
        <cfoutput>
        #movingunitcost#
        #movingbal#
        #refno#
        <br>
        </cfoutput>
        </cfif>--->
        
        </cfloop>
        
		<cfset movingstockbal=movingbal*movingunitcost>
        
        </cfif>
        
        <cfif getgeneral.cost eq "MONTH">
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        <cfquery name="getmonthcostamt" datasource="#dts#">
        select cost<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as cost,amt<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as amt
        from monthcost_last_year where itemno='#itemno#'
        </cfquery>
        <cfelse>
        <cfquery name="getmonthcostamt" datasource="#dts#">
        select cost<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as cost,amt<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as amt
        from monthcost where itemno='#itemno#'
        </cfquery>
        </cfif>
        </cfif>
        
        <!---New fifo calculate--->
        <cfif getgeneral.cost eq "FIFO" and getitem.balance gt 0>
        
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getlastrc" datasource="#dts#">
			select 
            if(a.type = "CN",a.it_cos,
		    <cfif isdefined('form.discounted')>if(a.taxincl="T",a.amt-taxamt,a.amt)<cfelse>a.amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7</cfif>) as amt,a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,(<cfif isdefined('form.discounted')>amt<cfelse>amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7<cfelse></cfif>)/qty) as price,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a
			where a.itemno='#getitem.itemno#' 
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type in ('RC','OAI'<cfif getgeneral.costingcn eq 'Y'>,'CN'</cfif>)
			and a.fperiod='99'
			and a.wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
			and a.wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by a.wos_date desc,a.trdatetime desc
			</cfquery>
            <cfelse>
            <cfquery name="getlastrc" datasource="#dts#">
			select 
            if(a.type = "CN",a.it_cos,
		    <cfif isdefined('form.discounted')>if(a.taxincl="T",a.amt-taxamt,a.amt)<cfelse>a.amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7</cfif>) as amt,a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,(<cfif isdefined('form.discounted')>amt<cfelse>amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7<cfelse></cfif>)/qty) as price,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a
            
			where a.itemno='#getitem.itemno#' 
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type in ('RC','OAI'<cfif getgeneral.costingcn eq 'Y'>,'CN'</cfif>)
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date desc,a.trdatetime desc
		</cfquery>
		</cfif>
        
        <cfset fifobalance=getitem.balance>
        <cfset fifostkvalue=0>
        
        <!---getfrombill--->
        <cfloop query="getlastrc">
        <cfif fifobalance gt 0>
        <!---
        <cfif huserid eq "ultralung">
        <cfoutput>
        #getlastrc.price# -#fifostkvalue# -- #fifobalance#<br>
        </cfoutput>
        </cfif>--->
        <cfif fifobalance gte getlastrc.qty>
        <cfset fifostkvalue = fifostkvalue+val(getlastrc.amt)>
        <cfset fifobalance= val(fifobalance)-val(getlastrc.qty)>
        <cfelse>
        <cfset fifostkvalue = fifostkvalue+(val(getlastrc.price)*val(fifobalance))>
        <cfset fifobalance= val(fifobalance)-val(getlastrc.qty)>
		</cfif>
        
        
        </cfif>
        </cfloop>
        <!---end getfrombill--->
        
        <cfif fifobalance gt 0>
        	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        	<cfquery name="getfifocost" datasource="#dts#">
        	select * from fifoopq_last_year where
            LastAccDate ='#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#' and itemno="#getitem.itemno#"
            </cfquery>
            <cfelse>
            <cfquery name="getfifocost" datasource="#dts#">
        	select * from fifoopq where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#"> 
            </cfquery>
            </cfif>
            <cfset lastfifocost=0>
            <cfloop from="11" to="50" index="z">
            <cfif fifobalance gt 0>
			<cfif fifobalance gte val(evaluate('getfifocost.ffq#z#'))>
            <cfset fifostkvalue = fifostkvalue+(val(evaluate('getfifocost.ffc#z#'))*val(evaluate('getfifocost.ffq#z#')))>
            <cfset fifobalance= fifobalance-val(evaluate('getfifocost.ffq#z#'))>
            <cfelse>
            <cfset fifostkvalue = fifostkvalue+(val(evaluate('getfifocost.ffc#z#'))*val(fifobalance))>
            <cfset fifobalance= fifobalance-val(evaluate('getfifocost.ffq#z#'))>
            </cfif>
            <cfif val(evaluate('getfifocost.ffc#z#')) gt 0>
            <cfset lastfifocost=val(evaluate('getfifocost.ffc#z#'))>
            </cfif>
            </cfif>
            </cfloop>
            
            <cfif fifobalance gt 0>
            <cfset fifostkvalue = fifostkvalue+(lastfifocost*val(fifobalance))>
            <cfset fifobalance= 0>
            </cfif>
            
        </cfif>
        
        
        <cfset getitem.stockbalance=val(fifostkvalue)>
        <cfset getitem.ucost=val(fifostkvalue)/val(getitem.balance)>
        
        
        </cfif>
        <!---End new fifo calculate--->
        
        <cfif getgeneral.cost eq "MOVING">
        <cfset check0varible=movingstockbal>
        <cfelseif getgeneral.cost eq "MONTH">
        <cfset check0varible=val(getmonthcostamt.cost)>
        <cfelse>
        <cfset check0varible=val(getitem.ucost)>
        </cfif>
        
            <cfif isdefined("form.include0")>
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#runno#.</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.aitemno#</font></div></td>
                </cfif>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
                <cfif lcase(hcomid) eq "mphcranes_i">
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.despa#</font></div></td>
				</cfif>
				<cfif lcase(hcomid) eq "hyray_i">
            	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
            	</cfif>
				<cfif getpin2.h42A0 eq 'T'>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.ucost),stDecl_UPrice)#</font></div></td>
					</cfcase>
                    <cfcase value="MONTH">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getmonthcostamt.cost),stDecl_UPrice)#</font></div></td>
					</cfcase>
					<cfcase value="WEIGHT">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.unitcost),stDecl_UPrice)#</font></div></td>
					</cfcase>
                     <cfcase value="MOVING">
                           <cfif getpin2.h42A0 eq 'T'>
                   <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(movingunitcost),stDecl_UPrice)#</font></div></td>
                 
                   </cfif>
                   </cfcase>
				</cfswitch>
                </cfif>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</font></div></td>

				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(qin)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(qout)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(balance)#</font></div></td>
                <cfif getpin2.h42A0 eq 'T'>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">
				<cfif getgeneral.cost eq "MOVING">#numberformat(val(movingstockbal),stDecl_UPrice)#
                <cfelseif getgeneral.cost eq "MONTH">#numberformat(val(getmonthcostamt.cost)*val(balance),stDecl_UPrice)#
                
                <cfelse><cfif lcase(hcomid) eq "meisei_i" or lcase(hcomid) eq "elm_i" >#numberformat(val(stockbalance),stDecl_UPrice)#<cfelse>
				<cfif getgeneral.cost eq "WEIGHT" and val(balance) lt 0>
                <cfif val(stockbalance) lt 0>
                <!--- <cfset getitem.stockbalance = abs(stockbalance)> --->
                
                <cfelseif (form.periodfrom neq "" and form.periodto neq "") or (form.datefrom neq "" and form.dateto neq "")>
                
                <cfquery name="getnextstockin" datasource="#dts#">
                SELECT wos_date,if(type = "CN",it_cos,amt) as totalcost,qty FROM ictran WHERE 
                (type = "RC" or type = "CN" or type = "OAI")
                and qty > 0
                <cfif form.periodfrom neq "" and form.periodto neq "" and form.datefrom eq "" and form.dateto eq "">
					and fperiod+0 > '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date > '#ndateto#' 
				</cfif>
                and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#"> 
                order by wos_date
                </cfquery>
                
				<cfif getnextstockin.recordcount neq 0>
                <cfif abs(val(balance)) eq val(getnextstockin.qty)>
                <cfset getitem.stockbalance = getnextstockin.totalcost * -1>
                <cfelse>
                <cfset getitem.stockbalance = val(getnextstockin.totalcost)/val(getnextstockin.qty) * abs(val(balance)) * -1>
                </cfif>
                </cfif>
                
				</cfif>
				</cfif>
                #numberformat(val(stockbalance),stDecl_UPrice)#
				
				</cfif></cfif></font></div></td>
                </cfif>
			</tr>
            <cfset runno=runno+1>
            <cfif getgeneral.cost eq "MOVING">
            <cfset grandstkval = grandstkval + numberformat(val(movingstockbal),'.__')>
            <cfelse>
			<cfset grandstkval = grandstkval + val(stockbalance)>
            </cfif>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + val(getitem.qin)>
            <cfset grandqtyout = grandqtyout + val(getitem.qout)>
            <cfset grandqty = grandqty + val(getitem.balance)>
            
            <cfelse>
            <cfif check0varible neq 0>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#runno#.</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.aitemno#</font></div></td>
                </cfif>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
                <cfif lcase(hcomid) eq "mphcranes_i">
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.despa#</font></div></td>
				</cfif>
				<cfif lcase(hcomid) eq "hyray_i">
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
            </cfif>
            	<cfif getpin2.h42A0 eq 'T'>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.ucost),stDecl_UPrice)#</font></div></td>
					</cfcase>
                    <cfcase value="MONTH">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getmonthcostamt.cost),stDecl_UPrice)#</font></div></td>
					</cfcase>
					<cfcase value="WEIGHT">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.unitcost),stDecl_UPrice)#</font></div></td>
					</cfcase>
                     <cfcase value="MOVING">
                           <cfif getpin2.h42A0 eq 'T'>
                   <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(movingunitcost),stDecl_UPrice)#</font></div></td>
                 
                   </cfif>
                   </cfcase>
				</cfswitch>
                </cfif>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</font></div></td>

				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(qin)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(qout)#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(balance)#</font></div></td>
                
                
                <cfif getpin2.h42A0 eq 'T'>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">
				<cfif getgeneral.cost eq "MOVING">#numberformat(val(movingstockbal),stDecl_UPrice)#
                <cfelseif getgeneral.cost eq "MONTH">#numberformat(val(getmonthcostamt.cost)*val(balance),stDecl_UPrice)#
                
                <cfelse><cfif lcase(hcomid) eq "meisei_i" or lcase(hcomid) eq "elm_i" >#numberformat(val(stockbalance),stDecl_UPrice)#<cfelse>
				<cfif getgeneral.cost eq "WEIGHT" and val(balance) lt 0>
                <cfif val(stockbalance) lt 0>
                <!--- <cfset getitem.stockbalance = abs(stockbalance)> --->
                
                <cfelseif (form.periodfrom neq "" and form.periodto neq "") or (form.datefrom neq "" and form.dateto neq "")>
                
                <cfquery name="getnextstockin" datasource="#dts#">
                SELECT wos_date,if(type = "CN",it_cos,amt) as totalcost,qty FROM ictran WHERE 
                (type = "RC" or type = "CN" or type = "OAI")
                and qty > 0
                <cfif form.periodfrom neq "" and form.periodto neq "" and form.datefrom eq "" and form.dateto eq "">
					and fperiod+0 > '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date > '#ndateto#' 
				</cfif>
                and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#"> 
                order by wos_date
                </cfquery>
                
				<cfif getnextstockin.recordcount neq 0>
                <cfif abs(val(balance)) eq val(getnextstockin.qty)>
                <cfset getitem.stockbalance = getnextstockin.totalcost * -1>
                <cfelse>
                <cfset getitem.stockbalance = val(getnextstockin.totalcost)/val(getnextstockin.qty) * abs(val(balance)) * -1>
                </cfif>
                </cfif>
                
				</cfif>
				</cfif>
                #numberformat(val(stockbalance),stDecl_UPrice)#
				
				</cfif></cfif></font></div></td>
                </cfif>
			</tr>
			<cfset runno=runno+1>
            <cfif getgeneral.cost eq "MOVING">
            <cfset grandstkval = grandstkval + numberformat(val(movingstockbal),'.__')>
            <cfelse>
			<cfset grandstkval = grandstkval + val(stockbalance)>
            </cfif>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + val(getitem.qin)>
            <cfset grandqtyout = grandqtyout + val(getitem.qout)>
            <cfset grandqty = grandqty + val(getitem.balance)>
            </cfif>
            </cfif>
            
            
        
            <!---<cfif huserid eq 'ultralung'>
            <cfquery name="updatemvage" datasource="#dts#">
            update icitem set avcost2='#val(movingunitcost)#' where itemno='#getitem.itemno#'
            </cfquery>
            </cfif>---> 
           
  		</cfoutput>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
        
		<tr>
			<td>&nbsp;</td>
            <cfif getpin2.h42A0 eq 'T'>
            <td>&nbsp;</td>
            </cfif>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td>&nbsp;</td>
            </cfif>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqtyout#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqty#</cfoutput></font></div></td>
            <cfif getpin2.h42A0 eq 'T'>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
            </cfif>
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
			and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and category between '#form.categoryfrom#' and '#form.categoryto#'
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
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">#getgeneral.lCATEGORY#: #form.categoryfrom# - #form.categoryto#</font></div></td>
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
		<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
        <cfif lcase(hcomid) eq "hyray_i">
        <cfquery name="getsuppliername" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierfrom#'
        </cfquery>
        <cfquery name="getsuppliername1" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierto#'
        </cfquery>
        </cfif>
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif"><cfif lcase(hcomid) eq "hyray_i">Supplier: #getsuppliername.name# - #getsuppliername1.name#<cfelse>Supplier: #form.supplierfrom# - #form.supplierto#</cfif></font></div></td>
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
      		<td colspan="100%"><hr></td>
    	</tr>
    	<tr>
      		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT CODE</font></div></td>
            </cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
             <cfif lcase(hcomid) eq "mphcranes_i">
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Description 2</font></div></td>
            </cfif>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
            <cfif getpin2.h42A0 eq 'T'>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">LAST COST</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td></cfif>
    	</tr>
        
    	<tr>
      		<td colspan="100%"><hr></td>
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'   
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
	      			select qty, amt<cfif isdefined('form.misccost')>+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7</cfif> as amt, amt_bil, <cfif isdefined('form.misccost')>(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty<cfelse>price</cfif> as price, price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					 
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
	    			</cfif> 
                    and (linecode <> 'SV' or linecode is null)
	      			order by trdatetime desc
	      		</cfquery>
			<cfelse>
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt<cfif isdefined('form.misccost')>+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7</cfif> as amt, amt_bil, <cfif isdefined('form.misccost')>(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty<cfelse>price</cfif> as price, price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    </cfif>
                    and (linecode <> 'SV' or linecode is null)
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
							and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
							and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
								and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
						and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
                            
								<cfif getgeneral.fifocal eq "1">
									<cfset stkval = minusqty * getrc.price>
                                <cfelse>
									<cfset stkval = minusqty * getrc.amt/getrc.qty>
                                </cfif>
                            
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
      		<td colspan="100%"><hr></td>
    	</tr>
    	<tr>
      		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT CODE</font></div></td>
            </cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
            <cfif lcase(hcomid) eq "mphcranes_i">
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Description 2</font></div></td>
            </cfif>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
            <cfif getpin2.h42A0 eq 'T'>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">LAST COST</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td></cfif>
    	</tr>
        
    	<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
        </cfif>
        </cfif>
        
        	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#aitemno#</font></div></td>
                </cfif>
          		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
                <cfif lcase(hcomid) eq "mphcranes_i">
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.despa#</font></div></td>
				</cfif>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#unit#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtybf#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#innowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttoutnowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balnowqty#</font></div></td><cfif getpin2.h42A0 eq 'T'>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(lastcost,stDecl_UPrice)#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,",_.__")#</font></div></td></cfif>
        	</tr>
			<cfset grandstkval = grandstkval + numberformat(val(totalstkval),'.__')>         
            <cfset grandqtybf =grandqtybf+val(qtybf)>
            <cfset grandqtyin = grandqtyin + val(innowqty)>
            <cfset grandqtyout = grandqtyout + val(ttoutnowqty)>
            <cfset grandqty = grandqty + val(balnowqty)>
      	</cfoutput>
    </cfloop>
	
		<tr>
			<td colspan="100%"><hr></td>
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
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td>&nbsp;</td>
            </cfif>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqtyout#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqty#</cfoutput></font></div></td>
			<td>&nbsp;</td><cfif getpin2.h42A0 eq 'T'>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td></cfif>
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

<cfcase value="EXCEL">

<cfset currentDirectory = GetDirectoryFromPath(GetTemplatePath()) & "..\..\Excel_Report\"&dts&"\">
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = "">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "0">
		</cfloop>
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
		   			<!---<NumberFormat ss:Format="#,###,###,##0"/>--->
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
					<cfset c="11">
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
		where LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
    <cfcase value="WEIGHT">
		<cfset costingmethod = "Weight Average Method">
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
	<cfset stDecl_UPrice = ".">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ".">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ".">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ".">
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
<cfif getgeneral.cost neq "LIFO">
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">	
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING,WEIGHT">
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) as unitcost,
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem_last_year as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
                <cfif form.datefrom eq "" and form.dateto eq "">
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
                <cfelse>
                	and operiod < '' 
				</cfif> 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)  and (toinv='' or toinv is null) 
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
                <cfif form.datefrom eq "" and form.dateto eq "">
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
                <cfelse>
                	and operiod < '' 
				</cfif>
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null) 
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
				select sum(qty) as rcqty,<cfif getgeneral.cost eq "weight">sum(if(type = "CN",it_cos,amt))<cfelse>sum(amt)</cfif> as rcamt,itemno 
				from ictran
				where <cfif getgeneral.cost eq "weight">(type='RC' or type = "CN" or type = "OAI")<cfelse>type='RC'</cfif> and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
			<!---
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
		     		and wos_date <= '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#' 
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
		     		and wos_date <= '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					group by itemno
				) as cc on aa.itemno=cc.itemno
				
				where aa.LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
				<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
					and aa.supp between '#form.supplierfrom#' and '#form.supplierto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and aa.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno--->
	
			where a.itemno <> ''
			and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >0
					</cfcase>
					
					<cfcase value="WEIGHT">
					and ((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
				and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) >0
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			and (a.itemtype <> "SV" or a.itemtype is null) 
			order by a.itemno
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING,WEIGHT">
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) as unitcost,
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as stockbalance
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
                <cfelse>
                	and fperiod < '' 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
                <cfelse>
                	and fperiod < '' 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
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
				select sum(qty) as rcqty,<cfif getgeneral.cost eq "weight">sum(if(type = "CN",it_cos,amt))<cfelse>sum(amt)</cfif> as rcamt,itemno 
				from ictran
				where <cfif getgeneral.cost eq "weight">(type='RC' or type = "CN" or type = "OAI")<cfelse>type='RC'</cfif> and (void = '' or void is null)
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
			<!---
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
	
				<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
					and aa.supp between '#form.supplierfrom#' and '#form.supplierto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and aa.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno--->
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="WEIGHT">
					and ((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) >0
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
			and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            and (a.itemtype <> "SV" or a.itemtype is null) 
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
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
             <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY#: #form.categoryfrom# - #form.categoryto#" output = "wddxText">
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
		<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
        <cfif lcase(hcomid) eq "hyray_i">
        <cfquery name="getsuppliername" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierfrom#'
        </cfquery>
        <cfquery name="getsuppliername1" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierto#'
        </cfquery>
        </cfif>

            <cfwddx action = "cfml2wddx" input = "Supplier: #form.supplierfrom# - #form.supplierto#" output = "wddxText">

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
        
        <cfif datefrom neq "" and dateto neq "">
        <cfwddx action = "cfml2wddx" input = "Date From #datefrom# To #dateto#" output = "wddxText">
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
		    if(a.taxincl="T" || b.taxincl="T",a.amt-taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b

			where a.itemno='#getitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and 
             <cfif isdefined('form.dodate')>
                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (select useddo from dolink))))
                <cfelse>
                a.type not in ('QUO','SO','PO','SAM')
                and (a.toinv='' or a.toinv is null) 
			</cfif>
			and a.fperiod='99'
			and a.wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
			and a.wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by b.wos_date,b.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			if(a.taxincl="T" || b.taxincl="T",a.amt-taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#getitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and 
            
            <cfif isdefined('form.dodate')>
                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (select useddo from dolink))))
                <cfelse>
                a.type not in ('QUO','SO','PO','SAM')
                and (a.toinv='' or a.toinv is null) 
			</cfif>

			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by b.wos_date,b.trdatetime
		</cfquery>
		</cfif>

        <cfloop query="getmovingictran">
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
                    
        
	    <cfset movingbal=movingbal-getmovingictran.qty>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        <!---
        <cfif huserid eq 'ultralung'>
        <cfoutput>
        #movingunitcost#
        #movingbal#
        #refno#
        <br>
        </cfoutput>
        </cfif>--->
        
        </cfloop>
        
		<cfset movingstockbal=movingbal*movingunitcost>
        
        </cfif>
        <!---New Month Calculation--->
        
        <cfif getgeneral.cost eq "MONTH">
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        <cfquery name="getmonthcostamt" datasource="#dts#">
        select cost<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as cost,amt<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as amt
        from monthcost_last_year where itemno='#itemno#'
        </cfquery>
        <cfelse>
        <cfquery name="getmonthcostamt" datasource="#dts#">
        select cost<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as cost,amt<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as amt
        from monthcost where itemno='#itemno#'
        </cfquery>
        </cfif>
        </cfif>
        
        <!---New fifo calculate--->
        <cfif getgeneral.cost eq "FIFO" and getitem.balance gt 0>
        
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getlastrc" datasource="#dts#">
			select 
            if(a.type = "CN",a.it_cos,
		    <cfif isdefined('form.discounted')>if(a.taxincl="T",a.amt-taxamt,a.amt)<cfelse>a.amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7</cfif>) as amt,a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,(<cfif isdefined('form.discounted')>amt<cfelse>amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7<cfelse></cfif>)/qty) as price,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a
			where a.itemno='#getitem.itemno#' 
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type in ('RC','OAI'<cfif getgeneral.costingcn eq 'Y'>,'CN'</cfif>)
			and a.fperiod='99'
			and a.wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
			and a.wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by a.wos_date desc,a.trdatetime desc
			</cfquery>
            <cfelse>
            <cfquery name="getlastrc" datasource="#dts#">
			select 
            if(a.type = "CN",a.it_cos,
		    <cfif isdefined('form.discounted')>if(a.taxincl="T",a.amt-taxamt,a.amt)<cfelse>a.amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7</cfif>) as amt,a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,(<cfif isdefined('form.discounted')>amt<cfelse>amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7<cfelse></cfif>)/qty) as price,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a
            
			where a.itemno='#getitem.itemno#' 
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type in ('RC','OAI'<cfif getgeneral.costingcn eq 'Y'>,'CN'</cfif>)
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date desc,a.trdatetime desc
		</cfquery>
		</cfif>
        
        <cfset fifobalance=getitem.balance>
        <cfset fifostkvalue=0>
        
        <!---getfrombill--->
        <cfloop query="getlastrc">
        <cfif fifobalance gt 0>
        <cfif fifobalance gte getlastrc.qty>
        <cfset fifostkvalue = fifostkvalue+val(getlastrc.amt)>
        <cfset fifobalance= val(fifobalance)-val(getlastrc.qty)>
        <cfelse>
        <cfset fifostkvalue = fifostkvalue+(val(getlastrc.price)*val(fifobalance))>
        <cfset fifobalance= val(fifobalance)-val(getlastrc.qty)>
		</cfif>
        </cfif>
        </cfloop>
        <!---end getfrombill--->
        
        <cfif fifobalance gt 0>
        	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        	<cfquery name="getfifocost" datasource="#dts#">
        	select * from fifoopq_last_year where
            LastAccDate ='#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#' and itemno="#getitem.itemno#"
            </cfquery>
            <cfelse>
            <cfquery name="getfifocost" datasource="#dts#">
        	select * from fifoopq where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#"> 
            </cfquery>
            </cfif>
            <cfset lastfifocost=0>
            <cfloop from="11" to="50" index="z">
            <cfif fifobalance gt 0>
			<cfif fifobalance gte val(evaluate('getfifocost.ffq#z#'))>
            <cfset fifostkvalue = fifostkvalue+(val(evaluate('getfifocost.ffc#z#'))*val(evaluate('getfifocost.ffq#z#')))>
            <cfset fifobalance= fifobalance-val(evaluate('getfifocost.ffq#z#'))>
            <cfelse>
            <cfset fifostkvalue = fifostkvalue+(val(evaluate('getfifocost.ffc#z#'))*val(fifobalance))>
            <cfset fifobalance= fifobalance-val(evaluate('getfifocost.ffq#z#'))>
            </cfif>
            <cfif val(evaluate('getfifocost.ffc#z#')) gt 0>
            <cfset lastfifocost=val(evaluate('getfifocost.ffc#z#'))>
            </cfif>
            </cfif>
            </cfloop>
            
            <cfif fifobalance gt 0>
            <cfset fifostkvalue = fifostkvalue+(lastfifocost*val(fifobalance))>
            <cfset fifobalance= 0>
            </cfif>
            
        </cfif>
        
        
        <cfset getitem.stockbalance=val(fifostkvalue)>
        <cfset getitem.ucost=val(fifostkvalue)/val(getitem.balance)>
        
        
        </cfif>
        <!---End new fifo calculate--->
        
        
        <cfif getgeneral.cost eq "MOVING">
        <cfset check0varible=movingstockbal>
        <cfelseif getgeneral.cost eq "MONTH">
        <cfset check0varible=val(getmonthcostamt.cost)>
        <cfelse>
        <cfset check0varible=val(getitem.ucost)>
        </cfif>
        
            <cfif isdefined("form.include0")>
            
            <cfwddx action = "cfml2wddx" input = "#runno#." output = "wddxText">
          	<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
           	<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
            <cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText3">
            <cfwddx action = "cfml2wddx" input = "#getitem.despa#" output = "wddxText4">
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
			<cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText5">
            </cfif>
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
			
                        
                        <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO">
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
                    <cfcase value="WEIGHT">
                           <cfif getpin2.h42A0 eq 'T'>
                   <Cell ss:StyleID="s33"><Data ss:Type="Number">#getitem.unitcost#</Data></Cell>
						</cfif>
                    </cfcase>
                    </cfswitch>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</Data></Cell>
                        <Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qin)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qout)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.balance)#</Data></Cell>
                        <cfif getpin2.h42A0 eq 'T'>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number"><cfif getgeneral.cost eq "MOVING">#val(movingstockbal)#<cfelseif getgeneral.cost eq "MONTH">#val(getmonthcostamt.cost)*val(balance)#<cfelse>#val(stockbalance)#</cfif></Data></Cell>
                    <cfelse>
                    <Cell ss:StyleID="s33"><Data ss:Type="Number"></Data></Cell>
                    </cfif>
					</Row>
            <cfset runno=runno+1>
            <cfif getgeneral.cost eq "MOVING">
            <cfset grandstkval = grandstkval + numberformat(val(movingstockbal),'.__')>
            <cfelse>
			<cfset grandstkval = grandstkval + val(stockbalance)>
            </cfif>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + val(getitem.qin)>
            <cfset grandqtyout = grandqtyout + val(getitem.qout)>
            <cfset grandqty = grandqty + val(getitem.balance)>
            
            <cfelse>
            <cfif check0varible neq 0>
			
            <cfwddx action = "cfml2wddx" input = "#runno#." output = "wddxText">
          	<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
           	<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
            <cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText3">
            <cfwddx action = "cfml2wddx" input = "#getitem.despa#" output = "wddxText4">
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
			<cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText5">
            </cfif>
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
			
                        
                        <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO">
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
                    <cfcase value="WEIGHT">
                           <cfif getpin2.h42A0 eq 'T'>
                   <Cell ss:StyleID="s33"><Data ss:Type="Number">#getitem.unitcost#</Data></Cell>
						</cfif>
                    </cfcase>
                    </cfswitch>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#</Data></Cell>
                        <Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qin)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qout)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.balance)#</Data></Cell>
                        <cfif getpin2.h42A0 eq 'T'>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number"><cfif getgeneral.cost eq "MOVING">#val(movingstockbal)#<cfelseif getgeneral.cost eq "MONTH">#val(getmonthcostamt.cost)*val(balance)#<cfelse>#val(stockbalance)#</cfif></Data></Cell>
                    <cfelse>
                    <Cell ss:StyleID="s33"><Data ss:Type="Number"></Data></Cell>
                    </cfif>
					</Row>
            <cfset runno=runno+1>
            <cfif getgeneral.cost eq "MOVING">
            <cfset grandstkval = grandstkval + numberformat(val(movingstockbal),'.__')>
            <cfelse>
			<cfset grandstkval = grandstkval + val(stockbalance)>
            </cfif>
            <cfset grandqtybf =grandqtybf+val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)>
            <cfset grandqtyin = grandqtyin + val(getitem.qin)>
            <cfset grandqtyout = grandqtyout + val(getitem.qout)>
            <cfset grandqty = grandqty + val(getitem.balance)>
            
            </cfif>
            </cfif>
		</cfloop>

		<Row ss:AutoFitHeight="0" ss:Height="12">
					<cfif lcase(hcomid) eq "hyray_i">
					<Cell ss:Index="6" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <Cell ss:Index="5" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                    <cfelse>
                    <Cell ss:Index="4" ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
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

<!-- LIFO Costing Method -->
<cfelseif getgeneral.cost eq "LIFO">
	<cfset stkvalff=0>
	<cfquery name="getitem" datasource="#dts#">
		select itemno,aitemno,desp,despa,unit,qtybf 
		from <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">icitem_last_year<cfelse>icitem</cfif> 
		where itemno <> ''
		<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
			and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and category between '#form.categoryfrom#' and '#form.categoryto#'
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
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
             <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY#: #form.categoryfrom# - #form.categoryto#" output = "wddxText">
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
		<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
        <cfif lcase(hcomid) eq "hyray_i">
        <cfquery name="getsuppliername" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierfrom#'
        </cfquery>
        <cfquery name="getsuppliername1" datasource="#dts#">
        select name from #target_apvend# where custno='#form.supplierto#'
        </cfquery>
        </cfif>

            <cfwddx action = "cfml2wddx" input = "Supplier: #form.supplierfrom# - #form.supplierto#" output = "wddxText">

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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'   
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
	      			select qty, amt<cfif isdefined('form.misccost')>+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7</cfif> as amt, amt_bil, <cfif isdefined('form.misccost')>(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty<cfelse>price</cfif> as price, price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'   
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    			</cfif> 
                    and (linecode <> 'SV' or linecode is null)
	      			order by trdatetime desc
	      		</cfquery>
			<cfelse>
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt<cfif isdefined('form.misccost')>+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7</cfif> as amt, amt_bil, <cfif isdefined('form.misccost')>(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty<cfelse>price</cfif> as price, price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    			</cfif> 
                    and (linecode <> 'SV' or linecode is null)
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
							and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
							and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
								and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
						and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
                            
								<cfif getgeneral.fifocal eq "1">
									<cfset stkval = minusqty * getrc.price>
                                <cfelse>
									<cfset stkval = minusqty * getrc.amt/getrc.qty>
                                </cfif>
                            
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
        
            <cfwddx action = "cfml2wddx" input = "#runno#." output = "wddxText">
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
				
                        
                        
						  <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO">
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
                        <Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qin)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.qout)#</Data></Cell>
						<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(getitem.balance)#</Data></Cell>
                             
                        
                        <cfif getpin2.h42A0 eq 'T'>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number"><cfif getgeneral.cost eq "MOVING">#numberformat(val(movingstockbal),stDecl_UPrice)#<cfelse>#numberformat(val(getitem.stockbalance),stDecl_UPrice)#</cfif></Data></Cell>
<cfelse>
<Cell ss:StyleID="s33"><Data ss:Type="Number"></Data></Cell>
</cfif>

					
					</Row>
                    <cfset runno=runno+1>
            <cfif getgeneral.cost eq "MOVING">
            <cfset grandstkval = grandstkval + numberformat(val(movingstockbal),stDecl_UPrice)>
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
		<cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
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
		where LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
    <cfcase value="WEIGHT">
		<cfset costingmethod = "WEIGHT Average Method">
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
	<cfset stDecl_UPrice = ".">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ".">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ".">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ".">
</cfif>


<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfloop index="LoopCount" from="1" to="#iDecl_TPrice#">
  	<cfset stDecl_TPrice = stDecl_TPrice & "_">
</cfloop>

<cfif getgeneral.cost neq "LIFO">
	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">	
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING,WEIGHT">
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) as unitcost,
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem_last_year as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
                <cfif form.datefrom eq "" and form.dateto eq "">
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
                <cfelse>
                	and operiod < '' 
				</cfif> 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)  and (toinv='' or toinv is null) 
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
                <cfif form.datefrom eq "" and form.dateto eq "">
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 < '#form.periodfrom#'
                <cfelse>
                	and operiod < '' 
				</cfif>
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null) 
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
				select sum(qty) as rcqty,<cfif getgeneral.cost eq "weight">sum(if(type = "CN",it_cos,amt))<cfelse>sum(amt)</cfif> as rcamt,itemno 
				from ictran
				where <cfif getgeneral.cost eq "weight">(type='RC' or type = "CN" or type = "OAI")<cfelse>type='RC'</cfif> and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
	      		and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and operiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
			) as i on a.itemno=i.itemno
			<!---
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
		     		and wos_date <= '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#' 
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
		     		and wos_date <= '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					group by itemno
				) as cc on aa.itemno=cc.itemno
				
				where aa.LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
				<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
					and aa.supp between '#form.supplierfrom#' and '#form.supplierto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and aa.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno--->
	
			where a.itemno <> ''
			and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >0
					</cfcase>
					<cfcase value="WEIGHT">
					and ((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
				and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) >0
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
 				and (a.itemtype <> "SV" or a.itemtype is null) 
			order by a.itemno
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.aitemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING,WEIGHT">
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) as unitcost,
				((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as stockbalance
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
                <cfelse>
                	and fperiod < '' 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
                <cfelse>
                	and fperiod < '' 
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
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
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
				select sum(qty) as rcqty,<cfif getgeneral.cost eq "weight">sum(if(type = "CN",it_cos,amt))<cfelse>sum(amt)</cfif> as rcamt,itemno 
				from ictran
				where <cfif getgeneral.cost eq "weight">(type='RC' or type = "CN" or type = "OAI")<cfelse>type='RC'</cfif> and (void = '' or void is null)
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
			<!---
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
	
				<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
					and aa.supp between '#form.supplierfrom#' and '#form.supplierto#'
				</cfif>
				<cfif form.brandfrom neq "" and form.brandto neq "">
					and aa.brand between '#form.brandfrom#' and '#form.brandto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and aa.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and aa.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno--->
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="WEIGHT">
					and ((ifnull(a.avcost2,0)*(ifnull(a.qtybf,0)) + (ifnull(f.rcamt,0)-ifnull(g.pramt,0))) / (ifnull(a.qtybf,0)+ifnull(b.lastin,0)+ifnull(d.qin,0))) * ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) >0
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
			and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			<cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            and (a.itemtype <> "SV" or a.itemtype is null) 
			order by a.itemno;
		</cfquery>
	</cfif>
	
      
    
        <cfset pagebreak = 0>
    	<cfset rowlimit = 40>
  		<cfoutput query="getitem">
        
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
		    if(a.taxincl="T" || b.taxincl="T",a.amt-taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b

			where a.itemno='#getitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and 
             <cfif isdefined('form.dodate')>
                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (select useddo from dolink))))
                <cfelse>
                a.type not in ('QUO','SO','PO','SAM')
                and (a.toinv='' or a.toinv is null) 
			</cfif>
			and a.fperiod='99'
			and a.wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
			and a.wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by b.wos_date,b.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			if(a.taxincl="T" || b.taxincl="T",a.amt-taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#getitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and
             <cfif isdefined('form.dodate')>
                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (select useddo from dolink))))
                <cfelse>
                a.type not in ('QUO','SO','PO','SAM')
                and (a.toinv='' or a.toinv is null) 
			</cfif>
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by b.wos_date,b.trdatetime
		</cfquery>
		</cfif>
        
        <cfloop query="getmovingictran">
       
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
                    
        
	    <cfset movingbal=movingbal-getmovingictran.qty>

        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        <!---
        <cfif huserid eq 'ultralung'>
        <cfoutput>
        #movingunitcost#
        #movingbal#
        #refno#
        <br>
        </cfoutput>
        </cfif>--->
        
        </cfloop>
        
		<cfset movingstockbal=movingbal*movingunitcost>
        
        </cfif>
            <!--- --->
            
        <cfif getgeneral.cost eq "MONTH">
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        <cfquery name="getmonthcostamt" datasource="#dts#">
        select cost<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as cost,amt<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as amt
        from monthcost_last_year where itemno='#itemno#'
        </cfquery>
        <cfelse>
        <cfquery name="getmonthcostamt" datasource="#dts#">
        select cost<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as cost,amt<cfif form.periodto neq '' and form.periodfrom neq ''>#numberformat(form.periodto,0)#<cfelse>18</cfif> as amt
        from monthcost where itemno='#itemno#'
        </cfquery>
        </cfif>
        </cfif>
        
        <!---New fifo calculate--->
        <cfif getgeneral.cost eq "FIFO" and getitem.balance gt 0>
        
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getlastrc" datasource="#dts#">
			select 
            if(a.type = "CN",a.it_cos,
		    <cfif isdefined('form.discounted')>if(a.taxincl="T",a.amt-taxamt,a.amt)<cfelse>a.amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7</cfif>) as amt,a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,(<cfif isdefined('form.discounted')>amt<cfelse>amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7<cfelse></cfif>)/qty) as price,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a
			where a.itemno='#getitem.itemno#' 
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type in ('RC','OAI'<cfif getgeneral.costingcn eq 'Y'>,'CN'</cfif>)
			and a.fperiod='99'
			and a.wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
			and a.wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by a.wos_date desc,a.trdatetime desc
			</cfquery>
            <cfelse>
            <cfquery name="getlastrc" datasource="#dts#">
			select 
            if(a.type = "CN",a.it_cos,
		    <cfif isdefined('form.discounted')>if(a.taxincl="T",a.amt-taxamt,a.amt)<cfelse>a.amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7</cfif>) as amt,a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,(<cfif isdefined('form.discounted')>amt<cfelse>amt1</cfif><cfif isdefined('form.misccost')>+a.M_charge1+a.M_charge2+a.M_charge3+a.M_charge4+a.M_charge5+a.M_charge6+a.M_charge7<cfelse></cfif>)/qty) as price,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a
            
			where a.itemno='#getitem.itemno#' 
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type in ('RC','OAI'<cfif getgeneral.costingcn eq 'Y'>,'CN'</cfif>)
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date desc,a.trdatetime desc
		</cfquery>
		</cfif>
        
        <cfset fifobalance=getitem.balance>
        <cfset fifostkvalue=0>
        
        <!---getfrombill--->
        <cfloop query="getlastrc">
        <cfif fifobalance gt 0>
        <cfif fifobalance gte getlastrc.qty>
        <cfset fifostkvalue = fifostkvalue+val(getlastrc.amt)>
        <cfset fifobalance= val(fifobalance)-val(getlastrc.qty)>
        <cfelse>
        <cfset fifostkvalue = fifostkvalue+(val(getlastrc.price)*val(fifobalance))>
        <cfset fifobalance= val(fifobalance)-val(getlastrc.qty)>
		</cfif>
        </cfif>
        </cfloop>
        <!---end getfrombill--->
        
        <cfif fifobalance gt 0>
        	<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        	<cfquery name="getfifocost" datasource="#dts#">
        	select * from fifoopq_last_year where
            LastAccDate ='#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#' and itemno="#getitem.itemno#"
            </cfquery>
            <cfelse>
            <cfquery name="getfifocost" datasource="#dts#">
        	select * from fifoopq where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#"> 
            </cfquery>
            </cfif>
            
            <cfset lastfifocost=0>
            <cfloop from="11" to="50" index="z">
            <cfif fifobalance gt 0>
			<cfif fifobalance gte val(evaluate('getfifocost.ffq#z#'))>
            <cfset fifostkvalue = fifostkvalue+(val(evaluate('getfifocost.ffc#z#'))*val(evaluate('getfifocost.ffq#z#')))>
            <cfset fifobalance= fifobalance-val(evaluate('getfifocost.ffq#z#'))>
            <cfelse>
            <cfset fifostkvalue = fifostkvalue+(val(evaluate('getfifocost.ffc#z#'))*val(fifobalance))>
            <cfset fifobalance= fifobalance-val(evaluate('getfifocost.ffq#z#'))>
            </cfif>
            <cfif val(evaluate('getfifocost.ffc#z#')) gt 0>
            <cfset lastfifocost=val(evaluate('getfifocost.ffc#z#'))>
            </cfif>
            </cfif>
            </cfloop>
            
            <cfif fifobalance gt 0>
            <cfset fifostkvalue = fifostkvalue+(lastfifocost*val(fifobalance))>
            <cfset fifobalance= 0>
            </cfif>
            
        </cfif>
        
        
        <cfset getitem.stockbalance=val(fifostkvalue)>
        <cfset getitem.ucost=val(fifostkvalue)/val(getitem.balance)>
        
        
        </cfif>
        <!---End new fifo calculate--->
            
        
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
					<cfcase value="FIXED,WEIGHT">
                        <cfset xucost=val(getitem.ucost)>
					</cfcase>
                    <cfcase value="MONTH" delimiters=",">
					<cfset xucost=val(getmonthcostamt.cost)>
					</cfcase>
					<cfcase value="MOVING" delimiters=",">
					<cfset xucost=val(movingunitcost)>
					</cfcase>
				</cfswitch>
                <cfelse>
                <cfset xucost=''>
                </cfif>
                <cfif getpin2.h42A0 eq 'T'>
                <cfif getgeneral.cost eq "MOVING">
           		<cfset xstockbalance = numberformat(val(movingstockbal),stDecl_UPrice)>
                <cfelseif getgeneral.cost eq "MONTH">
           		<cfset xstockbalance = numberformat(val(getmonthcostamt.cost),stDecl_UPrice)>
            	<cfelse>
				<cfset xstockbalance=val(stockbalance)>
                </cfif>
                <cfelse>
                <cfset xstockbalance=''>
                </cfif>
                
                <cfif getgeneral.cost eq "MOVING">
				<cfset check0varible=movingstockbal>
                <cfelseif getgeneral.cost eq "MONTH">
                <cfset check0varible=val(getmonthcostamt.cost)>
                <cfelse>
                <cfset check0varible=val(getitem.ucost)>
                </cfif>
        	
            	<cfif isdefined("form.include0")>
                    <cfquery name="insertcolumn" datasource="#dts#">
                    insert into itemstatustemp (itemno,aitemno,desp,despa,unit,cost,qtybf,qin,qout,balance,stockvalue) values ('#getitem.itemno#','#getitem.aitemno#','#getitem.desp#','#getitem.despa#','#getitem.unit#','#xucost#','#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#','#val(qin)#','#val(qout)#','#val(balance)#','#val(xstockbalance)#')
                    </cfquery> 
                <cfelse>
                	<cfif check0varible neq 0>
                	<cfquery name="insertcolumn" datasource="#dts#">
                    insert into itemstatustemp (itemno,aitemno,desp,despa,unit,cost,qtybf,qin,qout,balance,stockvalue) values ('#getitem.itemno#','#getitem.aitemno#','#getitem.desp#','#getitem.despa#','#getitem.unit#','#xucost#','#val(getitem.qtybf)+val(getitem.lastin)-val(getitem.lastout)#','#val(qin)#','#val(qout)#','#val(balance)#','#val(xstockbalance)#')
                    </cfquery> 
                	</cfif>
                </cfif>
</cfoutput>
<cfquery name="MyQuery" datasource="#dts#">
select * from itemstatustemp
</cfquery>
<cfreport template="itemstatus.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getgeneral.compro#">
   
	<cfreportparam name="brandfrom" value="#form.brandfrom#">
    <cfreportparam name="brandto" value="#form.brandto#">
    
    <cfreportparam name="catefrom" value="#form.categoryfrom#">
    <cfreportparam name="cateto" value="#form.categoryto#">
    
    <cfreportparam name="groupfrom" value="#form.groupfrom#">
    <cfreportparam name="groupto" value="#form.groupto#">
    
    <cfreportparam name="productfrom" value="#form.productfrom#">
    <cfreportparam name="productto" value="#form.productto#">
    
    <cfreportparam name="suppfrom" value="#form.supplierfrom#">
    <cfreportparam name="suppto" value="#form.supplierto#">
    <cfreportparam name="calcu" value="Calculated by #costingmethod#">
    
    
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
			and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and category between '#form.categoryfrom#' and '#form.categoryto#'
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#' 
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
						and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
						and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
				  	</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
			  		<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#' 
			  		</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
						and operiod+0 <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
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
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'   
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
	      			select qty, amt<cfif isdefined('form.misccost')>+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7</cfif> as amt, amt_bil, <cfif isdefined('form.misccost')>(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty<cfelse>price</cfif> as price, price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
					and wos_date > '#DateFormat(getdate.LastAccDate,"yyyy-mm-dd")#'
					 
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and operiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    <cfelse>
                    and wos_date <= '#DateFormat(getdate.ThisAccDate,"yyyy-mm-dd")#'  
	    			</cfif> 
                    and (linecode <> 'SV' or linecode is null)
	      			order by trdatetime desc
	      		</cfquery>
			<cfelse>
				<cfquery name="getrc" datasource="#dts#">
	      			select qty, amt<cfif isdefined('form.misccost')>+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7</cfif> as amt, amt_bil, <cfif isdefined('form.misccost')>(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty<cfelse>price</cfif> as price, price_bil 
					from ictran 
					where itemno='#getitem.itemno#'
	      			and type='RC' and (void = '' or void is null)
	      			<cfif form.periodfrom neq "" and form.periodto neq "">
	        			and fperiod+0 <= '#form.periodto#'
	      			</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
                    </cfif>
                    and (linecode <> 'SV' or linecode is null)
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
							and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
							and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
								and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
						and LastAccDate = '#DateFormat(form.thislastaccdate,"yyyy-mm-dd")#'
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
                            
								<cfif getgeneral.fifocal eq "1">
									<cfset stkval = minusqty * getrc.price>
                                <cfelse>
									<cfset stkval = minusqty * getrc.amt/getrc.qty>
                                </cfif>
                            
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
    <cfreportparam name="catefrom" value="#form.categoryfrom#">
    <cfreportparam name="cateto" value="#form.categoryto#">
    
    <cfreportparam name="groupfrom" value="#form.groupfrom#">
    <cfreportparam name="groupto" value="#form.groupto#">
    
    <cfreportparam name="productfrom" value="#form.productfrom#">
    <cfreportparam name="productto" value="#form.productto#">
    
    <cfreportparam name="suppfrom" value="#form.supplierfrom#">
    <cfreportparam name="suppto" value="#form.supplierto#">
    
    <cfreportparam name="periodfrom" value="#form.periodfrom#">
    <cfreportparam name="periodto" value="#form.periodto#">
    <cfreportparam name="datefrom" value="#datefrom#">
    <cfreportparam name="dateto" value="#dateto#">
    <cfreportparam name="dts" value="#dts#">
    
	</cfreport>

</cfcase>
<!--- --->
</cfswitch>
<!---
<cfquery name="deletefifoitemstatus" datasource="#dts#">
delete from fifoitemstatus where uuid='#uuid#'
</cfquery>--->