<cfsetting showdebugoutput="no">
<cfquery name="getlocationqty" datasource="#dts#">

select 
	a.itemno,
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
		and itemno='#url.itemno#' 
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
			and fperiod<>'99'
			and itemno='#url.itemno#' 

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
			and fperiod<>'99'
			and itemno='#url.itemno#' 
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno='#url.itemno#' 
       

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''

    and a.itemno='#url.itemno#' 
	order by a.itemno;

</cfquery>
<cfoutput>
<table>
<cfloop query="getlocationqty">
<tr><td>#getlocationqty.location#</td><td>&nbsp;</td><td>#getlocationqty.balance#</td></tr>
</cfloop>
</table>
</cfoutput>