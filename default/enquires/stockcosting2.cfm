<html>
<head>
<title>Stock Costing and Price Details</title>
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
	compro,
	lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,cost
	from gsetup;
</cfquery>

<cfquery name="getallitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
            a.ucost,
            a.avcost,
            a.avcost2,
			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			<cfswitch expression="#getgeneral.cost#">
            <cfcase value="FIXED,FIFO,LIFO">
            a.ucost as unitcost
            </cfcase>
			<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost
            </cfcase>
            <cfcase value="MOVING,WEIGHT">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost
                </cfcase>
			</cfswitch>
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
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
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
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
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
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
                and fperiod<>'99' 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodfrom#'
                <cfelse>
                and fperiod+0 <= '00'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
                and fperiod<>'99' 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodfrom#'
                <cfelse>
                and fperiod+0 <= '00'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
                and fperiod<>'99' 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodfrom#'
                <cfelse>
                and fperiod+0 <= '00'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
                and fperiod<>'99' 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodfrom#'
                <cfelse>
                and fperiod+0 <= '00'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as i on a.itemno=i.itemno
            
            where a.itemno=a.itemno 
            <cfif not isdefined("form.include0")>
				and (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
				and a.itemno = '#form.productfrom#'
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
				and a.supp between '#form.suppfrom#' and '#form.suppto#'
			</cfif>
			group by a.itemno 
			order by a.itemno
</cfquery>

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>STOCK COSTING AND PRICING DETAILS</strong></font></p>

<table width="100%" border="0" align="center" cellspacing="0">
<cfoutput>
	<cfif trim(catefrom) neq "" and trim(cateto) neq "">
    	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #catefrom# To #cateto#</font></div></td>
      	</tr>
    </cfif>
    <cfif trim(groupfrom) neq "" and trim(groupto) neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lGROUP# From #groupfrom# To #Groupto#</font></div></td>
      	</tr>
    </cfif>
	
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product <cfif isdefined('form.productform')>#productfrom#<cfelse></cfif></font></div></td>
      	</tr>

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
    
    <cfif thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #thislastaccdate#
		limit 1
	</cfquery>
	<cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
		<cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.qtybf,
			b.refno,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
            b.trdatetime,
			if(b.type='TROU' or b.type='TRIN','Transfer',b.name) as name,
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
            
			order by b.wos_date, b.trdatetime
		</cfquery>
	<cfelse>
		<cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.qtybf,
			b.refno,
			b.itemno,
			b.type,
			b.dono,
            b.trdatetime,
			b.wos_date,
			<cfif lcase(hcomid) eq "ovas_i">
				if(b.type='TROU' or b.type='TRIN',concat('Transfer - ',b.name),b.name) as name,
			<cfelse>
				if(b.type='TROU' or b.type='TRIN','Transfer',b.name) as name,
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
			b.refno,
			b.itemno,
			b.type,
			b.dono,
			b.wos_date,
            b.trdatetime,
			if(b.type='TROU' or b.type='TRIN','Transfer',b.name) as name,
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
            
			order by b.wos_date, b.trdatetime
		</cfquery>
	<cfelse>
		<cfquery name="getictran" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.qtybf,
			b.refno,
			b.itemno,
			b.type,
            b.trdatetime,
			b.dono,
			b.wos_date,
           '0' as qtybf,
			<cfif lcase(hcomid) eq "ovas_i">
				if(b.type='TROU' or b.type='TRIN',concat('Transfer - ',b.name),b.name) as name,
			<cfelse>
				if(b.type='TROU' or b.type='TRIN','Transfer',b.name) as name,
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
            
			order by b.wos_date, b.trdatetime
		</cfquery>
	</cfif>
	
</cfif>
    
	<tr>
        <td colspan="9"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #getallitem.itemno# - #getallitem.desp#</font></td>
    </tr>
	<tr>
    	<td colspan="12"><hr></td>
  	</tr>
  	<tr>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REFNO</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
        <cfif getpin2.h42A0 eq 'T'>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST P.</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SELL P.</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
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
    	<td><font size="2" face="Times New Roman, Times, serif">Balance B/F:</font></td>
    	<td></td>
   	 	<td></td>
    	<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#itembal#</div></font></td>

    	<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#lsnumberformat(unitcost,',_.____')#</div></font></td>
    	<td></td>
    	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><cfif itembal neq '' and itembal neq 0><cfif ucost neq ''>#lsnumberformat(unitcost*itembal,',_.__')#<cfelse>0.00</cfif></cfif></div></font></td>
  	</tr>
    
    <cfloop query="getictran">
    <!---- ----->
    <cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN" or type eq "PO">
    
    <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">	
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO,LIFO">
				a.ucost as unitcost
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
                and fperiod <>'99'
	      		and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				and trdatetime < '#getictran.trdatetime#'
				and itemno = '#getictran.itemno#'
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
	      		and wos_date > #getdate.LastAccDate#
                and fperiod <>'99'
				and wos_date <= #getdate.ThisAccDate# 
				and trdatetime < '#getictran.trdatetime#'
				and itemno = '#getictran.itemno#' 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
                and fperiod <>'99'
				and wos_date <= #getdate.ThisAccDate#
				and type= '#getictran.type#' 
                and refno= '#getictran.refno#'
				and itemno = '#getictran.itemno#'
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
	      		and wos_date > #getdate.LastAccDate#
                and fperiod <>'99'
				and wos_date <= #getdate.ThisAccDate# 
				and trdatetime <= '#getictran.trdatetime#'
				and itemno = '#getictran.itemno#'
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and fperiod <>'99'
				and trdatetime <= '#getictran.trdatetime#'
				and itemno = '#getictran.itemno#'
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and fperiod <>'99'
				and trdatetime <= '#getictran.trdatetime#'
				and itemno = '#getictran.itemno#'
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and fperiod <>'99'
				and trdatetime <= '#getictran.trdatetime#'
				and itemno = '#getictran.itemno#'
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
	      		and wos_date > #getdate.LastAccDate#
				and fperiod <>'99'
				and trdatetime <= '#getictran.trdatetime#'
				and itemno = '#getictran.itemno#'
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
					and itemno = '#getictran.itemno#'
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null)
					and (linecode <> 'SV' or linecode is null)
		     		and wos_date <= #getdate.LastAccDate#
					and itemno = '#getictran.itemno#'
					group by itemno
				) as cc on aa.itemno=cc.itemno
				
				where aa.LastAccDate = #form.thislastaccdate#

				and aa.itemno = '#getictran.itemno#'

				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			and LastAccDate = #form.thislastaccdate#
			<cfif isdefined("form.include0")>
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO,LIFO">
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
			
			and a.itemno = '#getictran.itemno#'
			
			order by a.itemno
		</cfquery>
	<cfelse>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.unit,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED,FIFO,LIFO">
				a.ucost as unitcost
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
				and trdatetime < '#getictran.trdatetime#'
                and fperiod <>'99'
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
				and trdatetime < '#getictran.trdatetime#'
                and fperiod <>'99'
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and type= '#getictran.type#' 
                and fperiod <>'99'
                and refno= '#getictran.refno#'
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
				and type= '#getictran.type#' 
                and refno= '#getictran.refno#'
                and fperiod <>'99'
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				and trdatetime <= '#getictran.trdatetime#' 
                and fperiod <>'99'
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and trdatetime <= '#getictran.trdatetime#' 
                and fperiod <>'99'
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and trdatetime <= '#getictran.trdatetime#' 
                and fperiod <>'99'
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and trdatetime <= '#getictran.trdatetime#' 
                and fperiod <>'99'
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
	

				and aa.itemno = '#getictran.itemno#'

				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			<cfif isdefined("form.include0")>
				
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO,LIFO">
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
			
			
			and a.itemno = '#getictran.itemno#'
			
			order by a.itemno;
		</cfquery>
	</cfif>
    </cfif>
    <!---- ----->
    
    
    
    
  <cfif isdefined('form.dodate')>
   <cfif type eq "INV">
  <cfquery name="checkexist2" datasource="#dts#">
  select toinv,refno,type,itemno from ictran a  where refno ='#getictran.refno#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and type = "#getictran.type#" and trancode = "#getictran.trancode#" and (dono = "" or dono is null or dono not in (select frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  </cfquery>
  </cfif>
  </cfif>
		<cfif ((type eq "PO" or type eq "SO") and getictran.toinv eq "") or (type neq "PO" and type neq "SO")>
    	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
      		<td>
				<div align="left"><font size="2" face="Times New Roman, Times, serif">#type# #refno#</font></div>
			</td>
      		<td><font size="2" face="Times New Roman, Times, serif">#name#<cfif lcase(hcomid) eq "ovas_i" and drivername neq ""> - #drivername#</cfif></font></td>
            
      		<td>
				<cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN" or type eq "PO">
          			<cfset itembal = val(itembal) + val(qty)>
          			<cfset totalin = totalin + val(qty)>
         			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
				</cfif>
			</td>
      		<td>
				<cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO") or (lcase(HcomID) eq "eocean_i" and type eq "CT")>
          			<cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
						<cfset itembal = val(itembal) - val(qty)>
	            		<cfset totalout = totalout + val(qty)>
	            		<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
					<cfelse>
                    
					<cfif isdefined('form.dodate')>
                    
                    <cfif type eq "DO" and isdefined('form.include') eq false>
                        <cfset itembal = val(itembal) - val(qty)>
	            		<cfset totalout = totalout + val(qty)>
	            			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty# / INV #toinv#</div></font>
						<cfelseif type eq "INV" and checkexist2.recordcount eq 0 and isdefined('form.include') eq false>
                        
						<cfelse>
	            			<cfset itembal = val(itembal) - val(qty)>
	            			<cfset totalout = totalout + val(qty)>
	            			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
	          			</cfif>
                    <cfelse>
						<cfif type eq "DO" and toinv neq "" and isdefined('form.include') eq false>
	            			<font size="2" face="Times New Roman, Times, serif"><div align="right">INV #toinv#</div></font>
						<cfelse>
	            			<cfset itembal = val(itembal) - val(qty)>
	            			<cfset totalout = totalout + val(qty)>
	            			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
	          			</cfif>
                        </cfif>
					</cfif>
        		</cfif>
			</td>
      		<td>
				<cfif lcase(hcomid) eq "redd_i" or lcase(hcomid) eq "idi_i" or lcase(hcomid) eq "ge_i">
					<font size="2" face="Times New Roman, Times, serif"><div align="right">#itembal#</div></font>
				<cfelse>
                <cfif isdefined('form.dodate')>
                <cfif type eq "INV" and checkexist2.recordcount eq 0 and isdefined('form.include') eq false>
	          		<cfelse>
	          			<font size="2" face="Times New Roman, Times, serif"><div align="right">#itembal#</div></font>
	          		</cfif>
				<cfelse>
					<cfif type eq "DO" and toinv neq "" and isdefined('form.include') eq false>
	          		<cfelse>
	          			<font size="2" face="Times New Roman, Times, serif"><div align="right">#itembal#</div></font>
	          		</cfif>
                    </cfif>
				</cfif>
			</td>
            <cfif getpin2.h42A0 eq 'T'>
      		<td><cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN" or type eq "PO">
          			<div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.unitcost,",_.__")#</font> </div>
        		</cfif>
			</td>
      		<td><cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO") or (lcase(HcomID) eq "eocean_i" and type eq "CT")>
         	 		<font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(price,",.____")#</div></font>
          		</cfif>
			</td>
      		<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(amt,",.__")#</div></font></td>
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
		</cfif>
  	</cfloop>
	<tr>
    	<td colspan="9"><hr></td>
  	</tr>
    <tr>
      	<td></td>
      	<td></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>Total:</strong></div></font></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#totalin#</strong></div></font></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#totalout#</strong></div></font></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#itembal#</strong></div></font></td>
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