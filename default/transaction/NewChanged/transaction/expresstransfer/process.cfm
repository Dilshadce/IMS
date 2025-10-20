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
			and counter = '#form.refnoset#'
		</cfquery>

<cfset uuid = form.uuid>

<cfset frem0 = form.name>
<cfset frem1 = ''>
<cfset frem2 = ''>
<cfset frem3 = ''>
<cfset frem4 = ''>
<cfset frem5 = ''>
<cfset frem6 = ''>
<cfset frem7 = ''>
<cfset frem8 = ''>
<cfset remark1 = form.locationfr>
<cfset remark2 = form.locationto>
<cfset remark3 = ''>
<cfset remark4 = ''>
<cfset remark12 = ''>
<cfset comm0 = ''>
<cfset comm1 = ''>
<cfset comm2 = ''>
<cfset comm3 = ''>
<cfset comm4 = ''>
<cfset agenno = form.agent>
<cfset phonea = ''>
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
				and counter = '#form.refnoset#'
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
location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locationfr#">
WHERE 
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and type='TROU'
</cfquery>

<cfquery name="updaterate" datasource="#dts#">
update ictrantemp 
SET
location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locationto#">
WHERE 
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and type='TRIN'
</cfquery>

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
        refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfif>


<cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,counter,rem7,rem6,rem5,rem8,rem10,consignment)
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark1#">,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.consignment#">

)
</cfquery>

<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl,consignment)

SELECT 

TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl,consignment

FROM ictrantemp
where 
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfif dts eq "tcds_i" and type eq "TR" and form.locationfr eq "stock">
<cfset transferto = trim(form.locationto)>
<cfquery name="gettransfer" datasource="#dts#">
SELECT itemno,qty FROM ictrantemp
where 
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and type = "TROU"
</cfquery>
<cfloop query="gettransfer">
<cfquery name="updateorderform" datasource="#dts#">
UPDATE orderformtemp SET 
qty_#transferto# = if(qty_#transferto# - #val(gettransfer.qty)# < 0,0,qty_#transferto# - #val(gettransfer.qty)#) 
WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettransfer.itemno#"> 
</cfquery>
</cfloop>
</cfif>




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
			and counter = '#form.refnoset#'
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
	and counter = '#form.refnoset#'
    </cfquery>
    <cfquery name="getgeneral" datasource="#dts#">
    SELECT AECE,autolocbf FROM gsetup
    </cfquery>
    <!---
    <cfif getgeneral.autolocbf eq "Y">
    <cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#refno#" type="#type#" returnvariable="done" />
    </cfif>
    --->
    <cfquery name="updateictrantemp" datasource="#dts#">
    update ictrantemp set onhold='' where uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
    
<cflocation url="/default/transaction/expresstransferdone.cfm?type=#type#&refno=#refno#&consignment=#form.consignment#" addtoken="no">
 	
    </body>
    </html>