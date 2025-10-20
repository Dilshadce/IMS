<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
 group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfsetting showdebugoutput="no">
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

			
			and wos_date <= '#lsdateformat(url.date,"yyyy-mm-dd")#'

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


			and wos_date <= '#lsdateformat(url.date,"yyyy-mm-dd")#'

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