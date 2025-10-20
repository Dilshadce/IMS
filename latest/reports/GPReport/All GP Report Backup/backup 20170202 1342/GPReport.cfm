<!---
<cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' >
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
<cfset query_date = '2016-12-1'>
<cfquery name="getGP" datasource="#dts#">
SELECT *,(t2.sale - t2.pay - t2.epf - t2.socso - t2.Oth) as GP,
	0 as GPPercent FROM (
	SELECT branch,type,consultant,custno,level,custname,empname,job,startdate,completedate,jobskill,orderstatus,
	candidateType,empno,INV,
	CASE WHEN totalhours IS NULL THEN 0 ELSE totalhours end as totalhours,
	case when SALE is null then 0 ELSE sale end as sale,
	case when pay is null then 0 else pay end as pay,
	case when EPF is null then 0 else epf end as epf,
	case when socso is null then 0 else socso end as socso,
	case when oth is null then 0 else oth end as oth

	FROM (
			SELECT
				p.location as branch,
				(SELECT type1 FROM manpower_i.chartofaccount WHERE type1_id = p.jobpostype LIMIT 1) as 'type',
				p.consultant,
				p.custno,
				'TBD' as level,
				custname,
				empname,
				(SELECT selfsalaryhrs FROM manpower_i.assignmentslip WHERE placementno = p.placementno) as totalHours,
				placementno as `job`,
				startdate,
				completedate,
				p.position as `jobSkill`,
				CASE WHEN p.jostatus = 1 THEN 'NEW'
				    WHEN p.jostatus = 2 THEN  'RENEW'
				    ELSE 'REPLACE' END as orderStatus,
				(SELECT CASE WHEN Country_Code_address = 'MY' THEN 'local' ELSE 'Foreigner' END FROM manpower_p.pmast WHERE empno = p.empno) as 'candidateType',
				empno,
				(SELECT invoiceno from manpower_i.assignmentslip WHERE placementno = p.placementno) as INV,
				(SELECT SUM(amt) FROM manpower_i.ictran WHERE brem5 = p.empno
					<cfif form.dateFrom neq '' >
					AND MONTH(WOS_DATE) = MONTH('#dateformat(form.dateFrom,"YYYY-MM-DD")#')
					</cfif>
					<cfif form.dateTo neq '' >
					AND MONTH(WOS_DATE) = MONTH('#dateformat(form.dateTo,"YYYY-MM-DD")#')
					</cfif>
					) as SALE,
				(SELECT SUM(amt) FROM manpower_i.ictran WHERE brem5 = p.empno
					AND itemno IN ( '47','48','58','OT2','OT3',"Salary")
					<cfif form.dateFrom neq '' >
					AND MONTH(WOS_DATE) = MONTH('#dateformat(form.dateFrom,"YYYY-MM-DD")#')
					</cfif>
					<cfif form.dateTo neq '' >
					AND MONTH(WOS_DATE) = MONTH('#dateformat(form.dateTo,"YYYY-MM-DD")#')
					</cfif>
					) as Pay,
				(SELECT SUM(amt)
					FROM manpower_i.ictran
					WHERE brem5 = p.empno
					AND ITEMNO = 'EPF'
					<cfif form.dateFrom neq '' >
					AND MONTH(WOS_DATE) = MONTH('#dateformat(form.dateFrom,"YYYY-MM-DD")#')
					</cfif>
					<cfif form.dateTo neq '' >
					AND MONTH(WOS_DATE) = MONTH('#dateformat(form.dateTo,"YYYY-MM-DD")#')
					</cfif>
				) as EPF,
				(SELECT SUM(amt)
					FROM manpower_i.ictran
					WHERE brem5 = p.empno
					AND ITEMNO = 'SOCSO YER'
					<cfif form.dateFrom neq '' >
					AND MONTH(WOS_DATE) = MONTH('#form.dateFrom#')
					</cfif>
					<cfif form.dateTo neq '' >
					AND MONTH(WOS_DATE) = MONTH('#form.dateTo#')
					</cfif>
				) as SOCSO,
				(SELECT SUM(amt)
					FROM manpower_i.ictran
					WHERE brem5 = p.empno
					AND ITEMNO = '17'
					<cfif form.dateFrom neq '' >
					AND MONTH(WOS_DATE) = MONTH('#form.dateFrom#')
					</cfif>
					<cfif form.dateTo neq '' >
					AND MONTH(WOS_DATE) = MONTH('#form.dateTo#')
					</cfif>
				)  as Oth
				FROM manpower_i.placement p
				WHERE 1 =1

				<cfif form.customer neq '' >
				AND p.custno = #form.customer#
				</cfif>
				<cfif form.dateFrom neq '' >
				AND startdate >= '#form.dateFrom#'
				</cfif>
				<cfif form.dateTo neq '' >
				AND startdate <= '#form.dateTo#'
				</cfif>
				<cfif form.placementNoFrom neq ''>
				AND placementno >= #form.placementNoFrom#
				</cfif>
				<cfif form.placementNoTo neq ''>
				AND placementno <= #form.placementNoTo#
				</cfif>
		) t ORDER BY empno
		) t2


</cfquery>
<!-- ============ SETTING table headers for excel file ==================== --->
<cfset headerFields = [
	"Branch",
	"Type",
	"StaffCode",
	"ClientID",
	"Level",
	"Company",
	"Name",
	"Total Hour",
	"Job",
	"Start Date",
	"End date",
	"Job Skill",
	"Order Status",
	"Candidate Type",
	"Candidate No",
	"Inv",
	"SALE",
	"PAY",
	"EPF",
	"SOCSO",
	"Oth Burdens",
	"GP(RM)",
	"GP%"
	] />
<cfset colList = getGP.columnList >
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
		<Worksheet ss:Name="GPbyBranch-JobType Report">
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
				<cfset sumHours = 0>
				<cfset sumSales = 0>
				<cfset sumPay = 0>
				<cfset sumEPF = 0>
				<cfset sumSOCSO = 0>
				<cfset sumOth = 0>
				<cfset sumGP = 0>
				<cfset sumGPPercent = 0>
				<cfloop query="getGP" >
					<cfset sumHours = sumHours + #getGP['totalHours'][getGP.currentRow]#>
					<cfset sumSales = sumSales + #getGP['SALE'][getGP.currentRow]#>
					<cfset sumPay =  sumPay + #getGP['PAY'][getGP.currentRow]#>
					<cfset sumEPF =  sumEPF + #getGP['EPF'][getGP.currentRow]#>
					<cfset sumSOCSO =  sumSOCSO + #getGP['SOCSO'][getGP.currentRow]#>
					<cfset sumOth =  sumOth + #getGP['Oth'][getGP.currentRow]#>
					<cfset sumGP =  sumGP + #getGP['GP'][getGP.currentRow]#>
					<cfset sumGPPercent =  sumGPPercent + #getGP['GPPercent'][getGP.currentRow]#>
					<Row>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['branch'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['type'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['consultant'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['custno'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['level'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['custname'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['empname'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['totalHours'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['job'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#dateformat(getGP['startdate'][getGP.currentRow],'YYYY-MM-DD')#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#dateformat(getGP['completedate'][getGP.currentRow],'YYYY-MM-DD')#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['jobskill'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['orderstatus'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['candidateType'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['empno'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['inv'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['SALE'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['PAY'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['EPF'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['SOCSO'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['Oth'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['GP'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">
								<cfoutput>
									#getGP['GPPercent'][getGP.currentRow]#
								</cfoutput>
							</Data>
						</Cell>
					</Row>
					<cfset isNextRowSameCustomer = true>
					<cfif getGP.currentRow neq getGP.RecordCount>
						<cfif getGP['custno'][getGP.currentRow] neq getGP['custno'][getGP.currentRow +1]>
							<cfset isNextRowSameCustomer = false>
						</cfif>
					<cfelse>
						<cfset isNextRowSameCustomer = false>
					</cfif>
					<cfif isNextRowSameCustomer neq true>
						<Row>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumHours#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumSales#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumPay#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumEPF#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumSOCSO#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumOth#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumGP#
									</cfoutput>
								</Data>
							</Cell>
							<Cell>
								<Data ss:Type="String">
									<cfoutput>
										#sumGPPercent#
									</cfoutput>
								</Data>
							</Cell>
						</Row>
						<cfset sumHours = 0>
						<cfset sumSales = 0>
						<cfset sumPay = 0>
						<cfset sumEPF = 0>
						<cfset sumSOCSO = 0>
						<cfset sumOth = 0>
						<cfset sumGP = 0>
						<cfset sumGPPercent = 0>
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
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\GP_Report.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=#dts#GP_Report#huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\GP_Report.xls">
