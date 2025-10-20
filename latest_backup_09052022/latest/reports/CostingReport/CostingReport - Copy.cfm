<cfif getpin2.h4G00 eq "T">
  <script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>
<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<!-- QUERY FOR placement no--->
<cfquery name="getCostingQuery" datasource="#dts#">
   SELECT *,
  (salary + t.adminFee + t.EPF + t.SOCSO + t.medical) as subtotal,
  (salary + adminFee + EPF + SOCSO + medical + housingAllow + fixedAllow + varAllow+ shiftAllow + autoAllow + reimbClaim + bonus + KPI + ALInLieu+ UPL + noticeInLieu+Disbursement + outsourceFee + otherAdminFee + workPermit + recruitmentFee + socsoOT + dayShiftAllowance + languageAllowance + payAdjustment + OTAdjustment + selfottotal) as total
FROM (SELECT
  a.custno,
  p.location,
  a.branch as `entity`, 
  (SELECT attn from manpower_i.address WHERE custno = p.custno) as request,
  p.department as `dept`,
  p.po_no as PO,
  a.empname as `staffname`,
  a.placementno as JO,
  (SELECT DATE_FORMAT(WOS_DATE,'%M%Y') FROM manpower_i.artran WHERE refno = a.invoiceno) as `billingMth`,
  a.invoiceno,
  p.startdate,
  p.completedate,
  selfsalary as basicSalary,
  (SELECT fperiod FROM manpower_i.ictran WHERE brem6 = a.refno LIMIT 1 ) as fperiod, 
  (SELECT SUM(qty) from manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'Salary') as nomonthwork,
  ((SELECT SUM(qty) FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'Salary') * selfsalary) as salary,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'adminfee') as adminFee,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'EPF') as EPF,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'SOCSO YER') as SOCSO,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '17') as medical,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '99999') as housingAllow,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '3') as fixedAllow,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '5') as varAllow,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND (ITEMNO = '48' OR ITEMNO = '47' OR ITEMNO = '69')) as shiftAllow,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '32') as autoAllow,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '6') as reimbClaim,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '9') as bonus,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '72') as KPI,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '14') as `ALInLieu`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '19') as `UPL`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '9999') as `noticeInLieu`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '9999') as `Disbursement`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '18') as `outsourceFee`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '9999') as `otherAdminFee`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '9999') as `workPermit`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'Recruit') as `recruitmentFee`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '9999') as `socsoOT`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '9999') as `dayShiftAllowance`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '75') as `languageAllowance`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '11') as `payAdjustment`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = '12') as `OTAdjustment`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND NOTE_A != "OS" ) as taxable,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND NOTE_A = "OS" ) as nonTaxable,
  a.selfOT1,
  a.selfOTRATE1,
  a.selfOT2,
  a.selfOTRATE2,
  a.selfOT3,
  a.selfOTRATE3,
  a.selfOTTOTAL,
  '' as `non taxable`,
  '' as `GST 6%`

FROM manpower_i.assignmentslip a
left join manpower_i.placement p
on a.placementno = p.placementno
WHERE 1 = 1 
	<cfif form.PLACEMENTNOFROM neq "">
    	AND p.placementno >= #form.PLACEMENTNOFROM# 
    </cfif>
    <cfif #form.customerFrom# neq "">
    	AND p.custno >= #form.customerFrom# 
    </cfif>
    <cfif #form.customerTo# neq "">
    	AND p.custno <= #form.customerTo# 
    </cfif>
    <cfif #form.PLACEMENTNOTO# neq "">
    	AND p.placementno <= #form.PLACEMENTNOTO# 
    </cfif>
    <cfif #form.dateFrom# neq "">
    	AND (SELECT WOS_DATE FROM manpower_i.artran WHERE refno = a.invoiceno) >= #dateformat(form.dateFrom ,"YYYYMMDD")#
    </cfif>
    <cfif #form.dateTo# neq "">
    	AND (SELECT WOS_DATE FROM manpower_i.artran WHERE refno = a.invoiceno) <= #dateformat(form.dateTo ,"YYYYMMDD")#
    </cfif>
    HAVING JO is not null 
    <cfif #form.periodFrom# neq "">
    	AND fperiod >= #form.periodFrom# 
    </cfif>
    <cfif #form.periodTo# neq "">
    	AND fperiod <= #form.periodTo# 
    </cfif> 
    ) t ;
    
</cfquery>
<cfswitch expression="#form.result#">
  <cfcase value="EXCEL">
  
  <!-- ============ SETTING table headers for excel file ==================== --->
  <cfset headerFields = [
                          "Client ID",
						  "Office Code",
						  "Request",
						  "Dept",
						  "PO",
						  "Staff name",
						  "JO",
						  "Billing Mth",
						  "Invoice No",
						  "Start Date",
						  "End Date",
						  "Basic Salary",
						  "No Month Work",
						  "Salary",
						  "Admin Fee",
						  "EPF",
						  "SOCSO",
						  "Medical",
						  "Sub-total",
						  "","","","",
						  "OT1.5(QTY)",
						  "OT1.5(RM)",
						  "RD2.0(QTY)",
						  "RD2.0(RM)",
						  "OT3.0(QTY)",
						  "OT3.0(RM)",
						  "OT Sub-total",
						  "Housing Allow",
						  "Fixed Allow",
						  "Var. Allow",
						  "Shift Allow",
						  "Auto Allow",
						  "Reimb Claim",
						  "Bonus",
						  "KPI",
						  "AL in Lieu",
						  "UPL",
						  "Notice in Lieu",
						  "Disbursement",
						  "",
						  "Outsource Fee",
						  "Other Admin Fee",
						  "Work Permit",
						  "Recruitment Fee",
						  "SOCSO OT",
						  "Day Shift Allow",
						  "Language Allow",
						  "Pay Adjustment",
						  "OT Adjustment",
						  "Taxable",
						  "Non Taxable",
						  "GST 6%",
						  "Total",
						  "Entity"
                        ] />
  <cfset colList = getCostingQuery.columnList >
  <!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
  <cfsavecontent variable="strExcelData">
  <style type="text/css">
        td.header {
            border-bottom: 0.5pt solid black ;
            font-weight: bold ;
            }
    </style>
  <table>
    <tr>
      <td>Costing Report</td>
    </tr>
    <tr>
      <td>Accounting Period<cfoutput>#form.periodFrom#</cfoutput>to<cfoutput>#form.periodTo#</cfoutput></td>
    </tr>
    <tr>
      <td></td>
    </tr>
    <tr>
      <cfloop array="#headerFields#" index="field">
        <td class="header"><cfoutput>#field#</cfoutput></td>
      </cfloop>
    </tr>
    <cfloop query="getCostingQuery" >
      <tr>
        <td><cfoutput>#getCostingQuery['custno'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['location'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['request'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['dept'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['PO'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['staffname'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['JO'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['billingMth'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['invoiceno'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#dateformat(getCostingQuery['startdate'][getCostingQuery.currentRow],'YYYY-mm-dd')#</cfoutput></td>
        <td><cfoutput>#dateformat(getCostingQuery['completedate'][getCostingQuery.currentRow],'YYYY-mm-dd')#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['basicSalary'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['nomonthwork'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['salary'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['adminFee'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['EPF'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['SOCSO'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['medical'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['subtotal'][getCostingQuery.currentRow]#</cfoutput></td>
        <td></td><td></td><td></td><td></td>
        <td><cfoutput>#getCostingQuery['selfOT1'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['selfOT1'][getCostingQuery.currentRow] * getCostingQuery['selfOTRate1'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['selfOT2'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['selfOT2'][getCostingQuery.currentRow] * getCostingQuery['selfOTRate1'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['selfOT3'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['selfOT3'][getCostingQuery.currentRow] * getCostingQuery['selfOTRate1'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['selfOTTotal'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['housingAllow'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['fixedAllow'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['varAllow'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['shiftAllow'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['autoAllow'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['reimbClaim'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['bonus'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['KPI'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['ALINLieu'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['UPL'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['noticeInLieu'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['Disbursement'][getCostingQuery.currentRow]#</cfoutput></td><td></td>
        <td><cfoutput>#getCostingQuery['outsourceFee'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['otherAdminFee'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['workPermit'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['recruitmentFee'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['socsoOT'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['dayShiftAllowance'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['languageAllowance'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['payAdjustment'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['OTAdjustment'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['taxable'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['nontaxable'][getCostingQuery.currentRow]#</cfoutput></td>
        <td><cfoutput>#(getCostingQuery['taxable'][getCostingQuery.currentRow] * 0.06)#</cfoutput></td>
        <td><cfoutput>#(getCostingQuery['total'][getCostingQuery.currentRow])#</cfoutput></td>
        <td><cfoutput>#getCostingQuery['entity'][getCostingQuery.currentRow]#</cfoutput></td>
        </tr>
    </cfloop>
  </table>
  </cfsavecontent>
  
  <!-- ============OUTPUT EXCEL FILE==================== --->
  <cfheader
    name="Content-Disposition"
    value="attachment; filename=CostingReport.xls"
    />
  <cfif StructKeyExists( URL, "text" )>
    <cfcontent
        type="application/msexcel"
        reset="true"

    />
    <cfset WriteOutput( strExcelData.Trim() )
    />
    <cfexit />
    <cfelseif StructKeyExists( URL, "file" )>
    <cfset strFilePath = GetTempFile(
        GetTempDirectory(),
        "excel_"
        ) />
    <cffile
        action="WRITE"
        file="#strFilePath#"
        output="#strExcelData.Trim()#"
        />
    <cfcontent
        type="application/msexcel"
        file="#strFilePath#"
        deletefile="true"
        />
    <cfelse>
    <cfcontent
        type="application/msexcel"
        variable="#ToBinary( ToBase64( strExcelData.Trim() ) )#"
        />
  </cfif>
  </cfcase>
  
  <!--- PDF report---->
  <cfcase value="PDF2">
  <cfreport template="reportbilling.cfr" format="PDF" query="gettran">
    <!--- or "FlashPaper" or "Excel" or "RTF" --->
    <cfreportparam name="compro" value="#getgeneral.compro#">
    <cfreportparam name="compro2" value="#getgeneral.compro2#">
    <cfreportparam name="compro3" value="#getgeneral.compro3#">
    <cfreportparam name="compro4" value="#getgeneral.compro4#">
    <cfreportparam name="compro5" value="#getgeneral.compro5#">
    <cfreportparam name="compro6" value="#getgeneral.compro6#">
    <cfreportparam name="compro7" value="#getgeneral.compro7#">
    <cfreportparam name="title" value="#title#">
    <cfreportparam name="periodfrom" value="#periodfrom#">
    <cfreportparam name="periodto" value="#periodto#">
    <cfreportparam name="datefrom" value="#ndatefrom#">
    <cfreportparam name="dateto" value="#ndateto#">
    <cfreportparam name="target_arcust" value="#target_arcust#">
    <cfreportparam name="target_apvend" value="#target_apvend#">
    <cfreportparam name="dts" value="#dts#">
    <cfif IsDefined('form.customerFrom')>
      <cfreportparam name="custfrom" value="#form.customerFrom#">
      <cfelse>
      <cfreportparam name="custfrom" value="">
    </cfif>
    <cfif IsDefined('form.customerTo')>
      <cfreportparam name="custto" value="#form.customerTo#">
      <cfelse>
      <cfreportparam name="custto" value="">
    </cfif>
    <cfreportparam name="gstno" value="#getgeneral.gstno#">
    <cfreportparam name="tranname" value="#tranname#">
  </cfreport>
  </cfcase>
  <!---- End PDF report --->
  
  <!--- PDF report2---->
  <cfcase value="PDF">
  <cfreport template="reportbilling2.cfr" format="PDF" query="gettran">
    <!--- or "FlashPaper" or "Excel" or "RTF" --->
    <cfreportparam name="compro" value="#getgeneral.compro#">
    <cfreportparam name="compro7" value="#getgeneral.compro7#">
    <cfreportparam name="refno" value="#gettran.refno#">
    <cfreportparam name="title" value="#title#">
    <cfreportparam name="periodfrom" value="#periodfrom#">
    <cfreportparam name="periodto" value="#periodto#">
    <cfreportparam name="datefrom" value="#ndatefrom#">
    <cfreportparam name="dateto" value="#ndateto#">
    <cfreportparam name="dts" value="#dts#">
    <cfif IsDefined('form.customerFrom')>
      <cfreportparam name="custfrom" value="#form.customerFrom#">
      <cfelse>
      <cfreportparam name="custfrom" value="">
    </cfif>
    <cfif IsDefined('form.customerTo')>
      <cfreportparam name="custto" value="#form.customerTo#">
      <cfelse>
      <cfreportparam name="custto" value="">
    </cfif>
    <cfreportparam name="gstno" value="#getgeneral.gstno#">
    <cfreportparam name="tranname" value="#tranname#">
    <cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
      <cfinclude template="/CFC/LastDayOfMonth.cfm">
      <cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
      <cfset date2a = LastDayOfMonth(month(date2),year(date2))>
      <cfreportparam name="accdate" value="#dateformat(date2a,'dd/mm/yyyy')#">
      <cfelse>
      <cfreportparam name="accdate" value="#dateformat(now(),'dd/mm/yyyy')#">
    </cfif>
  </cfreport>
  </cfcase>
  <!---- End PDF report --->
  
  <cfcase value="HTML">
  <cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
  <cfset stDecl_UPrice = ",.">
  <cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
    <cfset stDecl_UPrice = stDecl_UPrice & "_">
  </cfloop>
  <cfif isdefined('form.cbdetail')>
    <html>
    <head>
    <title><cfoutput>#url.type#Listing Report</cfoutput></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
    <style type="text/css" media="print">
.noprint {
	display: none;
}
</style>
    </head>
    
    <body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>
    <table align="center" cellpadding="3" cellspacing="0" width="100%">
      <cfoutput>
        <tr>
          <td colspan="100%"><div align="center"><font size="3" face="Arial, Helvetica, sans-serif"><strong>#url.type# Listing Report</strong></font></div></td>
        </tr>
        <cfif form.refNoFrom neq "" and form.refNoTo neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Ref No From #form.refNoFrom# To #form.refNoTo#</font></div></td>
          </tr>
        </cfif>
        <cfif ndatefrom neq "" and ndateto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#form.datefrom# - #form.dateto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.periodfrom neq "" and form.periodto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Period From #form.periodfrom# To #form.periodto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.agentfrom neq "" and form.agentto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.locationfrom neq "" and form.locationto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Location From #form.locationfrom# To #form.locationto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.projectfrom neq "" and form.projectto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Project From #form.projectfrom# To #form.projectto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.jobfrom neq "" and form.jobto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Job From #form.Jobfrom# To #form.Jobto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.driverFrom neq "" and form.userTo neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.lDriver# From #form.driverFrom# To #form.userTo#</font></div></td>
          </tr>
        </cfif>
        <cfif form.Daddressfrom neq "" and form.Daddressto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Delivery Address Code From #form.Daddressfrom# To #form.Daddressto#</font></div></td>
          </tr>
        </cfif>
        <tr>
          <td colspan="80%"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.compro#</font></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td colspan="20%"><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">
              <cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
                <cfinclude template="/CFC/LastDayOfMonth.cfm">
                <cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
                <cfset date2a = LastDayOfMonth(month(date2),year(date2))>
                #dateformat(date2a,"dd/mm/yyyy")#
                <cfelse>
                #dateformat(now(),"dd/mm/yyyy")#
              </cfif>
              </font></div></td>
        </tr>
      </cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
            <cfif url.trancode eq "TR">
              Authorised by.<br>
              Transfer No.
              <cfelse>
              Account No.<br>
              Bill No.
            </cfif>
            </strong></font></div></td>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
            <cfif url.trancode eq "TR">
              Reason for transfer.<br>
              Date.
              <cfelse>
              Account Name.<br>
              Date
            </cfif>
            </strong></font></div></td>
        <cfif isdefined('form.checkbox1')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Ref No 2</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.checkbox3')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>PO/SO NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.checkbox4')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>DO NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbso')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>SO NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbproject')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Project NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbjob')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Job NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbagent')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Agent NO</strong></font></div></td>
        </cfif>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Product No</strong></font></div></td>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Product Code</strong></font></div></td>
        </cfif>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Product Name</strong></font></div></td>
        <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
          <cfif url.trancode eq "TR">
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Location From</strong></font></div></td>
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Location To</strong></font></div></td>
            <cfelse>
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Location</strong></font></div></td>
          </cfif>
        </cfif>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Qty</strong></font></div></td>
        <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>GST</strong></font></div></td>
        <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Price</strong></font></div></td>
        <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Disc %</strong></font></div></td>
        <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Amount</strong></font></div></td>
        <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Project</strong></font></div></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Job</strong></font></div></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Grand Foreign Rate</strong></font></div></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Grand Foreign Amount</strong></font></div></td>
        </cfif>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfset count=1>
      <cfset detailtotalgrand = 0>
      <cfset detailforeigntotalgrand = 0>
      <cfoutput query="gettran">
        <cfif hcomid eq "taftc_i" and url.trancode eq "INV">
          <cfif gettran.cdispec neq 0>
            <cfset gettran.discount = val(gettran.cgrant) * val(gettran.cdispec)>
            <cfset gettran.invgross = val(gettran.invgross) + val(gettran.discount)>
          </cfif>
        </cfif>
        <cfif currrate neq "">
          <cfset xcurrrate = currrate>
          <cfelse>
          <cfset xcurrrate = 1>
        </cfif>
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"> #gettran.custno#</font></div></td>
          <cfquery datasource="#dts#" name="getcust">
						Select name, currcode from #title1# where custno='#custno#'
					</cfquery>
          <td colspan="3" nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#name#</font></div></td>
        </tr>
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"> #gettran.refno#</font></div></td>
          <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(gettran.wos_date,'dd-mm-yyyy')#</font></div></td>
          <cfif isdefined('form.checkbox1')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.refno2#</font></div></td>
          </cfif>
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.PONO#</font></div></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.DONO#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.sONO#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.source#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.job#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.agenno#</font></div></td>
          </cfif>
        </tr>
        <cfquery name="getbodydetail" datasource="#dts#">
                select * from ictran where refno='#gettran.refno#' and type=<cfif url.trancode eq 'TR'>'TROU'<cfelse>'#gettran.type#'</cfif>
                </cfquery>
        <cfloop query="getbodydetail">
          <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <cfif isdefined('form.checkbox1')>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
            </cfif>
            <cfif isdefined('form.checkbox3')>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
            </cfif>
            <cfif isdefined('form.checkbox4')>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
            </cfif>
            <cfif isdefined('form.cbso')>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
            </cfif>
            <cfif isdefined('form.cbproject')>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
            </cfif>
            <cfif isdefined('form.cbjob')>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
            </cfif>
            <cfif isdefined('form.cbagent')>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
            </cfif>
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"> </font></div></td>
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"> </font></div></td>
            <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")>
              <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getbodydetail.itemno#</font></div></td>
              <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <cfquery name="getproductcode" datasource="#dts#">
                    select aitemno from icitem where itemno='#getbodydetail.itemno#'
                    </cfquery>
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getproductcode.aitemno#</font></div></td>
              </cfif>
              <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getbodydetail.desp#
                  <cfif getbodydetail.despa neq ''>
                    <br>
                    #getbodydetail.despa#
                  </cfif>
                  <cfif tostring(getbodydetail.comment) neq ''>
                    <br>
                    #tostring(getbodydetail.comment)#
                  </cfif>
                  </font></div></td>
              <cfelse>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getbodydetail.itemno#
                  <cfif lcase(hcomid) eq "bestform_i">
                    <br>
                    #getbodydetail.batchcode#
                  </cfif>
                  </font></div></td>
              <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <cfquery name="getproductcode" datasource="#dts#">
                    select aitemno from icitem where itemno='#getbodydetail.itemno#'
                    </cfquery>
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getproductcode.aitemno#</font></div></td>
              </cfif>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getbodydetail.desp#
                  <cfif getbodydetail.despa neq ''>
                    <br>
                    #getbodydetail.despa#
                  </cfif>
                  <cfif tostring(getbodydetail.comment) neq ''>
                    <br>
                    #tostring(getbodydetail.comment)#
                  </cfif>
                  </font></div></td>
            </cfif>
            <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
              <cfif url.trancode eq "TR">
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.rem1#</font></div></td>
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.rem2#</font></div></td>
                <cfelse>
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getbodydetail.location#</font></div></td>
              </cfif>
            </cfif>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getbodydetail.qty#</font></div></td>
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(getbodydetail.taxpec1,'.__')#</font></div></td>
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"> #numberformat(getbodydetail.price,',_.__')#</font></div></td>
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(getbodydetail.dispec1,'.__')#</font></div></td>
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(getbodydetail.amt,',_.__')#</font></div></td>
            <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
              <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.source#</font></div></td>
              <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.job#</font></div></td>
              <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.currrate#</font></div></td>
              <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(getbodydetail.amt_bil,',_.__')#</font></div></td>
            </cfif>
          </tr>
        </cfloop>
        <tr>
          <td colspan="6">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td colspan="2"></td>
          <td nowrap><hr></td>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <td></td>
            <td></td>
            <td></td>
            <td><hr></td>
          </cfif>
        </tr>
        <cfif url.trancode eq 'TR'>
          <cfset gettran.invgross=gettran.invgross/2>
          <cfset gettran.gross_bil=gettran.gross_bil/2>
          <cfset gettran.discount=gettran.discount/2>
          <cfset gettran.disc_bil=gettran.disc_bil/2>
          <cfset gettran.net=gettran.net/2>
          <cfset gettran.net_bil=gettran.net_bil/2>
          <cfset gettran.tax=gettran.tax/2>
          <cfset gettran.tax_bil=gettran.tax_bil/2>
          <cfset gettran.grand=gettran.grand/2>
          <cfset gettran.grand_bil=gettran.grand_bil/2>
        </cfif>
        <tr>
          <td colspan="6">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td colspan="2"><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.invgross,',_.__')#</font></div></td>
          <td></td>
          <td></td>
          <td></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.gross_bil,',_.__')#</font></div></td>
        </tr>
        <tr>
          <td colspan="6">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td colspan="2"><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">Total Discount</font></div></td>
          <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.discount,',_.__')#</font></div></td>
          <td></td>
          <td></td>
          <td></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.disc_bil,',_.__')#</font></div></td>
        </tr>
        <tr>
          <td colspan="8">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
          </cfif>
          <td nowrap><hr></td>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <td></td>
            <td></td>
            <td></td>
            <td><hr></td>
          </cfif>
        </tr>
        <tr>
          <td colspan="8">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.net,',_.__')#</font></div></td>
          <td></td>
          <td></td>
          <td></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.net_bil,',_.__')#</font></div></td>
        </tr>
        <tr>
          <td colspan="6">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td colspan="2"><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">GST</font></div></td>
          <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.tax,',_.__')#</font></div></td>
          <td></td>
          <td></td>
          <td></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.tax_bil,',_.__')#</font></div></td>
        </tr>
        <tr>
          <td colspan="8">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td nowrap><hr></td>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <td></td>
            <td></td>
            <td></td>
            <td><hr></td>
          </cfif>
        </tr>
        <tr>
          <td colspan="8">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><b>#numberformat(gettran.grand,',_.__')#</b></font></div></td>
          <td></td>
          <td></td>
          <td></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(gettran.grand_bil,',_.__')#</font></div></td>
        </tr>
        <cfset detailtotalgrand = detailtotalgrand + val(numberformat(gettran.grand,".__"))>
        <cfset detailforeigntotalgrand = detailforeigntotalgrand + val(numberformat(gettran.grand_bil,".__"))>
        <tr>
          <td colspan="8">
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
              <td></td>
            </cfif>
            <td></td>
          </cfif>
          <td nowrap><hr></td>
        </tr>
        <tr>
        <tr>
          <td></td>
        </tr>
      </cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfoutput>
        <tr>
          <td><b>Total</b></td>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><b>#numberformat(detailtotalgrand,",_.__")#</b></td>
          <td></td>
          <td></td>
          <td></td>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <td><b>#numberformat(detailforeigntotalgrand,",_.__")#</b></td>
        </tr>
        <tr>
          <td></td>
        </tr>
      </cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
    </table>
    <br>
    <br>
    <div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
    <p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
    </body>
    </html>
    <cfelse>
    <html>
    <head>
    <title><cfoutput>#url.type#Listing Report</cfoutput></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
    <style type="text/css" media="print">
.noprint {
	display: none;
}
</style>
    </head>
    
    <body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>
    <table align="center" cellpadding="3" cellspacing="0" width="100%">
      <cfoutput>
        <tr>
          <td colspan="100%"><div align="center"><font size="3" face="Arial, Helvetica, sans-serif"><strong>#url.type# Listing Report</strong></font></div></td>
        </tr>
        <cfif form.refNoFrom neq "" and form.refNoTo neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Ref No From #form.refNoFrom# To #form.refNoTo#</font></div></td>
          </tr>
        </cfif>
        <cfif ndatefrom neq "" and ndateto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#form.datefrom# - #form.dateto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.periodfrom neq "" and form.periodto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Period From #form.periodfrom# To #form.periodto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.agentfrom neq "" and form.agentto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.locationfrom neq "" and form.locationto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Location From #form.locationfrom# To #form.locationto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.projectfrom neq "" and form.projectto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Project From #form.projectfrom# To #form.projectto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.jobfrom neq "" and form.jobto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Job From #form.Jobfrom# To #form.Jobto#</font></div></td>
          </tr>
        </cfif>
        <cfif form.driverFrom neq "" and form.userTo neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.lDriver# From #form.driverFrom# To #form.userTo#</font></div></td>
          </tr>
        </cfif>
        <cfif form.Daddressfrom neq "" and form.Daddressto neq "">
          <tr>
            <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Delivery Address Code From #form.Daddressfrom# To #form.Daddressto#</font></div></td>
          </tr>
        </cfif>
        <cfif IsDefined('form.customerFrom') AND IsDefined('form.customerTo')>
          <cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
            <tr>
              <td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Customer From #form.customerFrom# To #form.customerTo#</font></div></td>
            </tr>
          </cfif>
        </cfif>
        <cfif IsDefined('form.customerFrom') eq IsDefined('form.customerTo')>
          <cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
            <cfif form.title eq "Customer">
              <cfquery name="getcustadd" datasource="#dts#">
                        select * 
                        from #target_arcust# 
                        where custno='#form.customerFrom#'
                    </cfquery>
              <cfelse>
              <cfquery name="getcustadd" datasource="#dts#">
                        select * 
                        from #target_apvend# 
                        where custno='#IsDefined("form.customerFrom")#'
                    </cfquery>
            </cfif>
            <tr>
              <td colspan="100%"><div align="center"> <font size="1.5" face="Arial, Helvetica, sans-serif"> Address : #getcustadd.add1# #getcustadd.add2# #getcustadd.add3# #getcustadd.add4# </font> </div></td>
            </tr>
          </cfif>
        </cfif>
        <tr>
          <td colspan="80%"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.compro#</font></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td colspan="20%"><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">
              <cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
                <cfinclude template="/CFC/LastDayOfMonth.cfm">
                <cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
                <cfset date2a = LastDayOfMonth(month(date2),year(date2))>
                #dateformat(date2a,"dd/mm/yyyy")#
                <cfelse>
                #dateformat(now(),"dd/mm/yyyy")#
              </cfif>
              </font></div></td>
        </tr>
      </cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <cfif lcase(HcomID) eq "winbells_i">
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>No</strong></font></div></td>
        </cfif>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Refno</strong></font></div></td>
        <cfif isdefined('form.checkbox1')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Refno 2</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.checkbox2')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Status</strong></font></div></td>
        </cfif>
        <cfif lcase(HcomID) eq "mphcranes_i">
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Project No</strong></font></div></td>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
              <cfif url.trancode eq 'INV'>
                Service Report No.
                <cfelse>
                Refno 2
              </cfif>
              </strong></font></div></td>
        </cfif>
        <cfif isdefined('form.checkbox3')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>PO/SO NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.checkbox4')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>DO NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbso')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>SO NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbproject')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Project NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbjob')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Job NO</strong></font></div></td>
        </cfif>
        <cfif isdefined('form.cbagent')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Agent NO</strong></font></div></td>
        </cfif>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Date</strong></font></div></td>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
            <cfif url.trancode eq "TR">
              Authorised by
              <cfelse>
              Cust No
            </cfif>
            </strong></font></div></td>
        <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
            <cfif url.trancode eq "TR">
              Reason for transfer
              <cfelse>
              Name
            </cfif>
            </strong></font></div></td>
        <cfif lcase(hcomid) eq "elitez_i">
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Delivery Address</strong></font></div></td>
        </cfif>
        <cfif lcase(HcomID) eq "pengwang_i" or lcase(HcomID) eq "pingwang_i" or lcase(HcomID) eq "huanhong_i" or lcase(HcomID) eq "prawn_i" or lcase(HcomID) eq "hhsf_i">
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Salesman</strong></font></div></td>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Driver</strong></font></div></td>
        </cfif>
        <cfif lcase(HcomID) eq "powernas_i">
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Policy No</strong></font></div></td>
        </cfif>
        <cfif url.trancode eq "TR">
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Transfer From</strong></font></div></td>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Transfer To</strong></font></div></td>
        </cfif>
        <cfif lcase(HcomID) eq "simplysiti_i">
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Courier Type</strong></font></div></td>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Courier Ref No</strong></font></div></td>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Deliver Out Date</strong></font></div></td>
          <cfif url.trancode eq "TR">
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Cost</strong></font></div></td>
          </cfif>
        </cfif>
        <cfif lcase(HcomID) neq "atc2005_i">
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Amount</strong></font></div></td>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
              <cfif lcase(HcomID) eq "taftc_i">
                Grant
                <cfelse>
                Discount
              </cfif>
              </strong></font></div></td>
        </cfif>
        <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>NET</strong></font></div></td>
        <cfif isdefined('form.cbgst')>
          <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>GST CODE</strong></font></div></td>
        </cfif>
        <cfif lcase(HcomID) neq "sdc_i">
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Tax</strong></font></div></td>
        </cfif>
        <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Grand Total</strong></font></div></td>
        <cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "bestform_i">
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Currency Rate</strong></font></div></td>
        </cfif>
        <cfif lcase(HcomID) eq "bestform_i">
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Currency Code</strong></font></div></td>
        </cfif>
        <cfif url.trancode neq 'ISS'>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Grand Foreign</strong></font></div></td>
        </cfif>
        <cfif lcase(HcomID) eq "atc2005_i">
          <td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Delivery Date</strong></font></div></td>
        </cfif>
        <td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
            <cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i">
              Agent
              <cfelse>
              Created By
            </cfif>
            </strong></font></div></td>
        <cfif lcase(Hcomid) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i">
          <td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Agent</strong></font></div></td>
        </cfif>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfset count=1>
      <cfoutput query="gettran">
        <cfif hcomid eq "taftc_i" and url.trancode eq "INV">
          <cfif gettran.cdispec neq 0>
            <cfset gettran.discount = val(gettran.cgrant) * val(gettran.cdispec)>
            <cfset gettran.invgross = val(gettran.invgross) + val(gettran.discount)>
          </cfif>
        </cfif>
        <cfif currrate neq "">
          <cfset xcurrrate = currrate>
          <cfelse>
          <cfset xcurrrate = 1>
        </cfif>
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <cfif lcase(HcomID) eq "winbells_i">
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#count#</strong></font></div></td>
          </cfif>
          <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">
              <cfif url.trancode eq "rc" or url.trancode eq "DO" or url.trancode eq "INV" or url.trancode eq "CS" or url.trancode eq "QUO" or url.trancode eq "PO" or url.trancode eq "CN" or url.trancode eq "DN" or url.trancode eq "PR" or url.trancode eq "SAM">
                <a href="bill_listingreport2.cfm?type=#url.trancode#&refno=#gettran.refno#">#gettran.refno#</a>
                <cfelse>
                #gettran.refno#
              </cfif>
              </font></div></td>
          <cfif isdefined('form.checkbox1')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.refno2#</font></div></td>
          </cfif>
          <cfif isdefined('form.checkbox2')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">
                <cfif toinv neq ''>
                  Y
                </cfif>
                <cfif posted eq 'P'>
                  P
                </cfif>
                <cfif void neq ''>
                  <font color="red"><strong>Void</strong></font>
                </cfif>
                </font></div></td>
          </cfif>
          <cfif lcase(HcomID) eq "mphcranes_i">
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#source#</font></div></td>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">
                <cfif url.trancode eq 'INV'>
                  #rem6#
                  <cfelse>
                  #refno2#
                </cfif>
                </font></div></td>
          </cfif>
          <cfif isdefined('form.checkbox3')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.PONO#</font></div></td>
          </cfif>
          <cfif isdefined('form.checkbox4')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.DONO#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbso')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.sONO#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbproject')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.source#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbjob')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.job#</font></div></td>
          </cfif>
          <cfif isdefined('form.cbagent')>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.agenno#</font></div></td>
          </cfif>
          <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(wos_date,"dd-mm-yy")#</font></div></td>
          <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#custno#</font></div></td>
          <cfquery datasource="#dts#" name="getcust">
						Select name, currcode from #title1# where custno='#custno#'
					</cfquery>
          <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#name#</font></div></td>
          <cfif lcase(hcomid) eq "elitez_i">
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.comm0# #gettran.comm1# #gettran.comm2# #gettran.comm3# #gettran.rem14#</font></div></td>
          </cfif>
          <cfif lcase(HcomID) eq "pengwang_i" or lcase(HcomID) eq "pingwang_i" or lcase(HcomID) eq "huanhong_i" or lcase(HcomID) eq "prawn_i" or lcase(HcomID) eq "hhsf_i">
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#agenno#</font></div></td>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#van#</font></div></td>
          </cfif>
          <cfif lcase(HcomID) eq "powernas_i">
            <cfquery name='getpolicy' datasource='#dts#'>
		    select brem2 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
		    </cfquery>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getpolicy.brem2#</font></div></td>
          </cfif>
          <cfif url.trancode neq "TR">
            <cfset xamt = val(gettran.invgross)>
            <cfset xdisc = val(gettran.discount)>
            <cfif gettran.taxincl eq 'T'>
              <cfset xnet = val(gettran.net)-val(gettran.tax)>
              <cfelse>
              <cfset xnet = val(gettran.net)>
            </cfif>
            <cfset xtax = val(gettran.tax)>
            <cfset xgrand =numberformat(gettran.grand,'.__')>
            <cfset xcurrrate = val(gettran.currrate)>
            <cfelse>
            <cfset xamt = val(gettran.invgross) / 2>
            <cfset xdisc = val(gettran.discount) / 2>
            <cfset xnet = val(gettran.net) / 2>
            <cfset xtax = val(gettran.tax) / 2>
            <cfset xgrand = val(gettran.grand) / 2>
            <cfset xcurrrate = val(gettran.currrate)>
          </cfif>
          <cfif url.trancode eq "TR">
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#rem1#</font></div></td>
            <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#rem2#</font></div></td>
          </cfif>
          <cfif lcase(HcomID) eq "simplysiti_i">
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#rem8#</strong></font></div></td>
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#rem9#</strong></font></div></td>
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#rem11#</strong></font></div></td>
            <cfif url.trancode eq "TR">
              <cfquery name="getsimplysiticost" datasource="#dts#">
                select sum(ucost*qty) as ucost from(
                select (select ucost from icitem where itemno=a.itemno) as ucost,qty from ictran as a where refno='#refno#' and type='TRIN')as b
                </cfquery>
              <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getsimplysiticost.ucost#</font></div></td>
            </cfif>
          </cfif>
          <cfif lcase(HcomID) neq "atc2005_i">
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xamt,",.__")#</font></div></td>
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xdisc,",.__")#</font></div></td>
          </cfif>
          <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xnet,",.__")#</font></div></td>
          <cfif isdefined('form.cbgst')>
            <cfif getgeneral.wpitemtax NEQ ''>
              <cfquery name="getIctranTaxCode" datasource="#dts#">
                            	SELECT DISTINCT note_a
                                FROM ictran
                                WHERE refno = '#gettran.refno#'
                                AND type = '#gettran.type#'
                                ORDER BY note_a
                            </cfquery>
              <cfset taxCodeList=valuelist(getIctranTaxCode.note_a)>
              <td nowrap><div align="left"> <font size="1.5" face="Arial, Helvetica, sans-serif"> #taxCodeList# </font> </div></td>
              <cfelse>
              <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.note#</font></div></td>
            </cfif>
          </cfif>
          <cfif lcase(HcomID) neq "sdc_i">
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xtax,",.__")#</font></div></td>
          </cfif>
          <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xgrand,",.__")#</font></div></td>
          <cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "bestform_i">
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xcurrrate,",.______")#</font></div></td>
          </cfif>
          <cfif lcase(HcomID) eq "bestform_i">
            <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#currcode#</font></div></td>
          </cfif>
          <cfif url.trancode neq 'ISS'>
            <cfif xcurrrate eq "1">
              <cfif lcase(HcomID) eq "powernas_i">
                <cfquery name="getictranqty4" datasource="#dts#">
                            select qty4 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
                            </cfquery>
                <cfif getictranqty4.recordcount neq 0>
                  <cfset xfcamt = val(gettran.grand_bil/getictranqty4.qty4)>
                  <cfelse>
                  <cfset xfcamt = val(gettran.grand_bil)>
                </cfif>
                <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">SGD #numberformat(xfcamt,stDecl_UPrice)#</font></div></td>
                <cfelse>
                <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">-</font></div></td>
              </cfif>
              <cfelse>
              <cfif gettran.grand_bil neq "">
                <cfif url.trancode neq "TR">
                  <cfif lcase(HcomID) eq "powernas_i">
                    <cfquery name="getictranqty4" datasource="#dts#">
                            select qty4 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
                            </cfquery>
                    <cfif getictranqty4.recordcount neq 0>
                      <cfset xfcamt = val(gettran.grand_bil/getictranqty4.qty4)>
                      <cfelse>
                      <cfset xfcamt = val(gettran.grand_bil)>
                    </cfif>
                    <cfelse>
                    <cfset xfcamt = val(gettran.grand_bil)>
                  </cfif>
                  <cfelse>
                  <cfset xfcamt = val(gettran.grand_bil) / 2>
                </cfif>
              </cfif>
              <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#getcust.currcode# #numberformat(xfcamt,stDecl_UPrice)#</font></div></td>
              <cfif xcurrrate eq "1" or xcurrrate eq "0">
                <cfelse>
                <cfset totalfcamt = totalfcamt + xfcamt>
              </cfif>
            </cfif>
          </cfif>
          <cfif lcase(HcomID) eq "atc2005_i">
            <td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#rem5#</font></div></td>
          </cfif>
          <td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">
              <cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i">
                #agenno#
                <cfelse>
                #userid#
              </cfif>
              </font></div></td>
          <cfif lcase(Hcomid) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i">
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#agenno#</font></div></td>
          </cfif>
        </tr>
        <cfset totalamt = totalamt + numberformat(xamt,".__")>
        <cfset totaldisc = totaldisc + numberformat(xdisc,".__")>
        <cfset totalnet = totalnet + numberformat(xnet,".__")>
        <cfif lcase(HcomID) neq "sdc_i">
          <cfset totaltax = totaltax + numberformat(xtax,".__")>
        </cfif>
        <cfset totalgrand = totalgrand + numberformat(xgrand,".__")>
        <cfset count=count+1>
      </cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <cfif isdefined('form.checkbox1')>
          <td></td>
        </cfif>
        <cfif isdefined('form.checkbox2')>
          <td></td>
        </cfif>
        <cfif isdefined('form.checkbox4')>
          <td></td>
        </cfif>
        <cfif isdefined('form.checkbox3')>
          <td></td>
        </cfif>
        <cfif isdefined('form.cbso')>
          <td></td>
        </cfif>
        <cfif isdefined('form.cbproject')>
          <td></td>
        </cfif>
        <cfif isdefined('form.cbjob')>
          <td></td>
        </cfif>
        <cfif isdefined('form.cbagent')>
          <td></td>
        </cfif>
        <cfif lcase(HcomID) eq "powernas_i">
          <td></td>
        </cfif>
        <cfif url.trancode eq "TR">
          <td></td>
          <td></td>
        </cfif>
        <cfif lcase(HcomID) eq "simplysiti_i">
          <td></td>
          <td></td>
          <td></td>
          <cfif url.trancode eq "TR">
            <td></td>
          </cfif>
        </cfif>
        <cfif lcase(HcomID) eq "mphcranes_i">
          <td></td>
          <td></td>
        </cfif>
        <cfoutput>
          <cfif lcase(hcomid) eq "elitez_i">
            <td></td>
          </cfif>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Total:</strong></font></div></td>
          <cfif lcase(HcomID) neq "atc2005_i">
            <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalamt,",.__")#</strong></font></div></td>
            <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totaldisc,",.__")#</strong></font></div></td>
          </cfif>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalnet,",.__")#</strong></font></div></td>
          <cfif isdefined('form.cbgst')>
            <td></td>
          </cfif>
          <cfif lcase(HcomID) neq "sdc_i">
            <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totaltax,",.__")#</strong></font></div></td>
          </cfif>
          <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalgrand,",.__")#</strong></font></div></td>
          <cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "bestform_i">
            <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif lcase(HcomID) eq "bestform_i">
            <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td>
          </cfif>
          <cfif url.trancode neq 'ISS'>
            <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
                <cfif totalfcamt neq 0>
                  #numberformat(totalfcamt,",.__")#
                </cfif>
                </strong></font></div></td>
          </cfif>
        </cfoutput>
        <td></td>
        <cfif lcase(Hcomid) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i">
          <td></td>
        </cfif>
      </tr>
    </table>
    <br>
    <br>
    <div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
    <p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
    </body>
    </html>
  </cfif>
  </cfcase>
</cfswitch>
