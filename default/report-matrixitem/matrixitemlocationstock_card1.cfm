<html>
<head>
<title>Stock Balance Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfset grandtotal=0>
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup;
</cfquery>

<body>

<cfquery name="ClearICBil_M" datasource="#dts#">
  	truncate r_IcBil_M
</cfquery>

<cfquery name="ClearICBil_S" datasource="#dts#">
  	truncate r_IcBil_S
</cfquery>

<table align="center" width="100%" border="1" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="20"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Stock Balance Report</strong></font></div></td>
	</tr>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.catefrom# - #form.cateto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.productfrom# - #form.productto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(ndatefrom,"dd-mm-yyyy")# - #dateformat(ndateto,"dd-mm-yyyy")#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="10"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="10"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="20"><hr/></td>
	</tr>
    <tr>
    <td colspan="10"><div align="left"><font size="2" face="Times New Roman,Times,serif">ART NO.</font></div></td>
    
      <td colspan="10"><div align="left"><font size="2" face="Times New Roman,Times,serif">QTY</font></div></td>
  </tr>
   
    
	<tr>
		<td colspan="20"><hr/></td>
	</tr>
    
	<cfoutput>
        <cfquery name="getlocation" datasource="#dts#">
	select 
	a.location,
	bb.location_desp
	<!--- ,
	a.itemno,
	aa.desp,
	ifnull(d.qin,0) as qin,
	ifnull(e.qout,0) as qout,
	(ifnull(a.locqfield,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
	(ifnull(a.locqfield,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance --->
	from locqdbf as a 
	
	right join 
	(
		select 
		itemno,
		desp 
		from icitem 
		where itemno<>'' 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category between '#form.catefrom#' and '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group between '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		order by itemno
	) as aa on a.itemno=aa.itemno 
	
	left join 
	(
		select 
		location,
		desp as location_desp 
		from iclocation 
		order by location
	) as bb on a.location=bb.location
	
	left join
	(
		select 
		location,
		itemno,
		sum(qty) as getlastin 
		from ictran
		where type in ('RC','CN','OAI','TRIN') 
		and fperiod < '#form.periodfrom#' 
		and fperiod<>'99'
		and (void = '' or void is null) 
		and (linecode <> 'SV' or linecode is null)
		<cfif form.datefrom neq "" and form.dateto neq "">
		and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif> 
		group by location,itemno
		order by location,itemno
	) as b on a.itemno=b.itemno and a.location=b.location

	left join
	(
		select 
		location,
		itemno,
		sum(qty) as getlastout 
		from ictran
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
		and fperiod < '#form.periodfrom#' 
		and fperiod<>'99'
		and (toinv='' or toinv is null)
		and (void = '' or void is null) 
		and (linecode <> 'SV' or linecode is null)
		<cfif form.datefrom neq "" and form.dateto neq "">
    	and wos_date < '#ndatefrom#'
    	</cfif> 
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		group by location,itemno
		order by location,itemno
	) as c on a.itemno=c.itemno and a.location=c.location

	left join
	(
		select 
		location,
		itemno,
		sum(qty) as qin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)
		and (linecode <> 'SV' or linecode is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
    	<cfif form.datefrom neq "" and form.dateto neq "">
    	and wos_date between '#ndatefrom#' and '#ndateto#'
    	</cfif> 
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		group by location,itemno
		order by location,itemno
	) as d on a.itemno=d.itemno and a.location=d.location

	left join
	(
		select 
		location,
		itemno,
		sum(qty) as qout 
		from ictran 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and (void = '' or void is null)
		and (toinv='' or toinv is null) 
		and (linecode <> 'SV' or linecode is null)
   		<cfif form.periodfrom neq "" and form.periodto neq "">
    	and fperiod between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
    	<cfif form.datefrom neq "" and form.dateto neq "">
    	and wos_date between '#ndatefrom#' and '#ndateto#'
   		</cfif> 
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		group by location,itemno
		order by location,itemno
	) as e on a.itemno=e.itemno and a.location=e.location
	
	where a.location<>''
    <cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locfrom neq "">
			and a.location = '#form.locfrom#'
		</cfif>
        <cfelse>
	<cfif form.locfrom neq "" and form.locto neq "">
	and a.location between '#form.locfrom#' and '#form.locto#'
	</cfif>
    </cfif>
	group by a.location
	order by a.location
</cfquery>
</cfoutput>
    		<cfset j=1>
    
    <cfoutput query="getlocation">
		<cfset target_location = getlocation.location>
		<cfset target_location_desp = getlocation.location_desp>
		<tr>
			<td colspan="20"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif>: #getlocation.location#</u></strong></font></div></td>
		
		</tr>
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			a.itemno,
			aa.desp,
            aa.unit,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			(ifnull(a.locqfield,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(a.locqfield,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
			from locqdbf as a 
			
			right join 
			(
				select 
				itemno,
				desp,
                unit
				from icitem 
				where itemno<>'' 
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				order by itemno
			) as aa on a.itemno=aa.itemno 
			
			left join
			(
				select 
				location,
				itemno,
				sum(qty) as getlastin 
				from ictran
				where type in ('RC','CN','OAI','TRIN') 
				and fperiod < '#form.periodfrom#' 
				and fperiod<>'99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				and location='#target_location#'
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#' 
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by location,itemno
				order by location,itemno
			) as b on a.itemno=b.itemno and a.location=b.location
		
			left join
			(
				select 
				location,
				itemno,
				sum(qty) as getlastout 
				from ictran
				where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
				and fperiod < '#form.periodfrom#' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null) 
				and location='#target_location#'
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by location,itemno
				order by location,itemno
			) as c on a.itemno=c.itemno and a.location=c.location
		
			left join
			(
				select 
				location,
				itemno,
				sum(qty) as qin 
				from ictran 
				where type in ('RC','CN','OAI','TRIN')
				and fperiod<>'99' 
				and (void = '' or void is null)  
				and (linecode <> 'SV' or linecode is null)
				and location='#target_location#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by location,itemno
				order by location,itemno
			) as d on a.itemno=d.itemno and a.location=d.location
		
			left join
			(
				select 
				location,
				itemno,
				sum(qty) as qout 
				from ictran 
				where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				and location='#target_location#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by location,itemno
				order by location,itemno
			) as e on a.itemno=e.itemno and a.location=e.location
			
			where a.location<>''
            <cfif not isdefined("form.include0")>
				and (ifnull(a.locqfield,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
			and a.location='#target_location#'
			order by a.location
		</cfquery>
		

		<cfloop query="getiteminfo">
        <cftry>
        <cfset itemno2 = listgetat(itemno,1,'-')&"-"&listgetat(itemno,2,'-')>
        <cfset itemno1 = listgetat(itemno,1,'-')>
        <cfquery name="getitemdesp" datasource='#dts#'>
        select desp from icmitem where mitemno='#itemno1#' 
        </cfquery>
        <cfquery name="getcolourdesp" datasource="#dts#">
                select desp from iccolor2 where colorno='#listgetat(itemno,2,'-')#'
                </cfquery>
        <cfset colour = getcolourdesp.desp>
        <cfset qty1 = 'brem3'>
        
        <cfquery name="getitemsize" datasource='#dts#'>
        select sizeid from icitem where itemno='#getiteminfo.itemno#' 
        </cfquery>
        
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '45.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '46.0'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.5'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '34.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset qty1 = 'q115'>
        </cfif>
        </cfif>
        
        
        <cfquery name="checkexistitemno" datasource='#dts#'>
        select itemno,amt,qty from r_icbil_s where counter_4='#itemno2#' and location ='#getlocation.location#'
        </cfquery>
        <cfif checkexistitemno.recordcount eq 0>
        
		<cfquery name="InsertICBil_S" datasource='#dts#'>
	 		Insert into r_icbil_s (SRefno, No, ItemNo, Desp,despa, SN_No, Unit,qty,#qty1#, counter_4,location)
			values ('1','#j#','#itemno1#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getiteminfo.desp#" >,'#colour#','',
			'#jsstringformat(getiteminfo.unit)#','#jsstringformat(getiteminfo.balance)#','#jsstringformat(getiteminfo.balance)#','#itemno2#','#jsstringformat(getlocation.location)#')
	  	</cfquery>
         <cfelse>
    <cfset qtytotal=checkexistitemno.qty+getiteminfo.balance>
    <cfquery name="InsertICBil_S" datasource='#dts#'>
	 		update r_icbil_s set #qty1# = '#jsstringformat(getiteminfo.balance)#',qty='#qtytotal#' where counter_4='#itemno2#' and location ='#getlocation.location#'
	  	</cfquery>
</cfif>
<cfset j=j+1>
<cfcatch>
            </cfcatch>
            </cftry>
		</cfloop>
        
        <cfquery name="getdata" datasource='#dts#'>
        select * from r_icbil_s where location='#getlocation.location#' order by itemno
        </cfquery>
        <cfloop query="getdata">
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td colspan="10"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getdata.counter_4#</font></div></td>
                
                <cfquery name="gettotalqty" datasource='#dts#'>
	 		select sum(qty) as sumqty from r_icbil_s where counter_4='#getdata.counter_4#' and location ='#getlocation.location#'
	  	</cfquery>
                <td colspan="10"><div align="left"><font size="2" face="Times New Roman,Times,serif">#gettotalqty.sumqty#</font></div></td>
		<cfset grandtotal=grandtotal+gettotalqty.sumqty>

			</tr>
            
            </cfloop>
            <tr>
            <td colspan="100%"><hr></td>
            </tr>
		<tr>
        <td colspan="10"><font size="2" face="Times New Roman,Times,serif"><strong>Total Qty</strong></font></td>
			<td colspan="10"><font size="2" face="Times New Roman,Times,serif"><strong>#grandtotal#</strong></font></td>
		</tr>
        <tr>
            <td colspan="100%"><hr></td>
            </tr>
	</cfoutput>
</table>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>