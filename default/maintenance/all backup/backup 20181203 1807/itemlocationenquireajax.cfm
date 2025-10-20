<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
and itemno='#url.itemno#' 
 group by frrefno
</cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfquery datasource="#dts#" name="getitem">

	select
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
            and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
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
			
			where 
			<cfif isdefined('form.dodate')>
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>

		type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and (toinv='' or toinv is null) 
		</cfif>
        and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
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
  <cfif getitem.recordcount eq 0>
  <h3>Item Not Found</h3>
  <cfelse>
  <table border="1" align="center" width="90%" class="data">
  <tr>
  <th width="30">Location</th>
  <cfloop query="getitem">
  <td align="center" nowrap>
  #getitem.location#
  </td>
  </cfloop>
  </tr>
  <tr>
  <th>Qty</th>
  <cfloop query="getitem">
  <td align="center">
  #getitem.balance#
  </td>
  </cfloop>
  
  </tr>
  </table>
  </cfif>
  </cfoutput>

