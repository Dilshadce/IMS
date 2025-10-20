<cfset tran = URLDecode(url.tran)>
<cfset tranno = URLDecode(url.tranno)>
<cfset custno = URLDecode(url.custno)>
<cfset uuid = URLDecode(url.uuid)>

<cfif tran eq "TROU" or tran eq "TR">
<cfset locationfr = URLDecode(url.locationfr)> 
<cfset locationto = URLDecode(url.locationto)> 
</cfif>

<cfquery name="getdefaultlocation" datasource="#dts#">
select ddllocation,itemdiscmethod from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getgsetup2">
	select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>




<cfloop from="1" to="100" index="i">
<cftry>
<cfset itemno = evaluate("url.servicecode#i#")>

<cfquery name="getproductdetail" datasource="#dts#">
select * from icitem where itemno='#itemno#'
</cfquery>

<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictrantemp where  uuid = "#uuid#" order by trancode desc
</cfquery>

<cfif selectictran.recordcount eq 0>
<cfset selectictran.trancode = 0>
</cfif>

<cfset trancode = val(selectictran.trancode) + 1>

<cfset desp = getproductdetail.desp>
<cfset qty = val(evaluate("url.qty#i#"))>
<cfset price = val(URLDecode(evaluate("url.price#i#")))>
<cfset dispec1 = val(URLDecode(evaluate("url.disc#i#")))>
<cfif lcase(hcomid) eq "didachi_i">
<cfset dispec2 = val(URLDecode(evaluate("url.disca#i#")))>
<cfset dispec3 = val(URLDecode(evaluate("url.discb#i#")))>
<cfelse>
<cfset dispec2 = 0>
<cfset dispec3 = 0>
</cfif>

<cfset location = URLDecode(evaluate("url.location#i#"))> 

<cfif getdefaultlocation.itemdiscmethod eq 'byprice'>

<cfset amt1_bil = price * qty>

		<cfset realamt1 = numberformat(((100-val(dispec1)) / 100)*val(price),stDecl_UPrice)* val(qty)>
		<cfset disamt_bil1 = numberformat((val(price)*val(qty))-realamt1,stDecl_UPrice)>
        <cfset netamttemp = amt1_bil - disamt_bil1>

        <cfset realamt2 = numberformat(((100-val(dispec2)) / 100)*(netamttemp/val(qty)),stDecl_UPrice)* val(qty)>
        <cfset disamt_bil2 = numberformat(netamttemp-realamt2,stDecl_UPrice)>
        <cfset netamttemp = netamttemp - disamt_bil2>
        
        <cfset realamt3 = numberformat(((100-val(dispec3)) / 100)*(netamttemp/val(qty)),stDecl_UPrice)* val(qty)>
        <cfset disamt_bil3 = numberformat(netamttemp-realamt3,stDecl_UPrice)>
        <cfset amt = netamttemp - disamt_bil3>
        
        <cfset dis = disamt_bil1 + disamt_bil2 + disamt_bil3>

<cfelse>
<cfset amt1_bil = qty*price>
<cfset dis = (dispec1/100)*amt1_bil>
<cfset disamt_bil1 = (val(dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(dispec3) / 100) * netamttemp>

<cfset amt = netamttemp - disamt_bil3>
<cfset dis = disamt_bil1 + disamt_bil2 + disamt_bil3>

</cfif>

<!---
<cfif tran eq 'PO' or tran eq 'PR' or tran eq 'RC'>
<cfset amt = getproductdetail.ucost*qty>
<cfset price = getproductdetail.ucost>
<cfelse>
<cfset amt = getproductdetail.price*qty>
<cfset price = getproductdetail.price>
</cfif>
<cfset dispec1 = 0>
<cfset location = getdefaultlocation.ddllocation> 
<cfset dispec2 = 0>
<cfset dispec3 = 0>
<cfset dis = 0>
--->
<cfset unit = getproductdetail.unit>


<cfset driver = ''> 
<cfset rem9 = ''> 



<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil 
FROM ictrantemp WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfif validitemexist.recordcount neq 0>
<cfelse>
<cfquery name="checkitemExist" datasource="#dts#">
    select 
    itemcount 
    from ictrantemp 
    where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
    select 
    wos_group,category
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
		and itemcount>=#newtc# 
		and itemcount<=#end#
		order by itemcount desc;
	</cfquery>
</cfif>


<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" >
</cfquery>

<cfset qtyReal = qty>

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
        rem9
        )
        values
        (
        <cfif tran eq "TROU" or tran eq "TR">'TROU'<cfelse>'#tran#'</cfif>,
        '#tranno#',
        '#custno#',
        #trancode#,#trancode#,
        '',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        '', 
        <cfif tran eq "TROU" or tran eq "TR">'#locationfr#'<cfelse>'#location#'</cfif>,
        #numberformat(val(qty),'._____')#,
        #numberformat(val(price),'.__')#, 
        '#unit#',
         #numberformat(val(amt1_bil),'.__')#,
        #val(dispec1)#,
        #val(dispec2)#,
        #val(dispec3)#,
        #numberformat(val(dis),'._____')#,
        #numberformat(val(amt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(price),'.__')#,
          '#unit#',
          '1',
           '1',
            #numberformat(val(amt1_bil),'.__')#,
            #numberformat(val(dis),'._____')#,
            #numberformat(val(amt),'.__')#,
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
              '#driver#',
              '#rem9#'
        )
</cfquery>

<cfif tran eq "TROU" or tran eq "tr">
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
        'TRIN',
        '#tranno#',
        '#custno#',
        #trancode#,#trancode#,
        '',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        '', 
        '#locationto#',
        #numberformat(val(qty),'._____')#,
        #numberformat(val(price),'.__')#, 
        '#unit#',
         #numberformat(val(amt),'.__')#,
        #val(dispec1)#,
        #val(dispec2)#,
        #val(dispec3)#,
        #numberformat(val(dis),'._____')#,
        #numberformat(val(amt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(price),'.__')#,
          '#unit#',
          '1',
           '1',
            #numberformat(val(amt),'.__')#,
            #numberformat(val(dis),'._____')#,
            #numberformat(val(amt),'.__')#,
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
              '#driver#',
              '#rem9#'
        )
</cfquery>
</cfif>
</cfif>


<cfset trancode = trancode+1>

<cfcatch></cfcatch></cftry>

</cfloop>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as sumsubtotal,count(itemno) as countitemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
</cfoutput>