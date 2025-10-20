<cfif getHTTPRequestData().method EQ "POST">

	<cfquery name="tempPayroll" datasource="manpower_i">
SELECT *,CASE WHEN tax is null then 0 else tax END as incomeTax FROM (
	select custname,empname,empno,refno,selfsalary,lvltotalee1,

CASE WHEN paydate = 'paytra1' THEN
  (SELECT ded115 FROM manpower_p.paytra1 WHERE empno = a.empno)
ELSE
  (SELECT ded115 FROM manpower_p.paytran WHERE empno = a.empno)
END as tax,
(selfot1 + selfot2 + selfot3 + selfot4 + selfot5 + selfot6 + selfot7 + selfot8) as OT,
awee1,awee2,awee3,awee4,awee5,awee6,awee7,awee8,awee9,awee10,awee11,awee12,awee13,awee14,awee15,awee16,awee17,awee18,
fixawee1,fixawee2,fixawee3
,selfcpf,custcpf,selfsdf,custsdf,ded1,ded1desp,ded2,ded2desp,ded3,ded3desp  from manpower_i.assignmentslip a
WHERE custno = '#form.customer#' AND payrollperiod = "1") t;

</cfquery>
</cfif>
<html>
	<head>
		<title>
			Temp Payroll
		</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<style>
			.highlightCol { background-color : #c5e2c0; }
		</style>
	</head>
	<body>
		<form method="POST">
			<input type="text" name="customer" placeholder="e.g 3000123123">
			<input type="submit" name="submit" value="search" class="btn btn-info">
		</form>
		<cfif getHTTPRequestData().method EQ "POST">
			<table class="table table-hover table-border">
				<thead>
					<tr>
						<th>
							Client
						</th>
						<th>
							Associate Name
						</th>
						<th>
							Candidate No
						</th>
						<th>
							refno
						</th>
						<th class="highlightCol">
							gross total
						</th>
						<th>
							deduction
						</th>
						<th class="highlightCol">
							gross w/ deduction
						</th>
						<th class="highlightCol">
							Employee EPF
						</th>
						<th>
							Employer EPF
						</th>
						<th class="highlightCol">
							Employee SOCSO
						</th>
						<Th>
							Employer SOCSO
						</Th>
						<th class="highlightCol">
							First deduction
						</th>
						<th class="highlightCol">
							Second deduction
						</th>
						<th  class="highlightCol">
							Third deduction
						</th>


						<th class="highlightCol">Tax</th>
						<th class="highlightCol">NETT</th>
					</tr>
					<cfoutput>

						<cfloop query="tempPayroll">
							<cfset gross = tempPayroll.selfsalary + tempPayroll.OT>
							<cfset deduction = (tempPayroll.lvltotalee1 * -1)>
							<cfloop from="1" to="18" index="i">
								<cfif tempPayroll['awee#i#'][tempPayroll.currentRow] GT 0 >
									<cfset gross = gross + tempPayroll['awee#i#'][tempPayroll.currentRow]>
								<cfelse>
									<cfset deduction =deduction +  (tempPayroll['awee#i#'][tempPayroll.currentRow] * -1)>
								</cfif>
							</cfloop>
							<cfloop from="1" to="3" index="i">
								<cfif tempPayroll['fixawee#i#'][tempPayroll.currentRow] GT 0>
									<cfset gross = gross + tempPayroll['fixawee#i#'][tempPayroll.currentRow]>
									<cfset tax = tempPayroll.tax eq '' ? 0 : tempPayroll.tax>
								</cfif>
							</cfloop>
							<tr>
								<td>
									#tempPayroll.custname#
								</td>
								<td>
									#tempPayroll.empname#
								</td>
								<td>
									#tempPayroll.empno#
								</td>
								<td>
									#tempPayroll.refno#
								</td>
								<td class="highlightCol">
									#gross#
								</td>
								<td>
									#deduction#
								</td>
								<td class="highlightCol">
									#gross-deduction#
								</td>
								<td class="highlightCol">
									#tempPayroll.selfcpf#
								</td>
								<td>
									#tempPayroll.custcpf#
								</td>
								<td class="highlightCol">
									#tempPayroll.selfsdf#
								</td>
								<td>
									#tempPayroll.custsdf#
								</td>
								<td class="highlightCol">
									#tempPayroll.ded1#
								</td>
								<td class="highlightCol">
									#tempPayroll.ded2#
								</td>
								<td class="highlightCol">
									#tempPayroll.ded3#
								</td>

								<td>
									#incomeTax#
								</td>
								<td class="highlightCol">
									#gross - deduction - tempPayroll.selfcpf - tempPayroll.selfsdf - incomeTax#
								</td>
							</tr>
						</cfloop>
					</cfoutput>
				</thead>
			</table>
		</cfif>
	</body>
</html>
