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
<cfif isdefined('form.showdetail')>
  <cfswitch expression="#form.result#">
    <cfcase value="HTML">
    <html>
    <head>
    <title>Stock Card Details</title>
    <link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
    </head>
    
    <!--- Add On 28-01-2010 --->
    <cfquery name="getdealer_menu" datasource="#dts#">
	select include_SO_PO_stockcard from dealer_menu limit 1
</cfquery>
    <cfparam name="totalin" default="0">
    <cfparam name="totalout" default="0">
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
    <cfquery name="getgeneral" datasource="#dts#">
	select 
	*
	from gsetup;
</cfquery>
    <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
      <cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
      <cfquery name="getallitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,

			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf
		
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
                <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
            
			and (a.itemtype <> 'SV' or a.itemtype is null)
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
      <cfelse>
      <cfquery name="getallitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
                <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
                <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
            
            where a.itemno=a.itemno 
            <cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
            and (a.itemtype <> 'SV' or a.itemtype is null)
			group by a.itemno 
			order by a.itemno
</cfquery>
    </cfif>
    
    <body>
    <p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>STOCK CARD DETAILS</strong></font></p>
    <table width="100%" border="0" align="center" cellspacing="0">
      <cfoutput>
        <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #catefrom# To #cateto#</font></div></td>
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
        <cfif trim(suppfrom) neq "" and trim(suppto) neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Supplier From #suppfrom# To #suppto#</font></div></td>
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
        <cfloop query="getallitem">
          <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
            <cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
            a.sizeid,
			a.qtybf,
			b.refno,
            b.refno2,
            b.invlinklist,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
			if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			b.price,
            b.IT_COS,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
		
			from icitem_last_year a,ictran b
		
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null) 
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and (b.type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN','SO','PO') or 
				(b.type='INV' and b.refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
			<cfelse>
				and (b.type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(b.type='INV' and b.refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
			</cfif> 
			and b.fperiod='99'
			and b.wos_date > #getdate.LastAccDate#
			and b.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
			</cfif>
			and a.LastAccDate=#getdate.LastAccDate#
			and a.ThisAccDate=#getdate.ThisAccDate#
            <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
              <cfelse>
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
            a.sizeid,
            b.invlinklist,
			a.qtybf,
			b.refno,
            b.refno2,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
			<cfif lcase(hcomid) eq "ovas_i">
				if(b.type='TROU' or b.type='TRIN',concat('Transfer - ',b.name),b.name) as name,
			<cfelse>
				if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			</cfif>
			b.price,
            b.IT_COS,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
			<cfif lcase(hcomid) eq "ovas_i">
				,c.drivername
			</cfif>
		
			from icitem_last_year a,ictran b
			<cfif lcase(hcomid) eq "ovas_i">
				,(
					select a.type,a.refno,a.van,concat(dr.name,' ',dr.name2) as drivername 
					from artran a
					left join driver dr on a.van=dr.driverno
					
					where 0=0
					<cfif form.datefrom neq "" and form.dateto neq "">
						and a.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
					</cfif>
				)as c
			</cfif>
		
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null)
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and b.type not in ('QUO','SAM')
			<cfelse>
				and b.type not in ('QUO','SO','PO','SAM')
			</cfif> 
			and b.fperiod='99'
			and b.wos_date > #getdate.LastAccDate#
			and b.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
			</cfif>
            
			<cfif lcase(hcomid) eq "ovas_i">
				and if(b.type='TROU' or b.type='TRIN','TR',b.type)=c.type and b.refno=c.refno
			</cfif>
			and a.LastAccDate=#getdate.LastAccDate#
			and a.ThisAccDate=#getdate.ThisAccDate#
            <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
            </cfif>
            <cfelse>
            <cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.qtybf,
            a.sizeid,
			b.refno,
            b.refno2,
            b.invlinklist,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
			if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			b.price,
            b.IT_COS,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
		
			from icitem a,ictran b
		
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null) 
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and (type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN','SO','PO') or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno))) 
			<cfelse>
				and (type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno))) 
			</cfif> 
			
			and b.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
						and b.fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and b.wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
			</cfif>
             <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
              <cfelse>
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.qtybf,
            a.sizeid,
			b.refno,
            b.refno2,
            b.invlinklist,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
           '0' as qtybf,
			<cfif lcase(hcomid) eq "ovas_i">
				if(b.type='TROU' or b.type='TRIN',concat('Transfer - ',b.name),b.name) as name,
			<cfelse>
				if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			</cfif>
			b.price,
            b.IT_COS,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
			<cfif lcase(hcomid) eq "ovas_i">
				,c.drivername
			</cfif>
		
			from icitem a,ictran b
			<cfif lcase(hcomid) eq "ovas_i">
				,(
					select a.type,a.refno,a.van,concat(dr.name,' ',dr.name2) as drivername 
					from artran a
					left join driver dr on a.van=dr.driverno
					
					where 0=0
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and b.fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and b.wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
			</cfif>
				)as c
			</cfif>
			
            
            
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null) 
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and b.type not in ('QUO','SAM')
			<cfelse>
				and b.type not in ('QUO','SO','PO','SAM')
			</cfif> 
			and b.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
						and b.fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and b.wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif lcase(hcomid) eq "ovas_i">
				and if(b.type='TROU' or b.type='TRIN','TR',b.type)=c.type and b.refno=c.refno
			</cfif>
             <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
            </cfif>
          </cfif>
          <tr>
            <td colspan="9"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #getallitem.itemno# - #getallitem.desp# </font></td>
          </tr>
          <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <tr>
              <td colspan="9"><font size="2" face="Times New Roman, Times, serif">Product Code: #getallitem.aitemno#</font></td>
            </tr>
          </cfif>
          <tr>
            <td colspan="12"><hr></td>
          </tr>
          <tr>
            <cfif lcase(hcomid) eq "epsilon_i">
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item No</font></div></td>
            </cfif>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">REFNO</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">REFNO2</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
            <cfif lcase(hcomid) eq "sjpst_i">
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">SIZE</font></div></td>
            </cfif>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
            <cfif getpin2.h42A0 eq 'T'>
              <td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST P.</font></div></td>
              <cfif lcase(hcomid) neq "epsilon_i">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">SELL P.</font></div></td>
              </cfif>
              <cfif lcase(hcomid) eq "epsilon_i">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST PRICE</font></div></td>
              </cfif>
              <cfif lcase(hcomid) neq "epsilon_i">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
              </cfif>
            </cfif>
          </tr>
          <tr>
            <td colspan="12"><hr></td>
          </tr>
          <cfset itembal=#getallitem.qtybf#>
          <cfset totalin=0>
          <cfset totalout=0>
          <tr>
            <td></td>
            <td></td>
            <td></td>
            <td><font size="2" face="Times New Roman, Times, serif">Balance B/F:</font></td>
            <td></td>
            <td></td>
            <td><font size="2" face="Times New Roman, Times, serif">
              <div align="right">#itembal#</div>
              </font></td>
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
              <cfquery name="getcost" datasource="#dts#">
        select ffc11 from fifoopq_last_year where itemno='#itemno#'
        </cfquery>
              <cfquery name="getcost2" datasource="#dts#">
        select ucost,avcost,avcost2 from icitem_last_year where itemno='#itemno#'
        </cfquery>
              <cfelse>
              <cfquery name="getcost" datasource="#dts#">
        select ffc11 from fifoopq where itemno='#itemno#'
        </cfquery>
              <cfquery name="getcost2" datasource="#dts#">
        select ucost,avcost,avcost2 from icitem where itemno='#itemno#'
        </cfquery>
            </cfif>
            <cfif getpin2.h42A0 eq 'T'>
              <td><font size="2" face="Times New Roman, Times, serif">
                <div align="right">
                  <cfif getgeneral.cost eq "FIFO">
                    #lsnumberformat(getcost.ffc11,',_.____')#
                    <cfelse>
                    <cfif getgeneral.cost eq "Month">
                      #lsnumberformat(getcost2.avcost,',_.____')#
                      <cfelseif getgeneral.cost eq "Moving">
                      #lsnumberformat(getcost2.avcost2,',_.____')#
                      <cfelse>
                      #lsnumberformat(getcost2.ucost,',_.____')#
                    </cfif>
                  </cfif>
                </div>
                </font></td>
              <cfif lcase(hcomid) neq "epsilon_i">
                <td></td>
              </cfif>
              <td><font size="2" face="Times New Roman, Times, serif">
                <div align="right">
                  <cfif itembal neq '' and itembal neq 0>
                    <cfif getgeneral.cost eq "FIFO">
                      #lsnumberformat(val(getcost.ffc11)*itembal,',_.__')#
                      <cfelse>
                      <cfif getgeneral.cost eq "Month">
                        #lsnumberformat(val(getcost2.avcost)*itembal,',_.____')#
                        <cfelseif getgeneral.cost eq "Moving">
                        #lsnumberformat(val(getcost2.avcost2)*itembal,',_.____')#
                        <cfelse>
                        #lsnumberformat(val(getcost2.ucost)*itembal,',_.____')#
                      </cfif>
                    </cfif>
                  </cfif>
                </div>
                </font></td>
            </cfif>
          </tr>
          <cfloop query="getictran">
            <cfif isdefined('form.dodate')>
              <cfif type eq "INV">
                <cfquery name="checkexist2" datasource="#dts#">
  select toinv,refno,type,itemno from ictran a  where refno ='#getictran.refno#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and type = "#getictran.type#" and trancode = "#getictran.trancode#" and (dono = "" or dono is null or dono not in (select frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  </cfquery>
              </cfif>
            </cfif>
            <cfif ((type eq "PO" or type eq "SO") and getictran.toinv eq "") or (type neq "PO" and type neq "SO")>
              <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                <cfif lcase(hcomid) eq "epsilon_i">
                  <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getallitem.itemno#</font></div></td>
                </cfif>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#type# #refno#</font></div></td>
                <cfquery name="getrefno2" datasource="#dts#">
            select refno2 from artran where refno='#refno#' and type='#type#'
            </cfquery>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getrefno2.refno2#</font></div></td>
                <td><font size="2" face="Times New Roman, Times, serif">#name#
                  <cfif lcase(hcomid) eq "ovas_i" and drivername neq "">
                    - #drivername#
                  </cfif>
                  </font></td>
                <cfif lcase(hcomid) eq "sjpst_i">
                  <td><font size="2" face="Times New Roman, Times, serif">#sizeid#</font></td>
                </cfif>
                <td><cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN" or type eq "PO">
                    <cfset itembal = val(itembal) + val(qty)>
                    <cfset totalin = totalin + val(qty)>
                    <font size="2" face="Times New Roman, Times, serif">
                    <div align="right">#qty#</div>
                    </font>
                  </cfif></td>
                <td><cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO") or (lcase(HcomID) eq "eocean_i" and type eq "CT")>
                    <cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
                      <cfset itembal = val(itembal) - val(qty)>
                      <cfset totalout = totalout + val(qty)>
                      <font size="2" face="Times New Roman, Times, serif">
                      <div align="right">#qty#</div>
                      </font>
                      <cfelse>
                      <cfif isdefined('form.dodate')>
                        <cfif type eq "DO" and isdefined('form.include') eq false>
                          <cfset itembal = val(itembal) - val(qty)>
                          <cfset totalout = totalout + val(qty)>
                          <font size="2" face="Times New Roman, Times, serif">
                          <div align="right">#qty# / INV #toinv#</div>
                          </font>
                          <cfelseif type eq "INV" and checkexist2.recordcount eq 0 and isdefined('form.include') eq false>
                          <cfelse>
                          <cfset itembal = val(itembal) - val(qty)>
                          <cfset totalout = totalout + val(qty)>
                          <font size="2" face="Times New Roman, Times, serif">
                          <div align="right">#qty#</div>
                          </font>
                        </cfif>
                        <cfelse>
                        <cfif type eq "DO" and toinv neq "" and isdefined('form.include') eq false>
                          <font size="2" face="Times New Roman, Times, serif">
                          <div align="right">INV #toinv#</div>
                          </font>
                          <cfelse>
                          <cfset itembal = val(itembal) - val(qty)>
                          <cfset totalout = totalout + val(qty)>
                          <font size="2" face="Times New Roman, Times, serif">
                          <div align="right">#qty#</div>
                          </font>
                        </cfif>
                      </cfif>
                    </cfif>
                  </cfif></td>
                <td><cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
                    <font size="2" face="Times New Roman, Times, serif">
                    <div align="right">#itembal#</div>
                    </font>
                    <cfelse>
                    <cfif isdefined('form.dodate')>
                      <cfif type eq "INV" and checkexist2.recordcount eq 0 and isdefined('form.include') eq false>
                        <cfelse>
                        <font size="2" face="Times New Roman, Times, serif">
                        <div align="right">#itembal#</div>
                        </font>
                      </cfif>
                      <cfelse>
                      <cfif type eq "DO" and toinv neq "" and isdefined('form.include') eq false>
                        <cfelse>
                        <font size="2" face="Times New Roman, Times, serif">
                        <div align="right">#itembal#</div>
                        </font>
                      </cfif>
                    </cfif>
                  </cfif></td>
                <cfif getpin2.h42A0 eq 'T'>
                  <td><cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN" or type eq "PO">
                      <cfif lcase(hcomid) eq "widos_i" or lcase(hcomid) eq "derotech_i">
                        <cfquery name="getlastinv" datasource="#dts#">
                select wos_date from ictran where refno='#invlinklist#' and type='INV'
                </cfquery>
                        <cfif getlastinv.recordcount neq 0>
                          <cfquery name="getlastrc" datasource="#dts#">
                select amt+m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7 as amt,if(qty=0,1,qty) as qty from ictran where wos_date<=#getlastinv.wos_date# and type='RC' and itemno='#itemno#'  order by wos_date desc
                </cfquery>
                          <cfelse>
                          <cfquery name="getlastrc" datasource="#dts#">
                select amt+m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7 as amt,if(qty=0,1,qty) as qty from ictran where wos_date<=#wos_date# and type='RC' and itemno='#itemno#'  order by wos_date desc
                </cfquery>
                        </cfif>
                        <cfif getlastrc.recordcount eq 0>
                          <cfquery name="getlastrc" datasource="#dts#">
                select ffc11 as amt,'1' as qty from fifoopq where itemno='#itemno#'
                </cfquery>
                        </cfif>
                      </cfif>
                      <div align="right"><font size="2" face="Times New Roman, Times, serif">
                        <cfif lcase(hcomid) eq "widos_i" or lcase(hcomid) eq "derotech_i">
                          <cfif type eq 'CN'>
                            <cfif val(getlastrc.qty) eq 0>
                              #numberformat(val(getlastrc.amt),",.____")#
                              <cfelse>
                              #numberformat(val(getlastrc.amt)/val(getlastrc.qty),",.____")#
                            </cfif>
                            <cfelse>
                            <cfif qty eq 0>
                              #numberformat(price,",.____")#
                              <cfelse>
                              #numberformat(amt/qty,",.____")#
                            </cfif>
                          </cfif>
                          <cfelse>
                          #numberformat(price,",.____")#
                        </cfif>
                        </font> </div>
                    </cfif></td>
                  <cfif lcase(hcomid) neq "epsilon_i">
                    <td><cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO") or (lcase(HcomID) eq "eocean_i" and type eq "CT")>
                        <font size="2" face="Times New Roman, Times, serif">
                        <div align="right">
                          <cfif lcase(hcomid) eq "widos_i" or lcase(hcomid) eq "derotech_i">
                            <cfif qty eq 0>
                              #numberformat(price,",.____")#
                              <cfelse>
                              #numberformat(amt/qty,",.____")#
                            </cfif>
                            <cfelse>
                            #numberformat(price,",.____")#
                          </cfif>
                        </div>
                        </font>
                      </cfif></td>
                  </cfif>
                  <cfif lcase(hcomid) eq "epsilon_i">
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(it_cos,",.____")#</font> </div></td>
                    <cfelseif lcase(hcomid) eq "widos_i" or lcase(hcomid) eq "derotech_i">
                    <td><font size="2" face="Times New Roman, Times, serif">
                      <div align="right">
                        <cfif type eq 'CN'>
                          <cfif val(getlastrc.qty) eq 0>
                            #numberformat(amt,",.__")#
                            <cfelse>
                            #numberformat((val(getlastrc.amt)/val(getlastrc.qty))*qty,",.__")#
                          </cfif>
                          <cfelse>
                          #numberformat(amt,",.__")#
                        </cfif>
                      </div>
                      </font></td>
                    <cfelse>
                    <td><font size="2" face="Times New Roman, Times, serif">
                      <div align="right">#numberformat(amt,",.__")#</div>
                      </font></td>
                  </cfif>
                </cfif>
              </tr>
            </cfif>
            <cfif (lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i") and  type eq "DO">
              <cfquery name="getinv" datasource="#dts#">
				select * from iclink 
				where frtype='DO' and type='INV' and frrefno='#refno#'
				group by type,refno
			</cfquery>
              <cfif getinv.recordcount neq 0>
                <cfloop query="getinv">
                  <tr>
                    <td></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">INV #getinv.refno#</font></div></td>
                  </tr>
                </cfloop>
              </cfif>
            </cfif>
          </cfloop>
          <tr>
            <td colspan="9"><hr></td>
          </tr>
          <tr>
            <cfif lcase(hcomid) eq "epsilon_i">
              <td></td>
            </cfif>
            <cfif lcase(hcomid) eq "sjpst_i">
              <td></td>
            </cfif>
            <td></td>
            <td></td>
            <td></td>
            <td><font size="2" face="Times New Roman, Times, serif">
              <div align="right"><strong>Total:</strong></div>
              </font></td>
            <td><font size="2" face="Times New Roman, Times, serif">
              <div align="right"><strong>#totalin#</strong></div>
              </font></td>
            <td><font size="2" face="Times New Roman, Times, serif">
              <div align="right"><strong>#totalout#</strong></div>
              </font></td>
            <td><font size="2" face="Times New Roman, Times, serif">
              <div align="right"><strong>#itembal#</strong></div>
              </font></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
        </cfloop>
      </cfoutput>
    </table>
    <br>
    <div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
    <p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
    </body>
    </html>
    </cfcase>
    <cfcase value="EXCELDEFAULT">
    
    <!--- Add On 28-01-2010 --->
    <cfquery name="getdealer_menu" datasource="#dts#">
	select include_SO_PO_stockcard from dealer_menu limit 1
</cfquery>
    <cfparam name="totalin" default="0">
    <cfparam name="totalout" default="0">
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
    <cfquery name="getgeneral" datasource="#dts#">
	select 
	*
	from gsetup;
</cfquery>
    <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
      <cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
      <cfquery name="getallitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,

			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf
		
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
                <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			and (a.itemtype <> 'SV' or a.itemtype is null)
			and a.LastAccDate = #getdate.LastAccDate#
			group by a.itemno 
			order by a.itemno 
		</cfquery>
      <cfelse>
      <cfquery name="getallitem" datasource="#dts#">
			select 
			a.itemno,
            a.aitemno,
			a.desp,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
            
            where a.itemno=a.itemno 
            <cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
            and (a.itemtype <> 'SV' or a.itemtype is null)
			group by a.itemno 
			order by a.itemno
</cfquery>
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
        <Style ss:ID="s40">
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style> 
        <Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
      </Styles>
      <Worksheet ss:Name="STOCK CARD DETAILS"><cfoutput>
          <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
          <Column ss:Width="64.5"/>
          <Column ss:Width="60.25"/>
          <Column ss:Width="60.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
          <Column ss:Width="60.75"/>
          <Column ss:Width="60.75"/>
          <Column ss:Width="60.75"/>
          <Column ss:Width="60.75"/>
          <Column ss:Width="60.75"/>
          <Column ss:Width="60.75"/>
          <Column ss:Width="60.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
          <cfset c="20">
          <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
          <cfset c=c+1>
          <cfwddx action = "cfml2wddx" input = "STOCK CARD DETAILS" output = "wddxText">
          <Row ss:AutoFitHeight="0" ss:Height="23.0625">
            <Cell ss:MergeAcross="#c#" ss:StyleID="s22">
              <Data ss:Type="String">#wddxText#</Data>
            </Cell>
          </Row>
          <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #catefrom# To #cateto#" output = "wddxText">
          <cfif trim(catefrom) neq "" and trim(cateto) neq "">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP# From #groupfrom# To #Groupto#" output = "wddxText">
          <cfif trim(groupfrom) neq "" and trim(groupto) neq "">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfwddx action = "cfml2wddx" input = "Product From #productfrom# To #productto#" output = "wddxText">
          <cfif trim(productfrom) neq "" and trim(productto) neq "">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfwddx action = "cfml2wddx" input = "Supplier From #suppfrom# To #suppto#" output = "wddxText">
          <cfif trim(suppfrom) neq "" and trim(suppto) neq "">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfwddx action = "cfml2wddx" input = "Period From #periodfrom# To #periodto#" output = "wddxText">
          <cfif periodfrom neq "" and periodto neq "">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfwddx action = "cfml2wddx" input = "Date From #datefrom# To #dateto#" output = "wddxText">
          <cfif datefrom neq "" and dateto neq "">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfwddx action = "cfml2wddx" input = "" output = "wddxText">
          <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:MergeAcross="#c-1#" ss:StyleID="s26">
              <Data ss:Type="String">#wddxText#</Data>
            </Cell>
            <Cell ss:StyleID="s26">
              <Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data>
            </Cell>
          </Row>
        </cfoutput>
        <cfloop query="getallitem">
          <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
            <cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.qtybf,
            a.sizeid,
			b.refno,
            b.refno2,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
			if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			b.price,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
		
			from icitem_last_year a,ictran b
		
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null) 
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and (b.type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN','SO','PO') or 
				(b.type='INV' and b.refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
			<cfelse>
				and (b.type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(b.type='INV' and b.refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))
			</cfif> 
			and b.fperiod='99'
			and b.wos_date > #getdate.LastAccDate#
			and b.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
			</cfif>
			and a.LastAccDate=#getdate.LastAccDate#
			and a.ThisAccDate=#getdate.ThisAccDate#
            <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
              <cfelse>
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.qtybf,
            a.sizeid,
			b.refno,
            b.refno2,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
			<cfif lcase(hcomid) eq "ovas_i">
				if(b.type='TROU' or b.type='TRIN',concat('Transfer - ',b.name),b.name) as name,
			<cfelse>
				if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			</cfif>
			b.price,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
			<cfif lcase(hcomid) eq "ovas_i">
				,c.drivername
			</cfif>
		
			from icitem_last_year a,ictran b
			<cfif lcase(hcomid) eq "ovas_i">
				,(
					select a.type,a.refno,a.van,concat(dr.name,' ',dr.name2) as drivername 
					from artran a
					left join driver dr on a.van=dr.driverno
					
					where 0=0
					<cfif form.datefrom neq "" and form.dateto neq "">
						and a.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
					</cfif>
				)as c
			</cfif>
		
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null)
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and b.type not in ('QUO','SAM')
			<cfelse>
				and b.type not in ('QUO','SO','PO','SAM')
			</cfif> 
			and b.fperiod='99'
			and b.wos_date > #getdate.LastAccDate#
			and b.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
			</cfif>
            
			<cfif lcase(hcomid) eq "ovas_i">
				and if(b.type='TROU' or b.type='TRIN','TR',b.type)=c.type and b.refno=c.refno
			</cfif>
			and a.LastAccDate=#getdate.LastAccDate#
			and a.ThisAccDate=#getdate.ThisAccDate#
            <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
            </cfif>
            <cfelse>
            <cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.qtybf,
            a.sizeid,
			b.refno,
            b.refno2,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
			if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			b.price,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
		
			from icitem a,ictran b
		
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null) 
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and (type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN','SO','PO') or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno))) 
			<cfelse>
				and (type in ('DO','PR','CS','DN','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno))) 
			</cfif> 
			
			and b.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
						and b.fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and b.wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
			</cfif>
             <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
              <cfelse>
              <cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.qtybf,
            a.sizeid,
			b.refno,
            b.refno2,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
           '0' as qtybf,
			<cfif lcase(hcomid) eq "ovas_i">
				if(b.type='TROU' or b.type='TRIN',concat('Transfer - ',b.name),b.name) as name,
			<cfelse>
				if(b.type='TROU' or b.type='TRIN','Transfer',(select name from artran where refno=b.refno and type=b.type)) as name,
			</cfif>
			b.price,
			b.qty,
			b.toinv,
            b.trancode,
			(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
			<cfif lcase(hcomid) eq "ovas_i">
				,c.drivername
			</cfif>
		
			from icitem a,ictran b
			<cfif lcase(hcomid) eq "ovas_i">
				,(
					select a.type,a.refno,a.van,concat(dr.name,' ',dr.name2) as drivername 
					from artran a
					left join driver dr on a.van=dr.driverno
					
					where 0=0
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and b.fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and b.wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
			</cfif>
				)as c
			</cfif>
			
            
            
			where a.itemno=b.itemno 
			and a.itemno='#getallitem.itemno#'
			and (b.void = '' or b.void is null) 
			and (b.linecode = '' or b.linecode is null)
			<cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
				and b.type not in ('QUO','SAM')
			<cfelse>
				and b.type not in ('QUO','SO','PO','SAM')
			</cfif> 
			and b.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
						and b.fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and b.wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif lcase(hcomid) eq "ovas_i">
				and if(b.type='TROU' or b.type='TRIN','TR',b.type)=c.type and b.refno=c.refno
			</cfif>
             <cfif isdefined('form.exclude')>
            and (toinv = "" or toinv is null)
			</cfif>
            <cfif isdefined('form.include')>
            and refno not in (select toinv from ictran where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and fperiod <> '99' and toinv <> "")
			</cfif>
			order by b.wos_date, b.trdatetime
		</cfquery>
            </cfif>
          </cfif>
          <cfoutput>
            <cfwddx action = "cfml2wddx" input = "ITEM NO: #getallitem.itemno# - #getallitem.desp#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <cfwddx action = "cfml2wddx" input = "ITEM NO: #getallitem.aitemno#" output = "wddxText">
              <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
              </Row>
            </cfif>
          </cfoutput>
          <Row ss:AutoFitHeight="0" ss:Height="23.0625">
            <cfif lcase(hcomid) eq "epsilon_i">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item No</Data>
              </Cell>
            </cfif>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">Date</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">REFNO</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">REFNO 2</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">DESCRIPTION</Data>
            </Cell>
            <cfif lcase(hcomid) eq "sjpst_i">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">SIZE</Data>
              </Cell>
            </cfif>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">IN</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">OUT</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">BALANCE</Data>
            </Cell>
            <cfif getpin2.h42A0 eq 'T'>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">COST P.</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">SELL P.</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">AMOUNT</Data>
              </Cell>
            </cfif>
          </Row>
          <cfoutput>
            <cfset itembal=getallitem.qtybf>
            <cfset totalin=0>
            <cfset totalout=0>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:StyleID="s32">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String">Balance B/F:</Data>
              </Cell>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String">#itembal#</Data>
              </Cell>
              <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
                <cfquery name="getcost" datasource="#dts#">
        			select ffc11 from fifoopq_last_year where itemno='#itemno#'
        			</cfquery>
                <cfquery name="getcost2" datasource="#dts#">
        			select ucost,avcost,avcost2 from icitem_last_year where itemno='#itemno#'
        			</cfquery>
                <cfelse>
                <cfquery name="getcost" datasource="#dts#">
                    select ffc11 from fifoopq where itemno='#itemno#'
                    </cfquery>
                <cfquery name="getcost2" datasource="#dts#">
                    select ucost,avcost,avcost2 from icitem where itemno='#itemno#'
                    </cfquery>
              </cfif>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String"><cfif getgeneral.cost eq "FIFO">#val(getcost.ffc11)#<cfelse><cfif getgeneral.cost eq "Month">#val(getcost2.avcost)#<cfelseif getgeneral.cost eq "Moving">#val(getcost2.avcost2)#<cfelse>#val(getcost2.ucost)#
                    </cfif>
                  </cfif>
                </Data>
              </Cell>
              <Cell ss:StyleID="s32">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s33">
                <Data ss:Type="String"><cfif itembal neq '' and itembal neq 0><cfif getgeneral.cost eq "FIFO">#val(getcost.ffc11)*itembal#<cfelse><cfif getgeneral.cost eq "Month">#val(getcost2.avcost)*itembal#<cfelseif getgeneral.cost eq "Moving">#val(getcost2.avcost2)*itembal#<cfelse>#val(getcost2.ucost)*itembal#</cfif>
                    </cfif>
                  </cfif>
                </Data>
              </Cell>
            </Row>
          </cfoutput>
          <cfloop query="getictran">
            <cfif isdefined('form.dodate')>
              <cfif type eq "INV">
                <cfquery name="checkexist2" datasource="#dts#">
          select toinv,refno,type,itemno from ictran a  where refno ='#getictran.refno#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and type = "#getictran.type#" and trancode = "#getictran.trancode#" and (dono = "" or dono is null or dono not in (select frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
          </cfquery>
              </cfif>
            </cfif>
            <cfif ((type eq "PO" or type eq "SO") and getictran.toinv eq "") or (type neq "PO" and type neq "SO")>
              <cfwddx action = "cfml2wddx" input = "#getallitem.itemno#" output = "wddxText">
              <cfwddx action = "cfml2wddx" input = "#dateformat(wos_date,"dd/mm/yy")#" output = "wddxText2">
              <cfwddx action = "cfml2wddx" input = "#type# #refno#" output = "wddxText3">
              <cfquery name="getrefno2" datasource="#dts#">
            select refno2 from artran where refno='#refno#' and type='#type#'
            </cfquery>
              <cfwddx action = "cfml2wddx" input = "#getrefno2.refno2#" output = "wddxText9">
              <cfwddx action = "cfml2wddx" input = "#name#" output = "wddxText4">
              <cfwddx action = "cfml2wddx" input = "#type# #refno#" output = "wddxText5">
              <cfwddx action = "cfml2wddx" input = "#type# #refno#" output = "wddxText6">
              <cfwddx action = "cfml2wddx" input = "#sizeid#" output = "wddxText7">
              <cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText8">
              <cfoutput>
                <Row ss:AutoFitHeight="0">
                  <cfif lcase(hcomid) eq "epsilon_i">
                    <Cell ss:StyleID="s32">
                      <Data ss:Type="String">#wddxText#</Data>
                    </Cell>
                  </cfif>
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText2#</Data>
                  </Cell>
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText3#</Data>
                  </Cell>
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText9#</Data>
                  </Cell>
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText8#</Data>
                  </Cell>
                  
                  <cfif lcase(hcomid) eq "sjpst_i">
                    <Cell ss:StyleID="s32">
                      <Data ss:Type="String">#wddxText7#</Data>
                    </Cell>
                  </cfif>
                  <cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN" or type eq "PO">
                    <cfset itembal = val(itembal) + val(qty)>
                    <cfset totalin = totalin + val(qty)>
                    <cfwddx action = "cfml2wddx" input = "#qty#" output = "wddxText">
                    <Cell ss:StyleID="s32">
                      <Data ss:Type="String">#wddxText#</Data>
                    </Cell>
                    <cfelse>
                    <cfwddx action = "cfml2wddx" input = "" output = "wddxText">
                    <Cell ss:StyleID="s32">
                      <Data ss:Type="String">#wddxText#</Data>
                    </Cell>
                  </cfif>
                  <cfwddx action = "cfml2wddx" input = "" output = "wddxText">
                  <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO") or (lcase(HcomID) eq "eocean_i" and type eq "CT")>
                    <cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
                      <cfset itembal = val(itembal) - val(qty)>
                      <cfset totalout = totalout + val(qty)>
                      <cfwddx action = "cfml2wddx" input = "#qty#" output = "wddxText">
                      <cfelse>
                      <cfif isdefined('form.dodate')>
                        <cfif type eq "DO" and isdefined('form.include') eq false>
                          <cfset itembal = val(itembal) - val(qty)>
                          <cfset totalout = totalout + val(qty)>
                          <cfwddx action = "cfml2wddx" input = "#qty# / INV #toinv#" output = "wddxText">
                          <cfelseif type eq "INV" and checkexist2.recordcount eq 0 and isdefined('form.include') eq false>
                          <cfelse>
                          <cfset itembal = val(itembal) - val(qty)>
                          <cfset totalout = totalout + val(qty)>
                          <cfwddx action = "cfml2wddx" input = "#qty#" output = "wddxText">
                        </cfif>
                        <cfelse>
                        <cfif type eq "DO" and toinv neq "" and isdefined('form.include') eq false>
                          <cfwddx action = "cfml2wddx" input = "INV #toinv#" output = "wddxText">
                          <cfelse>
                          <cfset itembal = val(itembal) - val(qty)>
                          <cfset totalout = totalout + val(qty)>
                          <cfwddx action = "cfml2wddx" input = "#qty#" output = "wddxText">
                        </cfif>
                      </cfif>
                    </cfif>
                  </cfif>
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                  <cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
                    <cfwddx action = "cfml2wddx" input = "#itembal#" output = "wddxText">
                    <cfelse>
                    <cfif isdefined('form.dodate')>
                      <cfif type eq "INV" and checkexist2.recordcount eq 0 and isdefined('form.include') eq false>
                        <cfelse>
                        <cfwddx action = "cfml2wddx" input = "#itembal#" output = "wddxText">
                      </cfif>
                      <cfelse>
                      <cfif type eq "DO" and toinv neq "" and isdefined('form.include') eq false>
                        <cfelse>
                        <cfwddx action = "cfml2wddx" input = "#itembal#" output = "wddxText">
                      </cfif>
                    </cfif>
                  </cfif>
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                  <cfif getpin2.h42A0 eq 'T'>
                    <cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN" or type eq "PO">
                      <Cell ss:StyleID="s33">
                        <Data ss:Type="Number">#price#</Data>
                      </Cell>
                      <cfelse>
                      <Cell ss:StyleID="s32">
                        <Data ss:Type="String"></Data>
                      </Cell>
                    </cfif>
                    <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO") or (lcase(HcomID) eq "eocean_i" and type eq "CT")>
                      <Cell ss:StyleID="s33">
                        <Data ss:Type="Number">#price#</Data>
                      </Cell>
                      <cfelse>
                      <Cell ss:StyleID="s32">
                        <Data ss:Type="String"></Data>
                      </Cell>
                    </cfif>
                  </cfif>
                  <Cell ss:StyleID="s33">
                    <Data ss:Type="Number">#amt#</Data>
                  </Cell>
                </Row>
              </cfoutput>
            </cfif>
            <cfif (lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i") and  type eq "DO">
              <cfquery name="getinv" datasource="#dts#">
				select * from iclink 
				where frtype='DO' and type='INV' and frrefno='#refno#'
				group by type,refno
			</cfquery>
              <cfif getinv.recordcount neq 0>
                <cfloop query="getinv">
                  <Row ss:AutoFitHeight="0" ss:Height="12"/>
                  <cfoutput>
                    <cfwddx action = "cfml2wddx" input = "INV #getinv.refno#" output = "wddxText">
                    <Row ss:AutoFitHeight="0" ss:Height="12">
                      <Cell ss:StyleID="s38">
                        <Data ss:Type="String"></Data>
                      </Cell>
                      <Cell ss:StyleID="s38">
                        <Data ss:Type="String">#wddxText#</Data>
                      </Cell>
                      <Cell ss:StyleID="s39">
                        <Data ss:Type="Number">0</Data>
                      </Cell>
                      <Cell ss:StyleID="s39">
                        <Data ss:Type="Number">0</Data>
                      </Cell>
                      <Cell ss:StyleID="s39">
                        <Data ss:Type="Number">0</Data>
                      </Cell>
                      <Cell ss:StyleID="s39">
                        <Data ss:Type="Number">0</Data>
                      </Cell>
                      <Cell ss:StyleID="s39">
                        <Data ss:Type="Number">0</Data>
                      </Cell>
                      <Cell ss:StyleID="s38"/>
                    </Row>
                  </cfoutput>
                </cfloop>
              </cfif>
            </cfif>
          </cfloop>
          <cfoutput>
            <Row ss:AutoFitHeight="0" ss:Height="12">
              <cfif lcase(hcomid) eq "epsilon_i">
                <Cell ss:StyleID="s38">
                  <Data ss:Type="String"></Data>
                </Cell>
              </cfif>
              <cfif lcase(hcomid) eq "sjpst_i">
                <Cell ss:StyleID="s38">
                  <Data ss:Type="String"></Data>
                </Cell>
              </cfif>
              <Cell ss:StyleID="s38">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s38">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s38">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s38">
                <Data ss:Type="String">Total:</Data>
              </Cell>
              <Cell ss:StyleID="s40">
                <Data ss:Type="Number">#totalin#</Data>
              </Cell>
              <Cell ss:StyleID="s40">
                <Data ss:Type="Number">#totalout#</Data>
              </Cell>
              <Cell ss:StyleID="s40">
                <Data ss:Type="Number">#itembal#</Data>
              </Cell>
              <Cell ss:StyleID="s38"/>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="12"/>
          </cfoutput>
        </cfloop>
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
    <cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_Report_By-Type_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Excel_Report#huserid#.xls">

    </cfcase>
  </cfswitch>
  <cfelse>
  <cfswitch expression="#form.result#">
    <cfcase value="HTML">
    <html>
    <head>
    <title>
    <cfif hcomid eq "pnp_i">
      Stock Card2 Details
      <cfelse>
      Stock Card2
    </cfif>
    </title>
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
	select * from gsetup
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
            a.brand,
            a.sizeid,
            a.costcode,
            a.category,
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			and (a.itemtype <> 'SV' or a.itemtype is null)
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
            a.brand,
            a.sizeid,
            a.costcode,
            a.category,
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			and (a.itemtype <> 'SV' or a.itemtype is null)
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
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			and (a.itemtype <> 'SV' or a.itemtype is null)
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
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
            and (a.itemtype <> 'SV' or a.itemtype is null)
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
	<cfif form.catefrom neq "" and form.cateto neq "">
	and a.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif form.groupfrom neq "" and form.groupto neq "">
	and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif form.suppfrom neq "" and form.suppto neq "">
	and a.supp between '#form.suppfrom#' and '#form.suppto#'
	</cfif>
	group by a.itemno 
	order by a.itemno 
</cfquery> --->
    
    <body>
    <table width="80%" border="0" align="center" cellspacing="0">
      <cfoutput>
        <tr>
          <td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>
              <cfif hcomid eq "pnp_i">
                STOCK CARD DETAILS
                <cfelse>
                STOCK CARD SUMMARY
              </cfif>
              </strong></font></div></td>
        </tr>
        <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #catefrom# To #cateto#</font></div></td>
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
        <cfif trim(suppfrom) neq "" and trim(suppto) neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Supplier From #suppfrom# To #suppto#</font></div></td>
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
      <cfoutput>
        <tr>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">NO</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
          <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT CODE</font></div></td>
          </cfif>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
          <cfif getdisplaydetail.report_brand eq 'Y'>
            <td><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lbrand#</font></td>
          </cfif>
          <cfif getdisplaydetail.report_category eq 'Y'>
            <td><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lcategory#</font></td>
          </cfif>
          <cfif getdisplaydetail.report_group eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lgroup#</font></td>
          </cfif>
          <cfif getdisplaydetail.report_sizeid eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lsize#</font></td>
          </cfif>
          <cfif getdisplaydetail.report_colorid eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lmaterial#</font></td>
          </cfif>
          <cfif getdisplaydetail.report_costcode eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lrating#</font></td>
          </cfif>
          <cfif getdisplaydetail.report_shelf eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lmodel#</font></td>
          </cfif>
          <cfif lcase(hcomid) eq "sjpst_i">
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">SIZE</font></div></td>
          </cfif>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">UOM</font></div></td>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY B/F </font></div></td>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
          <cfif isdefined ('form.cb2ndunit')>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">2nd Unit</font></div></td>
          </cfif>
          <cfif lcase(hcomid) eq "gel_i">
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY SOLD</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">SALES AMT</font></div></td>
          </cfif>
          <cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">SO</font></div></td>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">NET</font></div></td>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">PO</font></div></td>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">GROSS</font></div></td>
          </cfif>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>
        </tr>
      </cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfloop query="getitem">
        <cfoutput>
          <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
            <td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.aitemno#</font></div></td>
            </cfif>
            <td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
            <cfif getdisplaydetail.report_brand eq 'Y'>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.brand#</font></div></td>
            </cfif>
            <cfif getdisplaydetail.report_category eq 'Y'>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.category#</font></div></td>
            </cfif>
            <cfif getdisplaydetail.report_group eq 'Y'>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.wos_group#</font></div></td>
            </cfif>
            <cfif getdisplaydetail.report_sizeid eq 'Y'>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.sizeid#</font></div></td>
            </cfif>
            <cfif getdisplaydetail.report_colorid eq 'Y'>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.colorid#</font></div></td>
            </cfif>
            <cfif getdisplaydetail.report_costcode eq 'Y'>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.costcode#</font></div></td>
            </cfif>
            <cfif getdisplaydetail.report_shelf eq 'Y'>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.shelf#</font></div></td>
            </cfif>
            <cfif lcase(hcomid) eq "sjpst_i">
              <td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.sizeid#</font></div></td>
            </cfif>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.qtybf#</font></div></td>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.qin#</font></div></td>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.qout#</font></div></td>
            <cfset balanceqty=val(getitem.qtybf)+val(getitem.qin)-val(getitem.qout)>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#balanceqty#</font></div></td>
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
              <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#secunit#</font></div></td>
            </cfif>
            <cfif lcase(hcomid) eq "gel_i">
              <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(sqty,"0")#</font></div></td>
              <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(sumamt,",.__")#</font></div></td>
            </cfif>
            <cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
              <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.SOqty#</font></div></td>
              <cfset netqty=val(balanceqty)-val(getitem.SOqty)>
              <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#netqty#</font></div></td>
              <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.POqty#</font></div></td>
              <cfset grossqty=netqty+val(getitem.POqty)>
              <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#grossqty#</font></div></td>
            </cfif>
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
              <cfset grandnetqty=grandnetqty+netqty>
              <cfset grandPOqty=grandPOqty+val(getitem.POqty)>
              <cfset grandgrossqty=grandgrossqty+grossqty>
            </cfif>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif"> <a href="stockcard3.cfm?itemno=#urlencodedformat(itemno)#&itembal=#getitem.qtybf#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#catefrom#&ct=#cateto#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#&sf=#urlencodedformat(suppfrom)#&st=#urlencodedformat(suppto)#&thislastaccdate=#thislastaccdate#<cfif isdefined ('form.cbcate')>&category=#category#</cfif><cfif isdefined ('form.cbbrand')>&brand=#brand#</cfif><cfif isdefined ('form.cbrating')>&rating=#costcode#</cfif><cfif isdefined('form.exclude')>&exclude=Y</cfif><cfif isdefined('form.include')>&include=Y</cfif><cfif isdefined('form.dodate')>&dodate=Y</cfif>">View Details</a></font></div></td>
            
            <!--- <cfif UCASE(HcomID) eq "IDI" or UCASE(HcomID) eq "ECN" or UCASE(HcomID) eq "GEM" or UCASE(HcomID) eq "JVG">
				<cfif HUserGrpID eq "admin" or HUserGrpID eq "super">
					<a href="stockcard3.cfm?itemno=#urlencodedformat(itemno)#&itembal=#getitem.qtybf#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#catefrom#&ct=#cateto#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#&sf=#urlencodedformat(suppfrom)#&st=#urlencodedformat(suppto)#">View Details</a></font></div></td>
				</cfif>
			<cfelse>
				<a href="stockcard3.cfm?itemno=#urlencodedformat(itemno)#&itembal=#getitem.qtybf#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#catefrom#&ct=#cateto#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#&sf=#urlencodedformat(suppfrom)#&st=#urlencodedformat(suppto)#">View Details</a></font></div></td>
			</cfif> ---> 
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
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
          <td nowrap></td>
        </cfif>
        <td nowrap></td>
        <cfif getdisplaydetail.report_brand eq 'Y'>
          <td></td>
        </cfif>
        <cfif getdisplaydetail.report_category eq 'Y'>
          <td></td>
        </cfif>
        <cfif getdisplaydetail.report_group eq 'Y'>
          <td></td>
        </cfif>
        <cfif getdisplaydetail.report_sizeid eq 'Y'>
          <td></td>
        </cfif>
        <cfif getdisplaydetail.report_colorid eq 'Y'>
          <td></td>
        </cfif>
        <cfif getdisplaydetail.report_costcode eq 'Y'>
          <td></td>
        </cfif>
        <cfif getdisplaydetail.report_shelf eq 'Y'>
          <td></td>
        </cfif>
        <td></td>
        <td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqtybf#</cfoutput></font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqtyin#</cfoutput></font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqtyout#</cfoutput></font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandbalanceqty#</cfoutput></font></div></td>
        <cfif lcase(hcomid) eq "gel_i">
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandqtysold#</cfoutput></font></div></td>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandsalesamt,",.__")#</cfoutput></font></div></td>
        </cfif>
        <cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandSOqty#</cfoutput></font></div></td>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandnetqty#</cfoutput></font></div></td>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandPOqty#</cfoutput></font></div></td>
          <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#grandgrossqty#</cfoutput></font></div></td>
        </cfif>
      </tr>
    </table>
    </body>
    </html>
    </cfcase>
    <cfcase value="EXCELDEFAULT">
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
      <cfparam name="netqty" default="0">
      <cfparam name="POqty" default="0">
      <cfparam name="grossqty" default="0">
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
	select * from gsetup
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
            a.brand,
            a.sizeid,
            a.costcode,
            a.category,
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			and (a.itemtype <> 'SV' or a.itemtype is null)
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
            a.brand,
            a.sizeid,
            a.costcode,
            a.category,
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			and (a.itemtype <> 'SV' or a.itemtype is null)
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
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			and (a.itemtype <> 'SV' or a.itemtype is null)
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
            a.ucost,
            a.wos_group,
            a.colorid,
            a.shelf,
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod < '#form.periodfrom#' 
                <cfelse>
                and fperiod < '' 
                </cfif>
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
			<cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
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
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
            and (a.itemtype <> 'SV' or a.itemtype is null)
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
        <Style ss:ID="s40">
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>                
        <Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
      </Styles>
      <Worksheet ss:Name="Stock Card">
        <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
          <Column ss:Width="64.5"/>
          <Column ss:Width="160.25"/>
          <Column ss:Width="180.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
          <Column ss:Width="27.75"/>
          <Column ss:Width="47.25"/>
          <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
          <cfset c="16">
          <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <cfif getdisplaydetail.report_brand eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <cfif getdisplaydetail.report_category eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <cfif getdisplaydetail.report_group eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <cfif getdisplaydetail.report_sizeid eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <cfif getdisplaydetail.report_colorid eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <cfif getdisplaydetail.report_costcode eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <cfif getdisplaydetail.report_shelf eq 'Y'>
            <cfset c=c+1>
          </cfif>
          <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
          <cfset c=c+1>
          <cfoutput>
            <cfwddx action = "cfml2wddx" input = "Stock Card" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:MergeAcross="#c#" ss:StyleID="s22">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
            <cfif trim(catefrom) neq "" and trim(cateto) neq "">
              <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #catefrom# To #cateto#" output = "wddxText">
              <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
              </Row>
            </cfif>
            <cfif trim(groupfrom) neq "" and trim(groupto) neq "">
              <cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP# From #groupfrom# To #Groupto#" output = "wddxText">
              <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
              </Row>
            </cfif>
            <cfif trim(productfrom) neq "" and trim(productto) neq "">
              <cfwddx action = "cfml2wddx" input = "Product From #productfrom# To #productto#" output = "wddxText">
              <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
              </Row>
            </cfif>
            <cfif trim(suppfrom) neq "" and trim(suppto) neq "">
              <cfwddx action = "cfml2wddx" input = "Supplier From #suppfrom# To #suppto#" output = "wddxText">
              <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
              </Row>
            </cfif>
            <cfif periodfrom neq "" and periodto neq "">
              <cfwddx action = "cfml2wddx" input = "Period From #periodfrom# To #periodto#" output = "wddxText">
              <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
              </Row>
            </cfif>
            <cfif datefrom neq "" and dateto neq "">
              <cfwddx action = "cfml2wddx" input = "Date From #datefrom# To #dateto#" output = "wddxText">
              <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <Cell ss:MergeAcross="#c#" ss:StyleID="s24">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
              </Row>
            </cfif>
            <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="#c-1#" ss:StyleID="s26">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
              <Cell ss:StyleID="s26">
                <Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data>
              </Cell>
            </Row>
          </cfoutput><cfoutput>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">NO</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">ITEM NO.</Data>
              </Cell>
              <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">PRODUCT CODE</Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_brand eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#getgeneral.lbrand#.</Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_category eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#getgeneral.lcategory#.</Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_group eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#getgeneral.lgroup#.</Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#getgeneral.lsize#.</Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_colorid eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#getgeneral.lmaterial#.</Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_costcode eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#getgeneral.lrating#.</Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_shelf eq 'Y'>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">#getgeneral.lmodel#.</Data>
                </Cell>
              </cfif>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">DESP</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">UOM</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">QTY B/F</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">IN</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">OUT</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">BALANCE</Data>
              </Cell>
              <cfif lcase(hcomid) eq "acht_i">
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">COST</Data>
                </Cell>
              </cfif>
              <cfif isdefined ('form.cb2ndunit')>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">2ND UNIT</Data>
                </Cell>
              </cfif>
              <cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">SO</Data>
                </Cell>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">NET</Data>
                </Cell>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">PO</Data>
                </Cell>
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">GROSS</Data>
                </Cell>
              </cfif>
            </Row>
          </cfoutput>
          <cfloop query="getitem">
            <cfoutput>
              <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText">
              <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
              <cfwddx action = "cfml2wddx" input = "#getitem.category#" output = "wddxText3">
              <cfwddx action = "cfml2wddx" input = "#getitem.brand#" output = "wddxText4">
              <cfwddx action = "cfml2wddx" input = "#getitem.costcode#" output = "wddxText5">
              <cfwddx action = "cfml2wddx" input = "#getitem.unit#" output = "wddxText6">
              <cfwddx action = "cfml2wddx" input = "#getitem.category#" output = "wddxText3">
              <cfwddx action = "cfml2wddx" input = "#getitem.category#" output = "wddxText3">
              <cfwddx action = "cfml2wddx" input = "#getitem.sizeid#" output = "wddxText7">
              <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText8">
              <Row ss:AutoFitHeight="0">
                <Cell ss:StyleID="s32">
                  <Data ss:Type="String">#getitem.currentrow#.</Data>
                </Cell>
                <Cell ss:StyleID="s32">
                  <Data ss:Type="String">#wddxText#</Data>
                </Cell>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText8#</Data>
                  </Cell>
                </cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                  <cfwddx action = "cfml2wddx" input = "#getitem.brand#" output = "wddxText">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                  <cfwddx action = "cfml2wddx" input = "#getitem.category#" output = "wddxText">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                  <cfwddx action = "cfml2wddx" input = "#getitem.wos_group#" output = "wddxText">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                  <cfwddx action = "cfml2wddx" input = "#getitem.sizeid#" output = "wddxText">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                  <cfwddx action = "cfml2wddx" input = "#getitem.colorid#" output = "wddxText">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                  <cfwddx action = "cfml2wddx" input = "#getitem.costcode#" output = "wddxText">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                  <cfwddx action = "cfml2wddx" input = "#getitem.shelf#" output = "wddxText">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText#</Data>
                  </Cell>
                </cfif>
                <Cell ss:StyleID="s32">
                  <Data ss:Type="String">#wddxText2#</Data>
                </Cell>
                <cfif lcase(hcomid) eq "sjpst_i">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#wddxText7#</Data>
                  </Cell>
                </cfif>
                <Cell ss:StyleID="s32">
                  <Data ss:Type="String">#wddxText6#</Data>
                </Cell>
                <Cell ss:StyleID="s40">
                  <Data ss:Type="Number">#getitem.qtybf#</Data>
                </Cell>
                <Cell ss:StyleID="s40">
                  <Data ss:Type="Number">#getitem.qin#</Data>
                </Cell>
                <Cell ss:StyleID="s40">
                  <Data ss:Type="Number">#getitem.qout#</Data>
                </Cell>
                <cfset balanceqty=val(getitem.qtybf)+val(getitem.qin)-val(getitem.qout)>
                <Cell ss:StyleID="s40">
                  <Data ss:Type="Number">#balanceqty#</Data>
                </Cell>
                <cfif lcase(hcomid) eq "acht_i">
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#getitem.ucost#</Data>
                  </Cell>
                </cfif>
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
                  <Cell ss:StyleID="s32">
                    <Data ss:Type="String">#secunit#</Data>
                  </Cell>
                </cfif>
                <cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
                  <Cell ss:StyleID="s33">
                    <Data ss:Type="Number">#getitem.SOqty#</Data>
                  </Cell>
                  <Cell ss:StyleID="s33">
                    <Data ss:Type="Number">#netqty#</Data>
                  </Cell>
                  <Cell ss:StyleID="s33">
                    <Data ss:Type="Number">#getitem.POqty#</Data>
                  </Cell>
                  <Cell ss:StyleID="s33">
                    <Data ss:Type="Number">#grossqty#</Data>
                  </Cell>
                </cfif>
                <cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
                <cfset grandqtyin=grandqtyin+val(getitem.qin)>
                <cfset grandqtyout=grandqtyout+val(getitem.qout)>
                <cfset grandbalanceqty=grandbalanceqty+val(balanceqty)>
                <cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
                  <cfset grandSOqty=grandSOqty+val(getitem.SOqty)>
                  <cfset grandnetqty=grandnetqty+netqty>
                  <cfset grandPOqty=grandPOqty+val(getitem.POqty)>
                  <cfset grandgrossqty=grandgrossqty+grossqty>
                </cfif>
              </Row>
            </cfoutput>
          </cfloop>
          <Row ss:AutoFitHeight="0" ss:Height="12"/>
          <cfoutput>
            <Row ss:AutoFitHeight="0" ss:Height="12">
              <Cell ss:StyleID="s38">
                <Data ss:Type="String">Total</Data>
              </Cell>
              <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <Cell ss:StyleID="s38">
                  <Data ss:Type="String"></Data>
                </Cell>
              </cfif>
              <cfif getdisplaydetail.report_brand eq 'Y'>
                <Cell ss:StyleID="s38"/>
              </cfif>
              <cfif getdisplaydetail.report_category eq 'Y'>
                <Cell ss:StyleID="s38"/>
              </cfif>
              <cfif getdisplaydetail.report_group eq 'Y'>
                <Cell ss:StyleID="s38"/>
              </cfif>
              <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <Cell ss:StyleID="s38"/>
              </cfif>
              <cfif getdisplaydetail.report_colorid eq 'Y'>
                <Cell ss:StyleID="s38"/>
              </cfif>
              <cfif getdisplaydetail.report_costcode eq 'Y'>
                <Cell ss:StyleID="s38"/>
              </cfif>
              <cfif getdisplaydetail.report_shelf eq 'Y'>
                <Cell ss:StyleID="s38"/>
              </cfif>
              <Cell ss:StyleID="s38">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s38">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s38">
                <Data ss:Type="String"></Data>
              </Cell>
              <Cell ss:StyleID="s40">
                <Data ss:Type="Number">#grandqtybf#</Data>
              </Cell>
              <Cell ss:StyleID="s40">
                <Data ss:Type="Number">#grandqtyin#</Data>
              </Cell>
              <Cell ss:StyleID="s40">
                <Data ss:Type="Number">#grandqtyout#</Data>
              </Cell>
              <Cell ss:StyleID="s40">
                <Data ss:Type="Number">#grandbalanceqty#</Data>
              </Cell>
              <cfif getdealer_menu.include_SO_PO_stockcard eq "Y">
                <Cell ss:StyleID="s39">
                  <Data ss:Type="Number">#grandSOqty#</Data>
                </Cell>
                <Cell ss:StyleID="s39">
                  <Data ss:Type="Number">#grandnetqty#</Data>
                </Cell>
                <Cell ss:StyleID="s39">
                  <Data ss:Type="Number">#grandPOqty#</Data>
                </Cell>
                <Cell ss:StyleID="s39">
                  <Data ss:Type="Number">#grandgrossqty#</Data>
                </Cell>
              </cfif>
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
    <cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_Report_By-Type_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Excel_Report#huserid#.xls">

    </cfcase>
  </cfswitch>
</cfif>
