<cfparam name="status" default="">
<cfset dbfdts = dts&"dbf">
<cfinvoke component="cfc.verify" method="VerifyDSN" dsn="#dbfdts#" returnvariable="result" />
<cfif result eq false>
<h1>Your system has not been setup to use this function. Please contact system administrator.</h1>
<cfabort>
</cfif>
<cfquery name="droptable" datasource="#dts#">
DROP TABLE IF EXISTS artran_csv
</cfquery>

<cfquery name="droptable" datasource="#dts#">
DROP TABLE IF EXISTS ictran_csv
</cfquery>

<cfquery name="recreatetqable" datasource="#dts#">
CREATE TABLE artran_csv like artran
</cfquery>

<cfquery name="recreatetqable" datasource="#dts#">
CREATE TABLE ictran_csv like ictran
</cfquery>

<cfquery name="insertartrancsv" datasource="#dts#">
	insert into artran_csv select * from artran where type='TR'
	<cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
		and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnofrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnoto#"></cfif>
</cfquery>
<cfquery name="insertictrancsv" datasource="#dts#">	
	insert into ictran_csv select * from ictran where type='TRIN'
	<cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
		and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnofrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnoto#"></cfif>
</cfquery>


<cfquery name="updateartrancsv" datasource="#dts#">
	update artran_csv set type='OAI'
</cfquery>
<cfquery name="updateictrancsv" datasource="#dts#">	
	update ictran_csv set type='OAI'
</cfquery>


    <cfquery name="getDefaultCurr" datasource="#dts#">
    SELECT bcurr from gsetup
    </cfquery>
<cfquery name="deleteolditem" datasource="#dbfdts#">
delete from ARTRAN9
</cfquery>

<cfquery name="deleteolditem" datasource="#dbfdts#">
delete from ictran9
</cfquery>

<cfquery name="deleteolditem" datasource="#dbfdts#">
delete from iserial9
</cfquery>

<!--- <cftry> --->
<cfquery name="moveartran" datasource="#trim(dts)#">
SELECT * FROM artran_csv
</cfquery>

<cfloop query="moveartran">
<cfquery name="insertartran" datasource="#dbfdts#">
INSERT INTO artran9 
(
refno,
refno2,
desp,
despa,
fperiod,
type,
Date,
trdatetime,
trancode,
custno,
name,
term,
agenno,
area,
source,
job,
currrate,
currrate2,
gross_bil,
disc1_bil,
disc2_bil,
disc3_bil,
disc_bil,
net_bil,
tax1_bil,
tax2_bil,
tax3_bil,
tax_bil,
grand_bil,
debit_bil,
credit_bil,
disp1,
disp2,
disp3,
discount1,
discount2,
discount3,
discount,
taxp1,
taxp2,
taxp3,
taxincl,
tax1,
tax2,
tax3,
tax,
invgross,
net,
grand,
debitamt,
creditamt,
cs_pm_cash,
cs_pm_crcd,
cs_pm_crc2,
cs_pm_cheq,
cs_pm_vouc,
cs_pm_debt,
cs_pm_dbcd,
billcost,
mc1_bil,
mc2_bil,
mc3_bil,
mc4_bil,
mc5_bil,
M_CHARGE1,
M_CHARGE2,
M_CHARGE3,
M_CHARGE4,
M_CHARGE5,
POSTED,
REM0,
REM1,
REM2,
REM3,
REM4,
REM5,
REM6,
REM7,
FREM0,
FREM1,
FREM2,
FREM3,
CASHIER,
TABLENO,
MEMBER,
COUNTER,
AGE,
CHECKNO,
NOTE,
DEL_BY,
ISCASH,
LOKSTATUS,
ORDER_CL,
VOID,
EXPORTED,
PRINTED,
GENERATED,
DONO,
PONO,
POINT,
TOURGROUP,
created_by,
created_on,
updated_by,
updated_on,
DEPOSIT,
GSTDIS,
TOINV
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#moveartran.refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.refno2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.desp)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.despa)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.fperiod))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.type)#">,
<cfif moveartran.wos_Date neq "">
{^#dateformat(moveartran.wos_Date,'YYYY/MM/DD')#},
<cfelse>
{^2001/01/01},
</cfif>
<cfif moveartran.trdatetime neq "">
{^#dateformat(moveartran.trdatetime,'YYYY/MM/DD')#},
<cfelse>
{^2001/01/01},
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(trim(moveartran.trancode)),'0000')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.custno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.name)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.term)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.agenno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.area)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.source)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.job)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.currrate))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.currrate2))#">,
<cfif moveartran.taxincl eq "false">
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.gross_bil))#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.gross_bil))-trim(val(moveartran.tax_bil))#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.disc1_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.disc2_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.disc3_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.disc_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.net_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax1_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax2_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax3_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.grand_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.debit_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.credit_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.disp1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.disp2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.disp3))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.discount1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.discount2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.discount3))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.discount))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.taxp1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.taxp2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.taxp3))#">,
<cfif moveartran.taxincl eq "false">.f.<cfelse>.t.</cfif>,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax3))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.tax))#">,
<cfif moveartran.taxincl eq "false">
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.invgross))#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.invgross))-trim(val(moveartran.tax))#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.net))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.grand))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.debitamt))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.creditamt))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.cs_pm_cash))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.cs_pm_crcd))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.cs_pm_crc2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.cs_pm_cheq))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.cs_pm_vouc))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.cs_pm_debt))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.cs_pm_dbcd))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.billcost))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.mc1_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.mc2_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.mc3_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.mc4_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.mc5_bil))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.M_CHARGE1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.M_CHARGE2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.M_CHARGE3))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.M_CHARGE4))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.M_CHARGE5))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.POSTED)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM0)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM3)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM4)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM5)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM6)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.REM7)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.FREM0)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.FREM1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.FREM2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.FREM3)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.CASHIER)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.TABLENO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.MEMBER)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.COUNTER)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.AGE))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.CHECKNO)#">,
<cfif trim(moveartran.NOTE) eq "">
	<cfif moveartran.type eq "RC" or moveartran.type eq "PO">
    <cfqueryparam cfsqltype="cf_sql_varchar" value="ZP">,
    <cfelse>
    <cfqueryparam cfsqltype="cf_sql_varchar" value="ZR">,
    </cfif>
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.NOTE)#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.DEL_BY)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.ISCASH)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.LOKSTATUS)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.ORDER_CL)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.VOID)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.EXPORTED)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.PRINTED)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.GENERATED)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.DONO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveartran.PONO)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.POINT))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.TOURGROUP))#">,

<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(created_by)#">,
<cfif moveartran.created_on neq "">
{^#dateformat(moveartran.created_on,'YYYY/MM/DD')#},
<cfelse>
{^#dateformat(now(),'YYYY/MM/DD')#},
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(updated_by)#">,
<cfif moveartran.updated_on neq "">
{^#dateformat(moveartran.updated_on,'YYYY/MM/DD')#},
<cfelse>
{^#dateformat(now(),'YYYY/MM/DD')#},
</cfif>
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(moveartran.deposit))#">,
0,
''
)
</cfquery>

</cfloop>


<cfquery name="getictran" datasource="#trim(dts)#">
SELECT * FROM ictran_csv
</cfquery>
<cfloop query="getictran">

<cfquery name="insertictran" datasource="#dbfdts#">
INSERT INTO ICTRAN9
(
TYPE,
REFNO,
REFNO2,
TRANCODE,
CUSTNO,
FPERIOD,
DATE,
CURRRATE,
ITEMCOUNT,
LINECODE,
ITEMNO,
DESP,
DESPA,
AGENNO,
LOCATION,
SOURCE,
JOB,
SIGN,
QTY_BIL,
PRICE_BIL,
UNIT_BIL,
AMT1_BIL,
DISPEC1,
DISPEC2,
DISPEC3,
DISAMT_BIL,
AMT_BIL,
TAXPEC1,
TAXPEC2,
TAXPEC3,
TAXAMT_BIL,
QTY,
PRICE,
UNIT,
AMT1,
DISAMT,
AMT,
TAXAMT,
FACTOR1,
FACTOR2,
DONO,
BREM1,
BREM2,
BREM3,
BREM4,
NOTE1,
NOTE2,
GLTRADAC,
WITHSN,
QTY1,
QTY2,
QTY3,
QTY4,
QTY5,
QTY6,
BATCHCODE,
POINT,
NAME,
GENERATED,
UD_QTY,
TOINV,
VOID,
BODY,
PROMOTER,
MEMBER,
TOURGROUP,
TRDATETIME

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.TYPE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.REFNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.REFNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(trim(getictran.ITEMCOUNT)),'0000')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.CUSTNO)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#val(getictran.FPERIOD)#">,
<cfif getictran.wos_Date neq "">
{^#dateformat(getictran.wos_date,'YYYY/MM/DD')#},
<cfelse>
{^2001/01/01},
</cfif>
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.CURRRATE))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#val(getictran.ITEMCOUNT)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.LINECODE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.ITEMNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.DESP)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.DESPA)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.AGENNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.LOCATION)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.SOURCE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.JOB)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="1">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY_BIL))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.PRICE_BIL))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.UNIT_BIL)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.AMT1_BIL))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.DISPEC1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.DISPEC2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.DISPEC3))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.DISAMT_BIL))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.AMT_BIL))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.TAXPEC1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.TAXPEC2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.TAXPEC3))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.TAXAMT_BIL))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.PRICE))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim((getictran.UNIT))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.AMT1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.DISAMT))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.AMT))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.TAXAMT))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.FACTOR1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.FACTOR2))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.DONO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.BREM1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.BREM2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.BREM3)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.BREM4)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.NOTE1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.NOTE2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.GLTRADAC)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.WITHSN)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY1))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY2))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY3))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY4))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY5))#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.QTY6))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.BATCHCODE)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.POINT))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.NAME)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.GENERATED)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.UD_QTY)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.TOINV)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.VOID)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.BODY))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.PROMOTER)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getictran.MEMBER)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#trim(val(getictran.TOURGROUP))#">,
<cfif TRDATETIME neq "">
{^#dateformat(TRDATETIME,'YYYY/MM/DD')#}
<cfelse>
{^2001/01/01}
</cfif>
)
</cfquery>
</cfloop>

<cfquery name="insertserial" datasource="#dbfdts#">
DELETE FROM ISERIAL9
</cfquery>


<cfquery name="getserial" datasource="#dts#">
SELECT * FROM iserial where type='TR' and sign = "1"
<cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnofrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnoto#"></cfif>
</cfquery>

<cfloop query="getserial">
<cfquery name="insertserial" datasource="#dbfdts#">
INSERT INTO ISERIAL9
(
REFNO,
REFNO2,
TYPE,
TRANCODE,
DATE,
FPERIOD,
SERIALNO,
ITEMNO,
DESP,
DESPA,
PRICE,
LOCATION,
SIGN,
CUSTNO,
AGENNO,
SOURCE,
JOB,
CURRRATE,
VOID,
EXPORTED,
GENERATED
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.refno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.refno2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="OAI">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(getserial.trancode),'0000')#">,
{^#dateformat(getserial.wos_date,'YYYY/MM/DD')#},
<cfqueryparam cfsqltype="cf_sql_float" value="#val(getserial.FPERIOD)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.serialno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.itemno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.desp)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.despa)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#val(getserial.price)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.location)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="1">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.agenno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.source)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.job)#">,
<cfqueryparam cfsqltype="cf_sql_float" value="#val(getserial.currrate)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.void)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.exported)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.generated)#">
)
</cfquery>
</cfloop>


<cfoutput>
<cfzip action="zip" file="C:\inetpub\wwwroot\IMS\Download\#dts#\DBF.zip" source = "C:\inetpub\wwwroot\IMS\Download\#dts#\DBF" overwrite="yes">
</cfoutput>
	<cfset status="Exported Successfully!">  
<!--- <cfcatch type="any">
	<!--- <cfoutput>#cfcatch.Message#<br />#cfcatch.Detail#</cfoutput><cfabort> --->
	<cfset status="#cfcatch.Message#">
</cfcatch>
</cftry> --->

<cfoutput>
  <form name="done" action="export_to_csvtransfer_list.cfm?process=done" method="post">
	<input name="status" value="#status#" type="hidden">
  </form>
</cfoutput>

<script>
	done.submit();
</script>
