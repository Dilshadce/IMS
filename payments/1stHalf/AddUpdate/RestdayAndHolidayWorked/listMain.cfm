<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Restday And Holiday Worked</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
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
<div class="mainTitle">List RD/PH Work</div>
<div class="tabber">
	<form name="rForm" action="listMain_report.cfm" method="post" target="_blank">
	<table>
		<tr>
			<th>Report Format</th>
			<td>
				<input type="radio" name="result" value="HTML" checked>HTML<br/>
				<input type="radio" name="result" value="EXCELDEFAULT">PDF<br/>
			<td>
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
			<th>Date From</th>
			<td><input type="text" name="dateFrom" value="">
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateFrom);"></td>
		</tr>	
		<tr>
			<th>Date To</th>
			<td><input type="text" name="dateTo" value="" />
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateTo);"></td>
		</tr>
		<tr>
			<th>Leave Type</th>
			<td><select id="leaveType" name="leaveType">
					<option id="" value=""></option>
					<option id="RD" value="Rest Day">Rest Day</option>
					<option id="PH" value="Public Holiday">Public Holiday</option>
				</select></td>
		</tr>
	</table>
	<br />
	<center>
		<input type="submit" name="ok" value="Ok">
		<input type="button" name="exit" value="Exit" onclick="window.location.href='rnlList.cfm';">
	</center>
</form>
</div>
</body>
</html>