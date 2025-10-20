<html>
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<cfset followlocationrefno=0><!---Follow location Profile Running No--->

<cfif lcase(huserloc) neq "all_loc">
<cfquery datasource="#dts#" name="getlocationrefno">
			select lastUsedNo
            from refnoset_location
			where type = '#tran#'
			and location = '#huserloc#'
            and activate="T"
</cfquery>
<cfif getlocationrefno.recordcount neq 0>
<cfset followlocationrefno=1>
</cfif>
</cfif>

<cfif lcase(huserloc) neq "all_loc" and followlocationrefno eq 1>

<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset_location
			where type = '#tran#'
			and location = '#huserloc#'
            and activate="T"
</cfquery>

<cfelse>
<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#tran#'
			and counter = '#refnoset#'
</cfquery>
</cfif>


<cfquery name="getposdefault" datasource="#dts#">
SELECT * FROM gsetuppos
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>


<cfset uuid = form.uuid>

<cfset type = form.tran>
<cfset refno = form.refno>
<cfset custno = form.custno>
<cfset currcode = form.currcode>
<cfset currrate = form.currrate>

<cfset agenno = form.agent>

<cfset disp1 = val(form.dispec1)>
<cfset disp2 = val(form.dispec2)>
<cfset disp3 = val(form.dispec3)>
<cfset disc1_bil = form.disbil1>
<cfset disc2_bil = form.disbil2>
<cfset disc3_bil = form.disbil3>
<cfset disc_bil = form.disamt_bil>
<cfset net_bil = form.net>
<cfif isdefined('form.taxincl')>
<cfset taxincl = form.taxincl>
<cfelse>
<cfset taxincl = "">
</cfif>
<cfif isdefined('form.taxcode')>
<cfset note = form.taxcode>
<cfelse>
<cfset note = "">
</cfif>
<cfset taxp1 = form.taxper>
<cfset tax_bil = form.taxamt>
<cfset tax1_bil = form.taxamt>
<cfset grand_bil = form.grand>
<cfset roundadj = 0>
<cfset actualamount=form.grand>

<cfif getgsetup.dfpos eq "0.05">
<cfset grand_bil = numberformat((numberformat(val(grand_bil)* 2,'._')/2),'.__')>
<cfset roundadj=grand_bil-actualamount>
</cfif>

<cfif isdefined('form.taxincl')>
<cfset form.gross=form.gross-form.taxamt-val(roundadj)>
</cfif>
<cfset gross_bil = form.gross>


<cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "CN">
<cfset credit_bil = grand_bil>
<cfset debit_bil = 0>
<cfelse>
<cfset debit_bil = grand_bil>
<cfset credit_bil = 0>
</cfif>
<cfif val(currrate) eq "0">
<cfset currrate = 1>
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

<!---Trade In module --->
<cfif lcase(hcomid) eq "amgworld_i" or lcase(hcomid) eq "netilung_i">
<cfset tradeinrefno="">
		<cfquery name="checktradeinexist" datasource="#dts#">
        SELECT refno FROM tradeintemp
        where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
        </cfquery>
        
        <cfif checktradeinexist.recordcount neq 0>
        

        <cfquery datasource="#dts#" name="getGeneralInfoamg">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = 'RC'
				and counter = '2'
			</cfquery>

        <cfset refnocheck = 0>
        <cfset tradeinrefno1 = getGeneralInfoamg.tranno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#tradeinrefno1#" returnvariable="tradeinrefno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#tradeinrefno1#" returnvariable="tradeinrefno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tradeinrefno#"> and type = 'RC'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset tradeinrefno1 = tradeinrefno>
		</cfif>
        </cfloop>

        <cfquery name="updaterate" datasource="#dts#">
        update tradeintemp 
        SET
        fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
        refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tradeinrefno#">,
        trdatetime = <cfif hcomid eq "amgworld_i">"#wos_date# 00:00:01"<cfelse>now()</cfif>
        WHERE 
        uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
        </cfquery>
        
        <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,CS_PM_TT,rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,counter,rem7,rem6,point,rem5)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#tradeinrefno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="4000/TI1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.telegraph_transfer)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membername#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membername#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfif form.membername eq ''>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile"><cfelse>''</cfif>,
        <cfif form.membername eq ''><cfqueryparam cfsqltype="cf_sql_varchar" value="Profile"><cfelse>''</cfif>,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membertel#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membertel#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="F">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="NR">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        "#form.cctype#",
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Trade In">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">,
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
        '0',
        '0',
        '0',
        '0',
        '',
        "",
        '',
        '',
        '',
        '0',
        '0'
        )
        </cfquery>
        
        <cfquery name="updaterefno" datasource="#dts#">
        UPDATE refnoset 
        SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tradeinrefno#">
        where type = 'RC'
        and counter = '2'
        </cfquery>
        
        <cfquery name="updateiserialtemp" datasource="#dts#">
            update iserialtemp set
            fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
            custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="4000/TI1">,
            wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
            refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tradeinrefno#">
            where
            uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="RC">
        </cfquery>
        
        

		<cfquery name="inserttradeinbody" datasource="#dts#">
        INSERT INTO ictran 
        
        (TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)
        
        SELECT 
        
        TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl
        
        FROM tradeintemp
        where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
        </cfquery>



		</cfif>
</cfif>
<!--- --->

<cfif getGeneralInfo.arun eq "1">
<cfif type eq "INV" or type eq "QUO">
<cfset minuslen = 4>
<cfelse>
<cfset minuslen = 3>
</cfif>
<cfset refnolen = len(refno)-minuslen>
<cfset refno = right(refno,refnolen)>
</cfif>

<cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='#type#' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>
		<cfif checkexistrefno.recordcount neq 0>
        
        <cfif lcase(huserloc) neq "all_loc" and followlocationrefno eq 1>

        <cfquery datasource="#dts#" name="getGeneralInfo">
                select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
                from refnoset_location
                where type = '#tran#'
                and location = '#huserloc#'
                and activate="T"
        </cfquery>
        
        <cfelse>
        
        
        <cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = '#type#'
				and counter = '#refnoset#'
			</cfquery>
        </cfif>
        
        <cfif getGeneralInfo.arun eq "1">
        <cfset refnocheck = 0>
        <cfset refno1 = checkexistrefno.refno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = '#type#'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = refno>
		</cfif>
        </cfloop>
		<cfelse>
        <h3>The refno existed. Please enter new refno. <a href="##" onClick="history.go(-1);">Back</a></h3>
        <cfabort />
        </cfif>
        
        </cfif>
<cfif tran eq "rc" or tran eq "pr" or tran eq "po">        
<cfquery name="getarea" datasource="#dts#">
select area,name,name2 from #target_apvend# where custno='#custno#'
</cfquery>
<cfelse>
<cfquery name="getarea" datasource="#dts#">
select area,name,name2 from #target_arcust# where custno='#custno#'
</cfquery>
</cfif>

<cfquery name="updaterate" datasource="#dts#">
update ictrantemp 
SET
price = price_bil * #val(currrate)#,
amt1 = amt1_bil * #val(currrate)#,
amt = amt_bil * #val(currrate)#,
disamt = disamt_bil * #val(currrate)#,
fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
trdatetime = now()
WHERE 
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfif getgsetup.wpitemtax neq "1" and val(invgross) neq 0>
<!---
<cfif taxincl neq "T" and net neq 0>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictrantemp
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(net_bil)#)*#val(tax1_bil)#,3),
        TAXAMT=round((AMT/#val(net)#)*#val(tax)#,3),
        taxincl="#taxincl#"
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfif>
--->
	<cfif taxincl eq "T">
    <cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictrantemp 
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(net_bil)+val(disc_bil)#)*#val(tax1_bil)#,5),
        TAXAMT=round((AMT/#val(net)+val(discount)#)*#val(tax)#,5),
        taxincl="#taxincl#"
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">;
    </cfquery>
    <cfelse>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictrantemp 
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(gross_bil)#)*#val(tax1_bil)#,5),
        TAXAMT=round((AMT/#val(invgross)#)*#val(tax)#,5),
        taxincl="#taxincl#"
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">;
    </cfquery>
    </cfif>

</cfif>




<cfquery name="gettotalpoint" datasource="#dts#">
select sum(amt) as totalamt from ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and (note1 ='' or note1 is null)
and (brem4 ='' or brem4 is null or brem4=0)
</cfquery>

<cfif driver neq ''>
<cfquery name="updatepoints" datasource="#dts#">
update driver set pointsredeem=pointsredeem+#val(form.cheque)# where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">
</cfquery>

<cfif val(form.cheque) eq 0 and val(getposdefault.memberpointamt) neq 0>
<cfquery name="updatepoints2" datasource="#dts#">
update driver set points=points+#fix((val(gettotalpoint.totalamt))/val(getposdefault.memberpointamt))# where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">
</cfquery>
</cfif>

</cfif>

<cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,CS_PM_TT,rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,counter,rem7,rem6,point,rem5,roundadj)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
<cfif lcase(hcomid) eq "amgworld_i" or lcase(hcomid) eq "netilung_i">
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tradeinrefno#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membername#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membername#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfif form.membername eq ''>
<cfqueryparam cfsqltype="cf_sql_varchar" value="Profile"><cfelse>''</cfif>,
<cfif form.membername eq ''><cfqueryparam cfsqltype="cf_sql_varchar" value="Profile"><cfelse>''</cfif>,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membertel#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membertel#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxincl#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now(),
"#form.cctype#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.name# #getarea.name2#">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
'#form.cash#',
'#form.cheque#',
'#form.credit_card1#',
'#form.credit_card2#',
'#form.debit_card#',
'#form.voucher#',
'#form.deposit#',
'#form.telegraph_transfer#',
'#form.changeamt1#',
'#form.checkno#',
'#form.cashcamt#',
'#form.rem9#',
"#form.cctype2#",
'#form.counterinfo#',
'#form.rem7#',
'#form.rem6#',
<cfif val(form.cheque) eq 0 and val(getposdefault.memberpointamt) neq 0>#fix((val(gettotalpoint.totalamt))/val(getposdefault.memberpointamt))#<cfelse>'0'</cfif>,
<cfif val(form.cheque) eq 0 and val(getposdefault.memberpointamt) neq 0>#fix((val(gettotalpoint.totalamt))/val(getposdefault.memberpointamt))#<cfelse>'0'</cfif>,
'#val(roundadj)#'
)
</cfquery>


<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)

SELECT 

TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl

FROM ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>



<cfquery name="updateiserialtemp" datasource="#dts#">
	update iserialtemp set
    fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
    custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
    wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
	refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
    where
	uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="CS">
</cfquery>

<cfquery name="insertiserial" datasource="#dts#">
INSERT INTO iserial 

(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, DEL_BY, ITEMNO, DESP, DESPA, SERIALNO, SEQ, AGENNO, LOCATION, SOURCE, JOB, CURRRATE, SIGN, VOID, PRICE, EXPORTED, GENERATED)

SELECT 

TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, DEL_BY, ITEMNO, DESP, DESPA, SERIALNO, SEQ, AGENNO, LOCATION, SOURCE, JOB, CURRRATE, SIGN, VOID, PRICE, EXPORTED, GENERATED

FROM iserialtemp
where
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>


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



<cfif lcase(huserloc) neq "all_loc" and followlocationrefno eq 1>

<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset_location
			where type = '#type#'
			and location = '#huserloc#'
            and activate="T"
</cfquery>

<cfelse>

<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#type#'
			and counter = '#refnoset#'
</cfquery>
</cfif>
 
 	<cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1" and getGeneralInfo.arun eq "1">
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
	<cfelse>
	<cfset newnextnum = refno>
	</cfif>
	
    <cfif lcase(huserloc) neq "all_loc" and followlocationrefno eq 1>
    <cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset_location 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newnextnum#">
    where type = '#type#'
	and location = '#huserloc#'
    </cfquery>
    
    
    <cfelse>
    
    <cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newnextnum#">
    where type = '#type#'
	and counter = '#refnoset#'
    </cfquery>
    </cfif>
    
    
    <cfquery name="getgeneral" datasource="#dts#">
    SELECT AECE,bcurr FROM gsetup
    </cfquery>
    
    <cfquery name="updateictrantemp" datasource="#dts#">
    update ictrantemp set onhold='' where uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
    
<cfif type eq "INV">
<cflocation url="/default/transaction/POS/index.cfm" addtoken="no">
<cfelse>

<cfif lcase(hcomid) eq "potmh_i">
	<cfform name="form1" id="form1" action="/default/transaction/POS/processprintpotmh.cfm" method="post">
    <cfinput type="hidden" name="type" id="type" value="#type#">
    <cfinput type="hidden" name="refno" id="refno" value="#refno#">
    </cfform>
<cfelseif getgeneral.bcurr eq "IDR">


    <cfform name="form1" id="form1" action="/default/transaction/POS/indoprocessprint.cfm" method="post">
    <cfinput type="hidden" name="type" id="type" value="#type#">
    <cfinput type="hidden" name="refno" id="refno" value="#refno#">
    </cfform>
    
   <script type="text/javascript">
    form1.submit();
    </script>
<cfelse>
    <cfform name="form1" id="form1" action="/default/transaction/POS/processprint.cfm" method="post">
    <cfinput type="hidden" name="type" id="type" value="#type#">
    <cfinput type="hidden" name="refno" id="refno" value="#refno#">
    </cfform>
</cfif>
   <script type="text/javascript">
    form1.submit();
    </script>
</cfif> 	
    </body>
    </html>