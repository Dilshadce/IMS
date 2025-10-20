<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Maintain Holidays - List Leaves</title>
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
<div class="mainTitle">List Leaves</div>
<div class="tabber">
<form name="eForm" action="holidayLeaveMaintenanceList_report.cfm" method="post" target="_blank">
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
			<cfoutput query="getEmp_qry"><option name="" value="#getEmp_qry.empno#">#getEmp_qry.empno#</option></cfoutput>
			</select></td>
			<td>-</td>
			<td><select name="empnoTo">
				<option name="" value="">zzzzzz</option>
			<cfoutput query="getEmp_qry"><option name="" value="#getEmp_qry.empno#">#getEmp_qry.empno#</option></cfoutput>
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
			<th>Order By</th>
			<td><select id="leaveType" name="leaveType">
					<option id="" value=""></option>
					<option id="AL" value="AL">Annual Leave</option>
					<option id="MC" value="MC">Medical Leave</option>
					<option id="MT" value="MT">Maternity Leave</option>
					<option id="MR" value="MR">Marriage Leave</option>
					<option id="CL" value="CL">Compassionate Leave</option>
					<option id="HL" value="HL">Hospital Leave</option>
					<option id="EX" value="EX">Examination Leave</option>
					<option id="PT" value="PT">Paternity Leave</option>
					<option id="AD" value="AD">Advance Leave</option>
					<option id="OPL" value="OPL">Other Pay Leave</option>
					<option id="LS" value="LS">Line Shut Down</option>
					<option id="AB" value="AB">Absent</option>
					<option id="NPL" value="NPL">No Pay Leave</option>
				</select></td>
		</tr>
	</table>
	<br />
	<center>
		<input type="submit" name="ok" value="Ok" />
		<input type="button" name="exit" value="Exit" onclick="window.location.href='hnlList.cfm';" />
	</center>
	
</form>
</div>

</body>
</html>