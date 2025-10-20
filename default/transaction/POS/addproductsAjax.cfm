<cfsetting showdebugoutput="no">
<cfset itemno = URLDecode(url.servicecode)>
<cfset desp = URLDecode(url.desp)>
<cfset amt = val(URLDecode(url.expressamt))>
<cfset qty = val(URLDecode(url.expqty))>
<cfset price = val(URLDecode(url.expprice))>
<cfset unit = URLDecode(url.unit)>
<cfset dispec1 = URLDecode(url.dispec1)>
<cfset dispec2 = URLDecode(url.dispec2)>
<cfset dispec3 = URLDecode(url.dispec3)>
<cfset dis = URLDecode(url.dis)>
<cfset tran = URLDecode(url.tran)>
<cfset tranno = URLDecode(url.tranno)>
<cfset custno = URLDecode(url.custno)>
<cfset isservi = URLDecode(url.isservi)>
<cfset uuid = URLDecode(url.uuid)>
<cfset trancode = URLDecode(url.trancode)>
<cfset brem1 = URLDecode(url.brem1)> 
<cfset driver = URLDecode(url.driver)> 
<cfset rem9 = URLDecode(url.rem9)> 
<cfset location = URLDecode(url.location)> 

<!--- <cfif FindNoCase('*',itemno) neq 0>
<cfset position = FindNoCase('*',itemno)>
<cfset qty = left(itemno,position-1)>
<cfset itemno = right(itemno,len(itemno)-position)>
</cfif> --->
<cfset footerdiscount =0>
<cfset updatefooterdiscount=0>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<!---Promotion--->
<cfquery name="checkpromotion" datasource="#dts#">
    SELECT * FROM promoitem as a right join promotion as b on a.promoid = b.promoid WHERE a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and b.periodfrom <="#dateformat(now(),'yyyy-mm-dd')#" and b.periodto >= "#dateformat(now(),'yyyy-mm-dd')#" and (b.customer='') and (b.location like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getgsetup.ddllocation#%"> or b.location='' or b.location is null)  order by rangefrom
</cfquery>

	<cfif checkpromotion.recordcount neq 0>
	<cfif checkpromotion.type eq "percent">
    <cfset dispec1 = val(checkpromotion.priceamt)>
    <cfset dis=(val(price)*val(qty))*(dispec1/100)>
    
    <cfset amt=(val(price)*val(qty))-dis>
    <cfset brem4=val(checkpromotion.priceamt)&"%">
    
    <cfelseif checkpromotion.type eq "price">
    <cfif checkpromotion.pricedistype eq "fixeddis">
	<cfset price = price - val(checkpromotion.priceamt)>
    <cfset amt=val(price)*val(qty)>
    <cfelseif checkpromotion.pricedistype eq "fixedprice">
    <cfset price = val(checkpromotion.priceamt)>
    <cfset amt=val(price)*val(qty)>
    <cfelseif checkpromotion.pricedistype eq "Varprice">
    <cfset price = checkpromotion.itemprice >
    <cfset amt=val(price)*val(qty)>
	</cfif>
    
    </cfif>

	<cfif checkpromotion.type eq "buy" and checkpromotion.buydistype eq "totalqty" and checkpromotion.discby neq "amt">
    
    <cfquery name="getallpromotionitem" datasource="#dts#">
    	SELECT itemno FROM promoitem where promoid = "#checkpromotion.promoid#"
	</cfquery>
    <cfset promoitemlist=valuelist(getallpromotionitem.itemno)>
    
    <cfquery name="getsumpromoqty" datasource="#dts#">
    	select sum(qty_bil) as qty from ictrantemp where itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#promoitemlist#">) and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
    </cfquery>
    
    <cfset promotiondone=0>
    
    <cfloop query="checkpromotion">
    
    <cfif promotiondone eq 0>
    
    <cfif (val(getsumpromoqty.qty)+val(qty)) gte checkpromotion.rangefrom and checkpromotion.rangefrom gt 0 and (val(getsumpromoqty.qty)+val(qty)) mod checkpromotion.rangefrom eq 0>
    
        <cfquery name="getalliteminpromo" datasource="#dts#">
            select * from ictrantemp where itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#promoitemlist#">) and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        </cfquery>
        
        <cfset price = checkpromotion.priceamt/checkpromotion.rangefrom>
        <cfset promoprice = checkpromotion.priceamt/checkpromotion.rangefrom>
    	<cfset amt=val(price)*val(qty)>
        
        <cfloop query="getalliteminpromo">
        
        <cfquery name="updateprice" datasource="#dts#">
        UPDATE ictrantemp SET 
        price_bil="#val(promoprice)#"
        WHERE 
        trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getalliteminpromo.trancode#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        </cfquery>
        
        <cfquery name="updateictranqty" datasource="#dts#">
        UPDATE ictrantemp SET 
        amt_bil = round((price_bil * qty_bil)-disamt_bil+0.000001 - disamt_bil,3),
        amt1_bil = round((price_bil * qty_bil)-disamt_bil+0.000001 - disamt_bil,3)
        WHERE 
        trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getalliteminpromo.trancode#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        </cfquery>
        
        <cfquery name="updateamt" datasource="#dts#">
        UPDATE ictrantemp SET 
        disamt = (disamt_bil * if(currrate = 0,1,currrate)),
        amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,3),
        amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,3),
        price = (price_bil * if(currrate = 0,1,currrate))
        WHERE 
        trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getalliteminpromo.trancode#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        </cfquery>
        
        <cfif getgsetup.wpitemtax eq "1">
            <cfquery name="updateictrantax" datasource="#dts#">
            UPDATE ictrantemp SET
                <cfif getgsetup.taxincluded eq "Y">
                TAXAMT_BIL=round((AMT_BIL*(taxpec1/(taxpec1+100))),3),
                TAXAMT=round((AMT*(taxpec1/(taxpec1+100))),3),
                taxincl="T"
                <cfelse>
                TAXAMT_BIL=round((AMT_BIL*(taxpec1/100)),3),
                TAXAMT=round((AMT*(taxpec1/100)),3)
                </cfif>
                where 
                uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getalliteminpromo.trancode#">
            </cfquery>
        </cfif>
        
        
        
        </cfloop>
        
        <cfset promotiondone=1>
    </cfif>
    </cfif>
    
    </cfloop>
    
    </cfif>

	
	</cfif>
    
    
    
    
    
<!---mika--->
<cfif lcase(hcomid) eq "mika_i" and now() gte "2015-03-13" and now() lte "2015-03-24">
<cfquery name="checkmikaexist" datasource="#dts#">
select itemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" /> and itemno in ('100002','100004','100503','100504','100505','100506','100507','100511','100513','100518','100520','100536')
</cfquery>

<cfif checkmikaexist.recordcount neq 0 and itemno eq "100502">
<cfset price=8>
<cfset amt=val(price)*val(qty)>
</cfif>
</cfif>
<!--- --->
<!--- --->

<!---Member price--->
<!---
<cfquery name="getproductdetail" datasource="#dts#">
select * from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfquery name="getmemberprice" datasource="#dts#">
select * from driver where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">
</cfquery>

<cfif getmemberprice.pricelevel eq 2>
<cfset price = getproductdetail.price2>
<cfelseif getmemberprice.pricelevel eq 3>
<cfset price = getproductdetail.price3>
<cfelseif getmemberprice.pricelevel eq 4>
<cfset price = getproductdetail.price4>
<cfelse>
</cfif>--->

<!--- --->


<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil,qty
FROM ictrantemp WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
and unit = <cfqueryparam cfsqltype="cf_sql_varchar" value="#unit#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and price_bil="#val(price)#"
</cfquery>

<cfif validitemexist.recordcount neq 0>
<cfquery name="updaterow" datasource="#dts#">
UPDATE ictrantemp SET 
qty_bil = qty_bil + #qty#,
qty = qty + #qty#
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,wserialno FROM ictrantemp WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.itemno#" >
</cfquery>

<cfset qtyReal = val(validitemexist.qty)>
<cfset unit = getitemdetail.unit>
<cfif unit neq "" and unit neq "#selecticitem.unit#">

<cfif unit eq "#selecticitem.unit2#">
<cfset qtyReal = val(validitemexist.qty) + ( val(qty) * val(selecticitem.factor1) ) / val(selecticitem.factor2)>
<cfelseif unit eq "#selecticitem.unit3#">
<cfset qtyReal = val(validitemexist.qty) + ( val(qty) * val(selecticitem.factorU3_a) ) / val(selecticitem.factorU3_b)>
<cfelseif unit eq "#selecticitem.unit4#">
<cfset qtyReal = val(validitemexist.qty) + ( val(qty) * val(selecticitem.factorU4_a) ) / val(selecticitem.factorU4_b)>
<cfelseif unit eq "#selecticitem.unit5#">
<cfset qtyReal = val(validitemexist.qty) + ( val(qty) * val(selecticitem.factorU5_a) ) / val(selecticitem.factorU5_b)>
<cfelseif unit eq "#selecticitem.unit6#">
<cfset qtyReal = val(validitemexist.qty) + ( val(qty) * val(selecticitem.factorU6_a) ) / val(selecticitem.factorU6_b)>
</cfif>

</cfif>

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantemp SET 
disamt_bil = disamt_bil+#numberformat(val(dis),'._____')#
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantemp SET 
amt_bil = round((price_bil * qty_bil)-disamt_bil+0.000001,3),
amt1_bil = round((price_bil * qty_bil)-disamt_bil+0.000001,3)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictrantemp SET 
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,3),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,3)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfif getgsetup.wpitemtax eq "1">
            <cfquery name="updateictrantax" datasource="#dts#">
            UPDATE ictrantemp SET
                <cfif getgsetup.taxincluded eq "Y">
                TAXAMT_BIL=round((AMT_BIL*(taxpec1/(taxpec1+100))),3),
                TAXAMT=round((AMT*(taxpec1/(taxpec1+100))),3),
                taxincl="T"
                <cfelse>
                TAXAMT_BIL=round((AMT_BIL*(taxpec1/100)),3),
                TAXAMT=round((AMT*(taxpec1/100)),3)
                </cfif>
                where 
                uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
            </cfquery>
</cfif>




<cfelse>
<cfquery name="checkitemExist" datasource="#dts#">
    select 
    itemcount 
    from ictrantemp 
    where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
    select 
    wos_group,category,wserialno,taxcode
    from icitem
    where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfif checkitemExist.recordcount gt 0>
<cfset end = checkitemExist.itemcount[checkitemExist.recordcount]>
<cfset newtc = trancode>

<cfquery name="updateIctran" datasource="#dts#">
		update ictrantemp set 
		itemcount=itemcount+1,
		trancode=trancode+1
		where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
		and itemcount>=#val(newtc)# 
		and itemcount<=#val(end)#
		order by itemcount desc;
	</cfquery>

<cfquery name="updateiserial" datasource="#dts#">
	update iserialtemp set 
	trancode=trancode+1
	where 
	uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
	and trancode>=#val(newtc)# 
	and trancode<=#val(end)#
	order by trancode desc;
</cfquery>

</cfif>

<!--- <cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictrantemp where  uuid = "#uuid#" order by trancode desc
</cfquery> --->

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" >
</cfquery>


<!--- <cfif selectictran.trancode eq "">
<cfset selectictran.trancode = 0>
</cfif>
 --->
<cfset qtyReal = qty>

<cfif unit neq "" and unit neq "#selecticitem.unit#">

<cfif unit eq "#selecticitem.unit2#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factor1) ) / val(selecticitem.factor2)>
<cfelseif unit eq "#selecticitem.unit3#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU3_a) ) / val(selecticitem.factorU3_b)>
<cfelseif unit eq "#selecticitem.unit4#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU4_a) ) / val(selecticitem.factorU4_b)>
<cfelseif unit eq "#selecticitem.unit5#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU5_a) ) / val(selecticitem.factorU5_b)>
<cfelseif unit eq "#selecticitem.unit6#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU6_a) ) / val(selecticitem.factorU6_b)>
</cfif>

</cfif>

<cftry>
<cfif tran eq 'PO' or tran eq 'RC' or tran eq 'PR'>

<cfelse>
	<cfquery name="checkpromotion" datasource="#dts#">
    	SELECT * FROM promoitem as a right join promotion as b on a.promoid = b.promoid WHERE a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(itemno)#"> and b.periodfrom <="#dateformat(now(),'yyyy-mm-dd')#" and b.periodto >= "#dateformat(now(),'yyyy-mm-dd')#" and (b.customer='#custno#' or b.customer='')
    </cfquery>
    
    <cfif checkpromotion.type eq "buy">
    <cfif checkpromotion.pricedistype eq "Varprice" and (qty gte checkpromotion.rangefrom and qty lte checkpromotion.rangeto)>
    <cfset price = checkpromotion.itemprice >
    <cfset amt = val(qty)*val(price)>
	</cfif>
    </cfif>
    
    </cfif>
    
<cfcatch>
</cfcatch></cftry>


<!--- <cfset trancode = val(selectictran.trancode) + 1> --->

<cfquery name="insertictran" datasource="#dts#">
	insert into ictrantemp
	(
		type,
        refno,
        custno,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        location,
        qty_bil,
        price_bil,
        unit_bil,
        amt1_bil,
        dispec1,
        dispec2,
        dispec3,
        disamt_bil,
        amt_bil,
		taxpec1,
        gltradac,
        taxamt_bil,
        qty,
        price,
        unit,
        factor1,
        factor2,
        amt1,
        disamt,
        amt,
        taxamt,
        note_a,
		dono,
        exported,
        exported1,
        sono,
        toinv,
        generated,
        wos_group,
        category,
        brem1,
        brem2,
        brem3,
        brem4,
        packing,
        shelf,
        supp,
        qty1,
        qty2,
        qty3,
        qty4,
        qty5,
        qty6,
        qty7,
        trdatetime,
        sv_part,
        sercost,
        userid,
        sodate,
        dodate,
        adtcost1,
        adtcost2,
        batchcode,
        expdate,
        mc1_bil,
        mc2_bil,
        defective,
        nodisplay,
        title_id,
        title_desp,
        comment,
        m_charge1,
        m_charge2,
        m_charge3,
        m_charge4,
        m_charge5,
        m_charge6,
        m_charge7,
       	mc3_bil,
        mc4_bil,
        mc5_bil,
        mc6_bil,
        mc7_bil,
        uuid,
        driver,
        rem9,
        wserialno
        )
        values
        (
        '#tran#',
        '#tranno#',
        '#custno#',
        #trancode#,#trancode#,
        '<cfif isservi eq "1">SV<cfelse></cfif>',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        '', 
        '#location#',
        #numberformat(val(qty),'._____')#,
        #numberformat(val(price),'.___')#, 
        '#unit#',
         #numberformat(val(amt),'.___')#,
        #val(dispec1)#,
        #val(dispec2)#,
        #val(dispec3)#,
        #numberformat(val(dis),'._____')#,
        #numberformat(val(amt),'.___')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(price),'.___')#,
          '#unit#',
          '1',
           '1',
            #numberformat(val(amt),'.___')#,
            #numberformat(val(dis),'._____')#,
            #numberformat(val(amt),'.___')#,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '#getitemdetail.wos_group#', 
              '#getitemdetail.category#', 
              '#brem1#', 
              '', 
              '', 
              '', 
              '', 
              '',
              '', 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              now(),
              '',
              0.00000,
              '#huserid#',
              '0000-00-00',
              '0000-00-00', 
              0.00000, 
              0.00000,
              '',
              '0000-00-00',
              0.00000, 
              0.00000,
              '',
              'N',
              '',
              '',
              '',
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              '#uuid#',
              '#driver#',
              '#rem9#',
              '#getitemdetail.wserialno#'
        )
</cfquery>


<cfif getgsetup.wpitemtax eq "1">

	<cfquery name="checktaxpercent" datasource="#dts#">
    select rate1 from #target_taxtable# where code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.taxcode#">
    </cfquery>
    
	<cfquery name="updateictrantax" datasource="#dts#">
	UPDATE ictrantemp
    	<cfif (checktaxpercent.rate1 eq "0" or checktaxpercent.recordcount eq 0) and getitemdetail.taxcode neq "">
        set note_a="#getitemdetail.taxcode#",
        TAXPEC1=0,
        TAXAMT_BIL=0,
        TAXAMT=0
        <cfelse>
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getgsetup.df_salestax#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(getgsetup.gst)#">,
        <cfif getgsetup.taxincluded eq "Y">
        TAXAMT_BIL=round((AMT_BIL*(#getgsetup.gst/(getgsetup.gst+100)#)),3),
        TAXAMT=round((AMT*(#getgsetup.gst/(getgsetup.gst+100)#)),3),
        taxincl="T"
        <cfelse>
        TAXAMT_BIL=round((AMT_BIL*(#getgsetup.gst/100#)),3),
        TAXAMT=round((AMT*(#getgsetup.gst/100#)),3)
        </cfif>
        </cfif>
        where 
        uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
        and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#">
	</cfquery>
</cfif>



</cfif>
<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno,sum(taxamt_bil) as sumtaxtotal FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>

<!---
<cfif lcase(hcomid) eq "mika_i">
<cfquery name="gettotalmikaqty" datasource="#dts#">
	select sum(qty_bil) as qty FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" /> and itemno in ('100001','100503','100504','100505','100506','100507','100511','100513','100518','100520','100521','100525','100527','100533','100502')
</cfquery>

<cfif gettotalmikaqty.qty gte 2>
<cfset mikafreeqty= int(gettotalmikaqty.qty/2)>

<cfquery name="checkmikafreeitem" datasource="#dts#">
	select itemno from ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" /> and itemno="300014"
</cfquery>

<cfif checkmikafreeitem.recordcount eq 0>
	<cfset trancode=trancode+1>
<cfquery name="insertictran" datasource="#dts#">
	insert into ictrantemp
	(
		type,
        refno,
        custno,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        location,
        qty_bil,
        price_bil,
        unit_bil,
        amt1_bil,
        dispec1,
        dispec2,
        dispec3,
        disamt_bil,
        amt_bil,
		taxpec1,
        gltradac,
        taxamt_bil,
        qty,
        price,
        unit,
        factor1,
        factor2,
        amt1,
        disamt,
        amt,
        taxamt,
        note_a,
		dono,
        exported,
        exported1,
        sono,
        toinv,
        generated,
        wos_group,
        category,
        brem1,
        brem2,
        brem3,
        brem4,
        packing,
        shelf,
        supp,
        qty1,
        qty2,
        qty3,
        qty4,
        qty5,
        qty6,
        qty7,
        trdatetime,
        sv_part,
        sercost,
        userid,
        sodate,
        dodate,
        adtcost1,
        adtcost2,
        batchcode,
        expdate,
        mc1_bil,
        mc2_bil,
        defective,
        nodisplay,
        title_id,
        title_desp,
        comment,
        m_charge1,
        m_charge2,
        m_charge3,
        m_charge4,
        m_charge5,
        m_charge6,
        m_charge7,
       	mc3_bil,
        mc4_bil,
        mc5_bil,
        mc6_bil,
        mc7_bil,
        uuid,
        driver,
        rem9
        )
        values
        (
        '#tran#',
        '#tranno#',
        '#custno#',
        #trancode#,#trancode#,
        '',
        '300014', 
        'FREE GIFT', 
        '', 
        '#location#',
        #numberformat(val(mikafreeqty),'._____')#,
        0, 
        'BOX',
        0,
        0,
        0,
        0,
        0,
        0, 
        '0',
        '',
        0.00000,
        #numberformat(val(mikafreeqty),'._____')#,
         0,
          'BOX',
          '1',
           '1',
            0,
            0,
            0,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '',
              '', 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              now(),
              '',
              0.00000,
              '#huserid#',
              '0000-00-00',
              '0000-00-00', 
              0.00000, 
              0.00000,
              '',
              '0000-00-00',
              0.00000, 
              0.00000,
              '',
              'N',
              '',
              '',
              '',
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              '#uuid#',
              '#driver#',
              '#rem9#'
        )
</cfquery>

<cfelse>
<cfquery name="updateictran" datasource="#dts#">
	update ictrantemp set qty="#val(mikafreeqty)#",qty_bil="#val(mikafreeqty)#"
    where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" /> and itemno="300014"
</cfquery>

</cfif>
<cfelse>
<cfquery name="updateictran" datasource="#dts#">
	delete from ictrantemp
    where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" /> and itemno="300014"
</cfquery>
</cfif>
</cfif>
--->

	<!--- --->
    <cfif checkpromotion.type eq "buy" and checkpromotion.discby eq "amt" and checkpromotion.buydistype eq "totalqty">

    <cfloop query="checkpromotion">
    <cfquery name="getallpromotionitem" datasource="#dts#">
    	SELECT itemno FROM promoitem where promoid = "#checkpromotion.promoid#"
	</cfquery>
    <cfset promoitemlist=valuelist(getallpromotionitem.itemno)>
    
    <cfquery name="getsumpromoqty" datasource="#dts#">
    	select sum(qty_bil) as qty from ictrantemp where itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#promoitemlist#">) and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
    </cfquery>
    
    <cfif getsumpromoqty.qty lt checkpromotion.rangefrom>
    <cfbreak>
    <cfelse>
    <cfset footerdiscount =val(checkpromotion.priceamt)>
    </cfif>
    
    </cfloop>
    <cfset updatefooterdiscount=1>
    
    </cfif>
    
    <!--- --->


<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
<input type="hidden" name="hidfooterdiscount" id="hidfooterdiscount" value="#numberformat(footerdiscount,'.__')#" />
<input type="hidden" name="updatefooterdiscount" id="updatefooterdiscount" value="#updatefooterdiscount#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
</cfoutput>

