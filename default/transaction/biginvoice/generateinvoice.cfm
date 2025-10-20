
<cfinclude template="/object/dateobject.cfm">
<cfset ndate = dateformatnew(form.invoicedate,'yyyy-mm-dd')>
	<cfif form.assignmenttype eq "invoice">
    <cfset prefix = "BM">
    <cfset counter = 5>
    <cfset refnolen = 9>
    <cfelse>
    <cfset prefix = "BE">
    <cfset counter = 4>
    <cfset refnolen = 9>
    </cfif>

<cfset refnolist = "">
<cfquery name="company_details" datasource="payroll_main">
	SELECT mmonth,myear FROM gsetup WHERE comp_id = "#replace(dts,'_i','')#"
</cfquery>

<cfset company_details.mmonth = dateformatnew(form.invoicedate,'mm')>

 <cfquery datasource="#dts#" name="getGeneralInfo">
            select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
            from refnoset
            where type = 'INV'
            and counter = #counter#
            </cfquery>

<cfset refno = getGeneralInfo.tranno>

<cftry>
	<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
<cfcatch>
	<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
</cfcatch>
</cftry>

            
<cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>

<cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='INV' and right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
</cfquery>

<cfif checkexistrefno.recordcount eq 0>
<cfquery name="checkexistrefno" datasource="#dts#">
SELECT refno FROM assignmentslip WHERE right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
</cfquery>
</cfif>

<cfif checkexistrefno.recordcount neq 0>
<cfset refnocheck = 0>

<cfloop condition="refnocheck eq 0">

    <cftry>
    <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
    <cfcatch>
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
    </cfcatch>
    </cftry>
    
    <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>

    <cfquery name="checkexistrefno" datasource="#dts#">
    select refno from artran where type='INV' and right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
    </cfquery>
    
    <cfif checkexistrefno.recordcount eq 0>
    <cfquery name="checkexistrefno" datasource="#dts#">
    SELECT refno FROM assignmentslip WHERE right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
    </cfquery>
    </cfif>

	<cfif checkexistence.recordcount eq 0>
    <cfset refnocheck = 1>
    </cfif>
</cfloop>                

</cfif>

        
<cfquery datasource="#dts#" name="getGeneralInfo">
    Update refnoset SET lastUsedNo = '#refno#' WHERE type = 'INV'
    and counter = #counter#
</cfquery>
            

<cfif form.combinationtype eq "gasi">
<cfif isdefined('form.checklist')>
<cfquery name="getgross" datasource="#dts#">
SELECT sum(round(coalesce(custtotalgross,0)+0.00001,2)) as totalamount,taxper,taxcode,custname2 FROM assignmentslip WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.checklist#" list="yes" separator=",">) and combine <> "Y"
</cfquery>
<cfset gettotal = numberformat(getgross.totalamount,'.__')>
<cfset taxamount = numberformat(gettotal * val(getgross.taxper) / 100,'.__') >
<cfset netamt = numberformat(gettotal + taxamount,'.__')>
<cfset ndate = dateformatnew(form.invoicedate,'yyyy-mm-dd')>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#ndate#" returnvariable="fperiod"/>


<cfquery name="getcustname" datasource="#dts#">
        select name,term from #target_arcust# where custno='#form.custno#'
</cfquery>


  <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="INV">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#netamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#netamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.taxper#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#netamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#netamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getgross.custname2,45)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getgross.custname2,45)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">,
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
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.taxcode#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.checklist#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getgross.custname2,45)#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
  		<Cfif getcustname.term eq "">
        <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
        <cfelse>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
        </Cfif>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">
        )
        </cfquery>
        
        
          <cfquery name="insertictran" datasource="#dts#">
                insert into ictran
                (
                    type,
                    refno,
                    fperiod,
                    wos_date,
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
                    currrate
                    )
                    values
                    (
                    'INV',
                    '#refno#',
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
                    '#form.custno#',
                    '1','1',
                    '',
                    'Salary', 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">, 
                    '', 
                    '',
                    '1',
                    #numberformat(val(gettotal),'.__')#, 
                    '',
                     #numberformat(val(gettotal),'.__')#,
                    0,
                    0,
                    0,
                    0,
                    #numberformat(val(gettotal),'.__')#, 
                    '0',
                    '',
                    0.00000,
                    '1',
                     #numberformat(val(gettotal),'.__')#,
                      '',
                      '1',
                       '1',
                        #numberformat(val(gettotal),'.__')#,
                        0,
                        #numberformat(val(gettotal),'.__')#,
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
                          1
                    )
             </cfquery>
             
             <cfquery datasource='#dts#' name="updateictran">
                Update ictran 
                set 
                taxpec1=#numberformat(val(getgross.taxper),'.__')#,
                note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.taxcode#">,
                taxamt=#numberformat(taxamount,'.__')#,
                taxamt_bil=#numberformat(taxamount,'.__')#
                where refno = '#refno#' and type='INV'
		  	</cfquery>
            
            <cfquery name="updatecombine" datasource="#dts#">
            	UPDATE assignmentslip SET combine = "Y",biginvoice = concat(coalesce(biginvoice,''),' ','#refno#') WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.checklist#" list="yes" separator=",">) and combine <> "Y"
            </cfquery>
    		
            <cfset refnolist = refno>    
     
</cfif>
<cfelseif  form.combinationtype eq "mg">

<cfquery name="getlist" datasource="#dts#">
SELECT orderno,desp FROM tempcreatebi WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#"> GROUP BY orderno ORDER BY orderno
</cfquery>

<cfquery name="getcustname" datasource="#dts#">
        select name,term from #target_arcust# where custno='#form.custno#'
</cfquery>

<cfset ndate = dateformatnew(form.invoicedate,'yyyy-mm-dd')>

<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#ndate#" returnvariable="fperiod"/>

<cfset agettotal = 0>
<cfset ataxamount = 0 >
<cfset anetamt = 0>

<cfloop query="getlist">

<cfquery name="getinvlist" datasource="#dts#">
SELECT * FROM tempcreatebi WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#"> AND orderno = "#getlist.orderno#" ORDER BY refno
</cfquery>

<cfquery name="getgross" datasource="#dts#">
SELECT sum(round(coalesce(custtotalgross,0)+0.00001,2)) as totalamount,taxper,taxcode,custname2 FROM assignmentslip WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar"  value="#valuelist(getinvlist.refno)#" list="yes" separator=",">) and combine <> "Y"
</cfquery>

<cfset gettotal = numberformat(getgross.totalamount,'.__')>
<cfset taxamount = numberformat(gettotal * val(getgross.taxper) / 100,'.__') >
<cfset netamt = numberformat(gettotal + taxamount,'.__')>

<cfset agettotal = agettotal + gettotal>
<cfset ataxamount = ataxamount + taxamount >
<cfset anetamt = anetamt + netamt>

<cfquery name="insertictran" datasource="#dts#">
                insert into ictran
                (
                    type,
                    refno,
                    fperiod,
                    wos_date,
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
                    currrate,
                    PONO
                    )
                    values
                    (
                    'INV',
                    '#refno#',
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
                    '#form.custno#',
                    '#getlist.currentrow#','#getlist.currentrow#',
                    '',
                    'Salary', 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlist.desp#">, 
                    '', 
                    '',
                    '1',
                    #numberformat(val(gettotal),'.__')#, 
                    '',
                     #numberformat(val(gettotal),'.__')#,
                    0,
                    0,
                    0,
                    0,
                    #numberformat(val(gettotal),'.__')#, 
                    '0',
                    '',
                    0.00000,
                    '1',
                     #numberformat(val(gettotal),'.__')#,
                      '',
                      '1',
                       '1',
                        #numberformat(val(gettotal),'.__')#,
                        0,
                        #numberformat(val(gettotal),'.__')#,
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
                          1,
                          <cfqueryparam cfsqltype="cf_sql_varchar"  value="#valuelist(getinvlist.refno)#">
                    )
             </cfquery>
             
             <cfquery datasource='#dts#' name="updateictran">
                Update ictran 
                set 
                taxpec1=#numberformat(val(getgross.taxper),'.__')#,
                note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.taxcode#">,
                taxamt=#numberformat(taxamount,'.__')#,
                taxamt_bil=#numberformat(taxamount,'.__')#
                where refno = '#refno#' and type='INV' and trancode = "#getlist.currentrow#"
		  	</cfquery>
            
            <cfquery name="updatecombine" datasource="#dts#">
            	UPDATE assignmentslip SET combine = "Y",biginvoice = concat(coalesce(biginvoice,''),' ','#refno#') WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar"  value="#valuelist(getinvlist.refno)#" list="yes" separator=",">) and combine <> "Y"
            </cfquery>
            
            <cfif refnolist eq "">
            <cfset refnolist = refno>
            <cfelse>
            <cfset refnolist = refnolist&" , "&refno>
            </cfif>  
            
</cfloop>

<cfquery name="getnewlist" datasource="#dts#">
SELECT refno FROM tempcreatebi WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#"> GROUP BY refno
</cfquery>

<cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="INV">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.taxper#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getgross.custname2,45)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getgross.custname2,45)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">,
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
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.taxcode#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getnewlist.refno)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getgross.custname2,45)#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
  		<Cfif getcustname.term eq "">
        <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
        <cfelse>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
        </Cfif>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">
        )
        </cfquery>

<cfelseif form.combinationtype eq "gnsi" or form.combinationtype eq "me">
	
	<cfquery name="getuuid" datasource="#dts#">
    SELECT orderno,invdesp FROM tempcreatebiitem WHERE uuid = "#form.uuid#" GROUP BY orderno ORDER BY orderno,id
    </cfquery>
    
    <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#ndate#" returnvariable="fperiod"/>
    
    <cfloop query="getuuid">
    
			<cfif getuuid.currentrow neq 1>
            <cftry>
            <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
            <cfcatch>
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
            </cfcatch>
            </cftry>
            
            
            <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
            
            <cfquery name="checkexistrefno" datasource="#dts#">
            select refno from artran where type='INV' and right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
            </cfquery>
            
            <cfif checkexistrefno.recordcount eq 0>
            <cfquery name="checkexistrefno" datasource="#dts#">
            SELECT refno FROM assignmentslip WHERE right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
            </cfquery>
            </cfif>
            
            <cfif checkexistrefno.recordcount neq 0>
            <cfset refnocheck = 0>
            
            <cfloop condition="refnocheck eq 0">
            
            <cftry>
            <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
            <cfcatch>
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
            </cfcatch>
            </cftry>
            
            <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
            
            <cfquery name="checkexistrefno" datasource="#dts#">
            select refno from artran where type='INV' and right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
            </cfquery>
            
            <cfif checkexistrefno.recordcount eq 0>
            <cfquery name="checkexistrefno" datasource="#dts#">
            SELECT refno FROM assignmentslip WHERE right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#"
            </cfquery>
            </cfif>
            
            <cfif checkexistence.recordcount eq 0>
            <cfset refnocheck = 1>
            </cfif>
            </cfloop>                
            
            </cfif>
            
            
            <cfquery datasource="#dts#" name="getGeneralInfo">
            Update refnoset SET lastUsedNo = '#refno#' WHERE type = 'INV'
            and counter = #counter#
            </cfquery>
            
            </cfif>

	<cfquery name="getitem" datasource="#dts#">
    SELECT type,refno as refnoi,desp,amount,qty,price,desp2,itemno,invdesp FROM tempcreatebiitem WHERE orderno = "#getuuid.orderno#" and uuid = "#form.uuid#" ORDER BY orderno,id
    </cfquery>                        
    
    <cfif getitem.recordcount neq 0>
    <cfset trancodestart = 0>
    
    <cfloop query="getitem">
    <cfset trancodestart = trancodestart + 1>
     <cfquery name="insertictran" datasource="#dts#">
        insert into ictran
        (
            type,
            refno,
            fperiod,
            wos_date,
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
            currrate,
            PONO
            )
            values
            (
            'INV',
            '#refno#',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
            '#form.custno#',
            '#trancodestart#','#trancodestart#',
            '',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">, 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.desp#">, 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.desp2#">, 
            '',
            '#val(getitem.qty)#',
            #numberformat(val(getitem.price),'.__')#, 
            '',
             #numberformat(val(getitem.amount),'.__')#,
            0,
            0,
            0,
            0,
            #numberformat(val(getitem.amount),'.__')#, 
            '0',
            '',
            0.00000,
            '#val(getitem.qty)#',
             #numberformat(val(getitem.price),'.__')#,
              '',
              '1',
               '1',
                #numberformat(val(getitem.amount),'.__')#,
                0,
                #numberformat(val(getitem.amount),'.__')#,
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
                  1,
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.refnoi#">
            )
   	 </cfquery>
    </cfloop>
    
    <cfquery name="getassignmentslip" datasource="#dts#">
    SELECT taxper,taxcode,custname2 FROM assignmentslip WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.refnoi#">
    </cfquery>
    
    <cfif val(getassignmentslip.taxper) neq 0>
        <cfquery datasource='#dts#' name="updateictran">
            Update ictran 
            set 
            taxpec1=#numberformat(val(getassignmentslip.taxper),'.__')#,
            note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmentslip.taxcode#">,
            taxamt=round((round(coalesce(amt,'0')+0.000001,2) * #numberformat(val(getassignmentslip.taxper),'.__')#/100)+0.000001,2),
            taxamt_bil=round((round(coalesce(amt,'0')+0.000001,2) * #numberformat(val(getassignmentslip.taxper),'.__')#/100)+0.000001,2)
            where refno = '#refno#' and type='INV'
        </cfquery>
    </cfif>
    
    <cfquery name="getcustname" datasource="#dts#">
        select name,term from #target_arcust# where custno='#form.custno#'
	</cfquery>
    
    <cfquery name="getallamt" datasource="#dts#">
    SELECT sum(round(coalesce(amt,0)+0.00001,2)) as totalamount,sum(round(coalesce(taxamt,0)+0.00001,2)) as totaltax FROM ictran 
    WHERE refno = '#refno#' and type='INV'
    </cfquery>
    
    <cfset agettotal = numberformat(getallamt.totalamount,'.__')>
    <cfset ataxamount = numberformat(getallamt.totaltax,'.__')>
    <cfset anetamt = numberformat(val(agettotal)+val(ataxamount),'.__')>
    
<!---     <cfif form.combinationtype eq "me"> --->
    <cfquery name="getnewlist" datasource="#dts#">
    SELECT refno FROM tempcreatebiitem WHERE uuid = "#form.uuid#" GROUP BY refno
    </cfquery>
<!--- 	</cfif> --->
    
    <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="INV">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
        <cfif form.combinationtype eq "me">
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
        <cfelse>
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#getuuid.invdesp#">,
        </cfif>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agettotal#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ataxamount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmentslip.taxper#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#anetamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getassignmentslip.custname2,45)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getassignmentslip.custname2,45)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">,
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
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmentslip.taxcode#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        <cfif form.combinationtype eq "me">
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
        <cfelse>
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#getuuid.invdesp#">,
        </cfif>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<!---          <cfif form.combinationtype eq "me"> --->
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getnewlist.refno)#">,
         <!--- <cfelse>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        </cfif> --->
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getassignmentslip.custname2,45)#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
  		<Cfif getcustname.term eq "">
        <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
        <cfelse>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
        </Cfif>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">
        )
        </cfquery>
                    
	
	</cfif> 
    
    <cfquery name="getallrefno" datasource="#dts#">
    SELECT refno FROM tempcreatebiitem WHERE uuid = "#form.uuid#" and orderno = "#getuuid.orderno#" GROUP BY refno
    </cfquery>
    
     <cfquery name="updatecombine" datasource="#dts#">
           UPDATE assignmentslip SET combine = "Y",biginvoice = concat(coalesce(biginvoice,''),' ','#refno#') WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar"  value="#valuelist(getallrefno.refno)#" list="yes" separator=",">) and combine <> "Y"
     </cfquery>
     
     <cfif refnolist eq "">
	<cfset refnolist = refno>
    <cfelse>
    <cfset refnolist = refnolist&" , "&refno>
    </cfif>  

	</cfloop>
    
   

</cfif>

<cfoutput>
<script type="text/javascript">
alert('Big Invoice Generation Completed. The invoice number is #refnolist#');
window.location.href='index.cfm';
</script>
</cfoutput>

