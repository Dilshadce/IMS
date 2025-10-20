
<cfsetting requesttimeout="0" >
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
   SELECT *, DATE_FORMAT(WOS_DATE,'%M%Y') as `billingMth`,
  (salary + t.adminFee + t.EPF + t.SOCSO + t.medical) as subtotal,
  (salary + adminFee + EPF + SOCSO + medical + housingAllow + fixedAllow + varAllow+ shiftAllow + autoAllow + reimbClaim + bonus + KPI + ALInLieu+ UPL + noticeInLieu+Disbursement + outsourceFee + otherAdminFee + workPermit + recruitmentFee + socsoOT + dayShiftAllowance + languageAllowance + payAdjustment + OTAdjustment + custottotal) as total
FROM (SELECT
  a.custno,
  p.location,
  a.branch as `entity`, 
  (SELECT attn from manpower_i.address WHERE custno = p.custno) as request,
  p.department as `dept`,
  p.po_no as PO,
  a.empname as `staffname`,
  a.placementno as JO,
  (SELECT WOS_DATE FROM manpower_i.artran WHERE refno = a.invoiceno) as `WOS_DATE`,
  
  a.invoiceno,
  p.startdate,
  p.completedate,
  selfsalary as basicSalary,
  (SELECT fperiod FROM manpower_i.ictran WHERE brem6 = a.refno LIMIT 1 ) as fperiod, 
  (SELECT SUM(qty) from manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'Salary') as nomonthwork,
  ((SELECT SUM(qty) FROM manpower_i.ictran WHERE brem6 = a.refno AND ITEMNO = 'Salary') * selfsalary) as salary,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = 'adminfee') as adminFee,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = 'EPF') as EPF,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = 'SOCSO YER') as SOCSO,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '17') as medical,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '52') as housingAllow,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '3') as fixedAllow,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '5') as varAllow,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND (ITEMNO = '48' OR ITEMNO = '47' OR ITEMNO = '69')) as shiftAllow,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '32') as autoAllow,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '6') as reimbClaim,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '9') as bonus,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '72') as KPI,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '14') as `ALInLieu`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '19') as `UPL`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '13') as `noticeInLieu`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '33') as `Disbursement`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '18') as `outsourceFee`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '86') as `otherAdminFee`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND desp LIKE '%work permit%') as `workPermit`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '4') as `recruitmentFee`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '42') as `socsoOT`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '47') as `dayShiftAllowance`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '75') as `languageAllowance`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '11') as `payAdjustment`,
 (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE refno = a.invoiceno AND ITEMNO = '12') as `OTAdjustment`,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND NOTE_A != "OS" ) as taxable,
  (SELECT CASE WHEN SUM(amt) IS NULL THEN 0 ELSE SUM(amt) END FROM manpower_i.ictran WHERE brem6 = a.refno AND NOTE_A = "OS" ) as nonTaxable,
  a.custOT1,
  a.custOTRATE1,
  a.custOT2,
  a.custOTRATE2,
  a.custOT3,
  a.custOTRATE3,
  a.custOTTOTAL,
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
    
    HAVING JO is not null 
    <cfif #form.periodFrom# neq "">
    	AND fperiod >= #form.periodFrom# 
    </cfif>
    <cfif #form.periodTo# neq "">
    	AND fperiod <= #form.periodTo# 
    </cfif> 
    ) t  WHERE 1 =1 
    <cfif #form.dateFrom# neq "">
    	AND  WOS_DATE >= #dateformat(form.dateFrom ,"YYYYMMDD")#
    </cfif>
    <cfif #form.dateTo# neq "">
    	AND  WOS_DATE  <= #dateformat(form.dateTo ,"YYYYMMDD")#
    </cfif>
    ;
    
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
  <cfxml variable="data">
  <?xml version="1.0"?>
  <?mso-application progid="Excel.Sheet"?>
  <Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
    <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
      <Author>Netiquette Technology</Author>
      <LastAuthor>Netiquette Technology</LastAuthor>
      <Company>Netiquette Technology</Company>
    </DocumentProperties>
    <Styles>
      <Style ss:ID="Default" ss:Name="Normal">
			   		<Alignment ss:Vertical="Bottom"/>
			   		<Borders/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
			   		<Interior/>
			   		<NumberFormat/>
			   		<Protection/>
		  		</Style>
      <Style ss:ID="s22">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  		</Style>
      <Style ss:ID="s24">
			   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
			  	</Style>
      <Style ss:ID="s26">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
      <Style ss:ID="s27">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
      <Style ss:ID="s30">
		   			<NumberFormat ss:Format="dd-mm-yy;@"/>
		  		</Style>
      <Style ss:ID="s31">
		  			<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
      <Style ss:ID="s32">
		  	 		<NumberFormat ss:Format="@"/>
		  		</Style>
      <Style ss:ID="s34">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="dd/mm/yyyy;@"/>
		  		</Style>
      <Style ss:ID="s35">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
      <Style ss:ID="s36">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
      <Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
      <Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
    </Styles>
    <Worksheet ss:Name="View Bill Listing Report">
      <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
        <Column ss:Width="64.5"/>
        <Column ss:Width="60.25"/>
        <Column ss:Width="183.75"/>
        <Column ss:AutoFitWidth="0" ss:Width="60"/>
        <Column ss:Width="47.25"/>
        <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
        <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
        <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
        <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
          <cfloop array="#headerFields#" index="field" >
            <Cell ss:StyleID="s27">
              <Data ss:Type="String"><cfoutput>#field#</cfoutput></Data>
            </Cell>
          </cfloop>
        </Row>
        <cfloop query="getCostingQuery" >
          <Row>
            <Cell>
              <Data ss:Type="String"><cfoutput>#getCostingQuery['custno'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"><cfoutput>#getCostingQuery['location'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"><cfoutput>#getCostingQuery['request'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"><cfoutput>#getCostingQuery['dept'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"><cfoutput>#getCostingQuery['PO'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['staffname'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['JO'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['billingMth'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['invoiceno'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#dateformat(getCostingQuery['startdate'][getCostingQuery.currentRow],'YYYY-mm-dd')#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#dateformat(getCostingQuery['completedate'][getCostingQuery.currentRow],'YYYY-mm-dd')#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['basicSalary'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['nomonthwork'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['salary'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['adminFee'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['EPF'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['SOCSO'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['medical'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['subtotal'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell></Cell>
            <Cell></Cell>
            <Cell></Cell>
            <Cell></Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['custOT1'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['custOT1'][getCostingQuery.currentRow] * getCostingQuery['custOTRate1'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['custOT2'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['custOT2'][getCostingQuery.currentRow] * getCostingQuery['custOTRate1'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['custOT3'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['custOT3'][getCostingQuery.currentRow] * getCostingQuery['custOTRate1'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['custOTTotal'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['housingAllow'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['fixedAllow'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['varAllow'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['shiftAllow'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['autoAllow'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['reimbClaim'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['bonus'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['KPI'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['ALINLieu'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['UPL'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['noticeInLieu'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['Disbursement'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell></Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['outsourceFee'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['otherAdminFee'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['workPermit'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['recruitmentFee'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['socsoOT'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['dayShiftAllowance'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['languageAllowance'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['payAdjustment'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['OTAdjustment'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['taxable'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['nontaxable'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#(getCostingQuery['taxable'][getCostingQuery.currentRow] * 0.06)#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#(getCostingQuery['total'][getCostingQuery.currentRow])#</cfoutput></Data>
            </Cell>
            <Cell>
              <Data ss:Type="String"> <cfoutput>#getCostingQuery['entity'][getCostingQuery.currentRow]#</cfoutput></Data>
            </Cell>
          </Row>
        </cfloop>
        <Row ss:AutoFitHeight="0" ss:Height="12"/>
      </Table>
      <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
        <Unsynced/>
        <Print>
          <ValidPrinterInfo/>
          <Scale>60</Scale>
          <HorizontalResolution>600</HorizontalResolution>
          <VerticalResolution>600</VerticalResolution>
        </Print>
        <Selected/>
        <Panes>
          <Pane>
            <Number>3</Number>
            <ActiveRow>20</ActiveRow>
            <ActiveCol>3</ActiveCol>
          </Pane>
        </Panes>
        <ProtectObjects>False</ProtectObjects>
        <ProtectScenarios>False</ProtectScenarios>
      </WorksheetOptions>
    </Worksheet>
  </Workbook>
  </cfxml>
  <cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\CostingReport.xls" output="#tostring(data)#" charset="utf-8">
  <cfheader name="Content-Disposition" value="inline; filename=#dts#_CostingReport_#huserid#.xls">
  <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\CostingReport.xls">
  </cfcase>
</cfswitch>
