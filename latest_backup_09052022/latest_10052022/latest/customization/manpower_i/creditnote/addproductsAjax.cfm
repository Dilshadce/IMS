<cfsetting showdebugoutput="no">

<cfinclude template="creditnotescript.cfm">

<cfset refnotype=1>
<cfset tran = form.tran>
<cfset uuid = form.uuid>
    
<!---<cfif left(dts,12) eq 'manpowertest'>--->

      <cfquery name="checkexistrefno" datasource="#dts#">
      select rem40 from artran where  refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#">
      </cfquery>
      
      <cfif form.invno neq ''>
          <cfquery name="getassignment" datasource="#dts#">
              SELECT placementno FROM assignmentslip
              WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(checkexistrefno.rem40)#">
          </cfquery>
      <cfelse>
      	<cfquery name="getassignmentrefno" datasource="#dts#">
          SELECT brem6 FROM ictrantempcn
          WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
          and brem6<>''
          limit 1
        </cfquery>
      	<cfquery name="getassignment" datasource="#dts#">
          SELECT placementno FROM assignmentslip
          WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmentrefno.brem6#">
        </cfquery>
      </cfif>
      
      <cfquery name="getplacement" datasource="#dts#">
          SELECT location,po_no,jobpostype,supervisor FROM placement
          WHERE placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.placementno#">
      </cfquery>
      
      <cfquery name="getentity" datasource="#dts#">
          SELECT invnogroup FROM bo_jobtypeinv
          WHERE officecode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.location#">
          AND jobtype = "#getplacement.jobpostype#"
      </cfquery>
      
      <cfquery name="getaddress" datasource="#dts#">
          SELECT * FROM invaddress
          WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getentity.invnogroup#">
      </cfquery> 
      
      <cfif getaddress.shortcode eq 'mss'>
            <cfset refnotype=1>
      <cfelseif getaddress.shortcode eq 'mbs'>
            <cfset refnotype=2>
      <cfelseif getaddress.shortcode eq 'tc'>    
      		<cfset refnotype=3>
      <cfelse>    
      		<cfset refnotype=4>
      </cfif>
      
      	<cfquery datasource="#dts#" name="getlastusedno">
            select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
            where type = '#tran#'
            and counter = '#refnotype#'
        </cfquery>
            
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastusedno.tranno#" returnvariable="newnextNum" />
                <cfset actual_nexttranno = newnextNum>
                    <cfif (getlastusedno.refnocode2 neq "" or getlastusedno.refnocode neq "") and getlastusedno.presuffixuse eq refnotype>
                        <cfset nexttranno = getlastusedno.refnocode&actual_nexttranno&getlastusedno.refnocode2>
                    <cfelse>
                        <cfset nexttranno = actual_nexttranno>
                    </cfif>
                    <cfset tranarun_1 = getlastusedno.arun>
            
            <cfset form.refno = tostring(nexttranno)>

<!---</cfif>--->

<cfif lcase(tran) eq 'dn'>
    <cfset newcustno = form.newcustno>
</cfif>
<cfset custno = form.custno>
<cfset invno = form.invno>
<cfset refno = form.refno>
<cfset gstper = form.gstrate>


<cfquery name="checkitemExist" datasource="#dts#">
    select refno
    from ictrantempcn 
    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
	and refno2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
</cfquery>
    
<cfif checkitemExist.recordcount neq 0>
    <cfquery name="removeexistitems" datasource="#dts#">
        DELETE
        from ictrantempcn 
        WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
        and refno2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
    </cfquery>
        
    <cfquery name="checkitemExist" datasource="#dts#">
        select refno
        from ictrantempcn 
        WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
        and refno2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
    </cfquery>
</cfif>

<cfif checkitemExist.recordcount eq 0>
<cfif tran eq 'cn'>
<cfquery name="insertictran" datasource="#dts#">
	insert into ictrantempcn
	(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,UUID,brem5,brem6)
	SELECT '#tran#' as type , '#refno#' as REFNO, REFNO, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL*-1 as PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL*-1 as AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, case when TAXAMT_BIL>0 then TAXAMT_BIL*-1 else TAXAMT_BIL end as TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE*-1 as PRICE, UNIT, AMT1, DISAMT, AMT*-1 as AMT, TAXAMT*-1 as TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,'#uuid#' as uuid,brem5,brem6 
	FROM ictran
	WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
    AND (VOID='' OR VOID IS NULL)
    <cfif lcase(left(invno,2)) eq 'in'>
        AND TYPE = "DN"
    <cfelseif lcase(left(invno,2)) eq 'cn'>
        AND TYPE = "CN"
    <cfelse>
        AND TYPE = "INV"
    </cfif>
</cfquery>
<cfelse>
<cfquery name="insertictran" datasource="#dts#">
	insert into ictrantempcn
	(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,UUID,brem5,brem6)
	SELECT '#tran#' as type , '#refno#' as REFNO, REFNO, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, case when PRICE_BIL<0 then PRICE_BIL*-1 else PRICE_BIL end as PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, case when AMT_BIL<0 then AMT_BIL*-1 else AMT_BIL end as AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, case when TAXAMT_BIL<0 then TAXAMT_BIL*-1 else TAXAMT_BIL end as TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, case when PRICE<0 then PRICE*-1 else PRICE end as PRICE, UNIT, AMT1, DISAMT, case when AMT<0 then AMT*-1 else AMT end as AMT, case when TAXAMT<0 then TAXAMT*-1 else TAXAMT end as TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,'#uuid#' as uuid,brem5,brem6
	FROM ictran
	WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
	AND (VOID='' OR VOID IS NULL)
    <cfif lcase(left(invno,2)) eq 'in'>
        AND TYPE = "DN"
    <cfelseif lcase(left(invno,2)) eq 'cn'>
        AND TYPE = "CN"
    <cfelse>
        AND TYPE = "INV"
    </cfif>
</cfquery>
</cfif>

</cfif>
    
<cfquery name="getcustgsttype" datasource="#dts#">
select arrem5 from #target_arcust# where custno='#form.custno#'
</cfquery>

<cfif lcase(tran) eq 'dn'>
    <cfif form.newcustno neq ''>
        <cfquery name="getcustgsttype" datasource="#dts#">
        SELECT arrem5 FROM #target_arcust# WHERE custno = "#form.newcustno#"
        </cfquery>
    </cfif>
</cfif>

<cfif lcase(tran) eq 'dn' or getcustgsttype.arrem5 eq 'GSTBILLRATE'>
    <cfinclude template="manpowergstcalc.cfm">
</cfif>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as sumsubtotal,count(itemno) as countitemno,sum(taxamt_bil) as sumtaxtotal FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>
    
<cfif form.invno neq ''>
    
<cfquery name="getgstrate" datasource="#dts#">
    SELECT taxp1,wos_date FROM artran 
    WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#" />
    AND (void = '' or void is null)
</cfquery>

</cfif>

<!---<cfif getcustgsttype.arrem5 eq 'GSTBILLRATE'>--->
    
<cfquery name="getcustgsttype" datasource="#dts#">
select arrem5 from #target_arcust# where custno='#form.custno#'
</cfquery>

<cfif lcase(tran) eq 'dn'>
    <cfif form.newcustno neq ''>
        <cfquery name="getcustgsttype" datasource="#dts#">
        SELECT arrem5 FROM #target_arcust# WHERE custno = "#form.newcustno#"
        </cfquery>
    </cfif>
</cfif>
    
<cfset check = false>
    
<cfif form.invno neq ''>
    
<cfif lcase(tran) eq 'cn'>
    
<cfquery name="checktotaltemp" datasource="#dts#">
    SELECT sum(amt_bil*-1) totalbill FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
</cfquery>
    
<cfelse>
    
<cfquery name="checktotaltemp" datasource="#dts#">
    SELECT sum(amt_bil) totalbill FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
</cfquery>
    
</cfif>
    
<cfquery name="checktotalbefore" datasource="#dts#">
    SELECT sum(amt_bil) totalbill FROM ictran 
    WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#" />
    AND (void = '' or void is null)
    <cfif lcase(left(invno,2)) eq 'in'>
        AND TYPE = "DN"
    <cfelseif lcase(left(invno,2)) eq 'cn'>
        AND TYPE = "CN"
    <cfelse>
        AND TYPE = "INV"
    </cfif>
</cfquery>
    
<cfset check = checktotaltemp.totalbill neq checktotalbefore.totalbill>
    
</cfif>

<cfif form.invno eq '' or lcase(tran) eq 'dn' or check>
    
<cfquery name="getSum_ictran" datasource="#dts#">
    SELECT refno,type,round((sum(amt_bil)*<cfif isdefined('getgstrate.taxp1')><cfif month(getgstrate.wos_date) lt 9 and year(getgstrate.wos_date) lte 2018 or year(getgstrate.wos_date) lt 2018>#getgstrate.taxp1#<cfelse>#gstper#</cfif><cfelse>#gstper#</cfif>/100),2) AS sumTaxAmt
    FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    AND note_a = 'SR'
    AND taxpec1=6
    GROUP BY refno
</cfquery>
    
<cfif getSum_ictran.recordcount neq 0>
    <cfset getsum.sumtaxtotal = getSum_ictran.sumTaxAmt>
<cfelse>   
    <cfset getsum.sumtaxtotal = 0>
</cfif>

    
<cfquery name="getgst" datasource="#dts#">
    SELECT refno,taxpec1
    FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    AND taxpec1<>0
    GROUP BY taxpec1
</cfquery>
    
<cfif getgst.recordcount neq 0>
    <cfset gstper = val(getgst.taxpec1)>
</cfif>
    
<cfelse>
    
<cfquery name="getSum_artran" datasource="#dts#">
    SELECT tax_bil*-1 AS sumTaxAmt,taxp1
    FROM artran
    WHERE refno = (
    SELECT refno2 FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
    )    
</cfquery>
    
<cfif getSum_artran.sumTaxAmt neq "">
    <cfset getsum.sumtaxtotal = getSum_artran.sumTaxAmt>
    <cfset gstper = val(getSum_artran.taxp1)>
</cfif>

</cfif>

<!---</cfif>--->

<cfinclude template="manpowergstcalc.cfm">
        
<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
<input type="hidden" name="hidtaxper" id="hidtaxper" value="#numberformat(gstper,'_')#" />

<cfquery name="getictrantemp" datasource="#dts#">
    SELECT * FROM ictrantempcn 
    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    and type = '#tran#' 
    order by length(trancode),trancode,refno2
</cfquery>

<cfinclude template="creditnotetablebody.cfm">

</cfoutput>

