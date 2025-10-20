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
<cfset custno = URLDecode(url.custno)>
<cfset isservi = URLDecode(url.isservi)>
<cfset refno = URLDecode(url.refno)>
<cfset trancode = URLDecode(url.trancode)>
<cfset location = URLDecode(url.location)> 
<cfset driver = URLDecode(url.driver)> 
<cfset agenno = URLDecode(url.agenno)>
<cfset rem5 = URLDecode(url.rem5)>
<cfset rem6 = URLDecode(url.rem6)>
<cfset rem7 = URLDecode(url.rem7)>
<cfset rem8 = URLDecode(url.rem8)>
<cfset rem9 = URLDecode(url.rem9)>
<cfset rem10 = URLDecode(url.rem10)>
<cfset rem11 = URLDecode(url.rem11)> 
<cfset headergroup = URLDecode(url.headergroup)> 
<cfset headercate = URLDecode(url.headercate)> 
<cfset headersupp = URLDecode(url.headersupp)> 

<!--- <cfif FindNoCase('*',itemno) neq 0>
<cfset position = FindNoCase('*',itemno)>
<cfset qty = left(itemno,position-1)>
<cfset itemno = right(itemno,len(itemno)-position)>
</cfif> --->

<cfquery name="checkiteminicitem" datasource="#dts#">
SELECT itemno from icitem WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfif checkiteminicitem.recordcount neq 0>
<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil 
FROM ictran WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
</cfquery>


<cfquery name="checkitemExist" datasource="#dts#">
    select 
    itemcount 
    from ictran 
    where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
    select 
    wos_group,category,despa,ucost
    from icitem
    where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfif checkitemExist.recordcount gt 0>
<cfset end = checkitemExist.itemcount[checkitemExist.recordcount]>
<cfset newtc = trancode>

<cfquery name="updateIctran" datasource="#dts#">
		update ictran set 
		itemcount=itemcount+1,
		trancode=trancode+1
		where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
		and itemcount>=#newtc# 
		and itemcount<=#end#
		order by itemcount desc;
	</cfquery>
</cfif>

<!--- <cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictran where  uuid = "#uuid#" order by trancode desc
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

<!--- <cfset trancode = val(selectictran.trancode) + 1> --->

<cfquery name="insertictran" datasource="#dts#">
	insert into ictran
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
        source,
        note1,
        agenno,job,van
        )
        values
        (
        '#tran#',
        '#refno#',
        '#custno#',
        #trancode#,#trancode#,
        '<cfif isservi eq "1">SV<cfelse></cfif>',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.despa#" />, 
        '#location#',
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
              <cfif lcase(HcomID) eq 'ltm_i'>'#getitemdetail.ucost#'<cfelse>''</cfif>, 
              '#headergroup#', 
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
              '#headercate#',
              '#headersupp#',
              '#agenno#',
              '#location#',
              '#driver#'
        )
</cfquery>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno FROM ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
</cfoutput>
</cfif>
