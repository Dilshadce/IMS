<cfsetting showdebugoutput="no">
<cfif isdefined('url.itemno')>
<cfset itemno = urldecode(url.itemno)>
<cfquery name="validitem" datasource="#dts#">
SELECT price,price2,price3,ucost,desp,despa,unit from icitem WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> 
</cfquery>
<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfset tran = URLDecode(url.type)>

<cfquery name="getcustomerbusiness" datasource="#dts#">
select business,dispec1,dispec2,dispec3 from #target_arcust# where custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
</cfquery>
<cfquery name="getbusinesspricetype" datasource="#dts#">
select * from business where business='#getcustomerbusiness.business#'
</cfquery>


<cfif validitem.recordcount neq 0>

<cfset desp = validitem.desp>
<cfset despa = validitem.despa>
<cfset qty = 1>
<cfif tran eq 'PO' or tran eq 'PR' or tran eq 'RC'>
<cfset price = val(validitem.ucost)>
<cfelse>
<cfif getbusinesspricetype.pricelvl eq '2'>
<cfset price = val(validitem.price2)>
<cfelseif getbusinesspricetype.pricelvl eq '3'>
<cfset price = val(validitem.price3)>
<cfelse>
<cfset price = val(validitem.price)>
</cfif>
</cfif>
<cfset amt = val(price) * 1>
<cfset dispec1=0>
<cfset dispec2=0>
<cfset dispec3=0>
<cfset disamt=0>
<cfif getgsetup.appDisSupCus eq 'Y'>
<cfif getgsetup.mitemdiscountbyitem eq 'Y'>
<cfset dispec1=val(getcustomerbusiness.dispec1)>
<cfset dispec2=val(getcustomerbusiness.dispec2)>
<cfset dispec3=val(getcustomerbusiness.dispec3)>
<cfset disamt1 = (val(dispec1) / 100) * amt>
<cfset netamttemp = amt - disamt1>
<cfset disamt2 = (val(dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt2>
<cfset disamt3 = (val(dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt3>
<cfset disamt = numberformat(disamt1 + disamt2 + disamt3,',_.__')>

</cfif>
</cfif>

<cfset amt=amt-disamt>

<cfset unit = validitem.unit>
<cfset tranno = URLDecode(url.refno)>
<cfset custno = URLDecode(url.custno)>
<cfset uuid = URLDecode(url.uuid)>
<cfset locationfr = URLDecode(url.locfr)>
<cfset locationto = URLDecode(url.locto)>
<cfset dis = 0>
<cfset ndate = createdate(right(URLDecode(url.wosdate),4),mid(URLDecode(url.wosdate),4,2),left(URLDecode(url.wosdate),2))>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>

<cfif type eq "TR">
<cfset type = "TROU">
<cfset tran = "TROU">
</cfif>

<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictrantemp where  uuid = "#uuid#" order by trancode desc
</cfquery>

<cfif selectictran.trancode eq "">
<cfset trancode = 0>
<cfelse>
<cfset trancode = val(selectictran.trancode) + 1>
</cfif>

<cfquery name='getictran' datasource='#dts#'>
select qty_bil,amt_bil,qty,disamt_bil from ictrantemp where 
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#"> 
and type = "#type#" 
and itemno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> 
and uuid= <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationfr#">
</cfquery>

<cfif getictran.recordcount eq 0>
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
        fperiod
        )
        values
        (
        '#type#',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
        #trancode#,
        #trancode#,
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#despa#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationfr#">,
        #val(qty)#,
        #val(price)#, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#unit#">,
         #numberformat(val(amt),'.__')#,
        #val(dispec1)#,
        #val(dispec2)#,
        #val(dispec3)#,
        #numberformat(val(disamt),'._____')#,
        #numberformat(val(amt),'.__')#, 
        '0',
        '',
        0.00000,
        #val(qty)#,
        #numberformat(val(price),'.__')#,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#unit#">,
          '1',
           '1',
            #numberformat(val(amt),'.__')#,
            #numberformat(val(disamt),'._____')#,
            #numberformat(val(amt),'.__')#,
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
              '#fperiod#'
        )
</cfquery>
<cfelse>
<cfset totalqty=qty+getictran.qty_bil>
<cfset totalamt=amt+getictran.amt_bil>
<cfset totalqty1=qty+getictran.qty>
<cfset totaldisamt=disamt+getictran.disamt_bil>

<cfquery name="updateictran" datasource="#dts#">
update ictrantemp set 
qty_bil=#val(totalqty)#,
amt_bil=#numberformat(val(totalamt),'.__')#,
amt1_bil=#numberformat(val(totalamt),'.__')#,
qty=#val(totalqty1)#,
disamt=#numberformat(val(totaldisamt),'.__')#,
disamt_bil=#numberformat(val(totaldisamt),'.__')#,
amt=#numberformat(val(totalamt),'.__')#,
amt1=#numberformat(val(totalamt),'.__')# 
where 
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#"> 
and type ="#tran#" 
and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> 
and uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>
</cfif>

<cfif tran eq "TROU" or tran eq "TR">
<cfquery name='getictran' datasource='#dts#'>
select qty_bil,amt_bil,qty from ictrantemp where 
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#"> 
and type = "TRIN" 
and itemno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> 
and uuid= <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationto#">
</cfquery>
<cfif getictran.recordcount eq 0>
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
        fperiod
        )
        values
        (
        'TRIN',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
        #trancode#,
        #trancode#,
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#despa#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationto#">,
        #val(qty)#,
        #numberformat(val(price),'.__')#, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#unit#">,
        #numberformat(val(amt),'.__')#,
        #val(dispec1)#,
        #val(dispec2)#,
        #val(dispec3)#,
        #numberformat(val(disamt),'._____')#,
        #numberformat(val(amt),'.__')#, 
        '0',
        '',
        0.00000,
        #val(qty)#,
        #numberformat(val(price),'.__')#,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#unit#">,
        '1',
        '1',
            #numberformat(val(amt),'.__')#,
            #numberformat(val(disamt),'._____')#,
            #numberformat(val(amt),'.__')#,
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
              '#fperiod#'
        )
</cfquery>
<cfelse>
<cfset totalqty=qty+getictran.qty_bil>
<cfset totalamt=amt+getictran.amt_bil>
<cfset totalqty1=qty+getictran.qty>
<cfset totaldisamt=disamt+getictran.disamt_bil>

<cfquery name="updateictran" datasource="#dts#">
update ictrantemp set 
qty_bil=#val(totalqty)#,
amt_bil=#numberformat(val(totalamt),'.__')#,
amt1_bil=#numberformat(val(totalamt),'.__')#,
disamt=#numberformat(val(totaldisamt),'.__')#,
disamt_bil=#numberformat(val(totaldisamt),'.__')#,
qty=#val(totalqty1)#,
amt=#numberformat(val(totalamt),'.__')#,
amt1=#numberformat(val(totalamt),'.__')# 
where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tranno#"> 
and type ="TRIN" 
and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
and uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>
</cfif>
</cfif>

<cfoutput>
<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>
<cfcontent type="text/html" reset="yes">
#numberformat(getsum.sumsubtotal,'.__')#
</cfoutput>
<cfelse>
<cfabort showerror="no item found" />
</cfif>
</cfif>