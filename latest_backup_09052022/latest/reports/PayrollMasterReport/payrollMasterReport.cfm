<!---<cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' > --->
<!-- QUERY FOR placement no--->
<cfquery name="getData" datasource="#dts#">
	select "business" as business,
		 (SELECT username FROM payroll_main.hmusers where entryID = p.hrmgr) as hrmgr,
		location as location,
		"" as accCode1,
		"" as accCode2,
		p.placementno as workOrder,
		"" as costCenter,
		a.empname,a.empname,
		DATE_FORMAT(p.startDate,'%d-%m-%Y') as `startdate`,
        DATE_FORMAT(p.completedate,'%d-%m-%Y') as completedate,
		a.custsalary,
		a.branch as entity, a.custot3,
		<cfloop from='1' to='6' index='i'>
		a.billitem#i#,a.billitemamt#i#,
		</cfloop>
		<cfloop from='1' to='18' index='i'>
		a.allowance#i#,a.awer#i#,a.allowancedesp#i#,
		</cfloop>
		a.fixawcode1,a.fixawcode2,a.fixawcode3, a.fixawcode4, a.fixawcode5,a.fixawcode6,
		a.fixawer1, a.fixawer2,a.fixawer3,a.fixawer4, a.fixawer5,a.fixawer6,
		adminfee,lvltotaler1,a.custtotalgross, custsdf,custcpf
		FROM manpower_i.assignmentslip a
		LEFT JOIN
		manpower_i.placement p
		on a.placementno = p.placementno
		where
		a.payrollperiod = "#form.periodFrom#"
		and
		a.custno = '#form.customer#'

</cfquery>
<!-- ============ SETTING table headers for excel file ==================== --->
<cfset headerFields = [
	"No",
	"Business Unit(Short)",
	"Hiring Manager",
	"Location Code",
	"Account Code1",
	"Account Code2",
	"Work Order Number",
	"Cost Center",
	"Staff Name",
	"Work Order Name",
	"Start Date",
	"End Date",
	"Salary",
	"Fixed Allow",
	"Med Insurance",
	"Admin Fee",
	"OT Adjustment",
	"OT2.0 (RM)",
	"Shift Allow",
	"Language Allow",
	"UPL",
	"Reimbursement",
	"Disbursement",
	"Pay Adj",
	"Misc",
	"Notice in Lieu",
	"AL in Liew",
	"Meal Allow",
	"Ex-Gratia",
	"Statutory Cost",
	"Non-taxable Amount",
	"Taxable Amount",
	"GST 6%",
	"Total",
	"",
	"Remarks"
	] />
<cfscript>
	sumFields = [];
	for(i =1; i<=22; i++){
		sumFields[i]=  0;
	}
</cfscript>
<!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
<cfxml variable="data">
	<cfinclude template="/excel_template/excel_header.cfm">
	<Worksheet ss:Name="payroll master Report">
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
		<cfloop query="#getData#" >
			<cfscript>
				taxable = 0;
				nonTaxable = 0;

				if(getData.entity == "MSS"){
					nonTaxableAllowances = [3,12,75,33,11,38,13,14,58,10];
					taxableAllowances = [86,6,17];

					taxable = getData.adminfee;
					nonTaxable = getData.custsalary + getData.custot3 + getData.lvltotaler1;//need to be set

				}else{
					nonTaxableAllowances = [];
					taxableAllowances = [];

					taxable = getData.custtotalgross;
					nonTaxable = 0 ;

				}

				for(i = 1; i <= ArrayLen(taxableAllowances); i = i +1 ){
						taxable = taxable + findItem(taxableAllowances[i],getData);
				}

				for(i = 1; i <= ArrayLen(nonTaxableAllowances); i = i +1 ){
						nonTaxable = nonTaxable + findItem(nonTaxableAllowances[i],getData);
				}

				gst = taxable * 0.06;

				data = [
					getData.currentRow,
					getData.business,
					getData.hrmgr,
					getData.location,
					getData.accCode1,
					getData.accCode2,
					getData.workOrder,
					getData.costCenter,
					getData.empname,
					getData.empname,
					getData.startdate,
					getData.completeDate

				];

				numberFields = [
					getData.custsalary,
					findItem(3,getData), //fixed
					findItem(17,getData), //med
					getData.adminfee + findItem(86,getData), // admin fee + var.admin fee
					findItem(12,getData),
					getData.custot3,
					'', // shift allowance leave it (RENU)
					findItem(75,getData), //language allowance,
					lvltotaler1,
					findItem(6,getData), // reimbursement
					findItem(33,getData), // disbursement
					findItem(11,getData), // pay adjusment
					findItem(38,getData),  // misc
					findItem(13,getData), // notice in lieu
					findItem(14,getData), // AL in lieu,
					findItem(58,getData), // meal
					findItem(10,getData), // ex-gratia
					val(custcpf) + val(custsdf),
					numberFormat(nonTaxable,'.__'),
					numberFormat(taxable,'.__'),
					gst,
					numberFormat(nonTaxable + taxable + gst , '.__')
				];
					</cfscript>
			<Row>
				<cfloop array="#data#" index="field">
					<Cell>
						<Data ss:Type="String"><cfoutput>#field#</cfoutput></Data>
					</Cell>
				</cfloop>
				<cfloop from='1' to="#ArrayLen(numberFields)#" index="i">
					<cfset sumFields[i] = val(sumFields[i]) + val(numberFields[i]) >
					<cfoutput>
						<Cell><Data ss:Type="Number">#val(numberFields[i])#</Data></Cell>
					</cfoutput>
				</cfloop>
			</Row>
		</cfloop>
		<cfscript>printTotal();</cfscript>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</Table>
	<cfinclude template="/excel_template/excel_footer.cfm">
</cfxml>
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\payroll_master.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=#dts#payroll_master#huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\payroll_master.xls">
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

function printTotal(){
	var row = "<Row>";
	for(var i = 0; i< 11; i++){
		row &= "<Cell></Cell>";
	}

	row &= "<Cell><Data ss:Type='String'>Grand-total</Data></Cell>";

	for(var i =1 ; i <= ArrayLen(sumFields); i++){
		row &= "<Cell><Data ss:Type='String'>" & sumFields[i] & "</Data></Cell>";
	}
	row &= "</Row>";
	WriteOutput(row);
}
</cfscript>
