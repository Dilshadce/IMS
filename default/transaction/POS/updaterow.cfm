<cfsetting showdebugoutput="no">
<cfif isdefined('url.uuid') and isdefined('url.trancode')>
<cfset url.uuid = URLDECODE(url.uuid)>
<cfset url.coltype = URLDECODE(url.coltype)>
<cfset url.qty = URLDECODE(url.qty)>
<!---
<cfset url.brem4 = trim(URLDECODE(url.brem4))>--->

<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_Discount = getgsetup2.Decl_Discount>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="updaterow" datasource="#dts#">
UPDATE ictrantemp SET 
qty_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(url.qty)#">,
brem1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.coltype#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,dispec1,dispec2,dispec3,price_bil FROM ictrantemp WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.itemno#" >
</cfquery>

<cfset qtyReal = val(qty)>
<cfset unit = getitemdetail.unit>
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


<cfset discountamount = 0 >
<!---
<cfif url.brem4 neq "">
<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,qty_bil FROM ictrantemp
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

	<cfif right(url.brem4,1) eq "%">
    <cfset totpercent = val(url.brem4)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset adiscountamount = numberformat(val(getprice.price_bil) * ((100-totpercent)/100),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    <cfelse>
    <cfset totdis = val(url.brem4)>
        <cfif totdis lte val(getprice.price_bil)>
        <cfset adiscountamount =numberformat( val(getprice.price_bil) - val(totdis),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    </cfif>
</cfif>
<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictrantemp SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#",
brem4 = "#url.brem4#"
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>   

--->

<cfset realamount = numberformat(val(getitemdetail.price_bil) * val(qtyReal),stDecl_UPrice)>

<cfset disamt_bil1 = (val(getitemdetail.dispec1) / 100) * realamount>
<cfset netamttemp = realamount - disamt_bil1>
<cfset disamt_bil2 = (val(getitemdetail.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(getitemdetail.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset adiscountamount = disamt_bil1 + disamt_bil2 + disamt_bil3>

<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictrantemp SET disamt_bil = "#numberformat(val(adiscountamount),stDecl_UPrice)#"
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery> 



<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantemp SET 
qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qtyReal#">,
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,3),
amt1_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,3)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictrantemp SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,3),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,3)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
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
        and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
	</cfquery>
</cfif>


<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran,sum(taxamt_bil) as sumtaxtotal FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#" />
</cfquery>

<!---
<cfif lcase(hcomid) eq "mika_i">
<cfquery name="gettotalmikaqty" datasource="#dts#">
	select sum(qty) as qty FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" /> and itemno in ('100001','100503','100504','100505','100506','100507','100511','100513','100518','100520','100521','100525','100527','100533','100502')
</cfquery>

<cfif gettotalmikaqty.qty gte 2>
<cfset mikafreeqty= int(gettotalmikaqty.qty/2)>

<cfquery name="checkmikafreeitem" datasource="#dts#">
	select itemno,type,refno,custno from ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" /> and itemno="300014"
</cfquery>

<cfif checkmikafreeitem.recordcount eq 0>
	<cfset trancode=getsum.notran+1>
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
        '#checkmikafreeitem.type#',
        '#checkmikafreeitem.refno#',
        '#checkmikafreeitem.custno#',
        #trancode#,#trancode#,
        '',
        '300014', 
        'FREE GIFT', 
        '', 
        '',
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
              '',
              ''
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
</cfif>--->

<cfset footerdiscount =0>
<cfset updatefooterdiscount=0>

<cfquery name="checkpromotion" datasource="#dts#">
    SELECT * FROM promoitem as a right join promotion as b on a.promoid = b.promoid WHERE a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.itemno#"> and b.periodfrom <="#dateformat(now(),'yyyy-mm-dd')#" and b.periodto >= "#dateformat(now(),'yyyy-mm-dd')#" and (b.customer='') and (b.location like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#huserloc#%"> or b.location='' or b.location is null)  order by rangefrom * 1
</cfquery>

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


<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
<input type="hidden" name="hidfooterdiscount" id="hidfooterdiscount" value="#numberformat(footerdiscount,'.__')#" />
<input type="hidden" name="updatefooterdiscount" id="updatefooterdiscount" value="#updatefooterdiscount#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
</cfoutput>


</cfif>