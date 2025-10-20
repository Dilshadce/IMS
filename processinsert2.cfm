<cfoutput>
<cfquery name="getall" datasource="#dts#">
SELECT * FROM eumasbalance WHERE actiontype = "PAYTOSUPP" 
AND wos_date between "2015-04-01" and "2015-04-30" and delstatus <> "Y" order by wos_date
</cfquery>

<cfset tran = "INV">
<cfloop query="getall">
<!--- <cfif getall.huserloc eq "emcs">
<cfset custnoa = "3010/c01">
<cfset itemno = "SERVICESEMCS">
<cfelseif getall.huserloc eq "emdw">
<cfset custnoa = "3010/d01">
<cfset itemno = "SERVICESEMDW">
<cfelseif getall.huserloc eq "emlv">
<cfset custnoa = "3010/l01">
<cfset itemno = "SERVICESEMLV">
<cfelseif getall.huserloc eq "emtc">
<cfset custnoa = "3010/t01">
<cfset itemno = "SERVICESEMTC">
<cfelse> --->
<cfset itemno = "GOLD">
<cfquery name="getapvend" datasource="#dts#">
SELECT name FROM #target_apvend# WHERE custno = "#getall.custno#"
</cfquery>

<cfquery name="getarcust" datasource="#dts#">
SELECT custno FROM #target_arcust# WHERE name = "#getapvend.name#"
</cfquery>
<cfset custnoa = getarcust.custno>

<!--- </cfif> --->
<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#tran#'
			and counter = '2'
</cfquery>

 <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="refnonew" />
 
 <cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='#tran#' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
</cfquery>
 
 <cfif checkexistrefno.recordcount neq 0>
        <cfset refnocheck = 0>
        <cfset refno1 = checkexistrefno.refno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refnonew"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refnonew" />	
		</cfcatch>
        </cftry>

        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#"> and type = '#tran#'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = refnonew>
		</cfif>
        </cfloop>
        </cfif>
        
         <cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
    where type = '#tran#'
	and counter = 2
    </cfquery>
 
 
 <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(getall.wos_date,'yyyy-mm-dd')#" returnvariable="fperiod"/>
 
  <cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#custnoa#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(getall.wos_date,'YYYY-MM-DD')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.particular#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.taxableamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.taxableamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.tax#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.tax#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.grand#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.grand#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.taxableamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.taxableamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.tax#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.tax#">,
<cfif val(getall.tax) neq 0>
<cfqueryparam cfsqltype="cf_sql_varchar" value="6">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.grand#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.grand#">,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="F">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.taxcode#">,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="MYR">
)
</cfquery>      

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
        fperiod,
       
        wos_date,
        currrate
        )
        values
        (
        '#tran#',
        '#refnonew#',
        '#custnoa#',
        1,1,
        '',
        '#itemno#', 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getall.particular#" />, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="" />, 
        '#getall.huserloc#',
        1,
        #numberformat(val(getall.taxableamt),'.______')#, 
        '',
         #numberformat(val(getall.taxableamt),'.__')#,
        0,
        0,
        0,
        #numberformat(0,'._____')#,
        #numberformat(val(getall.taxableamt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(1),'._____')#,
         #numberformat(val(getall.taxableamt),'.______')#,
          '',
          '1',
           '1',
            #numberformat(val(getall.taxableamt),'.__')#,
            #numberformat(val(0),'._____')#,
            #numberformat(val(getall.taxableamt),'.__')#,
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
        "#fperiod#",
      
        "#dateformat(getall.wos_date,'YYYY-MM-DD')#",
        1
        )
</cfquery>

<cfquery name="update" datasource="#dts#">
update eumasbalance SET refno = "#refnonew#" WHERE balanceno = "#getall.balanceno#"
</cfquery>


</cfloop>

</cfoutput>