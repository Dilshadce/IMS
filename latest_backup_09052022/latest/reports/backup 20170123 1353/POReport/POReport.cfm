<!---  SETUP HRootPATH for testing environment
<cfset HRootPath = "c:/inetpub/wwwroot/IMS/" />
--->

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
<cfquery name="getPlacementDetailsQuery" datasource="#dts#">
    SELECT
        p.location as branch,
        p.po_no as PO,
        p.empname as candidate,
        p.custno as clientID,
        p.custname as company,
        (SELECT username FROM payroll_main.hmusers where entryID = p.hrmgr)as `Hiring Mgr`,
        (SELECT name FROM manpower_i.arcust WHERE custno = p.custno) as `Billing name`,
        p.department as `Order Dept`,
        p.placementNO as JO,
        p.startDate as `StartDate`,
        p.completedate as EndDate,
        CONCAT(YEAR(p.completedate),i.fperiod) as `Acc Period`,
        i.desp as `Bill Item`,
        i.QTY_Bil as `Bill Qty`,
        i.QTY_BIL * i.amt_bil as `Bill Rate`,
        i.amt_bil as `Bill Amount`,
        i.qty as `Pay Qty`,
        (i.qty * i.amt) as `Pay Rate`,
        i.amt as `Pay Amount`,
        (CASE WHEN i.note_a != 'OS' THEN TRUE ELSE FALSE END)  as Taxable,
      	i.taxpec1 as `tax%`,
        i.taxamt as `GST Amount`,
        i.taxamt + i.amt as `Total With GST`,
        a.invoiceNo as `Invoice No` ,
        DATE_ADD(a.assignmentslipdate,INTERVAL (SELECT term FROM manpower_i.artran WHERE a.invoiceno = artran.refno LIMIT 1) MONTH) as `invoiceDue`,
 		a.assignmentslipdate as `invoiceIssue`,
        i.note1 as `Timesheet Remarks`
    FROM
    	manpower_i.ictran i
    	LEFT JOIN manpower_i.assignmentslip a ON i.refNo = a.invoiceno
    	LEFT JOIN manpower_i.placement p ON a.placementno = p.placementno
    WHERE 1 =1
	<cfif form.PLACEMENTNOFROM neq "">
    	AND a.placementno >= #form.PLACEMENTNOFROM#
    </cfif>
    <cfif #form.customerFrom# neq "">
    	AND p.custno = #form.customerFrom#
    </cfif>
    <cfif #form.PLACEMENTNOTO# neq "">
    	AND a.placementno <= #form.PLACEMENTNOTO#
    </cfif>
    <cfif #form.periodFrom# neq "">
    	AND i.fperiod >= #form.periodFrom#
    </cfif>
    <cfif #form.periodTo# neq "">
    	AND i.fperiod <= #form.periodTo#
    </cfif>


    ORDER by i.refno ASC,i.trancode ASC;

</cfquery>
<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">
		<!-- ============ SETTING table headers for excel file ==================== --->
		<cfset headerFields = [
			"Branch",
			"PO",
			"Candidate",
			"ClientID",
			"Company",
			"Hiring Mgr",
			"Billing name",
			"Order Dept",
			"JO",
			"StartDate",
			"EndDate",
			"Acc Period",
			"Bill Item",
			"Bill Qty",
			"Bill Rate",
			"Bill Amount",
			"Pay Qty",
			"Pay Rate",
			"Pay Amount",
			"Taxable",
			"Tax%",
			"GST Amount",
			"Total With GST",
			"Invoice No",
			"Invoice Issue",
			"Invoice Due",
			"Timesheet Remarks"
			] />
		<cfset colList = getPlacementDetailsQuery.columnList >
		<cfset tempInvoiceNo = getPlacementDetailsQuery['invoice no'][1] >
		<cfset totalBillAmount = 0>
		<cfset totalPayAmount = 0 >
		<cfset totalGSTAmount = 0>
		<cfset totalWithGST = 0 >
		<!--- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
		<!--- ===============================================================================  --->
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
									<Data ss:Type="String">
										<cfoutput>
											#field#
										</cfoutput>
									</Data>
								</Cell>
							</cfloop>
						</Row>

						<cfloop query="getPlacementDetailsQuery" >
							<!---   ======================================  CHECK IF THE POINTER IS REFERING TO THE SAME INVOICENO==========================================================================--->
							<cfif tempInvoiceNo neq #getPlacementDetailsQuery["invoice no"][getPlacementDetailsQuery.currentRow]# >
								<Row>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#getPlacementDetailsQuery['candidate'][getPlacementDetailsQuery.currentRow-1]#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#getPlacementDetailsQuery['JO'][getPlacementDetailsQuery.currentRow - 1]#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#dateformat(getPlacementDetailsQuery['startdate'][getPlacementDetailsQuery.currentRow -1 ],"YYYY-mm-dd")#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#dateformat(getPlacementDetailsQuery['enddate'][getPlacementDetailsQuery.currentRow -1 ],"YYYY-mm-dd")#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalBillAmount#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalPayAmount#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalGSTAmount#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalWithGST#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#getPlacementDetailsQuery['invoice no'][getPlacementDetailsQuery.currentRow -1 ]#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
								</Row>
								<cfset tempInvoiceNo = #getPlacementDetailsQuery["invoice no"][getPlacementDetailsQuery.currentRow ]# >
								<cfset totalBillAmount = 0>
								<cfset totalPayAmount = 0 >
								<cfset totalGSTAmount = 0>
								<cfset totalWithGST = 0 >
							</cfif>
							<cfset totalBillAmount = totalBillAmount + getPlacementDetailsQuery['Bill Amount'][getPlacementDetailsQuery.currentRow] />
							<cfset totalPayAmount = totalPayAmount + getPlacementDetailsQuery['Pay Amount'][getPlacementDetailsQuery.currentRow]  />
							<cfset totalGSTAmount = totalGSTAmount + getPlacementDetailsQuery['GST Amount'][getPlacementDetailsQuery.currentRow] />
							<cfset totalWithGST = totalWithGST + getPlacementDetailsQuery['Total With GST'][getPlacementDetailsQuery.currentRow] />
							<Row>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['branch'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['PO'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Candidate'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['ClientID'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Company'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Hiring Mgr'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Billing name'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Order Dept'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['JO'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#dateformat(getPlacementDetailsQuery['StartDate'][getPlacementDetailsQuery.currentRow],'YYYY-mm-dd')#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#dateformat(getPlacementDetailsQuery['EndDate'][getPlacementDetailsQuery.currentRow],'YYYY-mm-dd')#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Acc Period'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Bill Item'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Bill Qty'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Bill Rate'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Bill Amount'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Pay Qty'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Pay Rate'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Pay Amount'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Taxable'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Tax%'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['GST Amount'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Total With GST'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Invoice No'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#dateformat(getPlacementDetailsQuery['invoiceIssue'][getPlacementDetailsQuery.currentRow],'YYYY-mm-dd')#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#dateformat(getPlacementDetailsQuery['invoiceDue'][getPlacementDetailsQuery.currentRow],'YYYY-mm-dd')#
										</cfoutput>
									</Data>
								</Cell>
								<Cell>
									<Data ss:Type="String">
										<cfoutput>
											#getPlacementDetailsQuery['Timesheet Remarks'][getPlacementDetailsQuery.currentRow]#
										</cfoutput>
									</Data>
								</Cell>
							</Row>

							<!--- checking if the pointer reaches the last row --->
							<cfif #getPlacementDetailsQuery.currentrow# eq #getPlacementDetailsQuery.recordcount# >
								<Row>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#getPlacementDetailsQuery['candidate'][getPlacementDetailsQuery.currentRow-1]#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#getPlacementDetailsQuery['JO'][getPlacementDetailsQuery.currentRow - 1]#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#dateformat(getPlacementDetailsQuery['startdate'][getPlacementDetailsQuery.currentRow -1 ],"YYYY-mm-dd")#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#dateformat(getPlacementDetailsQuery['enddate'][getPlacementDetailsQuery.currentRow -1 ],"YYYY-mm-dd")#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalBillAmount#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalPayAmount#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalGSTAmount#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#totalWithGST#
											</cfoutput>
										</Data>
									</Cell>
									<Cell ss:StyleID="s38">
										<Data ss:Type="String">
											<cfoutput>
												#getPlacementDetailsQuery['invoice no'][getPlacementDetailsQuery.currentRow -1 ]#
											</cfoutput>
										</Data>
									</Cell>
									<Cell>
									</Cell>
									<Cell>
									</Cell>
								</Row>
								<cfset tempInvoiceNo = #getPlacementDetailsQuery["invoice no"][getPlacementDetailsQuery.currentRow ]# >
								<cfset totalBillAmount = 0>
								<cfset totalPayAmount = 0 >
								<cfset totalGSTAmount = 0>
								<cfset totalWithGST = 0 >
							</cfif>
						</cfloop>
						<Row ss:AutoFitHeight="0" ss:Height="12"/>
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
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\POTracker.xls" output="#tostring(data)#" charset="utf-8">
		<cfheader name="Content-Disposition" value="inline; filename=#dts#_POTracker_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\POTracker.xls">
		<!-- ===============================================================================  --->
	</cfcase>
</cfswitch>
