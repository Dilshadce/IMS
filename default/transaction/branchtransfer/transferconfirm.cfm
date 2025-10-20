<cfif isdefined('form.itemlist')>

<cfquery name="getlocation" datasource="#dts#">
SELECT remark13 as locationfrom
FROM icitem 
WHERE
round(coalesce(qtybf,0)-coalesce(remark11,0),4) > 0  
and remark12 <> "Y"
and itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemlist#" list="yes" separator=",">)
GROUP BY remark13
ORDER BY round(coalesce(qtybf,0)-coalesce(remark11,0),4)
</cfquery>

<cfloop query="getlocation">

<cfquery datasource="#dts#" name="getGeneralInfo">
    select lastUsedNo
    from refnoset
    where type = 'TR'
    and counter = '1'
</cfquery>

<cfset refno1 = getGeneralInfo.lastUsedNo>

<cftry>
	<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
    
    <cfcatch>
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />	
    </cfcatch>
</cftry>

<cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='TR' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>
<cfif checkexistrefno.recordcount neq 0>

        <cfset refnocheck = 0>
        <cfset refno1 = refno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = 'TR'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = refno>
		</cfif>
        </cfloop>  
</cfif>

<cfset date = now()>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(date,'yyyy-mm-dd')#" returnvariable="fperiod"/>

<cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,counter,rem7,rem6,rem5,rem8,rem10,consignment)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="TR">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(date,'yyyy-mm-dd')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserloc#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.locationfrom#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now(),
"",
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
'0',
'0',
'0',
'0',
'0',
'0',
'0',
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
'',
'0',
'',
'',
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">

)
</cfquery>

<cfquery name="getitem" datasource="#dts#">
SELECT itemno,aitemno,desp,qtybf,unit,category,brand,wos_group,round(coalesce(qtybf,0)-coalesce(remark11,0),4) as weight,unit
<cfloop from="1" to="20" index="a">
,remark#a#
</cfloop> 
FROM icitem 
WHERE
round(coalesce(qtybf,0)-coalesce(remark11,0),4) > 0  
and remark12 <> "Y"
and itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemlist#" list="yes" separator=",">)
and remark13 = "#getlocation.locationfrom#"
ORDER BY round(coalesce(qtybf,0)-coalesce(remark11,0),4)
</cfquery>

<cfset startcount = 1>
<cfloop query="getitem">
<cfloop list="in,ou" index="a">
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
        'TR#a#',
        '#refno#',
        '#getauthuser()#',
       #startcount#,
        #startcount#,
        '',
        '#getitem.itemno#', 
        '#getitem.desp#', 
        '', 
        <cfif a eq "in">
        '#getlocation.locationfrom#'
        <cfelse>
        '#form.location#'
        </cfif>
        ,
        #numberformat(val(getitem.weight),'._____')#,
        0, 
        '#getitem.unit#',
         0,
        0,
        0,
        0,
        0,
        0, 
        '0',
        '',
        0.00000,
        #numberformat(val(getitem.weight),'._____')#,
         0,
          '#getitem.unit#',
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
              '#getitem.wos_group#', 
              '#getitem.category#', 
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
<cfset startcount = startcount + 1>
</cfloop>
<cfset startcount = startcount + 1>
<cfquery name="updateicitem" datasource="#dts#">
UPDATE icitem SET remark13 = "#form.location#" WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
</cfquery>
</cfloop>

</cfloop>

<script type="text/javascript">
alert('Transfer Completed!');
window.location.href='index.cfm';
</script>

</cfif>