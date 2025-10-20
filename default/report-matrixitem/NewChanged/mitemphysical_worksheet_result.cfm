<cfif isdefined('form.printpdf')>
<!---Print PDF ---->
<cfif form.target_date neq "">
<cfset ndate = createdate(right(form.target_date,4),mid(form.target_date,4,2),left(form.target_date,2))>
<cfset form.target_date = ndate >
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
<cfquery name="getGSetup2" datasource='#dts#'>
  	Select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,concat('.',repeat('_',Decl_Discount)) as Decl_Discount from gsetup2
</cfquery>
<cfquery name="ClearICBil_M" datasource="#dts#">
  	truncate r_IcBil_M
</cfquery>

<cfquery name="ClearICBil_S" datasource="#dts#">
  	truncate r_IcBil_S
</cfquery>
<cfoutput>
        <cfquery name="getlocation" datasource="#dts#">
	select 
	a.itemno,
	a.shelf,
	b.location,
	b.locationdesp,
	c.balance 
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		
		and location = '#form.locationfrom#'

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			<cfif form.period neq ""> 
			and fperiod <='#form.period#' and fperiod<>'99' 
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>

			and location = '#form.locationfrom#'

			<cfif form.target_date neq "">
			and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
			and toinv='' 
			<cfif form.period neq "">
			and fperiod <='#form.period#' and fperiod<>'99'
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>

			and location = '#form.locationfrom#'

			<cfif form.target_date neq "">
			and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>

		and a.location = '#form.locationfrom#' 

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
	and a.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	<cfif form.shelffrom neq "" and form.shelfto neq "">
	and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
	</cfif>
	<cfif form.sizefrom neq "" and form.sizeto neq "">
			and a.sizeid between '#form.sizefrom#' and '#form.sizeto#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
	and b.location = '#form.locationfrom#' 

	<cfif not isdefined("form.include_stock")>
	and c.balance<>0
	</cfif> 
	group by b.location
	order by b.location;
</cfquery>
</cfoutput>
    		<cfset j=1>
    
    <cfoutput query="getlocation">
		<cfset location = getlocation.location>
        <cfquery name="getiteminfo" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
			a.shelf,
			b.location,
			b.locqactual,
			b.balance 
			
			from icitem as a 
					
			left join 
			(
				select 
				a.location,
				a.itemno,
				a.locqactual,
				(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
				
				from locqdbf as a 
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_in 
					
					from ictran
					
					where type in ('RC','CN','OAI','TRIN') 
					and location='#location#'
					<cfif form.period neq ""> 
					and fperiod <='#form.period#' and fperiod<>'99' 
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.target_date neq "">
					and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as b on a.location=b.location and a.itemno=b.itemno
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_out 
					
					from ictran 
					
					where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
					and toinv='' 
					and location='#location#'
					<cfif form.period neq "">
					and fperiod <='#form.period#' and fperiod<>'99'
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.target_date neq "">
					and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as c on a.location=c.location and a.itemno=c.itemno 
				
				where a.location='#location#'
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
			) as b on a.itemno=b.itemno and b.location='#location#'
			
			where b.location='#location#'
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and a.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif form.shelffrom neq "" and form.shelfto neq "">
			and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
			</cfif>
            <cfif form.sizefrom neq "" and form.sizeto neq "">
			and a.sizeid between '#form.sizefrom#' and '#form.sizeto#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif not isdefined("form.include_stock")>
			and b.balance<>0 
			</cfif> 
			order by a.shelf,a.itemno;		
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
        select itemno,amt,qty from r_icbil_s where counter_4='#itemno2#'
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
	 		update r_icbil_s set #qty1# = '#jsstringformat(getiteminfo.balance)#',qty='#qtytotal#' where counter_4='#itemno2#'
	  	</cfquery>
</cfif>
<cfset j=j+1>
<cfcatch>
        </cfcatch>
        </cftry>
		</cfloop>
        </cfoutput>
        <cfquery name="MyQuery" datasource="#dts#">
select * from r_icbil_s order by itemno
</cfquery>
<cfoutput>
<cfreport template="matrixpysicalreport.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->

	<cfreportparam name="compro" value="#getgeneral.compro#">
	<cfreportparam name="compro2" value="#getgeneral.compro2#">
	<cfreportparam name="compro3" value="#getgeneral.compro3#">
	<cfreportparam name="compro4" value="#getgeneral.compro4#">
	<cfreportparam name="compro5" value="#getgeneral.compro5#">
	<cfreportparam name="compro6" value="#getgeneral.compro6#">
	<cfreportparam name="compro7" value="#getgeneral.compro7#">
    <cfreportparam name="location" value="#getlocation.location#">
    <cfreportparam name="catefrom" value="#form.catefrom#">
    <cfreportparam name="cateto" value="#form.cateto#">
    <cfreportparam name="groupfrom" value="#form.groupfrom#">
    <cfreportparam name="groupto" value="#form.groupto#">
    <cfreportparam name="itemfrom" value="#form.itemfrom#">
    <cfreportparam name="itemto" value="#form.itemto#">
    <cfreportparam name="period" value="#form.period#">
    <cfreportparam name="date" value="#form.target_date#">
</cfreport>
        </cfoutput>
<cfelse>
<!----End PDF --->
<html>
<head>
<title>Physical Worksheet Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>
<cfif form.target_date neq "">
<cfset ndate = createdate(right(form.target_date,4),mid(form.target_date,4,2),left(form.target_date,2))>
<cfset form.target_date = ndate >
</cfif>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup;
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
		<td colspan="20"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Inventory Physical Worksheet</strong></font></div></td>
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
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.period neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.period#</font></div></td>
		</tr>
	</cfif>
	<cfif form.target_date neq "">
		<tr>
			<td colspan="20"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.target_date,"dd-mm-yyyy")#</font></div></td>
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
    <td width="8%" rowspan="5"><div align="left"><font size="2" face="Times New Roman,Times,serif">ART NO.</font></div></td>
    <td width="9%"><div align="left"><font size="2" face="Times New Roman,Times,serif">38</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
    <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">39</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">40</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">41</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
      <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">42</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
      <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">43</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
      <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">44</font></div></td>
	  <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
      <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">45</font></div></td>
      <td width="5%"><div align="left"><font size="2" face="Times New Roman,Times,serif">46</font></div></td>
      <td width="7%" rowspan="5"><div align="left"><font size="2" face="Times New Roman,Times,serif">QTY</font></div></td>
  </tr>
    <tr>
    <td><div align="left"><font size="2" face="Times New Roman,Times,serif">4</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
    <td><div align="left"><font size="2" face="Times New Roman,Times,serif">5</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">6</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">7</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">8</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">9</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">10</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">11</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
    </tr>
	<tr>
		
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">22</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">23</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">24</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">25</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">26</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">27</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">28</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">29</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
       
	</tr>
    <tr>
    <td><div align="left"><font size="2" face="Times New Roman,Times,serif">35</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
    <td><div align="left"><font size="2" face="Times New Roman,Times,serif">36</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">37</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">38</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">39</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">40</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">41</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">42</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
    </tr>
    <tr>
    <td><div align="left"><font size="2" face="Times New Roman,Times,serif">27</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
    <td><div align="left"><font size="2" face="Times New Roman,Times,serif">28</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">29</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">30</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">31</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">32</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">33</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">34</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">35</font></div></td>
    </tr>
    
	<tr>
		<td colspan="20"><hr/></td>
	</tr>
    
	<cfoutput>
        <cfquery name="getlocation" datasource="#dts#">
	select 
	a.itemno,
	a.shelf,
	b.location,
	b.locationdesp,
	c.balance 
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		
		and location = '#form.locationfrom#'

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			<cfif form.period neq ""> 
			and fperiod <='#form.period#' and fperiod<>'99' 
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>

			and location = '#form.locationfrom#'

			<cfif form.target_date neq "">
			and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
			and toinv='' 
			<cfif form.period neq "">
			and fperiod <='#form.period#' and fperiod<>'99'
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>

			and location = '#form.locationfrom#'

			<cfif form.target_date neq "">
			and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		
		and a.location = '#form.locationfrom#' 

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
	and a.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	<cfif form.shelffrom neq "" and form.shelfto neq "">
	and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
	</cfif>
	<cfif form.sizefrom neq "" and form.sizeto neq "">
			and a.sizeid between '#form.sizefrom#' and '#form.sizeto#'
			</cfif>
    <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
	and b.location = '#form.locationfrom#' 

	<cfif not isdefined("form.include_stock")>
	and c.balance<>0
	</cfif> 
	group by b.location
	order by b.location;
</cfquery>
</cfoutput>
    		<cfset j=1>
    
    <cfoutput query="getlocation">
		<cfset location = getlocation.location>
		<tr>
			<td colspan="20"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif>: #getlocation.location#</u></strong></font></div></td>
		
		</tr>
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
			a.shelf,
			b.location,
			b.locqactual,
			b.balance 
			
			from icitem as a 
					
			left join 
			(
				select 
				a.location,
				a.itemno,
				a.locqactual,
				(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
				
				from locqdbf as a 
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_in 
					
					from ictran
					
					where type in ('RC','CN','OAI','TRIN') 
					and location='#location#'
					<cfif form.period neq ""> 
					and fperiod <='#form.period#' and fperiod<>'99' 
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.target_date neq "">
					and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as b on a.location=b.location and a.itemno=b.itemno
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_out 
					
					from ictran 
					
					where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
					and toinv='' 
					and location='#location#'
					<cfif form.period neq "">
					and fperiod <='#form.period#' and fperiod<>'99'
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.target_date neq "">
					and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as c on a.location=c.location and a.itemno=c.itemno 
				
				where a.location='#location#'
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
			) as b on a.itemno=b.itemno and b.location='#location#'
			
			where b.location='#location#'
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and a.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif form.shelffrom neq "" and form.shelfto neq "">
			and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
			</cfif>
            <cfif form.sizefrom neq "" and form.sizeto neq "">
			and a.sizeid between '#form.sizefrom#' and '#form.sizeto#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif not isdefined("form.include_stock")>
			and b.balance<>0 
			</cfif> 
			order by a.shelf,a.itemno;		
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
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getdata.counter_4#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q040 neq 0>#getdata.q040#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q045 neq 0>#getdata.q045#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q050 neq 0>#getdata.q050#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q055 neq 0>#getdata.q055#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q060 neq 0>#getdata.q060#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q065 neq 0>#getdata.q065#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q070 neq 0>#getdata.q070#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q075 neq 0>#getdata.q075#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q080 neq 0>#getdata.q080#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q085 neq 0>#getdata.q085#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q090 neq 0>#getdata.q090#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q095 neq 0>#getdata.q095#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q100 neq 0>#getdata.q100#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q105 neq 0>#getdata.q105#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q110 neq 0>#getdata.q110#<cfelse>&nbsp;</cfif></font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif getdata.q115 neq 0>#getdata.q115#<cfelse>&nbsp;</cfif></font></div></td>
                <cfquery name="gettotalqty" datasource='#dts#'>
	 		select sum(qty) as sumqty from r_icbil_s where counter_4='#getdata.counter_4#' and location ='#getlocation.location#'
	  	</cfquery>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#gettotalqty.sumqty#</font></div></td>


			</tr>
            
            </cfloop>
            
		<tr>
			<td><br/></td>
		</tr>
	</cfoutput>
</table>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>
</cfif>