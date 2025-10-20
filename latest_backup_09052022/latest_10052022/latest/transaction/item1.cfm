
<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "65, 1302, 120, 121, 1096,1133">
<cfinclude template="/latest/words.cfm">

<cfquery name="getitem" datasource="#dts#">
	SELECT itemno,aitemno,desp,despa,price,qtybf
    FROM icitem
    WHERE itemno="#itemno#" or aitemno="#itemno#";
</cfquery>

<cfquery name="getcurrency" datasource="#dts#">
	SELECT bcurr from gsetup
</cfquery>

<cfquery name="getcurrency2" datasource="#dts#">
	SELECT currency from #target_currency# where currcode="#getcurrency.bcurr#"
</cfquery>

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
and itemno='#getitem.itemno#' 
group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>


<cfquery name="getitembalance" datasource="#dts#">
    select 
	b.location,
	b.locationdesp,
	c.balance ,
    c.locqfield as qtybf
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
        locqfield,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
        and itemno ="#getitem.itemno#"
	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
        locqfield,
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
            and (void='' or void is null)
            and (linecode="" or linecode is null)
			and itemno ="#getitem.itemno#"

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
			and fperiod<>'99'
            and (void='' or void is null)
            and (linecode="" or linecode is null)
			and itemno ="#getitem.itemno#"
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno ="#getitem.itemno#"
	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	and (a.itemtype <> 'SV' or a.itemtype is null)

	and a.itemno ="#getitem.itemno#"
    and c.balance <>0
	order by a.itemno;
    
</cfquery>

<cfif getitembalance.recordcount eq 0>

<cfquery name="getitembalance" datasource="#dts#">
    select 
	a.itemno,
    '' as location,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getitem.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
        and (linecode='' or linecode is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where
        (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
		and itemno='#getitem.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
        and (linecode='' or linecode is null)
		group by itemno
	) as c on a.itemno=c.itemno
    
	
	where a.itemno='#getitem.itemno#' 
</cfquery>

</cfif>

<cfoutput>
<center>
<table  width="100%">
<tr>							
	<td width="30%" nowrap>#words[120]#</td>
    <td>:</td>
	<td><input type="text" name="itema" id="itema" style="font-size:50px; color:black; background-color:transparent; border:none;" disabled value="#getitem.itemno#"></td>
</tr>
<tr>
	<td width="30%" nowrap>#words[121]#</td>
    <td>:</td>
    <td><input type="text" name="aitema" id="aitema" style="font-size:50px; background-color:transparent; border:none;" disabled value="#getitem.aitemno#"></td>
</tr>
<tr>
	<td width="30%" nowrap>#words[65]#</td>
    <td>:</td>
	<td><input type="text" name="desp" id="desp" style="font-size:50px; color:black; background-color:transparent; border:none;" disabled value="#getitem.desp#  #getitem.despa#"></td>
</tr>
<tr>
	<td width="30%" nowrap>#words[1133]#</td>
    <td>:</td>
	<td><!---<input type="text" name="qtybf" size="50" id="qtybf" style="font-size:50px;color:black; background-color:transparent; border:none;" disabled value="#getitembalance.balance#">---><div style="font-size:32px; color:##000"><cfloop query="getitembalance"><cfif getitembalance.location neq "">#getitembalance.location# - </cfif>#getitembalance.balance#&nbsp;&nbsp;&nbsp;&nbsp;</cfloop></div></td>
</tr>
<tr>									
	<td width="30%" nowrap>#words[1096]#</td>
    <td>:</td>
    <td><input type="text" name="price" id="price" style="font-size:50px; color:black; background-color:transparent; border:none;" disabled value="#getcurrency2.currency# #getitem.price#"></td>
</tr>	
<tr align="center"><td colspan="3"><input type="button" class="bttn" name="close" value="Close Window" onClick="window.close();"></td></tr>
</table>
</center>
</cfoutput>
