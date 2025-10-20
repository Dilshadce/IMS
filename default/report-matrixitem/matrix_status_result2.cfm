<html>
<head>
<title>Item Status & Value Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">
<cfparam name="grandstkval" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear 
	from gsetup
</cfquery>


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
  	select * from gsetup2
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelseif lcase(hcomid) eq "meisei_i">  
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
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

<h3 align="center"><font face="Times New Roman, Times, serif">Matrix - Item Status and Value</font></h3>
<h4 align="center"><font face="Times New Roman, Times, serif">Calculated by <cfoutput>#costingmethod#</cfoutput></font></h4>


<cfquery name="getmatrixitem" datasource="#dts#">
select mitemno from icmitem 
<cfif trim(form.mitemfrom) neq "" and trim(form.mitemto) neq "">
		where mitemno between '#form.mitemfrom#' and '#form.mitemto#'
	</cfif>
    order by mitemno
</cfquery>

	<table align="center" border="0" width="100%">
		<cfoutput>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">
					#dateformat(dateadd('m',form.periodfrom,getgeneral.lastaccyear),"mmm yy")# - #dateformat(dateadd('m',form.periodto,getgeneral.lastaccyear),"mmm yy")#
				</font></div></td>		
			</tr>
		</cfif>
		<tr>
			<td colspan="4"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></div></td>
	    	<td colspan="5"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">DESPCRIPTION</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">QTYBF</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">IN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">OUT</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ON HAND</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">
				<cfif getgeneral.cost eq "FIXED">UNIT COST<cfelseif getgeneral.cost eq "MONTH">AVERAGE<cfelseif getgeneral.cost eq "MOVING">AVERAGE</cfif>
			</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">STOCK VALUE</font></div></td>
	    </tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
		<cfloop query="getmatrixitem">
        <!----
			<cfset target_location = getmatrixitem.location>
			<cfset target_location_desp = getmatrixitem.location_desp>--->
			<cfset locationqtybf=0>
			<cfset locationqtyin=0>
			<cfset locationqtyout=0>
			<cfset locationbalanceqty=0>
			<cfset locationstkval=0>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Matrix Item No: #getmatrixitem.mitemno# </strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong></strong></font></div></td>
			</tr>
            
            <cfquery name="getmatrixcolour" datasource="#dts#">
			select * from icmitem where mitemno='#getmatrixitem.mitemno#' order by mitemno
			</cfquery>
            <cfset colorlist = "">
            <cfset colorcount = 0>
			<cfloop from="1" to="20" index="i">
				<cfif getmatrixcolour["color#i#"][getmatrixcolour.currentrow] neq "">
					<cfif colorlist eq "">
						<cfset colorlist = getmatrixcolour["color#i#"][getmatrixcolour.currentrow]>
                        <cfset colorcount = 1>
					<cfelse>
						<cfset colorlist = colorlist&','&getmatrixcolour["color#i#"][getmatrixcolour.currentrow]>
                        <cfset colorcount = colorcount+1>
					</cfif>
				</cfif>
			</cfloop>
            
			<cfloop from="1" to="#colorcount#" index="j">
				<cfset itemno = getmatrixitem.mitemno&'-'&ListGetAt(colorlist,j,',')&'%'>
                <cfquery name="getcolourdesp" datasource="#dts#">
                select desp from iccolor2 where colorno='#ListGetAt(colorlist,j,',')#'
                </cfquery>
				<cfset itemnodesp = getcolourdesp.desp>
				<cfset groupqtybf=0>
				<cfset groupqtyin=0>
				<cfset groupqtyout=0>
				<cfset groupbalanceqty=0>
				<cfset groupstkval=0>
				<cfset groupcounter=0>
				
				<tr>
					<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u>Colour: #itemnodesp#</u></font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u></u></font></div></td>
				</tr>
				<cfif getgeneral.cost eq "FIXED">
					<cfquery name="getitem" datasource="#dts#">
						select a.location,a.itemno,b.desp,b.ucost,
						(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
						ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
						((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
						((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
							
						from locqdbf as a
				
						right join
						(
							select itemno,desp,ucost,wos_group
							from icitem 
							where itemno<>'' 
							and itemno like '#itemno#'
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
						) as b on a.itemno=b.itemno
					
						left join
						(
							select location,itemno,sum(qty) as lastin 
							from ictran
							where type in ('RC','CN','OAI','TRIN') 
							and fperiod < '#form.periodfrom#' 
							and fperiod<>'99'
							and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
							and itemno like '#itemno#'
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date < #date1# 
							</cfif>
							 
							<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
								and category between '#form.Catefrom#' and '#form.Cateto#'
							</cfif>
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by location,itemno
						) as c on (a.itemno=c.itemno and a.location=c.location)
						
						left join
						(
							select sum(qty) as lastout,itemno,location 
							from ictran
							where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
							and fperiod < '#form.periodfrom#' 
							and fperiod<>'99'
							and toinv=''
							and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
							and itemno like '#itemno#' 
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date < #date1# 
							</cfif>
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by itemno,location
						) as d on (a.itemno=d.itemno and a.location=d.location)
				
						left join
						(
							select sum(qty) as qin,itemno,location 
							from ictran
							where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
							and itemno like '#itemno#' 
							and fperiod <> '99'
							and (linecode <> 'SV' or linecode is null) 
							<cfif form.periodfrom neq "" and form.periodto neq "">
								and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
							</cfif> 
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date between #date1# and #date2# 
							</cfif>
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
							
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by itemno,location
						) as e on (a.itemno=e.itemno and a.location=e.location)
						
						left join
						(
							select sum(qty) as qout,itemno,location  
							from ictran
							where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (void = '' or void is null) and toinv=''
							and itemno like '#itemno#' 
							and fperiod <> '99'
							and (linecode <> 'SV' or linecode is null) 
							<cfif form.periodfrom neq "" and form.periodto neq "">
								and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
							</cfif> 
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date between #date1# and #date2# 
							</cfif>
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
							
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by itemno,location 
						) as f on (a.itemno=f.itemno and a.location=f.location)
				
						where a.itemno like '#itemno#'
						
						<cfif isdefined("form.include0")>
						<cfelse>
							and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
						</cfif>
						<cfif isdefined("form.qty0")>
						<cfelse>
							and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
						</cfif>
						<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
							and b.category between '#form.catefrom#' and '#form.cateto#'
						</cfif>
						
						order by a.itemno
					</cfquery>
                <cfelseif getgeneral.cost eq "MONTH">
                    <cfquery name="getitem" datasource="#dts#">
                        select a.location,a.itemno,b.desp,
                        (ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
                        ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
                        ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
                        ((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0))) as ucost,
                        (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) as stockbalance
                            
                        from locqdbf as a
                
                        right join
                        (
                            select itemno,desp,avcost,wos_group
                            from icitem 
                            where itemno<>'' 
                            and itemno like '#itemno#'
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                        ) as b on a.itemno=b.itemno
                    
                        left join
                        (
                            select location,itemno,sum(qty) as lastin 
                            from ictran
                            where type in ('RC','CN','OAI','TRIN') 
                            and fperiod < '#form.periodfrom#' 
                            and fperiod<>'99'
                            and (void = '' or void is null) 
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date < #date1# 
                            </cfif>
                             
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by location,itemno
                        ) as c on (a.itemno=c.itemno and a.location=c.location)
                        
                        left join
                        (
                            select sum(qty) as lastout,itemno,location 
                            from ictran
                            where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
                            and fperiod < '#form.periodfrom#' 
                            and fperiod<>'99'
                            and toinv=''
                            and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date < #date1# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location
                        ) as d on (a.itemno=d.itemno and a.location=d.location)
                
                        left join
                        (
                            select sum(qty) as qin,itemno,location 
                            from ictran
                            where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            and fperiod <> '99'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location
                        ) as e on (a.itemno=e.itemno and a.location=e.location)
                        
                        left join
                        (
                            select sum(qty) as qout,itemno,location  
                            from ictran
                            where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (void = '' or void is null) and toinv=''
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            and fperiod <> '99'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location 
                        ) as f on (a.itemno=f.itemno and a.location=f.location)
                        
                        left join
                        (
                            select sum(qty) as rcqty,sum(amt) as rcamt,itemno,location   
                            from ictran
                            where type='RC' and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                            	and fperiod+0 <= '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location  
                        ) as g on (a.itemno=g.itemno and a.location=g.location)
                        
                        left join
                        (
                            select sum(qty) as prqty,sum(amt) as pramt,itemno,location   
                            from ictran
                            where type='PR' and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                            	and fperiod+0 <= '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location  
                        ) as h on (a.itemno=h.itemno and a.location=h.location)
                
                        where a.itemno like '#itemno#'
                        
                        <cfif isdefined("form.include0")>
                        <cfelse>
                            and (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) > 0
                        </cfif>
                        <cfif isdefined("form.qty0")>
                        <cfelse>
                            and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
                        </cfif>
                        <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                            and b.category between '#form.catefrom#' and '#form.cateto#'
                        </cfif>
                        
                        order by a.itemno,a.location
                    </cfquery>
                <cfelseif getgeneral.cost eq "MOVING">
                    <cfquery name="getitem" datasource="#dts#">
                        select a.location,a.itemno,b.desp,
                        (ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
                        ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
                        ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
                        ((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0))) as ucost,
                        (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) as stockbalance
                            
                        from locqdbf as a
                
                        right join
                        (
                            select itemno,desp,avcost2,wos_group
                            from icitem 
                            where itemno<>'' 
                            and itemno like '#itemno#'
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                        ) as b on a.itemno=b.itemno
                    
                        left join
                        (
                            select location,itemno,sum(qty) as lastin 
                            from ictran
                            where type in ('RC','CN','OAI','TRIN') 
                            and fperiod < '#form.periodfrom#' 
                            and fperiod<>'99'
                            and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date < #date1# 
                            </cfif>
                             
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by location,itemno
                        ) as c on (a.itemno=c.itemno and a.location=c.location)
                        
                        left join
                        (
                            select sum(qty) as lastout,itemno,location 
                            from ictran
                            where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
                            and fperiod < '#form.periodfrom#' 
                            and fperiod<>'99'
                            and toinv=''
                            and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date < #date1# 
                            </cfif>
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location
                        ) as d on (a.itemno=d.itemno and a.location=d.location)
                
                        left join
                        (
                            select sum(qty) as qin,itemno,location 
                            from ictran
                            where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            and fperiod <> '99'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location
                        ) as e on (a.itemno=e.itemno and a.location=e.location)
                        
                        left join
                        (
                            select sum(qty) as qout,itemno,location  
                            from ictran
                            where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (void = '' or void is null) and toinv=''
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            and fperiod <> '99'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location 
                        ) as f on (a.itemno=f.itemno and a.location=f.location)
                        
                        left join
                        (
                            select sum(qty) as rcqty,sum(amt) as rcamt,itemno,location   
                            from ictran
                            where type='RC' and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 <= '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location  
                        ) as g on (a.itemno=g.itemno and a.location=g.location)
                        
                        left join
                        (
                            select sum(qty) as prqty,sum(amt) as pramt,itemno,location   
                            from ictran
                            where type='PR' and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 <= '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location  
                        ) as h on (a.itemno=h.itemno and a.location=h.location)
                        
                        left join
                        (
                            select sum(qty) as movqin,itemno,location  
                            from ictran
                            where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null) and itemno like '#itemno#')	and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 <= '#form.periodto#'
                            </cfif>
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                             
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location 
                        ) as i on (a.itemno=i.itemno and a.location=i.location)
        
                        left join
                        (
                            select sum(qty) as movqout,itemno,location 
                            from ictran
                            where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null) and itemno like '#itemno#') and (void = '' or void is null)
                            and itemno like '#itemno#'
							and (linecode <> 'SV' or linecode is null) 
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 <= '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                             
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location
                        ) as j on (a.itemno=j.itemno and a.location=j.location)
                
                        where a.itemno like '#itemno#'
                        
                        <cfif isdefined("form.include0")>
                        <cfelse>
                            and (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) > 0
                        </cfif>
                        <cfif isdefined("form.qty0")>
                        <cfelse>
                            and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
                        </cfif>
                        <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                            and b.category between '#form.catefrom#' and '#form.cateto#'
                        </cfif>
                        
                        order by a.itemno,a.location
                    </cfquery>	
				<cfelseif getgeneral.cost eq "FIFO" or getgeneral.cost eq "LIFO">
					<cfquery name="getitem" datasource="#dts#">
						select a.location,a.itemno,b.desp,b.ucost,
						(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
						ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
						((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
						((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
							
						from locqdbf as a
				
						right join
						(
							select itemno,desp,ucost,wos_group
							from icitem 
							where itemno<>'' 
							and itemno like '#itemno#'
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
						) as b on a.itemno=b.itemno
					
						left join
						(
							select location,itemno,sum(qty) as lastin 
							from ictran
							where type in ('RC','CN','OAI','TRIN') 
							and fperiod < '#form.periodfrom#' 
							and fperiod<>'99'
							and (void = '' or void is null) 
							and (linecode <> 'SV' or linecode is null) 
							and itemno like '#itemno#'
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date < #date1# 
							</cfif>
							 
							<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
								and category between '#form.Catefrom#' and '#form.Cateto#'
							</cfif>
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by location,itemno
						) as c on (a.itemno=c.itemno and a.location=c.location)
						
						left join
						(
							select sum(qty) as lastout,itemno,location 
							from ictran
							where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
							and fperiod < '#form.periodfrom#' 
							and fperiod<>'99'
							and toinv=''
							and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
							and itemno like '#itemno#' 
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date < #date1# 
							</cfif>
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by itemno,location
						) as d on (a.itemno=d.itemno and a.location=d.location)
				
						left join
						(
							select sum(qty) as qin,itemno,location 
							from ictran
							where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
							and itemno like '#itemno#' 
							and fperiod <> '99'
							and (linecode <> 'SV' or linecode is null) 
							<cfif form.periodfrom neq "" and form.periodto neq "">
								and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
							</cfif> 
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date between #date1# and #date2# 
							</cfif>
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
							
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by itemno,location
						) as e on (a.itemno=e.itemno and a.location=e.location)
						
						left join
						(
							select sum(qty) as qout,itemno,location  
							from ictran
							where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (void = '' or void is null) and toinv=''
							and itemno like '#itemno#' 
							and fperiod <> '99'
							and (linecode <> 'SV' or linecode is null) 
							<cfif form.periodfrom neq "" and form.periodto neq "">
								and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
							</cfif> 
							<cfif form.datefrom neq "" and form.dateto neq "">
								and wos_date between #date1# and #date2# 
							</cfif>
							<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
								and category between '#form.catefrom#' and '#form.cateto#'
							</cfif>
							
							
							<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
								and custno between '#form.suppfrom#' and '#form.suppto#'
							</cfif>
							group by itemno,location 
						) as f on (a.itemno=f.itemno and a.location=f.location)
				
						where a.itemno like '#itemno#'
						<cfif isdefined("form.include0")>
						<cfelse>
							and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
						</cfif>
						<cfif isdefined("form.qty0")>
						<cfelse>
							and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
						</cfif>
						<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
							and b.category between '#form.catefrom#' and '#form.cateto#'
						</cfif>
						
						order by a.itemno
					</cfquery>
                <cfelseif getgeneral.cost eq "MONTH">
                    <cfquery name="getitem" datasource="#dts#">
                        select a.location,a.itemno,b.desp,
                        (ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
                        ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
                        ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
                        ((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0))) as ucost,
                        (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) as stockbalance
                            
                        from locqdbf as a
                
                        right join
                        (
                            select itemno,desp,avcost,wos_group
                            from icitem 
                            where itemno<>'' 
                            and itemno like '#itemno#'
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                        ) as b on a.itemno=b.itemno
                    
                        left join
                        (
                            select location,itemno,sum(qty) as lastin 
                            from ictran
                            where type in ('RC','CN','OAI','TRIN') 
                            and fperiod < '#form.periodfrom#' 
                            and fperiod<>'99'
                            and (void = '' or void is null) 
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date < #date1# 
                            </cfif>
                             
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by location,itemno
                        ) as c on (a.itemno=c.itemno and a.location=c.location)
                        
                        left join
                        (
                            select sum(qty) as lastout,itemno,location 
                            from ictran
                            where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
                            and fperiod < '#form.periodfrom#' 
                            and fperiod<>'99'
                            and toinv=''
                            and (void = '' or void is null) 
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date < #date1# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location
                        ) as d on (a.itemno=d.itemno and a.location=d.location)
                
                        left join
                        (
                            select sum(qty) as qin,itemno,location 
                            from ictran
                            where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
                            and itemno like '#itemno#'
                            and fperiod <> '99'
							and (linecode <> 'SV' or linecode is null) 
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location
                        ) as e on (a.itemno=e.itemno and a.location=e.location)
                        
                        left join
                        (
                            select sum(qty) as qout,itemno,location  
                            from ictran
                            where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (void = '' or void is null) and toinv=''
                            and itemno like '#itemno#'
                            and fperiod <> '99'
							and (linecode <> 'SV' or linecode is null) 
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                                and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location 
                        ) as f on (a.itemno=f.itemno and a.location=f.location)
                        
                        left join
                        (
                            select sum(qty) as rcqty,sum(amt) as rcamt,itemno,location   
                            from ictran
                            where type='RC' and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                            	and fperiod+0 <= '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location  
                        ) as g on (a.itemno=g.itemno and a.location=g.location)
                        
                        left join
                        (
                            select sum(qty) as prqty,sum(amt) as pramt,itemno,location   
                            from ictran
                            where type='PR' and (void = '' or void is null)
							and (linecode <> 'SV' or linecode is null) 
                            and itemno like '#itemno#'
                            <cfif form.periodfrom neq "" and form.periodto neq "">
                            	and fperiod+0 <= '#form.periodto#'
                            </cfif> 
                            <cfif form.datefrom neq "" and form.dateto neq "">
                                and wos_date between #date1# and #date2# 
                            </cfif>
                            <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                                and category between '#form.catefrom#' and '#form.cateto#'
                            </cfif>
                            
                            <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                                and custno between '#form.suppfrom#' and '#form.suppto#'
                            </cfif>
                            group by itemno,location  
                        ) as h on (a.itemno=h.itemno and a.location=h.location)
                
                        where a.itemno like '#itemno#'
                        
                        <cfif isdefined("form.include0")>
                        <cfelse>
                            and (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) > 0
                        </cfif>
                        <cfif isdefined("form.qty0")>
                        <cfelse>
                            and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
                        </cfif>
                        <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                            and b.category between '#form.catefrom#' and '#form.cateto#'
                        </cfif>
                        
                        order by a.itemno,a.location
                    </cfquery>
				</cfif>
                <cfloop query="getitem">
					<cfset groupcounter=groupcounter+1>
                	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qtybf#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qin#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qout#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.balance#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.ucost),stDecl_UPrice)#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.stockbalance),stDecl_TPrice)#</font></div></td>
                    </tr>
                    <cfset groupqtybf=groupqtybf+val(getitem.qtybf)>
					<cfset groupqtyin=groupqtyin+val(getitem.qin)>
                    <cfset groupqtyout=groupqtyout+val(getitem.qout)>
                    <cfset groupbalanceqty=groupbalanceqty+val(getitem.balance)>
                    <cfset groupstkval=groupstkval+val(getitem.stockbalance)>
					<cfset locationqtybf=locationqtybf+val(getitem.qtybf)>
					<cfset locationqtyin=locationqtyin+val(getitem.qin)>
					<cfset locationqtyout=locationqtyout+val(getitem.qout)>
					<cfset locationbalanceqty=locationbalanceqty+val(getitem.balance)>
					<cfset locationstkval=locationstkval+val(getitem.stockbalance)>
                    <cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
                    <cfset grandqtyin=grandqtyin+val(getitem.qin)>
                    <cfset grandqtyout=grandqtyout+val(getitem.qout)>
                    <cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>
                    <cfset grandstkval=grandstkval+val(getitem.stockbalance)>
                </cfloop>
                <cfif groupcounter neq 0>
					<tr>
	                    <td></td>
	                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
	                    <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupqtybf,"0")#</font></div></td>
	                    <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupqtyin,"0")#</font></div></td>
	                    <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupqtyout,"0")#</font></div></td>
	                    <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupbalanceqty,"0")#</font></div></td>
	                    <td></td>
	                    <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupstkval,stDecl_TPrice)#</font></div></td>
	                </tr>    
				</cfif>
				<tr><td height="5"></td></tr>
			</cfloop>
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
        		<td></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">LOCATION TOTAL:</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(locationqtybf,"0")#</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(locationqtyin,"0")#</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(locationqtyout,"0")#</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(locationbalanceqty,"0")#</font></div></td>
		        <td></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(locationstkval,stDecl_TPrice)#</font></div></td>
		    </tr>
		</cfloop>
		
		<tr><td height="10"></td></tr>
		<tr>
        	<td></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandqtybf,"0")#</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandqtyin,"0")#</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandqtyout,"0")#</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandbalanceqty,"0")#</strong></font></div></td>
		    <td></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandstkval,stDecl_TPrice)#</strong></font></div></td>
		</tr>
		</cfoutput>
	</table>
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