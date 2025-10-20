<cfset tran = URLDecode(url.tran)>
<cfset tranno = URLDecode(url.tranno)>
<cfset custno = URLDecode(url.custno)>

<cfquery name="gettempitem" datasource="#dts#">
SELECT itemno,qty,price FROM expresspickitem WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemlisting)#"> ORDER BY CREATED_ON DESC
</cfquery>

<cfloop query="gettempitem">
<cftry>
<cfset itemno = gettempitem.itemno>

<cfquery name="getdefaultlocation" datasource="#dts#">
select ddllocation from gsetup
</cfquery>

<cfquery name="getproductdetail" datasource="#dts#">
select * from icitem where itemno='#itemno#'
</cfquery>

<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictran where  type = "#tran#" and refno="#tranno#" order by trancode desc
</cfquery>

<cfif selectictran.recordcount eq 0>
<cfset selectictran.trancode = 0>
</cfif>

<cfset trancode = val(selectictran.trancode) + 1>

<cfset desp = getproductdetail.desp>
<cfset qty = val(gettempitem.qty)>

<cfset amt = gettempitem.price*qty>
<cfset price = gettempitem.price>

<cfset unit = getproductdetail.unit>
<cfset dispec1 = 0>
<cfset dispec2 = 0>
<cfset dispec3 = 0>
<cfset dis = 0>
<cfset location = getdefaultlocation.ddllocation> 
<cfset driver = ''> 
<cfset rem9 = ''> 



<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil 
FROM ictran WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
and type = "#tran#" and refno="#tranno#"
</cfquery>

<cfif validitemexist.recordcount neq 0>
<cfelse>
<cfquery name="checkitemExist" datasource="#dts#">
    select 
    itemcount 
    from ictran 
    where type = "#tran#" and refno="#tranno#"
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
		update ictran set 
		itemcount=itemcount+1,
		trancode=trancode+1
		where type = "#tran#" and refno="#tranno#"
		and itemcount>=#newtc# 
		and itemcount<=#end#
		order by itemcount desc;
	</cfquery>
</cfif>


<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" >
</cfquery>

<cfset qtyReal = qty>

<cftry>
<cfset brem1=listgetat(itemno,1,'-')>
<cfcatch>
<cfset brem1=itemno>
</cfcatch>
</cftry>

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
        mc7_bil
        )
        values
        (
        '#tran#',
        '#tranno#',
        '#custno#',
        #trancode#,#trancode#,
        '',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        '', 
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
              0.00000
        )
</cfquery>
</cfif>


<cfset trancode = trancode+1>

<cfcatch></cfcatch></cftry>

</cfloop>

<cfoutput>
    <div style="width:1px; height:1px; overflow:scroll">
    <cfset url.tran = #listfirst(tran)#>
    <cfset url.ttype = "Edit">
    <cfset url.refno = #listfirst(tranno)#>
    <cfset url.custno = #listfirst(custno)#>
    <cfset url.first = 0>
    <cfset url.jsoff = "true">
    <cfinclude template="/default/transaction/tran_edit2.cfm">
    </div>
    </cfoutput>

