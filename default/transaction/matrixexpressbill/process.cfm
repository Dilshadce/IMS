<html>
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
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
<cfset remark0 = form.BCode>
<cfset remark1 = form.DCode>
<cfset remark2 = form.B_Attn>
<cfset remark3 = form.D_Attn>
<cfset remark4 = form.B_Phone>
<cfset remark12 = form.D_Phone>
<cfset remark13 = form.B_add5>
<cfset remark14 = form.D_add5>
<cfset comm0 = form.D_add1>
<cfset comm1 = form.D_add2>
<cfset comm2 = form.D_add3>
<cfset comm3 = form.D_add4>
<cfset comm4 = form.D_fax>
<cfif isdefined('form.d_phone2')>
<cfset d_phone2 = form.d_phone2>
<cfelse>
<cfset d_phone2 = "">
</cfif>
<cfset type = form.tran>
<cfset refno = form.refno>
<cfset refno2 = form.refno2>
<cfset custno = form.custno>
<cfset agenno = form.agent>
<cfset phonea = form.b_phone2>
<cfset term = form.term>
<cfset source = form.project>
<cfset job = form.job>
<cfset driver = form.driver>
<cfset currcode = form.currcode>

<cfset PONO = form.PONO>
<cfset DONO = form.DONO>
<cfset rem5 = form.rem5>
<cfset rem6 = form.rem6>
<cfset rem7 = form.rem7>
<cfset rem8 = form.rem8>
<cfset rem9 = form.rem9>
<cfset rem10 = form.rem10>
<cfset rem11 = form.rem11>
<cfset desp = form.desp>
<cfset despa = form.despa>
<cfset gross_bil = form.gross>
<cfset disp1 = form.dispec1>
<cfset disp2 = form.dispec2>
<cfset disp3 = form.dispec3>
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
<cfset note = form.taxcode>
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

<cfset ndate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
<cfset wos_date = dateformat(ndate,'yyyy-mm-dd')>

    <cfquery name="getcurrqry" datasource="#dts#">
    SELECT * FROM #target_currency# where currcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#" >
    </cfquery>
    <cfif val(fperiod) gt 18 or val(fperiod) lte 0>
            <cfset currrate = getcurrqry.currrate>
        <cfelse>
            <cfset counter = val(fperiod)>
            <cfset currrate = Evaluate("getcurrqry.currp#counter#")>
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


<cfif type neq "TR">
<cfquery name="updaterate" datasource="#dts#">
update ictrantemp 
SET
price = price_bil * #val(currrate)#,
amt1 = amt1_bil * #val(currrate)#,
amt = amt_bil * #val(currrate)#,
disamt = disamt_bil * #val(currrate)#,
agenno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(currrate)#">,
source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
job = <cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
<cfif form.mode neq "edit">
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
</cfif>
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
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfif>
<cfelse>

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
fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
disamt = disamt_bil * #val(currrate)#,
agenno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(currrate)#">,
source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
job = <cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
<cfif form.mode neq "edit">
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TROU">,
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
</cfif>
trdatetime = now()
WHERE 
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="TROU">
</cfquery>
<cfif taxincl neq "Y" and net neq 0>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictrantemp
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(net_bil)#)*#val(tax1_bil)#,3),
        TAXAMT=round((AMT/#val(net)#)*#val(tax)#,3)
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TROU">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfif>

<cfquery name="updaterate" datasource="#dts#">
update ictrantemp 
SET
price = price_bil * #val(currrate)#,
amt1 = amt1_bil * #val(currrate)#,

amt = amt_bil * #val(currrate)#,
disamt = disamt_bil * #val(currrate)#,
agenno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(currrate)#">,
source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
job = <cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
<cfif form.mode neq "edit">
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TRIN">,
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
</cfif>
trdatetime = now()
WHERE 
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="TRIN">
</cfquery>

<cfif taxincl neq "Y" and net neq 0>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictrantemp
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(net_bil)#)*#val(tax1_bil)#,3),
        TAXAMT=round((AMT/#val(net)#)*#val(tax)#,3)
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TRIN">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfif>


</cfif>



<cfif form.mode eq "edit">
<!---Edit Bill--->


<cfquery name="insertartran" datasource="#dts#">
UPDATE artran SET

trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
fperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
wos_date=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">,
despa=<cfqueryparam cfsqltype="cf_sql_varchar" value="#despa#">,
agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
source=<cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
job=<cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
currrate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(currrate)#">,
gross_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
disc1_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
disc2_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
disc3_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
disc_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
net_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
tax1_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
tax_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax_bil#">,
grand_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
debit_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#debit_bil#">,
credit_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#credit_bil#">,
invgross=<cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
disp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp1#">,
disp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp2#">,
disp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp3#">,
discount1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
discount2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
discount3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
discount=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
net=<cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
tax1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1#">,
tax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
taxp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
grand=<cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
debitamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
creditamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">,
frem0=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
frem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem1#">,
frem2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem2#">,
frem3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem3#">,
frem4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem4#">,
frem5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem5#">,
frem6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem6#">,
frem7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem7#">,
frem8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem8#">,
rem0=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark0#">,
<cfif type eq 'TR'>
rem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locationfr#">,
rem2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locationto#">,
<cfelse>
rem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark1#">,
rem2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark2#">,
</cfif>
rem3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark3#">,
rem4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark4#">,
<cfif type eq 'TR'>
rem5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#b_name2#">,
rem6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#b_add1#">,
<cfelse>
rem5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem5#">,
rem6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem6#">,
</cfif>
rem7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem7#">,
rem8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem8#">,
rem9=<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem9#">,
rem11=<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem11#">,
rem12=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark12#">,
rem13=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark13#">,
rem14=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark14#">,
comm0=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm0#">,
comm1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm1#">,
comm2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm2#">,
comm3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm3#">,
comm4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm4#">,
d_phone2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#d_phone2#">,
taxincl=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxincl#">,
note=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
updated_on=now(),
rem10="",
PONO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#PONO#">,
DONO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#DONO#">,
userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
trdatetime=now(),
term=<cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
currcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">

where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#"> and
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">

</cfquery>


<cfif type neq "TR">

<cfquery name="deletebody" datasource="#dts#">
	delete from ictran where
    type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#"> and
    refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>

<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(REFNO,TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)

SELECT 

'#refno#',TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl

FROM ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
<cfelse>

<cfquery name="deletebody" datasource="#dts#">
	delete from ictran where
    type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TROU"> and
    refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>

<cfquery name="deletebody2" datasource="#dts#">
	delete from ictran where
    type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TRIN"> and
    refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>


<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(REFNO,TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)

SELECT 

'#refno#',TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl

FROM ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TROU">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="insertbody1" datasource="#dts#">
INSERT INTO ictran 

(REFNO,TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)

SELECT 

'#refno#',TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl

FROM ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TRIN">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

</cfif>

<!---End Edit Bill--->

<cfelse>
<!---Create Bill--->
<!---
<cfif type eq "INV" or type eq "QUO">
<cfset minuslen = 4>
<cfelse>
<cfset minuslen = 3>
</cfif>
<cfset refnolen = len(refno)-minuslen>
<cfset refno = right(refno,refnolen)>
--->
<cfset refno=refno>
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




<cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9<!--- ,rem10 --->,rem11,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,term,currcode,d_phone2)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#despa#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(currrate)#">,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark0#">,
<cfif type eq 'TR'>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locationfr#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locationto#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark2#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark4#">,
<cfif type eq 'TR'>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#b_name2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#b_add1#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem5#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem6#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem7#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem8#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem9#">,
<!--- <cfqueryparam cfsqltype="cf_sql_varchar" value="#rem10#">, --->
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem11#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark12#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark13#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark14#">,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="#PONO#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#DONO#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#d_phone2#">
)
</cfquery>


<cfif type neq "TR">
<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(REFNO,TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)

SELECT 

'#refno#',TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl

FROM ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
<cfelse>
<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(REFNO,TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)

SELECT 

'#refno#',TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl

FROM ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TROU">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="insertbody1" datasource="#dts#">
INSERT INTO ictran 

(REFNO,TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)

SELECT 

'#refno#',TYPE, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl

FROM ictrantemp
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="TRIN">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

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
	and counter = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnoset#">
    </cfquery>



</cfif>



    <cfform name="form1" id="form1" action="/default/transaction/matrixdone.cfm" method="post">
    <cfinput type="hidden" name="type" id="type" value="#type#">
    <cfinput type="hidden" name="refno" id="refno" value="#refno#">
    </cfform>
    <script type="text/javascript">
    form1.submit();
    </script>
 	
    </body>
    </html>