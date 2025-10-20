<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1125,1111,1123, 1124">
<cfinclude template="/latest/words.cfm">
<html>
<head>
    <link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfset uuid = form.uuid>
<cfset frem0 = ''>
<cfset frem1 = ''>
<cfset frem2 = ''>
<cfset frem3 = ''>
<cfset frem4 = ''>
<cfset frem5 = ''>
<cfset frem6 = ''>
<cfset frem7 = ''>
<cfset frem8 = ''>
<cfset remark2 = ''>
<cfset remark3 = ''>
<cfset remark4 = ''>
<cfset remark12 = ''>
<cfset comm0 = ''>
<cfset comm1 = ''>
<cfset comm2 = ''>
<cfset comm3 = ''>
<cfset comm4 = ''>
<cfset agenno = ''>
<cfset phonea = ''>
<cfset term = ''>
<cfset driver = ''>
<cfset source = ''>
<cfset job = ''>
<cfset refno = form.refno>
<cfset custno = 'ASSM/999'>
<cfset currcode = ''>
<cfset currrate = 1>
<cfset ndate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
<cfset wos_date = dateformat(ndate,'yyyy-mm-dd')>
<cfquery name="checkexistrefno" datasource="#dts#">
	SELECT refno 
	FROM artran 
	WHERE type='ISS' AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>
<cfquery name="checkexistrefno2" datasource="#dts#">
	SELECT refno 
	FROM artran 
	WHERE type='RC' AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>
<cfif checkexistrefno.recordcount neq 0 or checkexistrefno2.recordcount neq 0>
	<cfquery datasource="#dts#" name="getGeneralInfo">
		SELECT lastUsedNo AS tranno, refnoused AS arun,refnocode,refnocode2,presuffixuse
		FROM refnoset
		WHERE type = 'ASSM' 
        AND counter = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnoCounter#">
    </cfquery>
	<cfif getGeneralInfo.arun eq "1">
		<cfset refnocheck = 0>
		<cfset refno1 = getGeneralInfo.tranno>
		<cfloop condition="refnocheck eq 0">
			<cftry>
				<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
			<cfcatch>
				<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />	
			</cfcatch>
			</cftry>
			<cfquery name="checkexistence" datasource="#dts#">
				SELECT refno
				FROM artran
				WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> AND type = 'ISS'
			</cfquery>
			<cfquery name="checkexistence2" datasource="#dts#">
				SELECT refno
				FROM artran
				WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> AND type = 'RC'
			</cfquery>
			<cfif checkexistence.recordcount eq 0 and checkexistence2.recordcount eq 0>
				<cfset refnocheck = 1>
			<cfelse>
				<cfset refno1 = refno>
			</cfif>
		</cfloop>
	<cfelse>
    	<cfoutput>
			<h3>#words[1125]# <a href="##" onClick="history.go(-1);">#words[1111]#</a></h3>
        </cfoutput>
	<cfabort />
	</cfif>
</cfif>
	<!---
<cfif tran eq "rc" or tran eq "pr" or tran eq "po">        
<cfquery name="getarea" datasource="#dts#">
select area from #target_apvend# where custno='#custno#'
</cfquery>
<cfelse>
<cfquery name="getarea" datasource="#dts#">
select area from #target_arcust# where custno='#custno#'
</cfquery>
</cfif>--->

<!---ISS--->
<cfquery name="updaterate" datasource="#dts#">
	UPDATE issuetemp 
	SET price = price_bil * #val(currrate)#,
		amt1 = amt1_bil * #val(currrate)#,
		amt = amt_bil * #val(currrate)#,
		disamt = disamt_bil * #val(currrate)#,
		fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
		custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
		wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
		currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
		type=<cfqueryparam cfsqltype="cf_sql_varchar" value="ISS">,
		refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
		trdatetime = now()
	WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>


<!---RC--->
<cfquery name="updaterate2" datasource="#dts#">
	UPDATE receivetemp 
	SET price = price_bil * #val(currrate)#,
		amt1 = amt1_bil * #val(currrate)#,
		amt = amt_bil * #val(currrate)#,
		disamt = disamt_bil * #val(currrate)#,
		fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
		custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
		wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
		currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
		type=<cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
		refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
		trdatetime = now()
	WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>


<!--- ISS--->
<cfquery name="gettotaliss" datasource="#dts#">
	SELECT sum(amt) AS amt,type 
	FROM issuetemp 
	WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
<cfset gross_bil = val(gettotaliss.amt)>
<cfset disp1 = 0>
<cfset disp2 = 0>
<cfset disp3 = 0>
<cfset disc1_bil = 0>
<cfset disc2_bil = 0>
<cfset disc3_bil = 0>
<cfset disc_bil = 0>
<cfset net_bil = val(gettotaliss.amt)>
<cfset taxincl = "">
<cfset note = "">
<cfset taxp1 = 0>
<cfset tax_bil = 0>
<cfset tax1_bil = 0>
<cfset grand_bil = val(gettotaliss.amt)>
<cfif gettotaliss.type eq "rc" or gettotaliss.type eq "pr" or gettotaliss.type eq "po" or gettotaliss.type eq "CN">
	<cfset credit_bil = grand_bil>
    <cfset debit_bil = 0>
<cfelse>
	<cfset debit_bil = grand_bil>
    <cfset credit_bil = 0>
</cfif>
<cfset invgross = gross_bil * val(currrate)>
<cfset discount1 = disc1_bil * val(currrate)>
<cfset discount2 = disc2_bil * val(currrate)>
<cfset discount3 = disc3_bil * val(currrate)>
<cfset discount = disc_bil * val(currrate)>
<cfset net = net_bil * val(currrate)>
<cfset tax1 = tax1_bil * val(currrate)>
<cfset tax = tax_bil * val(currrate)>
<cfset grand = grand_bil * val(currrate)>
<cfset debitamt = debit_bil * val(currrate)>
<cfset creditamt = credit_bil * val(currrate)>
<cfquery name="insertartran" datasource="#dts#">
    INSERT INTO artran (
        type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,
        disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,
        disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,
        frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,
        comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,
        trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,
        DEPOSIT,rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,counter,rem7,rem6,rem5,rem8,rem10,termscondition)
    VALUES (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="ISS">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#debit_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#credit_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disp1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disp2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disp3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem5#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem6#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem7#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem8#">,
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark12#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm0#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxincl#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        "",
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '',
        '',
        0,
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
    )
</cfquery>


<cfquery name="insertbody" datasource="#dts#">
    INSERT INTO ictran (
        TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, 
        DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, 
        DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, 
        QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, 
        BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, 
        PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, 
        ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, 
        WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, 
        EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, 
        CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, 
        TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, 
        MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl,milcert,pallet)
    SELECT 
        TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, 
        DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, 
        DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, 
        AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, 
        NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, 
        QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, 
        AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, 
        DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, 
        LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, 
        TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, 
        COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, 
        MC6_BIL, MC7_BIL, taxincl,milcert,pallet
    FROM issuetemp
    WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="ISS"> AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>


<!---RC--->
<cfquery name="gettotalrc" datasource="#dts#">
    SELECT sum(amt) AS amt,type 
    FROM receivetemp 
    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
<cfset gross_bil = val(gettotalrc.amt)>
<cfset disp1 = 0>
<cfset disp2 = 0>
<cfset disp3 = 0>
<cfset disc1_bil = 0>
<cfset disc2_bil = 0>
<cfset disc3_bil = 0>
<cfset disc_bil = 0>
<cfset net_bil = val(gettotalrc.amt)>
<cfset taxincl = "">
<cfset note = "">
<cfset taxp1 = 0>
<cfset tax_bil = 0>
<cfset tax1_bil = 0>
<cfset grand_bil = val(gettotalrc.amt)>
<cfif gettotalrc.type eq "rc" or gettotalrc.type eq "pr" or gettotalrc.type eq "po" or gettotalrc.type eq "CN">
	<cfset credit_bil = grand_bil>
    <cfset debit_bil = 0>
<cfelse>
	<cfset debit_bil = grand_bil>
    <cfset credit_bil = 0>
</cfif>
<cfset invgross = gross_bil * val(currrate)>
<cfset discount1 = disc1_bil * val(currrate)>
<cfset discount2 = disc2_bil * val(currrate)>
<cfset discount3 = disc3_bil * val(currrate)>
<cfset discount = disc_bil * val(currrate)>
<cfset net = net_bil * val(currrate)>
<cfset tax1 = tax1_bil * val(currrate)>
<cfset tax = tax_bil * val(currrate)>
<cfset grand = grand_bil * val(currrate)>
<cfset debitamt = debit_bil * val(currrate)>
<cfset creditamt = credit_bil * val(currrate)>
<cfset ndate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
<cfset wos_date = dateformat(ndate,'yyyy-mm-dd')>
<cfquery name="insertartran" datasource="#dts#">
    INSERT INTO artran (
    	type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,
        gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,
        credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,
        debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,
        rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,
        userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,
        CS_PM_VOUC,DEPOSIT,rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,counter,rem7,rem6,rem5,rem8,
        rem10,termscondition)
	VALUES (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#debit_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#credit_bil#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disp1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disp2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#disp3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem5#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem6#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem7#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem8#">,
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#remark12#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm0#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#comm4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxincl#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        "",
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '',
        '',
        0,
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
	)
</cfquery>




<cfquery name="insertbody" datasource="#dts#">
    INSERT INTO ictran (
        TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO,
        DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1,
        DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY,
        PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3,
        BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE,
        QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1,
        ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF,
        TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO,
        SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, 
        TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, 
        DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, 
        taxincl,milcert,pallet)
    
	SELECT
    	TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP,
        DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3,
        DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT,
        AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC,
        UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7,
        QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE,
        POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY,
        TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL,
        USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER,
        TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6,
        M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl,milcert,pallet
    FROM receivetemp
    WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="RC"> AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>


<cfquery name="checkReferenceNo" datasource="#dts#">
	SELECT refno
    FROM assmtran
    WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">;
</cfquery>

<cfif checkReferenceNo.recordcount NEQ 0>
	<cfquery name="deleteReferenceNo" datasource="#dts#">
        DELETE FROM assmtran
        WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">;
    </cfquery>	
</cfif>

<cfquery name="insertassm" datasource="#dts#">
    INSERT INTO assmtran (refno,wos_date,created_on,created_by) 
    VALUES (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
    now(),
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">
    )
</cfquery>

<!--- Batch ISS Function--->
<cfquery name="getissbody" datasource="#dts#">
    SELECT * 
    FROM issuetemp 
    WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfloop query="getissbody">
    <cfquery name="checkbatch" datasource="#dts#">
        SELECT batchcode 
        FROM obbatch 
        WHERE batchcode='#getissbody.batchcode#' AND itemno='#getissbody.itemno#';
    </cfquery>
    <cfif checkbatch.recordcount eq 0>
        <cfquery name="insertbatch" datasource="#dts#">
            INSERT INTO obbatch (
                batchcode,
                itemno,
                type,
                refno,
                bth_QOB,
                BTH_QIN,
                BTH_QUT,
                RPT_QOB,
                RPT_QIN,
                RPT_QUT,
                EXP_DATE,
                manu_date,
                milcert,
                importpermit,
                countryoforigin,
                pallet,
                RC_TYPE,
                RC_REFNO,
                RC_EXPDATE
                
            ) 
            VALUES  
            (
                '#getissbody.batchcode#',
                '#getissbody.itemno#',
                '#getissbody.type#',
                '#getissbody.trancode#',
                '0',
                '0',
                '#getissbody.qty#',
                '0',
                '0',
                '0',
                <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>,
                    '0000-00-00',
                    '#getissbody.milcert#',
                    '',
                    '',
                    '#val(getissbody.pallet)#',
                    '#getissbody.type#',
                    '#getissbody.refno#',
                <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>             
            );
        </cfquery>
    <cfelse>
        <cfquery name="updateobbatch" datasource="#dts#">
            UPDATE obbatch
            SET BTH_QUT=(BTH_QUT+#getissbody.qty#) 
            WHERE itemno='#getissbody.itemno#' AND batchcode='#getissbody.batchcode#';
        </cfquery>
    </cfif>
    <cfif getissbody.location neq "">
        <cfquery name="checklobthob" datasource="#dts#">
            SELECT batchcode 
            FROM lobthob 
            WHERE location='#getissbody.location#' AND batchcode='#getissbody.batchcode#' AND itemno='#getissbody.itemno#';
        </cfquery>
        <cfif checklobthob.recordcount eq 0>
            <cfquery name="insertlobthob" datasource="#dts#">
                INSERT INTO lobthob (
                    location,
                    batchcode,
                    itemno,
                    type,
                    refno,
                    bth_QOB,
                    BTH_QIN,
                    BTH_QUT,
                    RPT_QOB,
                    RPT_QIN,
                    RPT_QUT,
                    EXPDATE,
                    manudate,
                    milcert,
                    importpermit,
                    countryoforigin,
                    pallet,
                    RC_TYPE,
                    RC_REFNO,
                    RC_EXPDATE
                    ) 
                VALUES (
                    '#getissbody.location#',
                    '#getissbody.batchcode#',
                    '#getissbody.itemno#',
                    '#getissbody.type#',
                    '#getissbody.refno#',
                    '0',
                    '0',
                    '#getissbody.qty#',
                    '0',
                    '0',
                    '0',
                    <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>,
                    '0000-00-00',
                    '#getissbody.milcert#',
                    '',
                    '',
                    '#val(getissbody.pallet)#',
                    '#getissbody.type#',
                    '#getissbody.refno#',
                    <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>
                );
            </cfquery>
        <cfelse>
            <cfquery name="updatelobthob" datasource="#dts#">
                UPDATE lobthob
                SET BTH_QUT=(BTH_QUT+#getissbody.qty#) 
                WHERE location='#getissbody.location#' AND itemno='#getissbody.itemno#' AND batchcode='#getissbody.batchcode#';
            </cfquery>
        </cfif>
    </cfif>
</cfloop>

<!--- Batch RC Function--->

<cfquery name="getrcbody" datasource="#dts#">
    SELECT * 
    FROM receivetemp 
    WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfloop query="getrcbody">
    <cfquery name="checkbatch" datasource="#dts#">
        SELECT batchcode 
        FROM obbatch 
        WHERE batchcode='#getrcbody.batchcode#' AND itemno='#getrcbody.itemno#';
    </cfquery>
	<cfif checkbatch.recordcount eq 0>
        <cfquery name="insertbatch" datasource="#dts#">
            INSERT INTO obbatch (
                batchcode,
                itemno,
                type,
                refno,
                bth_QOB,
                BTH_QIN,
                BTH_QUT,
                RPT_QOB,
                RPT_QIN,
                RPT_QUT,
                EXP_DATE,
                manu_date,
                milcert,
                importpermit,
                countryoforigin,
                pallet,
                RC_TYPE,
                RC_REFNO,
                RC_EXPDATE
            ) 
            VALUES (
                '#getrcbody.batchcode#',
                '#getrcbody.itemno#',
                '#getrcbody.type#',
                '#getrcbody.trancode#',
                '0',
                '#getrcbody.qty#',
                '0',
                '0',
                '0',
                '0',
                <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>,
                    '0000-00-00',
                    '#getrcbody.milcert#',
                    '',
                    '',
                    '#val(getrcbody.pallet)#',
                    '#getrcbody.type#',
                    '#getrcbody.refno#',
                <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>
            );
        </cfquery>
    <cfelse>
        <cfquery name="updateobbatch" datasource="#dts#">
            UPDATE obbatch 
            SET BTH_QIN=(BTH_QIN+#getrcbody.qty#) 
            WHERE itemno='#getrcbody.itemno#' AND batchcode='#getrcbody.batchcode#';
        </cfquery>
    </cfif>
	<cfif getrcbody.location neq "">
        <cfquery name="checklobthob" datasource="#dts#">
            SELECT batchcode 
            FROM lobthob 
            WHERE location='#getrcbody.location#' AND batchcode='#getrcbody.batchcode#' AND itemno='#getrcbody.itemno#';
        </cfquery>
        <cfif checklobthob.recordcount eq 0>
            <cfquery name="insertlobthob" datasource="#dts#">
                INSERT INTO lobthob (
                    location,
                    batchcode,
                    itemno,
                    type,
                    refno,
                    bth_QOB,
                    BTH_QIN,
                    BTH_QUT,
                    RPT_QOB,
                    RPT_QIN,
                    RPT_QUT,
                    EXPDATE,
                    manudate,
                    milcert,
                    importpermit,
                    countryoforigin,
                    pallet,
                    RC_TYPE,
                    RC_REFNO,
                    RC_EXPDATE
                ) 
                VALUES (
                    '#getrcbody.location#',
                    '#getrcbody.batchcode#',
                    '#getrcbody.itemno#',
                    '#getrcbody.type#',
                    '#getrcbody.refno#',
                    '0',
                    '#getrcbody.qty#',
                    '0',
                    '0',
                    '0',
                    '0',
                    <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>,
                        '0000-00-00',
                        '#getrcbody.milcert#',
                        '',
                        '',
                        '#val(getrcbody.pallet)#',
                        '#getrcbody.type#',
                        '#getrcbody.refno#',
                    <cfif getissbody.expdate eq ''>'0000-00-00'<cfelse>#getissbody.expdate#</cfif>
                );
            </cfquery>
        <cfelse>
            <cfquery name="updatelobthob" datasource="#dts#">
                UPDATE lobthob 
                SET BTH_QIN=(BTH_QIN+#getrcbody.qty#) 
                WHERE location='#getrcbody.location#' AND itemno='#getrcbody.itemno#' AND batchcode='#getrcbody.batchcode#';
            </cfquery>
        </cfif>
    </cfif>
</cfloop>

<!--- --->


<!--- Serial RC Function--->
<cfquery name="gettempserialno" datasource="#dts#">
    SELECT * 
    FROM iserialtemp 
    WHERE uuid='#uuid#'
</cfquery>
<cfloop query="gettempserialno">
    <cfquery name="checkexistserialno" datasource="#dts#">
        SELECT sum(sign) AS qty 
        FROM iserial 
        WHERE itemno='#itemno#' AND serialno='#gettempserialno.serialno#'
    </cfquery>
	<cfif checkexistserialno.qty gt 0>
    <cfelse>
        <cfquery name="inserttempserial" datasource="#dts#">
            INSERT INTO iserial
            (type,refno,trancode,custno,fperiod,wos_date,itemno,serialno,agenno,location,currrate,sign,price) 
            SELECT 
            type,refno,trancode,custno,fperiod,wos_date,itemno,serialno,agenno,location,currrate,sign,price 
            FROM iserialtemp
            WHERE uuid='#uuid#' AND trancode='#gettempserialno.trancode#' AND serialno='#gettempserialno.serialno#' AND itemno='#gettempserialno.itemno#'
        </cfquery>
    </cfif>
</cfloop>

<!------>


<!---
<cfif type eq "RC">
<cfquery name="checkupdate" datasource="#dts#">
SELECT UPDATE_UNIT_COST FROM gsetup2
</cfquery>
<cftry>
<cfif checkupdate.update_unit_cost eq "T">
	<cfquery name = "getictran" datasource = "#dts#">
		select 
		custno,
		itemno,
		price,
		dispec1,
		dispec2,
		dispec3,
        UPDCOST,
        type,
        refno
		from ictran 
		where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
		and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
		and fperiod <> '99' 
		order by itemcount;
	</cfquery>
	
	<cfif getictran.recordcount gt 0 and getictran.UPDCOST neq "Y">
		<cfloop query = "getictran">
			<cfquery name = "updateIcitem" datasource = "#dts#">
				update icitem 
				set ucost=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">
				where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">;
			</cfquery>
            
            <cfquery name="updateictran" datasource="#dts#">
            	UPDATE ICTRAN SET UPDCOST = "Y" WHERE 
                type=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.type#">
                and refno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.refno#">
                and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">
                and fperiod <> '99'
                
            </cfquery>
			
			<cfif getictran.custno neq "">
				<cfquery name = "update_icl3p2" datasource = "#dts#">
					insert into icl3p2 
					(
						itemno,
						custno,
						price,
						dispec,
						dispec2,
						dispec3
					)
					values 
					(
						<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.custno#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec1#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec2#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec3#">
					) 
					on duplicate key update 
					price=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">,
					dispec=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec1#">,
					dispec2=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec2#">,
					dispec3=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec3#">;
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
<cfelse>
<cfquery name = "updateictran" datasource = "#dts#">
		UPDATE ICTRAN SET UPDCOST = "Y" WHERE 
		type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
		and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
		and fperiod <> '99
	</cfquery>
</cfif>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>
--->
<cfquery datasource="#dts#" name="getGeneralInfo">
    SELECT lastUsedNo AS tranno, refnoused AS arun,refnocode,refnocode2,presuffixuse 
    FROM refnoset
    WHERE type = 'ASSM' 
    AND counter = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnoCounter#">
</cfquery>
<cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1" and getGeneralInfo.arun eq "1">
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
<cfelse>
	<cfset newnextnum = refno>
</cfif>
<cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newnextnum#">
    WHERE type = 'ASSM' 
    AND counter = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnoCounter#">
</cfquery>
<cfquery name="getgeneral" datasource="#dts#">
    SELECT AECE 
    FROM gsetup
</cfquery>
<form name="done" action="/default/transaction/dissemble/" method="post">
    <cfoutput>
        <input name="status" value="#words[1123]# #refno# #words[1124]#" type="hidden">
    </cfoutput>
</form>
<script language="javascript" type="text/javascript">
	done.submit();
</script>
</body>
</html>