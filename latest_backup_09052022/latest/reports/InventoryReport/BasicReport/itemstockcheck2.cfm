<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif form.productfrom neq "" and form.productto neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="HTML">
<html>
<head>
<title>Item Stock Check</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>
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

<!--- Add On 28-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select include_SO_PO_stockcard from dealer_menu limit 1
</cfquery>

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">
<cfif lcase(hcomid) eq "gel_i">
	<cfparam name="grandqtysold" default="0">	 		
    <cfparam name="grandsalesamt" default="0">
</cfif>
<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
	<cfparam name="grandSOqty" default="0">
	<cfparam name="grandnetqty" default="0">
	<cfparam name="grandPOqty" default="0">
	<cfparam name="grandgrossqty" default="0">
</cfif>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
    <cfset outtrantypewithinv1="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
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
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery>

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
	
	<cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
            a.aitemno,
			a.unit,
            a.brand,
            a.sizeid,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem_last_year as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
				</cfif>
				group by itemno
			) as b on a.itemno = b.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
				and fperiod = '99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
	
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
				and fperiod = '99'
				and (void = '' or void is null)
				and (toinv='' or toinv is null)  
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	   			</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno 
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
            
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.sizeid,
            a.brand,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem_last_year as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
				</cfif>
				group by itemno
			) as b on a.itemno = b.itemno
			
            left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a 
				where
				<cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                <cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null) 
				</cfif>
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod < '#form.periodfrom#' 
                </cfif>
				and fperiod = '99'
				
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
            
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod = '99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
			
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran a 
				where 
                
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null) 
				</cfif>
				and fperiod = '99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	   			</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
			left join
			(
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno 
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	</cfif>
	
	<cfset thislastaccdate = form.thislastaccdate>
<cfelse>
	<cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.sizeid,
            a.brand,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as b on a.itemno = b.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno))) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (linecode <> 'SV' or linecode is null)
				and (void = '' or void is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
	
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod<>'99' 
				and (void = '' or void is null)  
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
	   			</cfif>
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
				and fperiod<>'99' 
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
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod<>'99'
				and (void = '' or void is null)  
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.sizeid,
            a.brand,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as b on a.itemno = b.itemno
            left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a
				where
                
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null)
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
	   			</cfif>
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
						(
				select itemno,sum(qty) as qout 
				from ictran a
				where 
                
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null) 
				</cfif>
				and fperiod<>'99' 
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
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null) 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	</cfif>
	
	<cfset thislastaccdate = "">
</cfif>

<!--- <cfquery name="getitem" datasource="#dts#">
	select 
	a.itemno,
	a.desp,
	ifnull(d.qin,0) as qin,
	ifnull(e.qout,0) as qout,
	ifnull(f.sqty,0) as sqty,
	ifnull(f.sumamt,0) as sumamt,
	(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
	(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
	
	from icitem as a

	left join
	(
		select itemno,sum(qty) as getlastin 
		from ictran
		where type in ('RC','CN','OAI','TRIN') 
		and fperiod < '#form.periodfrom#' 
		and fperiod<>'99'
		and (void = '' or void is null) 
		<cfif form.datefrom neq "" and form.dateto neq "">
		and wos_date < '#ndatefrom#' 
		</cfif> 
		group by itemno
	) as b on a.itemno = b.itemno

	left join
	(
		select itemno,sum(qty) as getlastout 
		from ictran
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
		and fperiod < '#form.periodfrom#' 
		and fperiod<>'99'
		and toinv=''
		and (void = '' or void is null) 
		<cfif form.datefrom neq "" and form.dateto neq "">
    	and wos_date < '#ndatefrom#'
    	</cfif> 
		group by itemno
	) as c on a.itemno = c.itemno

	left join
	(
		select itemno,sum(qty) as qin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)  
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
    	<cfif form.datefrom neq "" and form.dateto neq "">
    	and wos_date between '#ndatefrom#' and '#ndateto#'
    	</cfif> 
		group by itemno
	) as d on a.itemno = d.itemno

	left join
	(
		select itemno,sum(qty) as qout 
		from ictran 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and toinv='' 
   		<cfif form.periodfrom neq "" and form.periodto neq "">
    	and fperiod between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
    	<cfif form.datefrom neq "" and form.dateto neq "">
    	and wos_date between '#ndatefrom#' and '#ndateto#'
   		</cfif> 
		group by itemno
	) as e on a.itemno=e.itemno

	left join
	(
		select itemno,sum(qty) as sqty,sum(amt) as sumamt 
		from ictran 
		where type in ('INV','CS','DN') 
		and fperiod<>'99'
		and (void = '' or void is null)  
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and wos_date between '#ndatefrom#' and '#ndateto#'
		</cfif> 
		group by itemno
	) as f on a.itemno = f.itemno 

	where a.itemno=a.itemno 
	<cfif not isdefined("form.include0")>
	and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
	</cfif>
	<cfif form.productfrom neq "" and form.productto neq "">
	and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
	<cfif form.categoryfrom neq "" and form.categoryto neq "">
	and a.category between '#form.categoryfrom#' and '#form.categoryto#'
	</cfif>
	<cfif form.groupfrom neq "" and form.groupto neq "">
	and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif form.supplierfrom neq "" and form.supplierto neq "">
	and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
	</cfif>
	group by a.itemno 
	order by a.itemno 
</cfquery> --->


<body>


<table width="80%" border="0" align="center" cellspacing="0">
  	<cfoutput>
    <tr>
      	<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Item Stock Check</strong></font></div></td>
	</tr>
    <cfif trim(categoryfrom) neq "" and trim(categoryto) neq "">
    	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #categoryfrom# To #categoryto#</font></div></td>
      	</tr>
    </cfif>
    <cfif trim(groupfrom) neq "" and trim(groupto) neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lGROUP# From #groupfrom# To #Groupto#</font></div></td>
      	</tr>
    </cfif>
	<cfif trim(productfrom) neq "" and trim(productto) neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product From #productfrom# To #productto#</font></div></td>
      	</tr>
    </cfif>
    <cfif trim(supplierfrom) neq "" and trim(supplierto) neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Supplier From #supplierfrom# To #supplierto#</font></div></td>
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
    
  	</cfoutput>
  	<tr>
		<td colspan="100%"><hr></td>
  	</tr>
  	<tr>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">NO</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
       
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
        
        
		
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif">UOM</font></div></td>
         <td><div align="center"><font size="2" face="Times New Roman, Times, serif">Closing Stock</font></div></td>
  	</tr>
  	<tr>
		<td colspan="100%"><hr></td>
  	</tr>

	<cfloop query="getitem">
		<cfoutput>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
      		<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
      		<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
            
      		
          
      		
			<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.balance#</font></div></td>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
            <cfif isdefined ('form.cb2ndunit')>
            <cfquery name="getfactor" datasource="#dts#">
            select factor1,factor2 from icitem where itemno='#getitem.itemno#'
            </cfquery>
            <cfif val(getfactor.factor2) eq 0>
            <cfset getfactor.factor2 = 1>
			</cfif>
            <cfif val(getfactor.factor1) eq 0>
            <cfset getfactor.factor1 = 1>
			</cfif>
            </cfif>
      		
	  		
	  	
			
            <cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
            <cfset grandqtyin=grandqtyin+val(getitem.qin)>
            <cfset grandqtyout=grandqtyout+val(getitem.qout)>
            <cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>

    	</tr>
		</cfoutput>
  	</cfloop>
    <tr>
        <td colspan="100%"><hr></td>
	</tr>
    <tr>
    <cfif lcase(hcomid) eq "sjpst_i">
    <td></td>
    </cfif>
        <td></td>
        <td></td>
		
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandbalanceqty,"0")#</cfoutput></font></div></td>
    </tr>
</table>
</body>
</html>
</cfcase>

<cfcase value="EXCEL">

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

<!--- Add On 28-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select include_SO_PO_stockcard from dealer_menu limit 1
</cfquery>

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">
<cfif lcase(hcomid) eq "gel_i">
	<cfparam name="grandqtysold" default="0">	 		
    <cfparam name="grandsalesamt" default="0">
</cfif>
<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
	<cfparam name="grandSOqty" default="0">
	<cfparam name="grandnetqty" default="0">
	<cfparam name="grandPOqty" default="0">
	<cfparam name="grandgrossqty" default="0">
</cfif>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
    <cfset outtrantypewithinv1="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
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
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery>

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
	
	<cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.sizeid,
            a.brand,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem_last_year as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
				</cfif>
				group by itemno
			) as b on a.itemno = b.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
				and fperiod = '99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
	
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
				and fperiod = '99'
				and (void = '' or void is null)
				and (toinv='' or toinv is null)  
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	   			</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno 
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.sizeid,
            a.brand,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem_last_year as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
				</cfif>
				group by itemno
			) as b on a.itemno = b.itemno
			
            left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a 
				where
				<cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                <cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null) 
				</cfif>
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod < '#form.periodfrom#' 
                </cfif>
				and fperiod = '99'
				
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#' 
				<cfelse>
					and wos_date < #getdate.LastAccDate#
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
            
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod = '99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
			
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran a 
				where 
                
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null) 
				</cfif>
				and fperiod = '99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	   			</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
			left join
			(
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod = '99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod = '99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					and wos_date > #getdate.LastAccDate#
					and wos_date <= #getdate.ThisAccDate#  
					and (toinv='' or toinv is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno 
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	</cfif>
	
	<cfset thislastaccdate = form.thislastaccdate>
<cfelse>
	<cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.brand,
            a.sizeid,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as b on a.itemno = b.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno))) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (linecode <> 'SV' or linecode is null)
				and (void = '' or void is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
	
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod<>'99' 
				and (void = '' or void is null)  
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
	   			</cfif>
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran a
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
				and fperiod<>'99' 
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
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod<>'99'
				and (void = '' or void is null)  
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.brand,
            a.sizeid,
            a.costcode,
            a.category,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				ifnull(g.SOqty,0) as SOqty,
				ifnull(h.POqty,0) as POqty,
			</cfif>
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
				</cfif> 
				group by itemno
			) as b on a.itemno = b.itemno
            left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran a
				where
                
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null)
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod+0 < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
	   			</cfif>
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
						(
				select itemno,sum(qty) as qout 
				from ictran a
				where 
                
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#)
                and (toinv='' or toinv is null) 
				</cfif>
				and fperiod<>'99' 
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
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null) 
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				left join
				(
					select itemno,sum(qty) as SOqty 
					from ictran 
					where type='SO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as g on a.itemno = g.itemno 
				
				left join
				(
					select itemno,sum(qty) as POqty 
					from ictran 
					where type='PO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif> 
					group by itemno
				) as h on a.itemno = h.itemno
			</cfif>
	
			where a.itemno=a.itemno 
            and (itemtype <> 'SV' or itemtype is null)
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
				and a.supp between '#form.supplierfrom#' and '#form.supplierto#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	</cfif>
	
	<cfset thislastaccdate = "">
</cfif>

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
		   			<NumberFormat ss:Format="#,###,###,##0.00"/>
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
		   			<NumberFormat ss:Format="#,###,###,##0.00"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.00"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Item Stock Check">
				
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="160.25"/>
					<Column ss:Width="180.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="180.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
                    
					<cfset c="16">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
				<cfoutput>
		   
					<cfwddx action = "cfml2wddx" input = "Item Stock Check" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			
<cfif trim(categoryfrom) neq "" and trim(categoryto) neq "">
						<cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #categoryfrom# To #categoryto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
</cfif>

<cfif trim(groupfrom) neq "" and trim(groupto) neq "">
						<cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP# From #groupfrom# To #Groupto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
</cfif>

<cfif trim(productfrom) neq "" and trim(productto) neq "">
						<cfwddx action = "cfml2wddx" input = "Product From #productfrom# To #productto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
</cfif>

<cfif trim(supplierfrom) neq "" and trim(supplierto) neq "">
						<cfwddx action = "cfml2wddx" input = "Supplier From #supplierfrom# To #supplierto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
</cfif>

<cfif periodfrom neq "" and periodto neq "">
						<cfwddx action = "cfml2wddx" input = "Period From #periodfrom# To #periodto#" output = "wddxText">
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
				
					
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
                    
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">NO</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM NO.</Data></Cell>
                    
					<Cell ss:StyleID="s27"><Data ss:Type="String">DESP</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTY</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">UOM</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Closing Stock</Data></Cell>
                </Row>
                <cfloop query="getitem">
                <cfoutput>
					<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
					<cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText8">
					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#getitem.currentrow#.</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
                        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                        </cfif>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                        <cfif isdefined('form.cbcate')>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        </cfif>
                        <cfif isdefined ('form.cbbrand')>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        </cfif>
                        <cfif isdefined ('form.cbrating')>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        </cfif>
                        <cfif lcase(hcomid) eq "sjpst_i">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        </cfif>
                        <cfset balanceqty=val(getitem.qtybf)+val(getitem.qin)-val(getitem.qout)>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#balanceqty#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        
                        
            <cfif isdefined ('form.cb2ndunit')>
            <cfquery name="getfactor" datasource="#dts#">
            select factor1,factor2 from icitem where itemno='#getitem.itemno#'
            </cfquery>
            <cfif val(getfactor.factor2) eq 0>
            <cfset getfactor.factor2 = 1>
			</cfif>
            <cfif val(getfactor.factor1) eq 0>
            <cfset getfactor.factor1 = 1>
			</cfif>
            <cfset secunit =((balance*getfactor.factor1)/getfactor.factor2)>
            <Cell ss:StyleID="s32"><Data ss:Type="String">#secunit#</Data></Cell>
            </cfif>
            <cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>
			</Row>
                    
				</cfoutput>
                </cfloop>
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
				<cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:StyleID="s38"><Data ss:Type="String">Total</Data></Cell>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    </cfif>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(grandbalanceqty,"0")#</Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
					
                    </Row>
				</cfoutput>
				
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
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

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">


</cfcase>
</cfswitch>