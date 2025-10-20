<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" order by trancode desc
</cfquery>

<cfquery name="selectartran" datasource="#dts#">
SELECT * from artran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#"
</cfquery>
<cfif selectictran.trancode eq "">
<cfset selectictran.trancode = 0>
</cfif>
<cfset url.desp = #URLDecode(url.desp)#>
<cfset url.servicecode = #URLDecode(url.servicecode)#>


<cfset trancode = val(selectictran.trancode) + 1>

<cfquery name="insertictran" datasource="#dts#">
	insert into ictran 
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
        '',
         #numberformat(val(url.expressamt),'.__')#,
        '0.00',
        '0.00',
        '0.00',
        0.00000,
        #numberformat(val(url.expressamt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(url.expqty),'._____')#,
         #numberformat(val(url.expprice),'.__')#,
          '',
          '1',
           '1',
            #numberformat(val(url.expressamt),'.__')#,
            0.00000,
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
              0.00000
        )
</cfquery>

<cfquery name="selectproducts" datasource="#dts#">
SELECT itemno, desp, amt,qty,price FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and (linecode <> "SV" or linecode is null)
</cfquery>
<cfoutput>
<table width="550">
<tr>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="100">Price</th><th width="100" align="right">Amount</th>
</tr>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.itemno#</td>
<td>#selectproducts.desp#</td>
<td>#numberformat(selectproducts.qty,'.__')#</td>
<td>#numberformat(selectproducts.price,'.__')#</td>
<td align="right">#numberformat(selectproducts.amt,'.__')#</td>
</tr>
</cfloop>
</table>
</cfoutput>
