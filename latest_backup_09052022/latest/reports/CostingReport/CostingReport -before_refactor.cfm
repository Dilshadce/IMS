<!---
	<cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' >
	--->
<cfsetting requesttimeout="0" >
<!-- QUERY FOR placement no--->
<cfquery name="getCostingQuery" datasource="#dts#">
  select a.custno,p.location,a.custtotalgross,a.paymenttype,a.custsalaryhrs,a.custsalaryday, a.workd,custusualpay,a.branch as entity,
(SELECT attn from manpower_i.address where custno = p.custno) as request,
REPLACE(p.department,"&","&amp;") as dept,
p.po_no,
REPLACE(a.empname,"&","&amp;") as `staffname`,
a.placementno as JO,
(SELECT MONTH(wos_date) from manpower_i.artran where refno = a.invoiceno limit 1) as billingMth, invoiceno,
a.startdate,
a.fixawcode1,a.fixawcode2,a.fixawcode3, a.fixawcode4, a.fixawcode5,a.fixawcode6,
a.fixawer1, a.fixawer2,a.fixawer3,a.fixawer4, a.fixawer5,a.fixawer6,
a.custsalary,a.custtotal,a.adminfee,a.custcpf,a.custsdf,
CASE WHEN billitem1 = '17' then billitemamt1
when billitem2 = '17' then billitemamt2
when billitem3 = '17' then billitemamt3
when billitem4 = '17' then billitemamt4
when billitem5 = '17' then billitemamt5
when billitem6 = '17' then billitemamt6
else 0 end as medical,
billitem1,billitemamt1,
billitem2,billitemamt2,
billitem3,billitemamt3,
billitem4,billitemamt4,
billitem5,billitemamt5,
billitem6,billitemamt6,
<cfloop from='1' to='8' index='i'>
custot#i#, custothour#i#,
</cfloop>
<cfloop from='1' to='4' index='i'>
a.billitem#i#,a.billitemamt#i#,
</cfloop>
<cfloop from='1' to='18' index='i'>
a.allowance#i#,a.awer#i#,a.allowancedesp#i#,
</cfloop>
a.completedate
 from manpower_i.assignmentslip a left join manpower_i.placement p on a.placementno = p.placementno
where 1 =1

<cfif form.customerFrom neq ''>
	AND a.custno >= "#form.customerFrom#"
</cfif>
<cfif form.customerTo neq ''>
	AND a.custno <=  "#form.customerTo#"
</cfif>
<cfif form.placementNoFrom neq ''>
	AND a.placementno >= "#form.placementNoFrom#"

</cfif>
<cfif form.placementNoTo neq ''>
	AND a.placementno <= "#form.placementNoTo#"
</cfif>
<cfif form.periodFrom neq ''>
	AND a.payrollperiod >= "#form.periodFrom#"
</cfif>
<cfif form.periodTo neq ''>
	AND a.payrollperiod <= "#form.periodTo#"
</cfif>

<cfif form.dateFrom neq ''>
	AND a.assignmentslipdate >= "#form.dateFrom#"
</cfif>
<cfif form.dateTo neq ''>
	AND a.assignmentslipdate <= "#form.dateTo#"
</cfif>

ORDER BY a.empno
</cfquery>
<cfdump var = #getCostingQuery#>
<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">
		<!-- ============ SETTING table headers for excel file ==================== --->
		<cfset headerFields = [
			"Client ID", "Office Code", "Request", "Dept", "PO",
			"Staff name","JO","Billing Mth","Invoice No","Start Date",
			"End Date","Basic Salary","No Month Work","Salary","Admin Fee",
			"EPF","SOCSO","Medical","Sub-total","",
			"","","",
			"OT1.5(QTY)","OT1.5(RM)",
			"OT2.0(QTY)","OT2.0(RM)",
			"OT3.0(QTY)","OT3.0(RM)",
			"RD2.0(QTY)","RD2.0(RM)",
			"PH2.0(QTY)","PH2.0(RM)",
			"OT Sub-total",
			"Housing Allowance","Fixed Alowance","Var. Allowance",
			"Night Shift Allowance","Auto Allowance",
			"Reimb Claim","Bonus","KPI",
			"AL in Lieu","UPL","Notice in Lieu","Disbursement","","Outsource Fee","Other Admin Fee",
			"Work Permit","Recruitment Fee","SOCSO OT","Day Shift Allowance",
			"Language Allowance","Pay Adjustment","OT Adjustment",
			"Taxable","Non Taxable","GST 6%","Total","Entity"
			] />
		<cfset colList = getCostingQuery.columnList >
		<!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
		<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
				<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
					<Author>
						Netiquette Technology
					</Author>
					<LastAuthor>
						Netiquette Technology
					</LastAuthor>
					<Company>
						Netiquette Technology
					</Company>
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
					<Style ss:ID="s66">
						<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
						<Font ss:FontName="Arial" x:Family="Swiss" ss:Bold="1"/>
						<NumberFormat ss:Format="Fixed"/>
					</Style>
					<Style ss:ID="s65">
						<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
						<Font ss:FontName="Arial" x:Family="Swiss"/>
						<NumberFormat ss:Format="Fixed"/>
					</Style>
				</Styles>
				<Worksheet ss:Name="Costing Report">
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
									<Data ss:Type="String">
										<cfoutput>
											#field#
										</cfoutput>
									</Data>
								</Cell>
							</cfloop>
						</Row>
						<cfset subtotal2 = 0>
						<cfset grandTotal = 0>
						<cfloop query="getCostingQuery" >
							<cfset OTTotal = getCostingQuery.custot2 + getCostingQuery.custot3 + getCostingQuery.custot4 + getCostingQuery.custot6 + getCostingQuery.custot8  />
							<cfset subtotal1 = getCostingQuery.custsalary + getCostingQuery.adminfee + getCostingQuery.custcpf + getCostingQuery.custsdf + getCostingQuery.medical />
							<cfscript>

								if(getCostingQuery.paymenttype == "hr"){
									noMonthWork = numberFormat(getCostingQuery.custsalaryhrs,'.__');

								}else if(getCostingQuery.paymenttype == "day"){
									noMonthWork = numberFormat(getCostingQuery.custsalaryday,'.__');

								}else{
									noMonthWork = numberFormat( getCostingQuery.workd != 0 ? ROUND((val(getCostingQuery.custsalaryday)/val(getCostingQuery.workd)) * 100000) / 100000  : 1);
								}

								if(getCostingQuery.entity == "MSS"){
									nonTaxableAllowances = [52,3,5,48,32,9,72,14,19,
												  13,33,18,43,4,42,47,75,11,
												  12];
									taxableAllowances = [86,6,17];

									taxable = getCostingQuery.adminfee;
									nonTaxable = subtotal1 + OTTotal - getCostingQuery.adminfee - getCostingQuery.medical;

								}else{
									nonTaxableAllowances = [];
									taxableAllowances = [];

									taxable = getCostingQuery.custtotalgross;
									nonTaxable = 0 ;

								}

								for(i = 1; i <= ArrayLen(taxableAllowances); i = i +1 ){
										taxable = taxable + findItem(taxableAllowances[i],getCostingQuery);
								}

								for(i = 1; i <= ArrayLen(nonTaxableAllowances); i = i +1 ){
										nonTaxable = nonTaxable + findItem(nonTaxableAllowances[i],getCostingQuery);
								}

								subtotal2 += subtotal1;

							</cfscript>
							<cfset gst  = numberFormat(taxable * 0.06,'.___')>
							<cfset grandTotal += numberFormat((taxable + nonTaxable + gst),'.__')>
							<cfset billingMonth = getCostingQuery.billingMth eq '' ? '' : MonthAsString(getCostingQuery.billingMth) >
							<cfset
								fieldValues = [
								getCostingQuery.custno,
								getCostingQuery.location,
								getCostingQuery.request,
								getCostingQuery.dept,
								getCostingQuery.po_no,
								getCostingQuery.staffName,
								getCostingQuery.JO,
								billingMonth,
								getCostingQuery.invoiceno,
								DateFormat(getCostingQuery.startdate,"YYYY-mm-dd"),
								DateFormat(getCostingQuery.completedate,"YYYY-mm-dd"),
								getCostingQuery.custusualpay,
								noMonthWork,custsalary,
								getCostingQuery.adminfee,
								getCostingQuery.custcpf,
								getCostingQuery.custsdf,
								getCostingQuery.medical,
								subtotal1,"",
								"", "", "",
								getCostingQuery.custothour2, getCostingQuery.custot2,
								getCostingQuery.custothour3, getCostingQuery.custot3,
								getCostingQuery.custothour4, getCostingQuery.custot4,
								getCostingQuery.custothour6, getCostingQuery.custot6,
								getCostingQuery.custothour8, getCostingQuery.custot8,
								OTTotal,
								findItem(52,getCostingQuery),
								findItem(3,getCostingQuery),
								findItem(5,getCostingQuery),
								findItem(48,getCostingQuery),
								findItem(32,getCostingQuery),
								findItem(6,getCostingQuery),
								findItem(9,getCostingQuery),
								findItem(72,getCostingQuery),
								findItem(14,getCostingQuery),
								findItem(19,getCostingQuery),
								findItem(13,getCostingQuery),
								findItem(33,getCostingQuery),
								"",
								findItem(18,getCostingQuery),
								findItem(86,getCostingQuery),
								findItem(43,getCostingQuery),
								findItem(4,getCostingQuery),
								findItem(42,getCostingQuery),
								findItem(47,getCostingQuery),
								findItem(75,getCostingQuery),
								findItem(11,getCostingQuery),
								findItem(12,getCostingQuery),
								taxable,
								nonTaxable,
								gst,
								numberFormat((taxable + nonTaxable + gst),'.__'),
								getCostingQuery.entity
								] />
							<Row>
								<cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
										<Cell>
											<Data ss:Type="String">
												<cfoutput>
													#fieldValues[i]#
												</cfoutput>
											</Data>
										</Cell>

								</cfloop>
							</Row>
						</cfloop>
						<Row>
							<cfloop from="1" to="58" index="i">
								<Cell>
									<Data ss:Type="String">
									</Data>
								</Cell>
							</cfloop>
							<Cell>
								<Data ss:Type="String">
									Total :
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#grandTotal#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
							</Cell>
						</Row>
						<Row ss:AutoFitHeight="0" ss:Height="12">
						</Row>
					</Table>
					<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
						<Unsynced/>
						<Print>
							<ValidPrinterInfo/>
							<Scale>
								60
							</Scale>
							<HorizontalResolution>
								600
							</HorizontalResolution>
							<VerticalResolution>
								600
							</VerticalResolution>
						</Print>
						<Selected/>
						<Panes>
							<Pane>
								<Number>
									3
								</Number>
								<ActiveRow>
									20
								</ActiveRow>
								<ActiveCol>
									3
								</ActiveCol>
							</Pane>
						</Panes>
						<ProtectObjects>
							False
						</ProtectObjects>
						<ProtectScenarios>
							False
						</ProtectScenarios>
					</WorksheetOptions>
				</Worksheet>
			</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\CostingReport.xls" output="#tostring(data)#" charset="utf-8">
		<cfheader name="Content-Disposition" value="inline; filename=#dts#_CostingReport_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\CostingReport.xls">
	</cfcase>
</cfswitch>
<cfscript>
	function findItem(value, row){
		var limit = 18;
		var valPrefix = "awer";
		var prefix = "allowance";
		var allowance_amt = 0;
		 for(var i = 1; i < limit; i = i+1){
		 	if(row[prefix&i][row.currentRow] == value){
		 		allowance_amt += row[valPrefix&i][row.currentRow];

		 	}
		 }

		limit = 6;
		valPrefix = "fixawer";
		prefix = "fixawcode";
		var fixAW_amt = 0;

		 for(var i = 1; i < limit; i = i+1){
		 	if(row[prefix&i][row.currentRow] == value){
		 		fixAW_amt += row[valPrefix&i][row.currentRow];

		 	}
		 }

		 limit = 6;
		valPrefix = "billitemamt";
		prefix = "billitem";
		var bill_amt = 0;

		 for(var i = 1; i < limit; i = i+1){
		 	if(row[prefix&i][row.currentRow] == value){
		 		bill_amt += row[valPrefix&i][row.currentRow];

		 	}
		 }

		 return fixAW_amt + allowance_amt + bill_amt;
	}

</cfscript>
