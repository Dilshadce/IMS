 <!--- <cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' > --->
<cfsetting requesttimeout="0" >
<cfset dsname = "#replace(dts,'_i','_p')#">
<cfquery datasource="#dsname#">
	SET SESSION binlog_format = 'MIXED';
</cfquery>
<!--- QUERY FOR placement no--->
<cfquery name="getComp_qry" datasource="payroll_main">
	SELECT * FROM gsetup WHERE comp_id = "#rereplace(HcomID,'_i','')#"
</cfquery>
<cfquery datasource="#dsname#">
	drop table if exists #dsname#.pay12_m_statutory;
</cfquery>
<cfquery datasource="#dsname#">
	create table  pay12_m_statutory as (
select TMONTH,empno,
SUM(EPFCC) as EPFCC,
SUM(EPFCC_ADJUSTMENT) as EPFCC_ADJUSTMENT,
SUM(EPFWW) as EPFWW,
SUM(EPFWW_ADJUSTMENT) AS EPFWW_ADJUSTMENT,
CASE WHEN SUM(SOCSOWW) > 19.75 then 19.75 ELSE SUM(SOCSOWW) END as SOCSOWW,
SUM(ded115) as ded115,
CASE WHEN SUM(SOCSOCC) > 69.05 then 69.05 ELSE SUM(SOCSOCC) END as SOCSOCC from (
select * FROM pay1_12m_fig
where TMONTH = "#form.period#"
union select * FROM pay2_12m_fig where TMONTH = "#form.period#") t group by empno,TMONTH) ;
</cfquery>
<cfif form.period eq getComp_qry.mmonth>
	<cfset p_table = "#dsname#.pay_tm WHERE empno = a.empno ">
<cfelse>
	<cfset p_table = "#dsname#.pay12_m_statutory WHERE TMONTH = #form.period# and empno = a.empno ">
</cfif>

<cfoutput>
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
	case when EPF is null then 0 else epf end as epf
	<!--- EPF --->,
	case when EPFCC_ADJUSTMENT is null then 0 else EPFCC_ADJUSTMENT end as EPFCC_ADJUSTMENT,
	case when socso is null then 0 else socso end as socso
	<!--- SOCSO --->,
	case when oth is null then 0 else oth end as oth

	FROM (
		 SELECT
		 p.location as branch,
		 (SELECT type1 FROM #dts#.chartofaccount WHERE type1_id = p.jobpostype LIMIT 1) as 'type',
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
		 (SELECT CASE WHEN national = 'MY' THEN 'local' ELSE 'Foreigner' END FROM #dsname#.pmast WHERE empno = p.empno) as 'candidateType',

		 invoiceno as INV,
		 a.empno as empno,
		 a.custtotalgross as SALE,
		 a.selftotal +
		 a.selfsdf + a.selfcpf
		 <cfloop from="1" to="18" index="i">
		 - case when a.allowancedesp#i# like '%deposit deduction%' then a.awee#i# else 0 end
		 - case when a.allowancedesp#i# like '%advance pay%' then a.awee#i# else 0 end
		 </cfloop>

		 <cfloop from="1" to="6" index="i">
			 <cfif #i# eq 1>
		 		- case when a.addchargedesp like '%+med benefit reimburse%' then a.addchargeself else 0 end
		 	 <cfelse>
		 	 	- case when a.addchargedesp#i# like '%+med benefit reimburse%' then a.addchargeself#i# else 0 end
		 	 </cfif>
		 </cfloop>
		 <!--- +
		 case when ded1desp LIKE "%CP38%" OR ded1desp LIKE "%LHDN%" THEN ded1 ELSE 0 end ---> as Pay,
		 (SELECT EPFCC FROM #p_table#) as EPF
		 <!--- a.custcpf as EPF --->,
		 (SELECT SOCSOCC FROM #p_table#) as SOCSO
		 <!--- a.custsdf as SOCSO --->,
		 (SELECT EPFCC_ADJUSTMENT FROM #p_table#) as EPFCC_ADJUSTMENT,
		 0 as Oth
		 FROM #dts#.assignmentslip a left join #dts#.placement p
		 on a.placementno = p.placementno
		 WHERE 1 =1 <!--- AND batches != "" --->
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
						<cfif form.period neq ''>
						AND a.payrollperiod = '#form.period#'
						</cfif>

				) t ORDER BY empno
				) t2


</cfquery>
</cfoutput>
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
	"EPF_ADJUSTMENT",
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
					sumEPF_adjustment = 0;
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
					if(getGP.currentRow > 1){
						if(getGP['empno'][getGP.currentRow] == getGP['empno'][getGP.currentRow -1]){
							getGP.EPF = 0;
							getGP.EPFCC_ADJUSTMENT = 0;
							getGP.SOCSO = 0;
						}
					}
						sumHours += getGP.totalHours;
						sumSales += getGP.SALE;
						sumPay += getGP.PAY;
						sumEPF += getGP.EPF;
						sumEPF_adjustment += getGP.EPFCC_ADJUSTMENT;
						sumSOCSO += getGP.SOCSO;
						sumOth = getGP.Oth;
						sumGP += getGP.SALE - getGP.PAY - getGP.EPF-getGP.SOCSO-getGP.Oth;
						if(getGP.SALE > 0){
							C_GPPercent = (getGP.SALE - getGP.PAY - getGP.EPF-getGP.SOCSO-getGP.Oth) / getGP.SALE;


						}else{
							C_GPPercent = 0;
						}
						sumGPPercent += C_GPPercent;
						data = [
							getGP.branch,
							getGP.type,
							getGP.consultant,
							getGP.custno,
							getGP.level,
							getGP.custname,
							getGP.empno,
							getGP.totalHours,
							getGP.job,
							dateFormat(getGP.startdate,"YYYY-MM-DD"),
							dateFormat(getGP.completedate,"YYYY-MM-DD"),
							getGP.jobskill,
							getGP.orderstatus,
							getGP.candidatetype,
							getGP.empname,
							getGP.inv,
							getGP.SALE,
							getGP.PAY,
							getGP.EPF,
							getGP.EPFCC_ADJUSTMENT,
							getGP.SOCSO,
							getGP.Oth,
							getGP.SALE - getGP.PAY - getGP.EPF-getGP.SOCSO-getGP.Oth,
							C_GPPercent
						];
					</cfscript>
			<Row>
				<cfloop from='1' to='#ArrayLen(data)#' index="i">
					<Cell>
						<Data ss:Type="String">
							<cfoutput>
								#data[i]#
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
								#sumEPF_adjustment#
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
				<Row>
				</Row>
				<cfset sumHours = 0>
				<cfset sumSales = 0>
				<cfset sumPay = 0>
				<cfset sumEPF = 0>
				<cfset sumEPF_adjustment = 0>
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
