<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Loan Deduction Maintenance</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name,emp_code FROM pmast 
</cfquery>

<cfquery name="line_qry" datasource="#dts#">
SELECT * FROM tlineno
</cfquery>

<cfquery name="branch_qry" datasource="#dts#">
SELECT * FROM branch
</cfquery>

<cfquery name="dept_qry" datasource="#dts#">
SELECT * FROM dept
</cfquery>

<cfquery name="category_qry" datasource="#dts#">
SELECT * FROM category
</cfquery>

<body>
<div class="mainTitle">Loan Listing</div>
<div class="tabber">
	<form name="rForm" action="listMain_selectPro.cfm?loanList=#loanList#" method="post" target="_blank">
	<table>
		<tr>
			<th>Loan Listiing</th>
		</tr>
		<tr>
			<td><select name="loanList" value="loanList" size="5">
				<option name="records" value="records" selected>List Loan Records</option>
				<option name="repayment" value="repayment">List This Month Repayment</option>
				<option name="report" value="report">Outstanding Loan Report</option>
				<option name="details" value="details">Loan To Bank Details</option>
				<option name="totals" value="totals">Loan To Bank Totals</option>
			</select><td>
		</tr>
		<tr>
			<th>Employee No.From</th>
			<td><select name="empnoFrom">
				<option name="" value=""></option>
			<cfoutput query="getEmp_qry"><option name="" value="">#getEmp_qry.empno#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="empnoTo">
				<option name="" value="">zzzzzz</option>
			<cfoutput query="getEmp_qry"><option name="" value="">#getEmp_qry.empno#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Line No.</th>
			<td><select name="lineFrom">
				<option name="" value=""></option>
			<cfoutput query="line_qry"><option value="#line_qry.lineno#" name="">#line_qry.desp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="lineTo" >
				<option name="" value="">zzzzzzzzzz</option>
			<cfoutput query="line_qry"><option value="#line_qry.lineno#" name="">#line_qry.desp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Branch From</th>
			<td><select name="branchFrom">
				<option name="" value=""></option>
			<cfoutput query="branch_qry"><option value="#branch_qry.brcode#" name="">#branch_qry.brdesp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="branchTo" value="">
				<option name="" value="">zzzz</option>
			<cfoutput query="branch_qry"><option value="#branch_qry.brcode#" name="">#branch_qry.brdesp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Department From</th>
			<td><select name="deptFrom">
				<option name="" value=""></option>
			<cfoutput query="dept_qry"><option value="#dept_qry.deptcode#" name="">#dept_qry.deptdesp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="deptTo">
				<option name="" value="">zzzzzzzzzz</option>
			<cfoutput query="dept_qry"><option value="#dept_qry.deptcode#" name="">#dept_qry.deptdesp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Category</th>
			<td><select name="categoryFrom">
				<option name="" value=""></option>
			<cfoutput query="category_qry"><option value="#category_qry.category#" name="">#category_qry.desp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="categoryTo">
				<option name="" value="">zzzzzzzzzz</option>
			<cfoutput query="category_qry"><option value="#category_qry.category#" name="">#category_qry.desp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Employee Code From</th>
			<td><select name="empcodeFrom">
				<option name="" value=""></option>
			<cfoutput query="getEmp_qry"><option name="empcode">#getEmp_qry.emp_code#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="empcodeTo">
				<option name="" value="">zzzzzzzzzzzz</option>
			<cfoutput query="getEmp_qry"><option name="empcode">#getEmp_qry.emp_code#</option></cfoutput>
			</select></td>
		</tr>	
	</table>
	<br />
	<center>
		<input type="submit" name="ok" value="Ok"</td>
		<input type="button" name="exit" value="Exit" onclick="window.location.href='ldList.cfm';">
	</center>
	</form>
</div>
</body>
</html>
