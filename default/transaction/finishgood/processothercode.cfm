<cfset uuid = form.othercodeuuid>
<cfquery name="getothercodelist" datasource="#dts#">
SELECT * FROM tempfgic WHERE uuid = "#uuid#" order by itemno
</cfquery>

<cfquery name="getdetailic" datasource="#dts#">
SELECT * FROM finishedgoodic where ID = "#getothercodelist.siid#"
</cfquery>

<cfquery name="getdetailar" datasource="#dts#">
SELECT * FROM finishedgoodar where ID = "#getdetailic.arid#"
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
from refnoset
where type = 'RC'
and counter = 1
</cfquery>

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
SELECT refno FROM artran WHERE 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = 'RC'
</cfquery>
<cfif checkexistence.recordcount eq 0>
<cfset refnocheck = 1>
<cfelse>
<cfset refno1 = refno>
</cfif>
</cfloop>

<cfset ndate = now()>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
<cfset wos_date = dateformat(ndate,'yyyy-mm-dd')>
        
<cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetailic.refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="ASSM/999">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="Finished Good Other Code">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetailar.project#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetailic.job#">,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="">
)
</cfquery>


<cfloop query="getothercodelist">
<cfquery name="getucost" datasource="#dts#">
SELECT ucost,unit,desp,despa,wos_group,category,shelf FROM icitem WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getothercodelist.itemno#">
</cfquery>
<cfset price = val(getucost.ucost)>
<cfset amt = val(getothercodelist.qty) * price>
<cfset qty = val(getothercodelist.qty)>
<cfset unit = getucost.unit>

<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl)
VALUES
(
"RC",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#REFNO#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetailic.refno#">, 
"#getothercodelist.currentrow#", 
"ASSM/999", 
"#FPERIOD#", 
"#WOS_DATE#", 
"1", 
"#getothercodelist.currentrow#", 
"", 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getothercodelist.itemno#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getucost.desp#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getucost.despa#">, 
"", 
"",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetailar.project#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetailic.job#">,
"", 
"#qty#", 
"#price#", 
"#unit#", 
"#amt#",
"0", "0", "0", "0", "#amt#", "0", "0", "0", "0", "", "", "#qty#", "#price#", "#unit#", "#amt#", "0", "#amt#", "0", "1", "1", "", "0000-00-00", "0000-00-00","", "", "", <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetailic.itemno#">, "", "", "", "", "", "", "", "", "", "", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "", "0000-00-00", "0", "0", "0", "", "", "0", "0", "0", "", "", "", "", "", "", "", "0000-00-00", "", "0000-00-00", "", "", "", "", "", "0", "0", "#huserid#", "0", "", <cfqueryparam cfsqltype="cf_sql_varchar" value="#getucost.wos_group#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getucost.category#">, "", <cfqueryparam cfsqltype="cf_sql_varchar" value="#getucost.shelf#">, "", "0", "", "", "", "", "", "", "", "", now(), "", "", "", "", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "F")
</cfquery>
</cfloop>

<cfquery name="sumtotal" datasource="#dts#">
SELECT sum(amt) as amt FROM ictran where type = "RC" and refno = "#refno#"
</cfquery>

<cfquery name="updateartran" datasource="#dts#">
UPDATE artran SET 
gross_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">,
net_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">,
grand_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">,
credit_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">,
invgross = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">,
net = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">,
grand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">,
creditamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(sumtotal.amt)#">
WHERE type = "RC" and refno = "#refno#"
</cfquery>

<cfquery name="insertrecord" datasource="#dts#">
INSERT INTO finishedgoodothercode (refno,fgic,wos_date,created_by,created_on)
VALUES
(
"#refno#",
"#getothercodelist.siid#",
"#wos_date#",
"#huserid#",
now()
)
</cfquery>

 <cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
    where type = 'RC'
	and counter = '1'
    </cfquery>
    
<cfoutput>
<h1>
Other Code Receive Generated Success!
</h1>
<input type="button" name="closeall" id="colseall" value="Close" onClick="ColdFusion.Window.hide('addothercode');" >
</cfoutput>