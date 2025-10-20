<!--- insert ISS ictran --->
<cfquery name="getbom" datasource="#dts#">
	select * from billmat where itemno = '#form.itemno#' and bomno = '#form.bomno#' group by itemno,bomno,bmitemno order by bmitemno
</cfquery>

<cfif getbom.recordcount neq 0><!---Added 20110211 --->

<cfquery datasource='#dts#' name="checkitemExist">
	select * from ictran where refno='#nexttranno#' and type = 'ISS'
</cfquery>

<cfset bomcostmethod1=''>

<cfif checkitemExist.recordcount GT 0>
	<cfset largest = 0>	
	
	<cfoutput query="checkitemExist">
		<cfset itemcnt = checkitemExist.itemcount>
		
		<cfif itemcnt gt largest>
			<cfset largest = itemcnt>
		</cfif>
	</cfoutput>
	
	<cfset itemcnt = largest + 1>
<cfelse>
	<cfset itemcnt = 1>
</cfif>

<cfset totalprice = 0>

<cfoutput query="getbom">
	<cfquery name="getitem" datasource="#dts#">
		select * from icitem where itemno = '#bmitemno#'
	</cfquery>
	<cfif isdefined('form.movingavrg')>
    <!--- Get average moving cost --->
    <cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU'">
</cfif>
 <cfquery name="getitem2" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,ifnull(((ifnull(a.qtybf,0))+ifnull(d.qin,0)-ifnull(e.qout,0)),0) as balance,
							((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				ifnull((((ifnull(a.qtybf,0))+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))),1) as stockbalance
			
			from icitem as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
                and fperiod<>'99'
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				and fperiod<>'99'
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod<>'99'
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
					and aa.itemno ='#bmitemno#'
				
				group by aa.itemno
			) as j on a.itemno = j.itemno
	

			where a.itemno <> ''
			
			and a.itemno ='#bmitemno#'
			
			order by a.itemno;
		</cfquery>
    <!--- end of average moving cost --->
    </cfif>
    
    <cfif isdefined('form.movingavrg')>
    <cfif getitem2.balance gt 0>
    <cfset itemprice = getitem2.stockbalance/getitem2.balance>
    <cfset bomcostmethod1='By Moving Average'>
    <cfelse>
    <cfset itemprice = 0>
    <cfset bomcostmethod1=''>
    </cfif>
    <cfelse>
    	
	<cfif getitem.price neq "">
		<!--- <cfset itemprice = getitem.price> --->
       
		<cfset itemprice = getitem.ucost>
	<cfelse>		
		<cfset itemprice = 0>
	</cfif>
    </cfif>
	<cfset amt1_bil = (form.qty * bmqty) * itemprice>
	<cfset disamt_bil = 0>
	<cfset netamt = amt1_bil - disamt_bil>
	<cfset taxamt_bil = 0>
	<!--- <cfset amt_bil = netamt + taxamt_bil> --->
    <cfset amt_bil = netamt>
	<cfset xprice = itemprice * currrate>
	<cfset amt1 = amt1_bil * currrate>
	<cfset disamt = disamt_bil * currrate>
	<cfset taxamt = taxamt_bil * currrate>
	<cfset amt = amt_bil * currrate>
	<cfset totalprice = totalprice + amt1_bil>
			
	<cftry>
        <cfquery datasource="#dts#" name="insertictran">
            Insert into ictran (type,refno,custno,fperiod,wos_date,currrate,itemcount,itemno,desp,despa,
            location,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,amt_bil,taxpec1,taxamt_bil,qty,price,
            amt1,disamt,amt,taxamt,dono,name,sono,wos_group,category,trdatetime,dispec2,dispec3,comment,factor1,factor2,bomcostmethod,unit,brem1,brem2)
        
            values ('ISS', '#nexttranno#', 'ASSM/999', '#form.readperiod#', 
            #ndatecreate#, '#currrate#', '#itemcnt#', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbom.bmitemno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.desp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.despa#"> ,
            '#form.location#', '#(form.qty * bmqty)#', '#val(itemprice)#','#val(amt1_bil)#', '#val(form.dispec1)#',
            '#val(disamt_bil)#', '#val(amt_bil)#', '#val(form.taxpec1)#','#val(taxamt_bil)#','#(form.qty * bmqty)#', '#val(xprice)#', '#val(amt1)#', 
            '#val(disamt)#',	'#val(amt)#', '#val(taxamt)#', 'DONO','#form.despa#', 'SONO', '#getitem.wos_group#',
            '#getitem.category#',#createdatetime(year(now()),month(now()),day(now()),hour(now()),minute(now()),second(now()))#,0,0,'','1','1','#bomcostmethod1#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem2#">)
        </cfquery>
    <cfcatch type="any">
    	<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><cfabort>
    </cfcatch>
    </cftry>
	
	<cfif lcase(HUserID) neq "kellysteel2">
		<cfset qname='QOUT'&(readperiod+10)>
		<cfset act_qty=(val(form.qty) * bmqty)>
		
		<cfquery name="UpdateIcitem" datasource="#dts#">
			update icitem set 
			#qname#=(#qname#+#act_qty#) 
			where itemno='#itemno#';
		</cfquery>
	</cfif>
    <cfset issno='ISS '&#nexttranno#>
</cfoutput>

<!--- insert RC ictran --->

<cfquery datasource='#dts#' name="checkitemExist">
	select * from ictran where refno='#nexttranno#' and type = 'RC'
</cfquery>

<cfif checkitemExist.recordcount GT 0>
	<cfset itemcnt = checkitemExist.recordcount + 1>
<cfelse>
	<cfset itemcnt = 1>
</cfif>

<cfquery name="getitem" datasource="#dts#">
	select bom_cost,wos_group,category,unit from icitem where itemno = '#form.itemno#'
</cfquery>
<cfset arprice_bil = val(form.price)>
<cfset amt1_bil = val(form.qty) * arprice_bil>
<cfset disamt_bil = (val(form.dispec1) / 100) * amt1_bil>
<cfset netamt = amt1_bil - disamt_bil>
<cfset taxamt_bil = (val(form.taxpec1) / 100) * netamt>
<!--- <cfset amt_bil = netamt + taxamt_bil> --->
<cfset amt_bil = netamt>
<cfset arprice = arprice_bil * currrate>
<cfset amt1 = amt1_bil * currrate>
<cfset disamt = disamt_bil * currrate>
<cfset taxamt = taxamt_bil * currrate>
<cfset amt = amt_bil * currrate>

<cfquery datasource="#dts#" name="insertictran">
	Insert into ictran (type,refno,custno,fperiod,wos_date,currrate,itemcount,itemno,desp,despa,
	location,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,amt_bil,taxpec1,taxamt_bil,qty,price,
	amt1,disamt,amt,taxamt,dono,name,sono,wos_group,category,trdatetime,dispec2,dispec3,comment,factor1,factor2,bomcostmethod,unit)

	values ('RC', '#nexttranno#', 'ASSM/999', '#form.readperiod#', 
	#ndatecreate#, '#currrate#', '#itemcnt#', '#form.itemno#', '#form.desp2#', '#form.despa2#',
	'#form.location#', '#val(form.qty)#', '#arprice_bil#','#amt1_bil#', '#form.dispec1#',
	'#disamt_bil#', '#amt_bil#', '#form.taxpec1#','#taxamt_bil#','#form.qty#', '#arprice#', '#amt1#', 
	'#disamt#',	'#amt#', '#taxamt#', 'DONO','#form.desp#', 'SONO', '#getitem.wos_group#',
	'#getitem.category#', #createdatetime(year(now()),month(now()),day(now()),hour(now()),minute(now()),second(now()))#,0,0,'','1','1','#bomcostmethod1#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">)
</cfquery>

<cfif lcase(HUserID) neq "kellysteel2">
	<cfset qname='QIN'&(readperiod+10)>
	<cfset act_qty=val(form.qty)>
		
	<cfquery name="UpdateIcitem" datasource="#dts#">
		update icitem set 
		#qname#=(#qname#+#act_qty#) 
		where itemno='#itemno#';
	</cfquery>
</cfif>

<!--- insert artran RC --->
<cfquery name="checkexist" datasource="#dts#">
  	select refno from artran where refno = '#nexttranno#' and type = 'RC'
</cfquery>

<cfif checkexist.recordcount eq 0>
  	<cfquery name="insertartran" datasource="#dts#">
		Insert into artran (type,refno,custno,fperiod,wos_date,currrate,
		name,rem1,exported,trdatetime,userid,currcode,created_by,created_on,updated_by,updated_on,pono)
		
		values('RC','#nexttranno#','ASSM/999','#readperiod#',#ndatecreate#,
		'#currrate#','#form.desp#','#form.desp#','',#createdatetime(year(now()),month(now()),day(now()),hour(now()),minute(now()),second(now()))#, '#HUserID#','#form.refno3#','#HUserID#',#now()#,'#HUserID#',#now()#,'#issno#')
	</cfquery>
   
</cfif>

<cfquery name="checkexist2" datasource="#dts#">
  	select refno from artran where refno = '#nexttranno#' and type = 'ISS'
</cfquery>

<cfif checkexist2.recordcount eq 0>
  	<cfquery name="insertartran" datasource="#dts#">
		Insert into artran (type,refno,custno,fperiod,wos_date,currrate,
		name,rem1,exported,trdatetime,userid,currcode,created_by,created_on,updated_by,updated_on)
		
		values('ISS','#nexttranno#','ASSM/999','#readperiod#',#ndatecreate#,
		'#currrate#','#form.despa#','#form.despa#','',#createdatetime(year(now()),month(now()),day(now()),hour(now()),minute(now()),second(now()))#, '#HUserID#','#form.refno3#','#HUserID#',#now()#,'#HUserID#',#now()#)
	</cfquery>
    
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
SELECT autolocbf FROM gsetup
</cfquery>
<cfif getgeneral.autolocbf eq "Y">
<cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#nexttranno#" type="RC" returnvariable="done" />
<cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#nexttranno#" type="ISS" returnvariable="done" />
</cfif>

<form name="done" action="../transaction/assm2.cfm?complete=complete" method="post">
	<cfoutput>
	<input type="hidden" name="currrate" value="#currrate#">
	<input type="hidden" name="bomno" value="#form.bomno#">
	<input type="hidden" name="desp" value="#form.desp#">
	<input type="hidden" name="despa" value="#form.despa#">
	<input type="hidden" name="custno" value="ASSM/999">
	<input type="hidden" name="nexttranno" value="#nexttranno#">
	<input type="hidden" name="invoicedate" value="#invoicedate#">
	<input type="hidden" name="readperiod" value="#form.readperiod#">
	<input type="hidden" name="refno3" value="#refno3#">
	</cfoutput> 
</form>

<script>
	done.submit();
</script>
<cfelse>
<h3>BOM No Does Not Exist</h3>
</cfif>