<html>
<head>
<title>Stock Card Report</title>
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

<table align="center" width="100%" border="0" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="6"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Stock Card Report</strong></font></div></td>
	</tr>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<tr>
			<td colspan="6"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.catefrom# - #form.cateto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="6"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<tr>
			<td colspan="6"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.period neq "">
		<tr>
			<td colspan="6"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.period#</font></div></td>
		</tr>
	</cfif>
	<cfif form.target_date neq "">
		<tr>
			<td colspan="6"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.target_date,"dd-mm-yyyy")#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="6"><hr/></td>
	</tr>
    <cfoutput>
    <!---
        <cfquery name="getcurrency" datasource='#dts#'>
        select ifnull(currp#form.period#,1) as currrate from currency where currcode="SGD"
        </cfquery>
        <cfif getcurrency.recordcount eq 0>--->
        <cfset currency = 1>
        <!---
        <cfelse>
        <cfset currency = getcurrency.currrate>
        </cfif>--->
    
	<tr>
		<td ><div align="left"><font size="2" face="Times New Roman,Times,serif">ART NO.</font></div></td>
        
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">Qty (PAIRS)</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">Unit Price (Pairs)</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">Unit Price (Pairs) @ #currency# = S$ </font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">Total Amount (Pairs)</font></div></td>
	</tr>
   <cfquery name="getlocation" datasource="#dts#">
	select 
	a.itemno,
    a.category,
    a.ucost,
    a.wos_group,
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
            category,
            wos_group,
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
     <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
	<cfif form.shelffrom neq "" and form.shelfto neq "">
	and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
	</cfif>

	and b.location = '#form.locationfrom#'

	<cfif not isdefined("form.include_stock")>
	and c.balance<>0
	</cfif> 
	group by b.location
	order by b.location;
</cfquery>
   </cfoutput>
	<tr>
		<td colspan="6"><hr/></td>
	</tr>
    		<cfset j=1>
	<cfoutput query="getlocation">
		<cfset location = getlocation.location>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif>: #getlocation.location#</u></strong></font></div></td>
		</tr>
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			a.itemno,
            a.category,
            a.ucost,
            a.wos_group,
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
            <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif form.shelffrom neq "" and form.shelfto neq "">
			and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
			</cfif>
			<cfif not isdefined("form.include_stock")>
			and b.balance<>0 
			</cfif> 
			order by a.shelf,a.itemno;		
		</cfquery>
        
        

		<cfloop query="getiteminfo">
        <cfquery name="getcolourdesp" datasource="#dts#">
        select desp from iccolor2 where colorno='#listgetat(getiteminfo.itemno,2,'-')#'
        </cfquery>
        <cfset colour=getcolourdesp.desp>
        
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.itemno#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.balance#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#lsnumberformat(getiteminfo.ucost*currency,",_.__")#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#lsnumberformat(getiteminfo.ucost,",_.__")#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#lsnumberformat(getiteminfo.ucost*getiteminfo.balance,",_.__")#</font></div></td>
                


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