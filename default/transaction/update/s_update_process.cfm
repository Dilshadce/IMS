<cfif IsDefined("session.formName") and session.formname eq "updatepage">
<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfif form.t2 eq "INV">
	<cfset totype="Invoice">
	<cfif form.t1 eq "SO">
		<cfset fromtype = "Sales Order">
	</cfif>
<cfelseif form.t2 eq "SAM">
	<cfset totype="Work Order">
	<cfif form.t1 eq "SO">
		<cfset fromtype = "Sales Order">
	</cfif>
</cfif>

<cfif checkbox eq "">
	<h3>No Item is selected.</h3><cfabort>
</cfif>

<body>
<cfset mylist= listchangedelims(checkbox,"",",")>
<cfset cnt=listlen(mylist,";")>
	
<cfloop from="1" to="#cnt#" index="i">
	<cfset thisrefno=listgetat(mylist,i,";")>
	
	<cfquery name="getartran" datasource="#dts#">
		select * from artran where type='#form.t1#' and refno='#thisrefno#'
	</cfquery>
	
	<cfquery name="getictran" datasource="#dts#">
		select * from ictran where type='#form.t1#' and refno='#thisrefno#'
	</cfquery>
	
	<cfquery name="getigrade" datasource="#dts#">
		select * from igrade where type='#form.t1#' and refno='#thisrefno#'
	</cfquery>
	
	<cfset thisdate=CreateDate(year(getartran.wos_date),month(getartran.wos_date),day(getartran.wos_date))>
	<cfif getartran.trdatetime neq "" and getartran.trdatetime neq "0000-00-00 00:00:00">
		<cfset thistrdatetime=CreateDateTime(year(getartran.trdatetime),month(getartran.trdatetime),day(getartran.trdatetime),hour(getartran.trdatetime),minute(getartran.trdatetime),second(getartran.trdatetime))>
	</cfif>
	
	<cfquery datasource="#dts#" name="getRefno">
		select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2 from refnoset
		where type = '#form.t2#'
		and counter = '#form.invset#'
	</cfquery>
	<cfinvoke component="cfc.refno" method="processNum" oldNum="#getRefno.tranno#" returnvariable="newnextNum" /> 
	
	<cfset nexttranno = newnextNum>
	

	
	<cftry>
		<cfquery name="insertartran" datasource="#dts#">
			INSERT INTO `artran` 
			(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,
			`DESP`,`DESPA`,`AGENNO`,`AREA`,`SOURCE`,`JOB`,`CURRRATE`,`GROSS_BIL`,`DISC1_BIL`,
			`DISC2_BIL`,`DISC3_BIL`,`DISC_BIL`,`NET_BIL`,`TAX1_BIL`,`TAX2_BIL`,`TAX3_BIL`,`TAX_BIL`,`GRAND_BIL`,
			`DEBIT_BIL`,`CREDIT_BIL`,`INVGROSS`,`DISP1`,`DISP2`,`DISP3`,`DISCOUNT1`,`DISCOUNT2`,`DISCOUNT3`,
			`DISCOUNT`,`NET`,`TAX1`,`TAX2`,`TAX3`,`TAX`,`TAXP1`,`TAXP2`,`TAXP3`,
			`GRAND`,`DEBITAMT`,`CREDITAMT`,`MC1_BIL`,`MC2_BIL`,`M_CHARGE1`,`M_CHARGE2`,`CS_PM_CASH`,`CS_PM_CHEQ`,
			`CS_PM_CRCD`,`CS_PM_CRC2`,<cfif isdefined("getartran.cs_pm_tt")>`CS_PM_TT`,</cfif>`CS_PM_DBCD`,`CS_PM_VOUC`,`DEPOSIT`,`CS_PM_DEBT`,`CS_PM_WHT`,`CHECKNO`,
			`IMPSTAGE`,`BILLCOST`,`BILLSALE`,`PAIDDATE`,`PAIDAMT`,`REFNO3`,`AGE`,`NOTE`,`TERM`,
			`ISCASH`,`VAN`,`DEL_BY`,`PLA_DODATE`,`ACT_DODATE`,`URGENCY`,`CURRRATE2`,`STAXACC`,`SUPP1`,
			`SUPP2`,`PONO`,`DONO`,`REM0`,`REM1`,`REM2`,`REM3`,`REM4`,`REM5`,
			`REM6`,`REM7`,`REM8`,`REM9`,`REM10`,`REM11`,`REM12`,`FREM0`,`FREM1`,
			`FREM2`,`FREM3`,`FREM4`,`FREM5`,`FREM6`,`FREM7`,`FREM8`,`FREM9`,`COMM1`,
			`COMM2`,`COMM3`,`COMM4`,`ID`,`GENERATED`,`TOINV`,`ORDER_CL`,`EXPORTED`,`EXPORTED1`,
			`EXPORTED2`,`EXPORTED3`,`LAST_YEAR`,`POSTED`,`PRINTED`,`LOKSTATUS`,`VOID`,`NAME`,`PHONEA`,
			`PONO2`,`DONO2`,`CSGTRANS`,`TAXINCL`,`TABLENO`,`CASHIER`,`MEMBER`,`COUNTER`,`TOURGROUP`,
			`TRDATETIME`,`TIME`,`XTRCOST`,`XTRCOST2`,`POINT`,`USERID`,`BPERIOD`,`VPERIOD`,`BDATE`,
			`CURRCODE`,`COMM0`,`REM13`,`REM14`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,`MC6_BIL`,`MC7_BIL`,
			`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`SPECIAL_ACCOUNT_CODE`,`CREATED_BY`,`UPDATED_BY`,`CREATED_ON`,
			`UPDATED_ON`) 
			VALUES 
			('#form.t2#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.refno2#">,'#getartran.trancode#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.custno#">,'#getartran.fperiod#',#thisdate#,
			
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.despa#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.agenno#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.area#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">,
			'#val(getartran.currrate)#','#val(getartran.gross_bil)#','#val(getartran.disc1_bil)#',
			
			'#val(getartran.disc2_bil)#','#val(getartran.disc3_bil)#','#val(getartran.disc_bil)#','#val(getartran.net_bil)#','#val(getartran.tax1_bil)#',
			'#val(getartran.tax2_bil)#','#val(getartran.tax3_bil)#','#val(getartran.tax_bil)#','#val(getartran.grand_bil)#',
			
			'#val(getartran.debit_bil)#','#val(getartran.credit_bil)#','#val(getartran.invgross)#','#val(getartran.disp1)#','#val(getartran.disp2)#',
			'#val(getartran.disp3)#','#val(getartran.discount1)#','#val(getartran.discount2)#','#val(getartran.discount3)#',
			
			'#val(getartran.discount)#','#val(getartran.net)#','#val(getartran.tax1)#','#val(getartran.tax2)#','#val(getartran.tax3)#',
			'#val(getartran.tax)#','#val(getartran.taxp1)#','#val(getartran.taxp2)#','#val(getartran.taxp3)#',
			
			'#val(getartran.grand)#','#val(getartran.debitamt)#','#val(getartran.creditamt)#','#val(getartran.mc1_bil)#','#val(getartran.mc2_bil)#',
			'#val(getartran.m_charge1)#','#val(getartran.m_charge2)#','#val(getartran.cs_pm_cash)#','#val(getartran.cs_pm_cheq)#',
			
			'#val(getartran.cs_pm_crcd)#','#val(getartran.cs_pm_crc2)#',
			<cfif isdefined("getartran.cs_pm_tt")>'#val(getartran.cs_pm_tt)#',</cfif>
			'#val(getartran.cs_pm_dbcd)#',
			'#val(getartran.cs_pm_vouc)#','#val(getartran.deposit)#','#val(getartran.cs_pm_debt)#','#val(getartran.cs_pm_wht)#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.checkno#">,
			
			'#getartran.impstage#','#val(getartran.billcost)#','#val(getartran.billsale)#',
			'<cfif getartran.paiddate eq "">0000-00-00<cfelse>#lsdateformat(getartran.paiddate,"yyyy-mm-dd")#</cfif>',
			'#val(getartran.paidamt)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.refno3#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.age#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.note#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.term#">,
			
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.iscash#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.van#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.del_by#">,
			'<cfif getartran.pla_dodate eq "">0000-00-00<cfelse>#lsdateformat(getartran.pla_dodate,"yyyy-mm-dd")#</cfif>',
			'<cfif getartran.act_dodate eq "">0000-00-00<cfelse>#lsdateformat(getartran.act_dodate,"yyyy-mm-dd")#</cfif>','#getartran.urgency#',
			'#val(getartran.currrate2)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.staxacc#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.supp1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.supp2#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.pono#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.dono#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem0#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem1#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem3#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem5#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem6#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem7#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem9#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem10#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem11#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem12#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem0#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem2#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem4#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem6#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem7#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem8#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.frem9#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.comm1#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.comm2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.comm3#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.comm4#">,'#getartran.id#',<cfif form.t2 neq "SAM">'#getartran.generated#'<cfelse>''</cfif>,
			<cfif form.t2 neq "SAM"><cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.toinv#"><cfelse>''</cfif>,<cfif form.t2 neq "SAM">'#getartran.order_cl#'<cfelse>''</cfif>,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.exported#">,
			'<cfif getartran.exported1 eq "">0000-00-00<cfelse>#lsdateformat(getartran.exported1,"yyyy-mm-dd")#</cfif>',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.exported2#">,
			'<cfif getartran.exported3 eq "">0000-00-00<cfelse>#lsdateformat(getartran.exported3,"yyyy-mm-dd")#</cfif>',
			'#getartran.last_year#','#getartran.posted#','#getartran.printed#','#getartran.lokstatus#','#getartran.void#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.name#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.phonea#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.pono2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.dono2#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.csgtrans#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getartran.taxincl#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.tableno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.cashier#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.member#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.counter#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.tourgroup#">,
			now(),'#getartran.time#','#val(getartran.xtrcost)#','#val(getartran.xtrcost2)#','#val(getartran.point)#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.bperiod#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.vperiod#">,
			'<cfif getartran.bdate eq "">0000-00-00<cfelse>#lsdateformat(getartran.bdate,"yyyy-mm-dd")#</cfif>',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.currcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.comm0#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem13#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.rem14#">,
			'#val(getartran.mc3_bil)#','#val(getartran.mc4_bil)#','#val(getartran.mc5_bil)#','#val(getartran.mc6_bil)#','#val(getartran.mc7_bil)#',
			'#val(getartran.m_charge3)#','#val(getartran.m_charge4)#','#val(getartran.m_charge5)#','#val(getartran.m_charge6)#','#val(getartran.m_charge7)#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.special_account_code#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,now(),now())
		</cfquery>
	<cfcatch type="any">
		<cfoutput>#cfcatch.Message#</cfoutput>
	</cfcatch>
	</cftry>
	
	<cfloop query="getictran">
		<cftry>
			<cfquery name="insertictran" datasource="#dts#">
				INSERT INTO `ictran` 
				(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,
				`LINECODE`,`ITEMNO`,`DESP`,`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,
				`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,
				`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`NOTE_A`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,
				`AMT1`,`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,
				`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,`NOTE2`,`GLTRADAC`,`UPDCOST`,
				`GST_ITEM`,`TOTALUP`,`WITHSN`,`NODISPLAY`,`GRADE`,`PUR_PRICE`,`QTY1`,`QTY2`,`QTY3`,
				`QTY4`,`QTY5`,`QTY6`,`QTY7`,`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,
				`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,
				`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,`VAN`,`GENERATED`,
				`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
				`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,
				`AREA`,`SHELF`,`TEMP`,`TEMP1`,`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,
				`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,
				`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,`MC6_BIL`,`MC7_BIL`,
				`taxincl`<cfif isdefined("getictran.loc_currrate")>,`LOC_CURRRATE`,`LOC_CURRCODE`</cfif>,`TITLE_ID`,`TITLE_DESP`<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,`ictranfilename`</cfif>,`photo`) 
				VALUES 
	 			('#form.t2#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.refno2#">,
				#getictran.trancode#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.custno#">,'#getictran.fperiod#',#thisdate#,
				'#val(getictran.currrate)#',#getictran.itemcount#,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.linecode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.desp#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.despa#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.agenno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.location#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.source#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.job#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.sign#">,
				
				'#val(getictran.qty_bil)#','#val(getictran.price_bil)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.unit_bil#">,
				'#val(getictran.amt1_bil)#','#val(getictran.dispec1)#','#val(getictran.dispec2)#','#val(getictran.dispec3)#','#val(getictran.disamt_bil)#','#val(getictran.amt_bil)#',
				
				'#val(getictran.taxpec1)#','#val(getictran.taxpec2)#','#val(getictran.taxpec3)#','#val(getictran.taxamt_bil)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.note_a#">,
				'#getictran.impstage#','#val(getictran.qty)#','#val(getictran.price)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.unit#">,
				
				'#val(getictran.amt1)#','#val(getictran.disamt)#','#val(getictran.amt)#','#val(getictran.taxamt)#','#val(getictran.factor1)#','#val(getictran.factor2)#',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.dono#">,
				'<cfif getictran.dodate eq "">0000-00-00<cfelse>#lsdateformat(getictran.dodate,"yyyy-mm-dd")#</cfif>',
				'<cfif getictran.sodate eq "">0000-00-00<cfelse>#lsdateformat(getictran.sodate,"yyyy-mm-dd")#</cfif>',
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.brem1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.brem2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.brem3#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.brem4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.packing#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.note1#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.note2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.gltradac#">,'#getictran.updcost#',
				
				'#getictran.gst_item#','#getictran.totalup#','#getictran.withsn#','#getictran.nodisplay#',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.grade#">,'#val(getictran.pur_price)#','#val(getictran.qty1)#',
				'#val(getictran.qty2)#','#val(getictran.qty3)#',
				
				'#val(getictran.qty4)#','#val(getictran.qty5)#','#val(getictran.qty6)#','#val(getictran.qty7)#',
				'#val(getictran.qty_ret)#','#val(getictran.tempfigi)#','#val(getictran.sercost)#','#val(getictran.m_charge1)#','#val(getictran.m_charge2)#',
				
				'#val(getictran.adtcost1)#','#val(getictran.adtcost2)#','#val(getictran.it_cos)#','#val(getictran.av_cost)#',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.batchcode#">,
				'<cfif getictran.expdate eq "">0000-00-00<cfelse>#lsdateformat(getictran.expdate,"yyyy-mm-dd")#</cfif>',
				'#val(getictran.point)#','#val(getictran.inv_disc)#','#val(getictran.inv_tax)#',
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.supp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.edi_cou1#">,
				'#val(getictran.writeoff)#','#val(getictran.toship)#',<cfif form.t2 neq "SAM">'#val(getictran.shipped)#'<cfelse>0</cfif>,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.name#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.del_by#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.van#">,'#getictran.generated#',
				
				'#getictran.ud_qty#',<cfif form.t2 neq "SAM"><cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.toinv#"><cfelse>''</cfif>,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.exported#">,
				'<cfif getictran.exported1 eq "">0000-00-00<cfelse>#lsdateformat(getictran.exported1,"yyyy-mm-dd")#</cfif>',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.exported2#">,
				'<cfif getictran.exported3 eq "">0000-00-00<cfelse>#lsdateformat(getictran.exported3,"yyyy-mm-dd")#</cfif>',
				'#getictran.brk_to#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.sv_part#">,'#getictran.last_year#',
				
				'#getictran.void#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.sono#">,
				'#val(getictran.mc1_bil)#','#val(getictran.mc2_bil)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,
				'#val(getictran.damt)#','#getictran.oldbill#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.wos_group#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.category#">,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.area#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.shelf#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.temp#">,'#val(getictran.temp1)#','#getictran.body#','#getictran.totalgroup#',
				'#getictran.mark#','#getictran.type_seq#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.promoter#">,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.tableno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.member#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.tourgroup#">,
				now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.time#">,'#getictran.bomno#',
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getictran.comment)#">,'#getictran.defective#','#val(getictran.m_charge3)#',
				
				'#val(getictran.m_charge4)#','#val(getictran.m_charge5)#','#val(getictran.m_charge6)#','#val(getictran.m_charge7)#',
				'#val(getictran.mc3_bil)#','#val(getictran.mc4_bil)#','#val(getictran.mc5_bil)#','#val(getictran.mc6_bil)#','#val(getictran.mc7_bil)#',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.taxincl#">
				<cfif isdefined("getictran.loc_currrate")>
					,'#val(getictran.loc_currrate)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.loc_currcode#">
				</cfif>,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.title_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.title_desp#"><cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.ictranfilename#"></cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.photo#">)
			</cfquery>
			
            <cfif form.t2 neq "SAM">
			<cfif getictran.batchcode neq "">
				<cfif getictran.location neq "">
					<cfquery name="updateobbatch" datasource="#dts#">
						update lobthob set bth_qut=(bth_qut+#val(getictran.qty)#)
						where location='#getictran.location#' 
						and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#"> 
						and batchcode = '#getictran.batchcode#'
					</cfquery>
					<cfquery name="updateobbatch" datasource="#dts#">
						update obbatch set bth_qut=(bth_qut+#val(getictran.qty)#)
						where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#"> and batchcode = '#getictran.batchcode#'
					</cfquery>
				<cfelse>
					<cfquery name="updateobbatch" datasource="#dts#">
						update obbatch set bth_qut=(bth_qut+#val(getictran.qty)#)
						where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#"> and batchcode = '#getictran.batchcode#'
					</cfquery>
				</cfif>
			</cfif>
            </cfif>
            
			<cfif form.t2 neq "SAM">
			<cfset qname='QOUT'&(val(getictran.fperiod)+10)>
			<cfif getictran.linecode neq "SV">
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+#val(getictran.qty)#) where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#">
				</cfquery>
			</cfif>
			</cfif>
			<cfquery name="inserticlink" datasource="#dts#">
				insert into iclink values ('#form.t2#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#">,'#val(getictran.itemcount)#',
				#thisdate#,'#form.t1#','#getictran.refno#','#getictran.trancode#',
				#thisdate#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#">,'#val(getictran.qty)#')
			</cfquery>
			
			<cfquery datasource="#dts#" name="updateictran">
				Update ictran set <cfif form.t2 neq "SAM">shipped = '#val(getictran.qty)#',toinv = '#nexttranno#', generated = 'Y'<cfelse>exported2 = '#nexttranno#' , exported3="#dateformat(now(),'YYYY-MM-DD')#"</cfif>
				where refno = '#getictran.refno#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#"> and trancode = '#getictran.trancode#'
				and type = '#form.t1#'
			</cfquery>
		<cfcatch type="any">
			<cfoutput>#cfcatch.Message#:::#cfcatch.Detail#</cfoutput>
		</cfcatch>
		</cftry>
	</cfloop>
	<cfif form.t2 neq "SAM">
	<cfloop query="getigrade">
		<cftry>
			<cfquery name="insertigrade" datasource="#dts#">
				INSERT INTO `igrade` 
				(`TYPE`,`REFNO`,`TRANCODE`,`ITEMNO`,`WOS_DATE`,`FPERIOD`,`SIGN`,`DEL_BY`,`LOCATION`,
				`VOID`,`GENERATED`,`CUSTNO`,`EXPORTED`,`FACTOR1`,`FACTOR2`
				<cfloop from="11" to="70" index="a">
					,GRD#a#
				</cfloop>) 
				VALUES 
	 			('#form.t2#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#">,'#val(getigrade.trancode)#',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.itemno#">,#thisdate#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.fperiod#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.sign#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.del_by#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.location#">,'','',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.custno#">,'','#val(getigrade.factor1)#','#val(getigrade.factor2)#'
	
				<cfloop from="11" to="70" index="a">
					,#getigrade["GRD#a#"][getigrade.currentrow]#
				</cfloop>			
				)
			</cfquery>
		<cfcatch type="any">
			<cfoutput>#cfcatch.Message#</cfoutput>
		</cfcatch>
		</cftry>
		
		<cfquery name="updateitemgrd" datasource="#dts#">
			update itemgrd
			set
			<cfloop from="11" to="70" index="a">
				<cfif a neq 70>
					BGRD#a#=BGRD#a#-#getigrade["GRD#a#"][getigrade.currentrow]#,
				<cfelse>
					BGRD#a#=BGRD#a#-#getigrade["GRD#a#"][getigrade.currentrow]#
				</cfif>
			</cfloop>
			where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.itemno#">
		</cfquery>
					
		<cfquery name="updatelogrdob" datasource="#dts#">
			update logrdob
			set
			<cfloop from="11" to="70" index="a">
				<cfif a neq 70>
					BGRD#a#=BGRD#a#-#getigrade["GRD#a#"][getigrade.currentrow]#,
				<cfelse>
					BGRD#a#=BGRD#a#-#getigrade["GRD#a#"][getigrade.currentrow]#
				</cfif>
			</cfloop>
			where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.itemno#">
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">
		</cfquery>
		
		<cfquery datasource="#dts#" name="updateigrade">
			Update igrade i 
			set i.generated = 'Y'
			where i.refno = '#getigrade.refno#' and i.type = '#getigrade.type#'
			and i.itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getigrade.itemno#"> and i.trancode = '#val(getigrade.trancode)#'
		</cfquery>
	</cfloop>
    </cfif>
	
	<cfquery name="updateartan" datasource="#dts#">
		update artran set <cfif form.t2 neq "SAM">toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'<cfelse> exported2 = '#nexttranno#', exported3 = "#dateformat(now(),'YYYY-MM-DD')#"</cfif> where type='#form.t1#' and refno='#thisrefno#'
	</cfquery>
    
    	<cfquery name="updategsetup" datasource="#dts#">
		update refnoset set 
		lastUsedNo=UPPER('#nexttranno#')
		where type = '#form.t2#'
		and counter =  '#invset#'
	</cfquery>
    <cfset foldername = "#HRootPath#\download\#dts#\bill\#form.t1#\#thisrefno#">
    <cfset destiname = "#HRootPath#\download\#dts#\bill\#form.t2#\#nexttranno#\">
	<cfif DirectoryExists(foldername)>
    <cfdirectory action="list" directory="#foldername#" name="file_list">
    <cfloop query="file_list">
    <cfif not DirectoryExists(destiname)>
    <cfdirectory action="create" directory="#destiname#" />
	</cfif>    
    <cffile action="copy" source="#foldername#\#file_list.name#" destination="#destiname#"> 
    </cfloop>
	</cfif>
</cfloop>
<cfoutput>The Selected #fromtype# Update to #totype# Successfully.
<input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#form.t2#&nexttranno=#nexttranno#')">
</cfoutput>

</body>
</html>
<cfset StructDelete(Session, "formName")>
<cfelse>
	This form has either already been submitted or is being called from the wrong page.
</cfif>