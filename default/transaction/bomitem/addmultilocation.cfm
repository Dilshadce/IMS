<cfoutput>
<cfquery name="insert_new_location_item" datasource="#dts#">
	insert ignore into locqdbf 
	(
		itemno,
		location
	)
	(
		select 
		itemno,
		location 
		from ictran 
		where location<>''
		and (linecode <> 'SV' or linecode is null)
			and itemno ='#listfirst(url.itemno)#'
		group by location,itemno
		order by location,itemno
	)
</cfquery>


<cfquery name="getlocation" datasource="#dts#">
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)-ifnull(d.iSOqty,0)-ifnull(e.SAMMqty,0)) as balance 
		
		from locqdbf as a 
		
        right join(select itemno from icitem order by itemno) as aa on aa.itemno=a.itemno
        
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
			and itemno='#listfirst(url.itemno)#' 
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
			and itemno='#listfirst(url.itemno)#' 

			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
        left join
        
        (
        select itemno,location,ifnull(sum(qty)-sum(shipped)-sum(writeoff),0) as iSOqty 
					from ictran 
					where type='SO'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					group by itemno,location
        )as d on a.location=d.location and a.itemno=d.itemno 
        
         left join
        
        (
       select itemno,location,ifnull(sum(qty)-sum(shipped)-sum(writeoff),0) as SAMMqty 
					from ictran 
					where type='SAMM'
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null) 
					and (toinv='' or toinv is null)
					group by itemno,location
        )as e on a.location=e.location and a.itemno=e.itemno 
        
        
		where a.itemno=a.itemno
		and aa.itemno='#listfirst(url.itemno)#' 
        and (ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)-ifnull(d.iSOqty,0)-ifnull(e.SAMMqty,0)) <> 0
        group by a.location,a.itemno
		order by a.location,a.itemno
</cfquery>

<cfset onsubvar = "">

<h1>MultiLocation</h1>
<cfform name="heatnoprocess" action="/default/transaction/bomitem/addmultilocationprocess.cfm" method="post">

<input type="hidden" name="multinexttranno" id="multinexttranno" value="#urldecode(listfirst(url.refno))#" />
<input type="hidden" name="multitran" id="multitran" value="#url.type#" />
<input type="hidden" name="multitranrecordcount" id="multitranrecordcount" value="#getlocation.recordcount#" />
Item No : #listfirst(url.itemno)# <br />
<cfquery name="getitemproductcode" datasource="#dts#">
select aitemno from icitem where itemno='#listfirst(url.itemno)#'
</cfquery>
Product Code : #getitemproductcode.aitemno# <br />
Need Qty : #listfirst(url.needqty)#
<input type="hidden" name="multiitemno" id="multiitemno" value="#URLDECODE(listfirst(url.itemno))#" />
<input type="hidden" name="bomlocationcurrentrow" id="bomlocationcurrentrow" value="#URLDECODE(listfirst(url.row))#" />
<input type="hidden" name="checklocationbomitemqty" id="checklocationbomitemqty" />
<input type="hidden" name="checklocationbomitemqtybal" id="checklocationbomitemqtybal"/>
<table id="heatnotbl" width="450px">
<tr>
<th width="100px">Location</th>

<th width="100px">Available Quantity</th>
<th width="100px">Quantity</th>

</tr>

<cfloop query="getlocation">
<tr>
<td>#getlocation.location# <input type="hidden" name="multilocation_#getlocation.currentrow#" id="multilocation_#getlocation.currentrow#" value="#getlocation.location#" readonly></td>

<!---
<cfquery name="getlocationqtybf" datasource="#dts#">
		select 
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
		and itemno='#urldecode(url.refno)#' 

		and location ='#getlocation.location#'

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
			and itemno='#urldecode(url.refno)#' 

			and location ='#getlocation.location#'


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
			and itemno='#urldecode(url.refno)#' 

			and location ='#getlocation.location#'

			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno='#urldecode(url.refno)#' 
       

		and a.location ='#getlocation.location#'

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''

	and b.location ='#getlocation.location#'

    and a.itemno='#urldecode(url.refno)#' 
	order by a.itemno;
</cfquery>--->
<td>#getlocation.balance#</td>


<td><input type="text" name="multilocationqty_#getlocation.currentrow#" id="multilocationqty_#getlocation.currentrow#" value="0" size="15" onchange="document.getElementById('checklocationbomitemqty').value=this.value;document.getElementById('checklocationbomitemqtybal').value='#val(getlocation.balance)#';locationbomcheck();"></td>
</tr>

</cfloop>
</table>
<div align="center">
<input type="submit" name="heatnosubbtn" id="heatnosubbtn" value="Save">
&nbsp; &nbsp;
<input type="button" name="clostbtn" id="closebtn" value="Close" onclick="ColdFusion.Window.hide('bomaddmultilocation');" />
</div>
</cfform>
</cfoutput>