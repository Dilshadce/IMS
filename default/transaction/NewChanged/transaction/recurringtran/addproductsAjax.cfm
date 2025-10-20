<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM currictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" order by trancode desc
</cfquery>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.servicecode)#" >
</cfquery>


<cfquery name="selectartran" datasource="#dts#">
SELECT * from currartran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#"
</cfquery>
<cfif selectictran.trancode eq "">
<cfset selectictran.trancode = 0>
</cfif>
<cfset url.desp = #URLDecode(url.desp)#>
<cfset url.servicecode = #URLDecode(url.servicecode)#>
<cfset qtyReal = val(url.expqty)>

<cfif url.unit neq "" and unit neq "#selecticitem.unit#">

<cfif url.unit eq "#selecticitem.unit2#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factor1) ) / val(selecticitem.factor2)>
<cfelseif url.unit eq "#selecticitem.unit3#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU3_a) ) / val(selecticitem.factorU3_b)>
<cfelseif url.unit eq "#selecticitem.unit4#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU4_a) ) / val(selecticitem.factorU4_b)>
<cfelseif url.unit eq "#selecticitem.unit5#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU5_a) ) / val(selecticitem.factorU5_b)>
<cfelseif url.unit eq "#selecticitem.unit6#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU6_a) ) / val(selecticitem.factorU6_b)>
</cfif>

</cfif>

<cfset trancode = val(selectictran.trancode) + 1>
<cfoutput>
<cfquery name="insertictran" datasource="#dts#">
	insert into currictran 
	(
		type,
        refno,
        custno,
        fperiod,
        wos_date,
        currrate,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        agenno,
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
        name,
        exported,
        exported1,
        sono,
        toinv,
        van,
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
        mc7_bil
        )
        values
        (
        '#tran#',
        '#tranno#',
        '#custno#',
        '#selectartran.Fperiod#',
         #selectartran.wos_date#,
        '#selectartran.currrate#',
        #trancode#,#trancode#,
        '',
        '#URLDecode(url.servicecode)#', 
        '#REReplace(URLDecode(url.desp),"925925925925","%","ALL")#', 
        '', 
        '#selectartran.agenno#', 
        '',
        #numberformat(val(url.expqty),'._____')#,
        #numberformat(val(url.expprice),'.__')#, 
        '#url.unit#',
         #numberformat(val(url.expressamt),'.__')#,
        '0.00',
        '0.00',
        '0.00',
        #numberformat(val(url.dis),'._____')#,
        #numberformat(val(url.expressamt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(url.expprice),'.__')#,
          '#url.unit#',
          '1',
           '1',
            #numberformat(val(url.expressamt),'.__')#,
            #numberformat(val(url.dis),'._____')#,
            #numberformat(val(url.expressamt),'.__')#,
            0.00000,
            'STAX',
            '',
             '#selectartran.name#',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '#selectartran.van#', 
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
              '#URLDecode(url.comment)#',
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
              0.00000
        )
</cfquery>

<cfquery name="updatesub" datasource="#dts#">
                SELECT * FROM currictran 
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.servicecode)#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#"> 
                </cfquery>
                
                <cfset qty = updatesub.qty_bil * updatesub.factor1 / updatesub.factor2 >
                <cfset price = updatesub.price_bil * updatesub.currrate>
                <cfset amt1_bil = updatesub.qty_bil * updatesub.price_bil>
                
                <cfset amt1 = amt1_bil * updatesub.currrate>
                <cfset namt1_bil = amt1_bil>
                <cfset namt1_bil = namt1_bil - (namt1_bil * updatesub.dispec1/100)>
                <cfset namt1_bil = namt1_bil - (namt1_bil * updatesub.dispec2/100)>
                <cfset namt1_bil = namt1_bil - (namt1_bil * updatesub.dispec3/100)>
                <cfset disamt_bil = amt1_bil - namt1_bil>
                <cfif disamt_bil eq 0>
                <cfset disamt_bil = updatesub.disamt_bil>
				</cfif>
				<cfset amt_bil = namt1_bil > 
				<cfif updatesub.taxincl neq "T">
				<cfset taxamt_bil = amt_bil * updatesub.taxpec1/100 >
                <cfelse>
                <cfset taxamt_bil = amt_bil * (updatesub.taxpec1/(100 + (updatesub.taxpec1 * 1))) >
				</cfif>
                <cfset amt = amt_bil * updatesub.currrate>
                <cfset disamt = disamt_bil * updatesub.currrate>
				<cfset taxamt = taxamt_bil * updatesub.currrate >
				
               
               	<cfquery name="updatedetail" datasource="#dts#">
                UPDATE currictran
                SET
                qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qty#">,
                amt1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt1_bil#">,
                amt_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt_bil#">,
                price = <cfqueryparam cfsqltype="cf_sql_varchar" value="#price#">,
                amt1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt1#">,
                amt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt#">,
                disamt_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disamt_bil#">,
                disamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disamt#">,
                taxamt_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamt_bil#">,
                taxamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamt#">
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.servicecode)#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#">  
                </cfquery>
                
                <cfquery name="getitempertax" datasource="#dts#">
                SELECT wpitemtax FROM gsetup
                </cfquery>
                
                <cfquery name="getsum" datasource="#dts#">
                SELECT sum(amt_bil) as sumamt,sum(taxamt_bil) as taxamt FROM currictran
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
                </cfquery>
                
                <cfquery name="getTax" datasource="#dts#">
                SELECT currrate,disp1,disp2,disp3,taxp1,taxincl FROM currartran
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
                </cfquery>
                
                <cfset gross_bil = getsum.sumamt>
                <cfset ngross_bil = gross_bil>
                <cfset ngross_bil = ngross_bil - (ngross_bil * getTax.disp1/100)>
                <cfset disc1_bil = gross_bil - ngross_bil>
				<cfset ngross_bil = ngross_bil - (ngross_bil * getTax.disp2/100)>
                <cfset disc2_bil = gross_bil - ngross_bil - disc1_bil>
                <cfset ngross_bil = ngross_bil - (ngross_bil * getTax.disp3/100)>
                <cfset disc3_bil = gross_bil - ngross_bil - disc2_bil-disc1_bil>
                <cfset disc_bil = gross_bil - ngross_bil>
                <cfset net_bil = ngross_bil>
                <cfif getitempertax.wpitemtax neq "1">
                <cfif getTax.taxincl eq "T">
                <cfset tax1_bil = net_bil * (getTax.taxp1/(100+getTax.taxp1))>
                <cfset grand_bil = net_bil>
                <cfelse>
                <cfset tax1_bil = net_bil * (getTax.taxp1/100)>
                <cfset grand_bil = net_bil + tax1_bil>
				</cfif>
                <cfelse>
                <cfset tax1_bil = getsum.taxamt>
                <cfset grand_bil = net_bil + tax1_bil>
                </cfif>
                <cfset tax_bil = tax1_bil>
                <cfset invgross = gross_bil * getTax.currrate>
                <cfset discount1 = disc1_bil * getTax.currrate>
                <cfset discount2 = disc2_bil * getTax.currrate>
                <cfset discount3 = disc3_bil * getTax.currrate>
                <cfset discount = disc_bil * getTax.currrate>
                <cfset net = net_bil * getTax.currrate>
                <cfset tax = tax_bil * getTax.currrate>
                <cfset grand = grand_bil * getTax.currrate>
                <cfif tran eq "rc" or tran eq "pr" or tran eq "po">
                <cfset debitamt = 0>
                <cfset creditamt = grand>
				<cfelse>
                <cfset debitamt = grand>
                <cfset creditamt = 0>
                </cfif>
                
                <cfquery name="getSum" datasource="#dts#">
                Update currartran
                SET
                gross_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
                disc1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
                disc2_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
                disc3_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
                disc_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
                net_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
                tax1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
                grand_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
                invgross = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
                discount1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
                discount2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
                discount3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
                discount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
                net = <cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
                tax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
                grand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
                debitamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
                creditamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
                </cfquery>
</cfoutput>