<cfsetting showdebugoutput="no">
<cfset itemno = URLDecode(url.servicecode)>
<cfset desp = URLDecode(url.desp)>
<cfset amt = val(URLDecode(url.expressamt))>
<cfset qty = val(URLDecode(url.expqty))>
<cfset price = val(URLDecode(url.expprice))>
<cfset tran = URLDecode(url.tran)>
<cfset tranno = URLDecode(url.tranno)>
<cfset uuid = URLDecode(url.uuid)>
<cfset trancode = URLDecode(url.trancode)>


<cfif tran eq 'ISS'>
<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil 
FROM issuetemp WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
<cfelseif tran eq 'RC'>
<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil 
FROM receivetemp WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
</cfif>

<cfquery name="checkiteminicitem" datasource="#dts#">
SELECT itemno FROM icitem WHERE 
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfif checkiteminicitem.recordcount neq 0>

<!---
<cfif validitemexist.recordcount neq 0>
<!---Same item--->
<!---ISS--->
<cfif tran eq 'ISS'>
<cfquery name="updaterow" datasource="#dts#">
UPDATE issuetemp SET 
qty_bil = qty_bil + #qty#
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit FROM issuetemp WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.itemno#" >
</cfquery>

<cfset qtyReal = val(validitemexist.qty_bil) + qty>
<cfset unit = getitemdetail.unit>

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE issuetemp SET 
qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qtyReal#">,
amt_bil = round((price_bil * qty_bil)+0.000001,2),
amt1_bil = round((price_bil * qty_bil)+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE issuetemp SET 
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<!---RC--->
<cfelseif tran eq 'RC'>

<cfquery name="updaterow" datasource="#dts#">
UPDATE receivetemp SET 
qty_bil = qty_bil + #qty#
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit FROM receivetemp WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.itemno#" >
</cfquery>

<cfset qtyReal = val(validitemexist.qty_bil) + qty>
<cfset unit = getitemdetail.unit>

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE receivetemp SET 
qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qtyReal#">,
amt_bil = round((price_bil * qty_bil)+0.000001,2),
amt1_bil = round((price_bil * qty_bil)+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE receivetemp SET 
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
</cfif>

<!---End same item--->
<cfelse>--->

<!---ISS--->
<cfif tran eq 'ISS'>
<cfquery name="checkitemExist" datasource="#dts#">
    select 
    itemcount 
    from issuetemp 
    where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
    select 
    wos_group,category,unit
    from icitem
    where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfif checkitemExist.recordcount gt 0>
<cfset end = checkitemExist.itemcount[checkitemExist.recordcount]>
<cfset newtc = trancode>

<cfquery name="updateIctran" datasource="#dts#">
		update issuetemp set 
		itemcount=itemcount+1,
		trancode=trancode+1
		where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
		and itemcount>=#newtc# 
		and itemcount<=#end#
		order by itemcount desc;
	</cfquery>
</cfif>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" >
</cfquery>

<cfset qtyReal = qty>

<cfquery name="insertictran" datasource="#dts#">
	insert into issuetemp
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
        'ASSM/999',
        #trancode#,#trancode#,
        '',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        '', 
        '#location#',
        #numberformat(val(qty),'._____')#,
        #numberformat(val(price),'._______')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt),'.__')#,
        '0',
        '0',
        '0',
        '0',
        #numberformat(val(amt),'._______')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(price),'._______')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt),'._______')#,
           '0',
            #numberformat(val(amt),'._______')#,
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

<!---RC--->
<cfelseif tran eq 'RC'>

<cfquery name="checkitemExist" datasource="#dts#">
    select 
    itemcount 
    from receivetemp 
    where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
    select 
    wos_group,category,unit
    from icitem
    where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfif checkitemExist.recordcount gt 0>
<cfset end = checkitemExist.itemcount[checkitemExist.recordcount]>
<cfset newtc = trancode>

<cfquery name="updateIctran" datasource="#dts#">
		update receivetemp set 
		itemcount=itemcount+1,
		trancode=trancode+1
		where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
		and itemcount>=#newtc# 
		and itemcount<=#end#
		order by itemcount desc;
	</cfquery>
</cfif>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" >
</cfquery>

<cfset qtyReal = qty>

<cfquery name="insertictran" datasource="#dts#">
	insert into receivetemp
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
        'ASSM/999',
        #trancode#,#trancode#,
        '',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        '', 
        '#location#',
        #numberformat(val(qty),'._____')#,
        #numberformat(val(price),'._______')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt),'._______')#,
        '0',
        '0',
        '0',
        '0',
        #numberformat(val(amt),'._______')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(price),'._______')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt),'._______')#,
           '0',
            #numberformat(val(amt),'._______')#,
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


<!---</cfif>--->
</cfif>


</cfif>
<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
</cfoutput>

