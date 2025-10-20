<cffunction name="reorder" output="false">
	<cfargument name="itemcountlist" required="yes">
	<cfargument name="refno" required="yes">
	
	<cfloop index="i" from="1" to="#listlen(itemcountlist)#">
		<cfif listgetat(itemcountlist,i) neq i>
			<cfquery name="updateIserial" datasource="#dts#">
				update iserial set 
				trancode='#i#'
				where type='#tran#' 
				and refno='#refno#' 
				and custno='#form.custno#' 
				and trancode='#listgetat(itemcountlist,i)#';
			</cfquery>
            <cfquery name="updateIgrade" datasource="#dts#">
				update igrade set 
				trancode='#i#'
				where type='#tran#' 
				and refno='#refno#' 
				and custno='#form.custno#' 
				and trancode='#listgetat(itemcountlist,i)#';
			</cfquery>
            <cfquery name="updateiclinkfr" datasource="#dts#">
            	Update iclink SET
                frtrancode = '#i#'
                WHERE frtype = '#tran#'
                and frrefno = '#refno#'
                and frtrancode= '#listgetat(itemcountlist,i)#';
            </cfquery>
            
            <cfquery name="updateiclinkto" datasource="#dts#">
            	Update iclink SET
                trancode = '#i#'
                WHERE type = '#tran#'
                and refno = '#refno#'
                and trancode= '#listgetat(itemcountlist,i)#';
            </cfquery>
            
			<cfquery name="updateIctran" datasource="#dts#">
				update ictran set 
				itemcount='#i#',
				trancode='#i#'
				where type='#tran#' 
				and refno='#refno#' 
				and custno='#form.custno#' 
				and itemcount='#listgetat(itemcountlist,i)#';
			</cfquery>
		</cfif>
	</cfloop>
</cffunction>

<cffunction name="relocate" output="false">
	<cfargument name="newtc" required="yes">
	<cfargument name="end" required="yes">
	<cfargument name="refno" required="yes">
	<cfquery name="updateIserial" datasource="#dts#">
        update iserial set 
        trancode=trancode + 1
       	where type='#tran#'
		and refno='#refno#' 
		and custno='#form.custno#' 
		and trancode>=#newtc# 
		and trancode<=#end#
    </cfquery>
    
    <cfquery name="updateIgrade" datasource="#dts#">
        update igrade set 
        trancode=trancode + 1
        where type='#tran#'
		and refno='#refno#' 
		and custno='#form.custno#' 
		and trancode>=#newtc# 
		and trancode<=#end#
    </cfquery>
    <cfquery name="updateiclinkfr" datasource="#dts#">
        Update iclink SET
        frtrancode = frtrancode + 1
        WHERE frtype = '#tran#'
        and frrefno = '#refno#'
        and frtrancode >=#newtc#
        and frtrancode<=#end#
    </cfquery>
    
     <cfquery name="updateiclinkfr" datasource="#dts#">
        Update iclink SET
        trancode = trancode + 1
        WHERE type = '#tran#'
        and refno = '#refno#'
        and trancode >=#newtc#
        and trancode <=#end#
    </cfquery>
            
	<cfquery name="updateIctran" datasource="#dts#">
		update ictran set 
		itemcount=itemcount+1,
		trancode=trancode+1
		where type='#tran#'
		and refno='#refno#' 
		and custno='#form.custno#' 
		and itemcount>=#newtc# 
		and itemcount<=#end#
		order by itemcount desc;
	</cfquery>
</cffunction>


<html>
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#tran#'
			and counter = '1'
		</cfquery>

<cfset uuid = form.uuid>

<cfset frem0 = form.B_name>
<cfset frem1 = form.B_name2>
<cfset frem2 = form.B_add1>
<cfset frem3 = form.B_add2>
<cfset frem4 = form.B_add3>
<cfset frem5 = form.B_add4>
<cfset frem6 = form.B_fax>
<cfset frem7 = form.D_name>
<cfset frem8 = form.D_name2>
<cfset remark2 = form.B_Attn>
<cfset remark3 = form.D_Attn>
<cfset remark4 = form.B_Phone>
<cfset remark12 = form.D_Phone>
<cfset comm0 = form.D_add1>
<cfset comm1 = form.D_add2>
<cfset comm2 = form.D_add3>
<cfset comm3 = form.D_add4>
<cfset comm4 = form.D_fax>
<cfset agenno = form.agent>
<cfset phonea = form.b_phone2>
<cfset term = form.term>
<cfset driver = form.driver>
<cfset source = form.project>
<cfset job = form.job>


<cfset type = form.tran>
<cfset refno = form.refno>
<cfset custno = form.custno>
<cfset currcode = form.currcode>
<cfset currrate = form.currrate>
<cfif isdefined('form.taxincl')>
<cfset form.gross=form.gross-form.taxamt>
</cfif>
<cfset gross_bil = form.gross>
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
        <cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = '#type#'
				and counter = 1
			</cfquery>
        
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
select area from #target_apvend# where custno='#custno#'
</cfquery>
<cfelse>
<cfquery name="getarea" datasource="#dts#">
select area from #target_arcust# where custno='#custno#'
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
trdatetime = now()
WHERE 
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
<cfif taxincl neq "Y" and net neq 0>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictrantemp
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(net_bil)#)*#val(tax1_bil)#,3),
        TAXAMT=round((AMT/#val(net)#)*#val(tax)#,3)
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfif>


<cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,counter,rem7,rem6,rem5,rem8,rem10)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
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
"#form.cctype#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
'#form.cash#',
'#form.cheque#',
'#form.credit_card1#',
'#form.credit_card2#',
'#form.debit_card#',
'#form.voucher#',
'#form.deposit#',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem11#">,
'#form.checkno#',
'#form.cashcamt#',
'#form.rem9#',
"#form.cctype2#",
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem7#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem6#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem5#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem8#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">

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


<!--- Promotion ---->

<cfquery name="getictranpromotion" datasource="#dts#">
select * from ictrantemp where
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfloop query="getictranpromotion">

<cfquery name="gettrancode" datasource="#dts#">
select max(trancode) as newtrancode from ictran where
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>
<cfset newtrancode=val(gettrancode.newtrancode)+1>

<cfquery name="checkitemExist" datasource="#dts#">
                select 
                itemcount 
                from ictran 
                where type='#getictranpromotion.type#'
                and refno='#getictranpromotion.refno#' 
                and custno='#getictranpromotion.custno#' 
                order by itemcount;
</cfquery>

<cfif checkitemExist.recordcount GT 0>
                <cfinvoke method="reorder" refno="#getictranpromotion.refno#" itemcountlist="#valuelist(checkitemExist.itemcount)#"/>
                <cfinvoke method="relocate" refno="#getictranpromotion.refno#" end="#checkitemExist.itemcount[checkitemExist.recordcount]#" newtc="#newtrancode#"/>
                
                <cfset itemcnt = newtrancode>
                <cfset trcode = itemcnt>
            <cfelse>
                <cfset itemcnt = 1>
                <cfset trcode = itemcnt>
            </cfif>
            
            <cfset validfree = 0>
            <cfset itemfreeqty = 0>
            <cfset promoqtyamt = getictranpromotion.qty>
            
            <cfquery name="checkpacking" datasource="#dts#">
            select * from icitem where itemno='#getictranpromotion.itemno#'
            </cfquery>
            <cfif checkpacking.packingqty1 eq 0>
			<cfset checkpacking.packingqty1=1>
			</cfif>
            <cfif checkpacking.packingqty2 eq 0>
            <cfset checkpacking.packingqty2=1>
            </cfif>
            <cfif checkpacking.packingqty3 eq 0>
            <cfset checkpacking.packingqty3=1>
            </cfif>
            <cfif checkpacking.packingqty4 eq 0>
            <cfset checkpacking.packingqty4=1>
            </cfif>
            <cfif checkpacking.packingqty5 eq 0>
            <cfset checkpacking.packingqty5=1>
            </cfif>
            
            <cfif checkpacking.packingqty6 eq 0>
            <cfset checkpacking.packingqty6=1>
            </cfif>
            
            <cfif checkpacking.packingqty7 eq 0>
            <cfset checkpacking.packingqty7=1>
            </cfif>
            
            <cfif checkpacking.packingqty8 eq 0>
            <cfset checkpacking.packingqty8=1>
            </cfif>
            
            <cfif checkpacking.packingqty9 eq 0>
            <cfset checkpacking.packingqty9=1>
            </cfif>
            
            <cfif checkpacking.packingqty10 eq 0>
            <cfset checkpacking.packingqty10=1>
            </cfif>
            
            <cfif getictranpromotion.promotion eq 1>
            <cfif getictranpromotion.qty gte checkpacking.packingqty1>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty1)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty1)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 2>
            <cfif getictranpromotion.qty gte checkpacking.packingqty2>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty2)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty2)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 3>
            <cfif getictranpromotion.qty gte checkpacking.packingqty3>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty3)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty3)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 4>
            <cfif getictranpromotion.qty gte checkpacking.packingqty4>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty4)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty4)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 5>
            <cfif getictranpromotion.qty gte checkpacking.packingqty5>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty5)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty5)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 6>
            <cfif getictranpromotion.qty gte checkpacking.packingqty6>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty6)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty6)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 7>
            <cfif getictranpromotion.qty gte checkpacking.packingqty7>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty7)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty7)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 8>
            <cfif getictranpromotion.qty gte checkpacking.packingqty8>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty8)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty8)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 9>
            <cfif getictranpromotion.qty gte checkpacking.packingqty9>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty9)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty9)>
            </cfif>
            <cfelseif getictranpromotion.promotion eq 10>
            <cfif getictranpromotion.qty gte checkpacking.packingqty10>
            <cfset leftcontrol = promoqtyamt / val(checkpacking.packingqty10)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(checkpacking.packingfreeqty10)>
            </cfif>
            
            </cfif>
            
            <cfif itemfreeqty gt 0>
            <cfset qtyfree = itemfreeqty >
            <cfset qtyfree_bil = itemfreeqty>
			
             <cfquery name="insertictran" datasource="#dts#" >
                insert into ictran 
                (
                    type,refno,custno,fperiod,wos_date,currrate,trancode,itemcount,linecode,
                    itemno,desp,despa,agenno,location,
                    qty_bil,price_bil,unit_bil,amt1_bil,
                    dispec1,dispec2,dispec3,
                    disamt_bil,amt_bil,
                    taxpec1,gltradac,taxamt_bil,
                    qty,price,unit,factor1,factor2,amt1,disamt,amt,taxamt,note_a,
                    dono,name,exported,exported1,sono,toinv,van,generated,
                    wos_group,category,brem1,brem2,brem3,brem4,
                    packing,shelf,source,job,
                    trdatetime,sv_part,sercost,userid,sodate,dodate<!---<cfif isdefined('form.it_cos') and tran eq "CN">,it_cos</cfif>--->
                )
                values
                (
                    '#type#','#refno#','#getictranpromotion.custno#','#getictranpromotion.fperiod#',#getictranpromotion.wos_date#,
                    '#getictranpromotion.currrate#','#itemcnt#','#trcode#','',
                    <cfqueryparam cfsqltype="cf_sql_char" value="#getictranpromotion.itemno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictranpromotion.desp#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictranpromotion.despa#">,
                    '#getictranpromotion.agenno#','#getictranpromotion.location#','#qtyfree_bil#','0',
                    <cfqueryparam cfsqltype="cf_sql_char" value="#getictranpromotion.unit#">,'0',
                    '0','0','0',
                    '0','0','0','#getictranpromotion.gltradac#','0',
                    '#qtyfree#','0','#getictranpromotion.unit#','#getictranpromotion.factor1#','#getictranpromotion.factor2#',
                    '0','0','0','0','','',
                    '#getictranpromotion.name#','','0000-00-00','','','#getictranpromotion.van#','',
                    '#getictranpromotion.wos_group#','#getictranpromotion.category#','#getictranpromotion.brem1#','#getictranpromotion.brem2#',
                    '#getictranpromotion.brem3#','<cfif ucase(getictranpromotion.brem4) eq "XCOST">XCOST<cfelse>#getictranpromotion.brem4#</cfif>',
                    '#getictranpromotion.packing#','#getictranpromotion.shelf#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictranpromotion.source#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictranpromotion.job#">,
					'#getictranpromotion.trdatetime#','#getictranpromotion.sv_part#','#val(getictranpromotion.sercost)#',
                    '#getictranpromotion.userid#',<cfif getictranpromotion.sodate eq ''>'0000-00-00'<cfelse>'#getictranpromotion.sodate#'</cfif>,<cfif getictranpromotion.dodate eq ''>'0000-00-00'<cfelse>'#getictranpromotion.dodate#'</cfif>
					<!---<cfif isdefined('form.it_cos') and tran eq "CN"> 
					<cfif form.it_cos eq "" or form.it_cos eq 0>
					<cfset it_cos = val(amt)>
                    <cfelse>
                    <cfset it_cos = form.it_cos>
                    </cfif>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#it_cos#" >
					</cfif>--->
                )		
            </cfquery>

            </cfif>

</cfloop>
<!--- ---->

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

<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#type#'
			and counter = 1
</cfquery>
 
 	<cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1" and getGeneralInfo.arun eq "1">
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
	<cfelse>
	<cfset newnextnum = refno>
	</cfif>
	
    <cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newnextnum#">
    where type = '#type#'
	and counter = <cfqueryparam cfsqltype="cf_sql_varchar" value="1">
    </cfquery>
    <cfquery name="getgeneral" datasource="#dts#">
    SELECT AECE,autolocbf FROM gsetup
    </cfquery>
    
    <cfif getgeneral.autolocbf eq "Y">
    <cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#refno#" type="#type#" returnvariable="done" />
    </cfif>
    
    <cfquery name="updateictrantemp" datasource="#dts#">
    update ictrantemp set onhold='' where uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
    
<cfif type eq "SO">
<cflocation url="/default/transaction/expressSOdone.cfm?type=#type#&refno=#refno#" addtoken="no">
<cfelse>
    <cfform name="form1" id="form1" action="/default/transaction/POS2/processprint.cfm" method="post">
    <cfinput type="hidden" name="type" id="type" value="#type#">
    <cfinput type="hidden" name="refno" id="refno" value="#refno#">
    </cfform>
    
   <script type="text/javascript">
    form1.submit();
    </script>
</cfif> 	
    </body>
    </html>