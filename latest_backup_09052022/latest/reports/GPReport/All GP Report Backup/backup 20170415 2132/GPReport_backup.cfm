<cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' >
<cfsetting requesttimeout="0" >
<!-- QUERY FOR placement no--->
<cfquery name="getGP" datasource="#dts#">
SELECT *,(t2.sale - t2.pay - t2.epf - t2.socso - t2.Oth) as GP,
	CASE WHEN ROUND(((t2.sale - t2.pay - t2.epf - t2.socso - t2.Oth)/t2.sale) * 100,2) IS NULL THEN 0 ELSE
	 ROUND(((t2.sale - t2.pay - t2.epf - t2.socso - t2.Oth)/t2.sale) * 100,2) END
	 as GPPercent FROM (
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
		 '' as level,
		 REPLACE(p.custname,'&','&amp;') as custname,
		 REPLACE(p.empname,'&','&amp;') as empname,
		 a.selfsalaryhrs as totalHours,
		 p.placementno as `job`,
		 p.startdate,
		 p.completedate,
		 REPLACE(p.position,'&','&amp;') as `jobSkill`,
		 CASE WHEN p.jostatus = 1 THEN 'NEW'
		 WHEN p.jostatus = 2 THEN 'RENEW'
		 ELSE 'REPLACE' END as orderStatus,
		 (SELECT CASE WHEN Country_Code_address = 'MY' THEN 'local' ELSE 'Foreigner' END FROM manpower_p.pmast WHERE empno = p.empno) as 'candidateType',
		 p.empno,
		 invoiceno as INV,
		 (SELECT SUM(amt) FROM manpower_i.ictran WHERE brem6 = a.refno
		 AND (void ='' OR void IS NULL)
		 ) as SALE,
		 a.selftotal as Pay,
		 a.custcpf as EPF,
		 a.custsdf as SOCSO,
		 0 as Oth
		 FROM manpower_i.assignmentslip a left join manpower_i.placement p
		on a.placementno = p.placementno
		 WHERE 1 =1 AND batches != ""
						<cfif form.customer neq '' >
						AND p.custno = #form.customer#
						</cfif>
						<cfif form.dateFrom neq '' >
						AND a.assignmentslipdate >= '#form.dateFrom#'
						</cfif>
						<cfif form.dateTo neq '' >
						AND a.assignmentslipdate <= '#form.dateTo#'
						</cfif>
						<cfif form.placementNoFrom neq ''>
						AND placementno >= #form.placementNoFrom#
						</cfif>
						<cfif form.placementNoTo neq ''>
						AND placementno <= #form.placementNoTo#
						</cfif>
						<cfif form.periodFrom neq ''>
						AND a.payrollperiod >= #form.periodFrom#
						</cfif>
						<cfif form.periodTo neq ''>
							And a.payrollperiod <= #form.periodTo#
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

	<cfscript>
					sumHours = 0;
					sumSales = 0;
					sumPay = 0;
					sumEPF = 0;
					sumSOCSO = 0;
					sumOth = 0;
					sumGP = 0;
					sumGPPercent = 0;
		</cfscript>
<cfset colList = getGP.columnList >
<!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
<cfxml variable="data">
	<cfinclude template="/excel_template/excel_header.cfm">
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

		<cfloop query="#getGP#" >
			<cfscript>
						sumHours += getGP.totalHours;
						sumSales += getGP.SALE;
						sumPay += getGP.PAY;
						sumEPF += getGP.EPF;
						sumSOCSO += getGP.SOCSO;
						sumOth = getGP.Oth;
						sumGP = getGP.GP;
						sumGPPercent = getGP.GPPercent;
						data = [
							getGP.branch,
							getGP.type,
							getGP.consultant,
							getGP.custno,
							getGP.level,
							getGP.custname,
							getGP.empname,
							getGP.totalHours,
							getGP.job,
							dateFormat(getGP.startdate,"YYYY-MM-DD"),
							dateFormat(getGP.completedate,"YYYY-MM-DD"),
							getGP.jobskill,
							getGP.orderstatus,
							getGP.candidatetype,
							getGP.inv,
							getGP.SALE,
							getGP.PAY,
							getGP.EPF,
							getGP.SOCSO,
							getGP.Oth,
							getGP.GP,
							getGP.GPPercent
						];
					</cfscript>
			<Row>
				<cfloop array="#data#" index="field">
					<Cell>
						<Data ss:Type="String">
							<cfoutput>
								#field#
							</cfoutput>
						</Data>
					</Cell>
				</cfloop>
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
					<!---- SPACING ------>
					<cfloop from='1' to="7" index='i'>
						<Cell>
							<Data ss:Type="String">
							</Data>
						</Cell>
					</cfloop>
					<Cell>
						<Data ss:Type="String">
							<cfoutput>
								#sumHours#
							</cfoutput>
						</Data>
					</Cell>
					<!---- SPACING ------>
					<cfloop from='1' to="8" index='i'>
						<Cell>
							<Data ss:Type="String">
							</Data>
						</Cell>
					</cfloop>
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
	<cfinclude template="/excel_template/excel_footer.cfm">
</cfxml>
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\GP_Report.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=#dts#GP_Report#huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\GP_Report.xls">
