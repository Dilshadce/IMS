<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" order by trancode desc
</cfquery>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.servicecode)#" >
</cfquery>


<cfquery name="selectartran" datasource="#dts#">
SELECT * from artran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#"
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
        '#URLDecode(url.despa)#', 
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

<cfquery name="selectproducts" datasource="#dts#">
SELECT itemno, desp, amt,qty_bil,price,trancode,unit_bil,disamt_bil FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and (linecode <> "SV" or linecode is null) order by trancode
</cfquery>
<cfoutput>
<table width="750">
<tr>
<th width="50">No</th>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="50">Unit</th><th width="100">Price</th>
<th width="100">Discount</th><th width="100" align="right">Amount</th>
</tr>
<cfset total = 0>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.trancode#</td>
<td>#selectproducts.itemno#</td>
<td>#selectproducts.desp#</td>
<td>#numberformat(selectproducts.qty_bil,'.__')#</td>
<td>#selectproducts.unit_bil#</td>
<td>#numberformat(selectproducts.price,'.__')#</td>
<td>#numberformat(selectproducts.qty_bil,'.__')# x #numberformat(selectproducts.disamt_bil/selectproducts.qty_bil,'.__')# = #numberformat(selectproducts.disamt_bil,'.__')#</td>
<td align="right">#numberformat(selectproducts.amt,'.__')#</td>
</tr>
<cfset total = total + #numberformat(selectproducts.amt,'.__')# >
</cfloop>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th>Total :</th>
  <td align="right">#numberformat(total,'.__')#</td>
</tr>
</table>
</cfoutput>
