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
	<form name="rForm" action="listMain_records.cfm" method="post">
	<table>
		<tr>
			<th>Employee No.From</th>
			<td><select name="empnoFrom">
			<cfoutput query="getEmp_qry"><option name="empno">#getEmp_qry.empno#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="empnoTo">
			<cfoutput query="getEmp_qry"><option name="empno">#getEmp_qry.empno#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Line No.</th>
			<td><select name="lineFrom">
			<cfoutput query="line_qry"><option value="#line_qry.lineno#" name="">#line_qry.desp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="lineTo">
			<cfoutput query="line_qry"><option value="#line_qry.lineno#" name="">#line_qry.desp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Branch From</th>
			<td><select name="branchFrom">
			<cfoutput query="branch_qry"><option value="#branch_qry.brcode#" name="">#branch_qry.brdesp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="branchTo">
			<cfoutput query="branch_qry"><option value="#branch_qry.brcode#" name="">#branch_qry.brdesp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Department From</th>
			<td><select name="deptFrom">
			<cfoutput query="dept_qry"><option value="#dept_qry.deptcode#" name="">#dept_qry.deptdesp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="deptTo">
			<cfoutput query="dept_qry"><option value="#dept_qry.deptcode#" name="">#dept_qry.deptdesp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Category</th>
			<td><select name="categoryFrom">
			<cfoutput query="category_qry"><option value="#category_qry.category#" name="">#category_qry.desp#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="categoryTo">
			<cfoutput query="category_qry"><option value="#category_qry.category#" name="">#category_qry.desp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Employee Code From</th>
			<td><select name="empcodeFrom">
			<cfoutput query="getEmp_qry"><option name="empcode">#getEmp_qry.emp_code#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="empcodeTo">
			<cfoutput query="getEmp_qry"><option name="empcode">#getEmp_qry.emp_code#</option></cfoutput>
			</select></td>
		</tr>	
	</table>
	<br />
	<center>
		<input type="submit" name="ok" value="Ok" /></td>
		<input type="button" name="exit" value="Exit" onclick="window.location.href='ldList.cfm';">
	</center>
	</form>
</div>
</body>
</html>
