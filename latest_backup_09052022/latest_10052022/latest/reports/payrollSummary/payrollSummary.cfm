<cfif CGI.SERVER_NAME eq "ims.man" >
	<cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' >
</cfif>
<cfscript>

	sumFields = ['selfsalary','selfexception',
				 'selfcpf','selfsdf','selftotal',
				 'custcpf','custsdf',
				 "lvltotalee1"
				 ];

	OTFields = [];
	deductionFields = [];
	varAllowanceFields = [];
	fixAllowanceFields = [];

	// OT fields
	for(i = 1 ; i <= 8; i = i+1){
		ArrayAppend(OTFields,"selfOT"&i);
	}

	// fix fields
	for(i = 1 ; i <= 6; i = i+1){
		ArrayAppend(fixAllowanceFields,"fixawee"&i);
	}

	// var fields
	for(i = 1 ; i <= 18; i = i+1){
		ArrayAppend(varAllowanceFields,"awee"&i);
	}

	//deductions
	for(i=1; i<=3; i = i+1 ){
		ArrayAppend(deductionFields,"ded"&i);
	}

	sumFields.addAll(OTFields);
	sumFields.addAll(varAllowanceFields);
	sumFields.addAll(fixAllowanceFields);
	sumFields.addAll(deductionFields);

</cfscript>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT *
    FROM gsetup
</cfquery>

<cfset c_Period = getgsetup.Period>

<cfif getgsetup.Period eq form.period>
	<cfif form.type eq "Normal">
		<cfset table = "paytran">
	<cfelse>
		<cfset table = "paytra1">
	</cfif>
<cfelse>
	<cfif form.type eq "Normal">
		<cfset table = "manpower_p.pay1_12m_fig WHERE  TMONTH = #form.period#">
	<cfelse>
		<cfset table = "manpower_p.pay2_12m_fig WHERE  TMONTH = #form.period#">
	</cfif>
</cfif>

<cfquery name="getAssignment" datasource="#dts#">

	SELECT a.empno,a.empname,
	<cfloop array="#sumFields#" index="field">
		SUM(a.#field#) as #field#,
	</cfloop>
	a.selfCPF,a.selfSDF, a.selftotal,
	a.ded1,a.ded1desp,
	p.EPFCC,p.EPFWW,p.DED115 as tax,p.SOCSOWW,p.SOCSOCC
	from manpower_i.assignmentslip a
	LEFT JOIN
	(SELECT EPFCC,EPFWW,empno,DED115,SOCSOWW,SOCSOCC FROM #table# )p
	on a.empno = p.empno
	WHERE a.custno = "#form.customer#" and a.payrollperiod = '#form.period#'
	<cfif form.dateFrom neq ''>
		AND assignmentslipdate >= "#form.dateFrom#"
	</cfif>
	<cfif form.dateTo neq ''>
		AND assignmentslipdate <= "#form.dateTo#"
	</cfif>
	and batches != ""
	GROUP BY a.empno
	ORDER BY a.empno;
</cfquery>
<!-- ============ SETTING table headers for excel file ==================== --->
<cfset headerFields = [
	"EMPNO", "Name", "Wage","OT","NPL","Allowances","Gross","Deductions","EPF EE","EPF ER","SOCSO EE","SOCSO ER","CP38","WP39","TAX","Nett Wage"
	] />
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
		</Styles>
		<Worksheet ss:Name="payroll summary Report">
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
				<cfloop query="getAssignment" >
					<cfset OTTotal = getAssignment.selfot1 + getAssignment.selfot2 + getAssignment.selfot3 + getAssignment.selfot4 + getAssignment.selfot5 + getAssignment.selfot6  />
					<cfset grossWage = getAssignment.selfsalary + OTTotal />
					<cfif getAssignment.ded1desp eq "CP38">
						<cfset cp38 = getAssignment.ded1>
					<cfelse>
						<cfset cp38 = 0>
					</cfif>
					<cfscript>
						varAwTotal = 0;
						fixAwTotal = 0;
						dedTotal = 0;
						for(i =1; i <= ArrayLen(varAllowanceFields); i++){
								varAwTotal += getAssignment[varAllowanceFields[i]][getAssignment.currentRow];
						}
						for(i =1; i <= ArrayLen(fixAllowanceFields); i++){
								fixAwTotal += getAssignment[fixAllowanceFields[i]][getAssignment.currentRow];
						}
						for(i =1; i <= ArrayLen(deductionFields); i++){
								dedTotal += getAssignment[deductionFields[i]][getAssignment.currentRow];
						}

						grossWage = grosswage + varAwTotal + fixAwTotal;

					</cfscript>
					<cfset
						fieldValues =[
						getAssignment.empno, getAssignment.empname, getAssignment.selfsalary,
						OTTotal,getAssignment.lvltotalee1,varAwTotal + fixAwTotal,
						grossWage,dedTotal,
						getAssignment.EPFWW,
						getAssignment.EPFCC,
						getAssignment.SOCSOWW,
						getAssignment.SOCSOCC,
						cp38
						,"",getAssignment.tax,getAssignment.selftotal
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
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\payrollSummary.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=#dts#_payrollSummary_#huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\payrollSummary.xls">
