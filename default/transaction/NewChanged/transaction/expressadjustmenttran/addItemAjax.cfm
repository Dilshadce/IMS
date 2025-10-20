<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
 group by frrefno
</cfquery>
<cfset url.itemno = URLDECODE(url.itemno)>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfsetting showdebugoutput="no">

<cfif url.location neq ''>
<cfquery name="addinlocationqtybf" datasource="#dts#">
insert ignore into locqdbf(itemno,location) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.location)#">)
</cfquery>
</cfif>


<cfif url.location eq ''>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getItemDetails" datasource="#dts#">
	select a.itemno,a.desp,a.ucost,a.unit,b.balance,a.qtyactual,a.shelf 
		from icitem as a 
			
		left join
		(
			select a.itemno,(ifnull(a.qtybf,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance
			from icitem as a
				
			left join
			(
				select itemno,sum(qty) as sum_in 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'
				and wos_date <= '#dateformat(createdate(right(url.date,4),mid(url.date,4,2),left(url.date,2)),"yyyy-mm-dd")#' 
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
				group by itemno
				order by itemno
			) as b on a.itemno=b.itemno
				
			left join
			(
				select itemno,sum(qty) as sum_out 
				from ictran
				where (type in (#PreserveSingleQuotes(outtrantype)#) or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'

				
				and wos_date <= '#dateformat(createdate(right(url.date,4),mid(url.date,4,2),left(url.date,2)),"yyyy-mm-dd")#' 
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
				
				group by itemno
				order by itemno
			) as c on a.itemno=c.itemno
			
			where a.itemno=a.itemno and
			a.itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
			order by a.itemno
		) as b on a.itemno=b.itemno 
	
		where a.itemno=a.itemno and
		a.itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">

		order by a.shelf,a.itemno;

</cfquery>

<cfelse>

<cfquery name="getItemDetails" datasource="#dts#">
	select 
	a.itemno,
	a.desp,
    a.category,
    a.wos_group,
	a.unit,
	a.shelf,
	a.ucost,
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
            
            and (void = '' or void is null)

			and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.location)#">
			
			and fperiod<>'99'


			and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">

			
			and wos_date <= '#dateformat(createdate(right(url.date,4),mid(url.date,4,2),left(url.date,2)),"yyyy-mm-dd")#'

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
			
			where (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            
            and (void = '' or void is null)

			and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.location)#">



			and fperiod<>'99'


			and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">


			and wos_date <= '#dateformat(createdate(right(url.date,4),mid(url.date,4,2),left(url.date,2)),"yyyy-mm-dd")#'

			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno

		and a.location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.location)#">
		
		and a.itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
        
	) as b on a.itemno=b.itemno
	
	where a.itemno=a.itemno 
	and b.location<>''
    
	and b.location =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.location)#">
	
	and a.itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">



	order by b.location,a.shelf,a.itemno;

</cfquery>
</cfif>
<cfset desp = getItemDetails.desp>
<cfif getItemDetails.recordcount neq 1 and url.itemno neq "">
<cfset desp = "itemisnoexisted" >
<cfset despa = "">
</cfif> 

<cfoutput>
<input type="hidden" name="desphid" id="desphid" value="#URLENCODEDFORMAT(desp)#" />
<input type="hidden" name="unithid" id="unithid" value="#getItemDetails.unit#" />
<input type="hidden" name="ucostid" id="ucostid" value="#getItemDetails.ucost#" />
<input type="hidden" name="qtyonhandid" id="qtyonhandid" value="#getItemDetails.balance#" />
</cfoutput>