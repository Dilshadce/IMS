
<cfsetting requesttimeout="0" >
<cfquery datasource="manpower_p">
	SET SESSION binlog_format = 'MIXED';
</cfquery>
<cfquery name="getPayroll" datasource="manpower_i">

	select custno,replace(custname,'&',"&amp;") as custname,empno,empname,selftotal + selfsdf + selfcpf as gross, selfsdf,selfcpf , selftotal as net,
	case when ded115 is null then 0 else ded115 end as ded115, selftotal - case when ded115 is null then 0 else ded115 end as payout
	FROM (
		select custno,custname,empno,empname,sum(selfsdf) as selfsdf, sum(selfcpf) as selfcpf,
		(SELECT SUM(funddd) from icgiro
			where batchno
			IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
			and empno = a.empno) as ded115,
		sum(selftotal) as selftotal
	 	from manpower_i.assignmentslip a where
	 	batches IN
	 	(<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
	 	 group by empno ) t1;
</cfquery>
<!-- ============ SETTING table headers for excel file ==================== --->
<cfset headerFields = [
	"custname",
	"custno",
	"empname",
	"empno",
	"Gross",
	"SOCSO",
	"EPF",
	"Nett before tax",
	"Tax",
	"Nett payout"
	] />
<!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
<cfxml variable="data">
	<cfinclude template="/excel_template/excel_header.cfm">
	<Worksheet ss:Name="payroll summary">
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
		<cfloop query="#getPayroll#">
			<cfoutput>
				<Row>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.custname#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.custno#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.empname#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.empno#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.gross#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.selfsdf#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.selfcpf#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.net#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.ded115#
						</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">
							#getPayroll.payout#
						</Data>
					</Cell>
				</Row>
			</cfoutput>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</Table>
	<cfinclude template="/excel_template/excel_footer.cfm">
</cfxml>
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\payrollsummaryreport.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=#dts#payrollsummaryreport#huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\payrollsummaryreport.xls">
