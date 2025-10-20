<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Loan Deduction Maintenance</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getList_qry" datasource="#dts#">
SELECT * FROM loanmst AS a LEFT JOIN pmast AS b ON a.empno=b.empno 
WHERE 
	a.empno BETWEEN '#form.empnoFrom#' AND '#form.empnoTo#' AND
	emp_code BETWEEN '#form.empcodeFrom#' AND '#form.empcodeTo#' AND
	plineno BETWEEN '#form.lineFrom#' AND '#form.lineTo#' AND
	brcode BETWEEN '#form.branchFrom#' AND '#form.branchTo#' AND
	deptcode BETWEEN '#form.deptFrom#' AND '#form.deptTo#' AND
	category BETWEEN '#form.categoryFrom#' AND '#form.categoryTo#'
</cfquery>

<body>
<cfoutput>
<div class="tabber">
<table>
	<tr><td colspan="9" align="center"><h1>List Loan Records</h1></tr>

	<tr><td colspan="9"><hr></td></tr>
	<tr>
		<th width="120px">Empno</th>
		<th width="350px">Accno</th>
		<th width="180px">Loanamt</th>
		<th width="100px">Date_from</th>
		<th width="80px">Date_to</th>
		<th width="120px">Repayment</th>
		<th width="350px">Times</th>
		<th width="180px">Ded_code</th>
		<th width="100px">Name</th>
	</tr>
	<cfloop query="getList_qry">
	<tr>
		<td>#getList_qry.empno#</td>
		<td>#getList_qry.accno#</td>
		<td>#getList_qry.loanamt#</td>
		<td>#lsdateformat(getList_qry.dates1,"dd/mm/yyyy")#</td>
		<td>#lsdateformat(getList_qry.datee1,"dd/mm/yyyy")#</td>
		<td>#getList_qry.loanret1#</td>
		<td></td>
		<td>#getList_qry.dednum#</td>
		<td>#getList_qry.name#</td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td>#lsdateformat(getList_qry.dates2,"dd/mm/yyyy")#</td>
		<td>#lsdateformat(getList_qry.datee2,"dd/mm/yyyy")#</td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	</cfloop>
</table>
</div>
</cfoutput>
</body>
</html>