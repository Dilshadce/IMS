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
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
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
			a.unit,
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
			</cfif>
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
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
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod < '#form.periodfrom#' 
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
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
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
			a.desp,
			a.unit,
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
				and fperiod+0 < '#form.periodfrom#' 
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
				and fperiod+0 < '#form.periodfrom#' 
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
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
				and fperiod+0 < '#form.periodfrom#' 
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
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '#form.periodfrom#' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
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
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	</cfif>
	
	<cfset thislastaccdate = "">
</cfif>

<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">

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
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>

		  		</Style>
                
                 <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>

		 	</Styles>
			
			<Worksheet ss:Name="Stock Card2 Details">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="150.25"/>
					<Column ss:Width="300.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>

				<cfoutput>

 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"><cfif hcomid eq "pnp_i">STOCK CARD DETAILS<cfelse>STOCK CARD SUMMARY</cfif></Data></Cell>
		</Row>
        
    <cfif trim(categoryFrom) neq "" and trim(categoryTo) neq "">
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            		<cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY#" output = "wddxText">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText# From #categoryFrom# To #categoryTo#</Data></Cell>
		</Row>
    </cfif>
    
    <cfif trim(groupfrom) neq "" and trim(groupto) neq "">
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            		<cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP#" output = "wddxText1">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText1# From #groupfrom# To #Groupto#</Data></Cell>
		</Row>
    </cfif>
    
	<cfif trim(productfrom) neq "" and trim(productto) neq "">
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            		<cfwddx action = "cfml2wddx" input = "#productfrom# To #productto#" output = "wddxText2">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Product From #wddxText2#</Data></Cell>
		</Row>
    </cfif>
    
    <cfif trim(supplierFrom) neq "" and trim(supplierTo) neq "">
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            		<cfwddx action = "cfml2wddx" input = "#supplierFrom# To #supplierTo#" output = "wddxText3">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Supplier From #wddxText3#</Data></Cell>
		</Row>
    </cfif>
    
    <cfif periodfrom neq "" and periodto neq "">
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            		<cfwddx action = "cfml2wddx" input = "#periodfrom# To #periodto#" output = "wddxText4">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Period From #wddxText4#</Data></Cell>
		</Row>
    </cfif>
    <cfif datefrom neq "" and dateto neq "">
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            		<cfwddx action = "cfml2wddx" input = "#datefrom# To #dateto#" output = "wddxText5">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Date From #wddxText5#</Data></Cell>
		</Row>
    </cfif>
    
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText6">
				<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText7">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	        <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
		</Row>
  	</cfoutput>
    
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
    	<Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">DESP</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">UOM</Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">QTY B/F </Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
   	 	<Cell ss:StyleID="s50"><Data ss:Type="String">BALANCE</Data></Cell>
     	
  	</Row>

	<cfloop query="getitem">
		<cfoutput>
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText8">
				<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText9">
				<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText10">
				<cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText11">
				<cfwddx action = "cfml2wddx" input = "#getitem.qtybf#" output = "wddxText12">
				<cfwddx action = "cfml2wddx" input = "#getitem.qin#" output = "wddxText13">
				<cfwddx action = "cfml2wddx" input = "#getitem.qout#" output = "wddxText14">
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#.</Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
			<cfset balanceqty=val(getitem.qtybf)+val(getitem.qin)-val(getitem.qout)>
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#balanceqty#</Data></Cell>
      
	  		
	  	
			
            <cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
            <cfset grandqtyin=grandqtyin+val(getitem.qin)>
            <cfset grandqtyout=grandqtyout+val(getitem.qout)>
            <cfset grandbalanceqty=grandbalanceqty+val(balanceqty)>
            <cfif lcase(hcomid) eq "gel_i">
            	<cfset grandqtysold=grandqtysold+val(sqty)>
                <cfset grandsalesamt=grandsalesamt+val(sumamt)>
			</cfif>
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				<cfset grandSOqty=grandSOqty+val(getitem.SOqty)>
				<cfset grandnetqty=grandnetqty<!--- +netqty --->>
				<cfset grandPOqty=grandPOqty+val(getitem.POqty)>
				<cfset grandgrossqty=grandgrossqty<!--- +grossqty --->>
			</cfif>

			<!--- <cfif UCASE(HcomID) eq "IDI" or UCASE(HcomID) eq "ECN" or UCASE(HcomID) eq "GEM" or UCASE(HcomID) eq "JVG">
				<cfif HUserGrpID eq "admin" or HUserGrpID eq "super">
					<a href="stockcard3.cfm?itemno=#urlencodedformat(itemno)#&itembal=#getitem.qtybf#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#categoryFrom#&ct=#categoryTo#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#&sf=#urlencodedformat(supplierFrom)#&st=#urlencodedformat(supplierTo)#">View Details</a></font></div></td>
				</cfif>
			<cfelse>
				<a href="stockcard3.cfm?itemno=#urlencodedformat(itemno)#&itembal=#getitem.qtybf#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#categoryFrom#&ct=#categoryTo#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#&sf=#urlencodedformat(supplierFrom)#&st=#urlencodedformat(supplierTo)#">View Details</a></font></div></td>
			</cfif> --->
    	</Row>
		</cfoutput>
  	</cfloop>
    
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
        
        </Row>
    
    
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s26"><Data ss:Type="String">TOTAL:</Data></Cell>
        <Cell ss:StyleID="s26"><Data ss:Type="String"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></Data></Cell>
        <Cell ss:StyleID="s26"><Data ss:Type="String"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></Data></Cell>
        <Cell ss:StyleID="s26"><Data ss:Type="String"><cfoutput>#numberformat(grandqtyout,"0")#</cfoutput></Data></Cell>
       <Cell ss:StyleID="s26"><Data ss:Type="String"><cfoutput>#numberformat(grandbalanceqty,"0")#</cfoutput></Data></Cell>
        <cfif lcase(hcomid) eq "gel_i">
         
		</cfif>
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
        <cfheader name="Content-Disposition" value="inline; filename=#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>

            <cfcase value="HTML">


<html>
<head>
<title><cfif hcomid eq "pnp_i">Stock Card2 Details<cfelse>Stock Card2</cfif></title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

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
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
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
			a.unit,
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
			</cfif>
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
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
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod < '#form.periodfrom#' 
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
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
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
			a.desp,
			a.unit,
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
				and fperiod+0 < '#form.periodfrom#' 
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
				and fperiod+0 < '#form.periodfrom#' 
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
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
				and fperiod+0 < '#form.periodfrom#' 
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
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '#form.periodfrom#' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
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
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
				and a.category between '#form.categoryFrom#' and '#form.categoryTo#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and a.supp between '#form.supplierFrom#' and '#form.supplierTo#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
	</cfif>
	
	<cfset thislastaccdate = "">
</cfif>

<body>
<table width="80%" border="0" align="center" cellspacing="0">
  	<cfoutput>
    <tr>
      	<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong><cfif hcomid eq "pnp_i">STOCK CARD DETAILS<cfelse>STOCK CARD SUMMARY</cfif></strong></font></div></td>
	</tr>
    <cfif trim(categoryFrom) neq "" and trim(categoryTo) neq "">
    	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #categoryFrom# To #categoryTo#</font></div></td>
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
    <cfif trim(supplierFrom) neq "" and trim(supplierTo) neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Supplier From #supplierFrom# To #supplierTo#</font></div></td>
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
    	<td colspan="5"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
  	</cfoutput>
  	<tr>
		<td colspan="100%"><hr></td>
  	</tr>
  	<tr>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">NO</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">UOM</font></div></td>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY B/F </font></div></td>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
   	 	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
     	
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
      		<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
			<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.qtybf#</font></div></td>
      		<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.qin#</font></div></td>
      		<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.qout#</font></div></td>
			<cfset balanceqty=val(getitem.qtybf)+val(getitem.qin)-val(getitem.qout)>
      		<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#balanceqty#</font></div></td>
      
	  		
	  	
			
            <cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
            <cfset grandqtyin=grandqtyin+val(getitem.qin)>
            <cfset grandqtyout=grandqtyout+val(getitem.qout)>
            <cfset grandbalanceqty=grandbalanceqty+val(balanceqty)>
            <cfif lcase(hcomid) eq "gel_i">
            	<cfset grandqtysold=grandqtysold+val(sqty)>
                <cfset grandsalesamt=grandsalesamt+val(sumamt)>
			</cfif>
			
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				<cfset grandSOqty=grandSOqty+val(getitem.SOqty)>
				<cfset grandnetqty=grandnetqty<!--- +netqty --->>
				<cfset grandPOqty=grandPOqty+val(getitem.POqty)>
				<cfset grandgrossqty=grandgrossqty<!--- +grossqty --->>
			</cfif>

		
    	</tr>
		</cfoutput>
  	</cfloop>
    <tr>
        <td colspan="100%"><hr></td>
	</tr>
    <tr>
        <td></td>
        <td></td>
		<td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyout,"0")#</cfoutput></font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandbalanceqty,"0")#</cfoutput></font></div></td>
        <cfif lcase(hcomid) eq "gel_i">
         
		</cfif>
    </tr>
</table>
</body>
</html>
</cfcase>
</cfswitch>