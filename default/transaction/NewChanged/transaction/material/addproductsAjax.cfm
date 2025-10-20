<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,Decl_Uprice as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>

<cfset stDecl_UPrice=getgsetup2.Decl_Uprice>
<cfset stDecl_Disc=getgsetup2.DECL_DISCOUNT1>

<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictranmat where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" order by trancode desc
</cfquery>

<cfquery name="selectartran" datasource="#dts#">
SELECT Fperiod,wos_date,currrate,agenno,name,van from artran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#"
</cfquery>
<cfif selectictran.trancode eq "">
<cfset selectictran.trancode = 0>
</cfif>
<cfset url.desp = #URLDecode(url.desp)#>
<cfset url.servicecode = #URLDecode(url.servicecode)#>
<cfquery name="getitem" datasource="#dts#">
SELECT unit,despa,wos_group,category from icitem where itemno = <cfqueryparam value="#url.servicecode#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfset location=URLDecode(url.location)>

<cfset trancode = val(selectictran.trancode) + 1>

<cfquery name="insertictran" datasource="#dts#">
	insert into ictranmat
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
        '#URLDecode(url.desp)#', 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.despa#">, 
        '#selectartran.agenno#', 
        '<cfif isdefined("url.location")>#location#</cfif>',
        #val(url.expqty)#,
        #numberformat(val(url.expprice),'.______')#, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,
         #numberformat(val(url.expressamt),'.______')#,
        '0.00',
        '0.00',
        '0.00',
        0.00000,
        #numberformat(val(url.expressamt),'.______')#, 
        '0',
        '',
        0.00000,
        #val(url.expqty)#,
         #numberformat(val(url.expprice)* val(selectartran.currrate),'.______')#,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,
          '1',
           '1',
            #numberformat(val(url.expressamt)* val(selectartran.currrate),'.______')#,
            0.00000,
            #numberformat(val(url.expressamt)* val(selectartran.currrate),'.______')#,
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
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.wos_group#">, 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.category#">, 
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
SELECT * FROM ictranmat where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and (linecode <> "SV" or linecode is null)
</cfquery>
<cfoutput>
<table width="700">
<tr>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="100">Price</th><th width="100" align="right">Amount</th><th width="100" align="right">Action</th>
</tr>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.itemno#</td>
<td>#selectproducts.desp#</td>
<td><cfif lcase(hcomid) eq "pengwang_i" or lcase(hcomid) eq "pingwang_i" or lcase(hcomid) eq "huanhong_i" or lcase(hcomid) eq "ptpw_i">#numberformat(selectproducts.qty_bil,'.____')#<cfelse>#selectproducts.qty_bil#</cfif></td>
<td>#numberformat(selectproducts.price_bil,stDecl_UPrice)#</td>
<td align="right"><cfif lcase(hcomid) eq "pengwang_i" or lcase(hcomid) eq "pingwang_i" or lcase(hcomid) eq "huanhong_i" or lcase(hcomid) eq "ptpw_i">#numberformat(selectproducts.amt_bil,'.____')#<cfelse>#numberformat(selectproducts.amt_bil,'.__')#</cfif></td>
<td align="right"><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="ajaxFunction(document.getElementById('ajaxFieldPro'),'/default/transaction/material/deleteproductsAjax.cfm?trancode=#selectproducts.trancode#&tran=#tran#&tranno=#tranno#&custno=#custno#');">Delete</a></td>
</tr>
</cfloop>
</table>
</cfoutput>
