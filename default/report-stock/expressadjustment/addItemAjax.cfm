<cfsetting showdebugoutput="no">

<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
 group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

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
				and wos_date <= '#lsdateformat(url.date,"yyyy-mm-dd")#' 
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

				
				and wos_date <= '#lsdateformat(url.date,"yyyy-mm-dd")#' 
				
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