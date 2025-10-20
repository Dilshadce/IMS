<cfquery datasource="#dts#" name="getGeneralInfo">
	SELECT *
	FROM gsetup;
</cfquery>
<!--- insert ISS ictran --->
<cfquery name="getbom" datasource="#dts#">
	select * from billmat where itemno = '#form.itemno#' and bomno = '#form.bomno#' group by itemno,bomno,bmitemno order by bmitemno
</cfquery>

<cfif getbom.recordcount neq 0><!---Added 20110211 --->

<cfquery datasource='#dts#' name="checkitemExist">
	select * from ictran where refno='#nexttranno#' and type = 'ISS'
</cfquery>

<cfset bomcostmethod1='Fixed'>

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
    
    <cfquery name="getdoupdated" datasource="#dts#">
            SELECT frrefno FROM iclink WHERE frtype = "DO" 
            and itemno = '#bmitemno#' 
            group by frrefno
    </cfquery>
    <cfset billupdated=valuelist(getdoupdated.frrefno)>
    
    <cfif getGeneralInfo.cost eq "FIFO">
            
            
                 <cfquery name="getbmitembalance" datasource="#dts#">
                    select 
                    ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
                    from icitem as a
                    left join 
                    (
                        select itemno,sum(qty) as sumtotalin 
                        from ictran 
                        where type in ('RC','CN','OAI','TRIN') 
                        and itemno='#bmitemno#' 
                        and fperiod<>'99'
                        and (void = '' or void is null)
                        group by itemno
                    ) as b on a.itemno=b.itemno
                    
                    left join 
                    (
                        select itemno,sum(qty) as sumtotalout 
                        from ictran 
                        where
                                (type in ('DO','DN','CS','OAR','PR','ISS','TROU') or 
                                (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                        and itemno='#bmitemno#' 
                        and fperiod<>'99'
                        and (void = '' or void is null)
                        and (linecode="" or linecode is null)
                        group by itemno
                    ) as c on a.itemno=c.itemno
                    
                    where a.itemno='#bmitemno#' 
                    and (a.itemtype <> 'SV' or a.itemtype is null)
                 </cfquery>
                 
                 <cfquery name="getlastrc" datasource="#dts#">
                    select 
                    a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,a.amt)as amt,(amt/qty) as price,
                    a.type,a.refno,a.itemno,a.trancode
                    from ictran a
                    
                    where a.itemno='#bmitemno#' 
                    and (a.void = '' or a.void is null) 
                    and (a.linecode = '' or a.linecode is null)
                    and a.type in ('RC','OAI','CN')
                    and a.fperiod<>'99'
                    
                    order by a.wos_date desc,a.trdatetime desc
                </cfquery>
                <cfset fifobalance=getbmitembalance.balance>
                
                <cfset itemprice=0>
                
                <!---getfrombill--->
                <cfloop query="getlastrc">
                <cfif fifobalance gt 0>
                <cfset itemprice = getlastrc.price>
                <cfbreak>
                </cfif>
                </cfloop>
                
                <cfif fifobalance gt 0>
                <cfquery name="getfifocost" datasource="#dts#">
                    select * from fifoopq where itemno="#bmitemno#" 
                </cfquery>
                
                <cfloop from="11" to="50" index="z">
                    <cfif fifobalance gt 0>
                    <cfset itemprice = val(evaluate('getfifocost.ffc#z#'))>
                    <cfbreak>
                    </cfif>
                </cfloop>
                
                
                </cfif>
                
            <cfelse>
    
    <!--- Get average moving cost --->
   	<cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#bmitemno#'
			 limit 1
    </cfquery>
    <cfset movingunitcost=getqtybf.avcost2>
    <cfset movingbal=getqtybf.qtybf>
    
    <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#bmitemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and 

                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))

			and a.fperiod<>'99'
			and a.wos_date > #getGeneralInfo.lastaccyear#
			
			order by b.wos_date,b.trdatetime
	</cfquery>
    
    <cfloop query="getmovingictran">
        
        <!---exclude CN --->
        <cfif getGeneralInfo.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        </cfif>
        
        <cfif getGeneralInfo.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>
        
        <cfif isdefined('form.dodate')>
	    <cfset movingbal=movingbal-getmovingictran.qty>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        
        </cfloop>
    
    
    
    <!--- end of average moving cost --->
    </cfif>
    </cfif>
    
    <cfif isdefined('form.movingavrg')>
    <cfif getGeneralInfo.cost eq "FIFO">
    <cfset bomcostmethod1='By FIFO'>
    <cfelse>
		<cfif movingbal gt 0>
        <cfset itemprice = movingbal*movingunitcost>
        <cfset bomcostmethod1='By Moving Average'>
        <cfelse>
        <cfset itemprice = 0>
        </cfif>
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
            amt1,disamt,amt,taxamt,dono,name,sono,wos_group,category,trdatetime,dispec2,dispec3,comment,factor1,factor2,bomcostmethod,unit,brem1,brem2,brem3)
        
            values ('ISS', '#nexttranno#', 'ASSM/999', '#form.readperiod#', 
            #ndatecreate#, '#currrate#', '#itemcnt#', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbom.bmitemno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.desp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.despa#"> ,
            '#form.location#', '#(form.qty * bmqty)#', '#val(itemprice)#','#val(amt1_bil)#', '#val(form.dispec1)#',
            '#val(disamt_bil)#', '#val(amt_bil)#', '#val(form.taxpec1)#','#val(taxamt_bil)#','#(form.qty * bmqty)#', '#val(xprice)#', '#val(amt1)#', 
            '#val(disamt)#',	'#val(amt)#', '#val(taxamt)#', 'DONO','#form.despa#', 'SONO', '#getitem.wos_group#',
            '#getitem.category#',#createdatetime(year(now()),month(now()),day(now()),hour(now()),minute(now()),second(now()))#,0,0,'','1','1','#bomcostmethod1#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem2#">,'#bomcostmethod1#')
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
	amt1,disamt,amt,taxamt,dono,name,sono,wos_group,category,trdatetime,dispec2,dispec3,comment,factor1,factor2,bomcostmethod,unit,brem3)

	values ('RC', '#nexttranno#', 'ASSM/999', '#form.readperiod#', 
	#ndatecreate#, '#currrate#', '#itemcnt#', '#form.itemno#', '#form.desp2#', '#form.despa2#',
	'#form.location#', '#val(form.qty)#', '#arprice_bil#','#amt1_bil#', '#form.dispec1#',
	'#disamt_bil#', '#amt_bil#', '#form.taxpec1#','#taxamt_bil#','#form.qty#', '#arprice#', '#amt1#', 
	'#disamt#',	'#amt#', '#taxamt#', 'DONO','#form.desp#', 'SONO', '#getitem.wos_group#',
	'#getitem.category#', #createdatetime(year(now()),month(now()),day(now()),hour(now()),minute(now()),second(now()))#,0,0,'','1','1','#bomcostmethod1#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,'#bomcostmethod1#')
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