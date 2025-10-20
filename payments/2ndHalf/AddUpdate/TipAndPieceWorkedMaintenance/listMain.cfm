<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>List Piece Rated Work/Pay</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name,emp_code FROM pmast where confid >= #hpin# 
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

<cfquery name="getdate" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfset mon = #numberformat(getdate.mmonth,'00')# >
<cfset yrs = getdate.myear>

<cfset system_start_date=CreateDate(yrs, mon, 1)>
<cfset system_end_date = CreateDate(yrs,mon, #DaysInMonth(system_start_date)#)>
<cfset system_start_date = #DATEFORMAT(system_start_date,"DD/MM/YYYY")#>
<cfset system_end_date = #DATEFORMAT(system_end_date,"DD/MM/YYYY")#>
<body>
<div class="mainTitle">List Piece Rated Work/Pay</div>
<div class="tabber">
	<form name="lForm" action="listMain_process.cfm?list=#list#" method="post" target="_blank">
	<table>
		<tr>
			<th>Piece Rated Work Maintenance</th>
		</tr>
		<tr>
			<td><select name="list" value="list" size="3">
				<option name="worked" value="worked" selected>List Piece Rated Worked</option>
				<option name="payX" value="payX">List Piece Rated Pay - X</option>
				<option name="payY" value="payY">List Piece Rated Pay - Y</option>
			</select></td>
		</tr>
		<tr>
			<th>Employee No.From</th>
			<td>
				<select name="empnoFrom">
					<option value=""></option>
				<cfoutput query="getEmp_qry">
					<option name="empno">#getEmp_qry.empno#</option>
				</cfoutput>
				</select>
			</td>
			<td>-</td>
			<td>
				<select name="empnoTo">
					<option value="">zzzzzz</option>
				<cfoutput query="getEmp_qry">
					<option name="empno">#getEmp_qry.empno#</option>
				</cfoutput>
				</select>
			</td>
		</tr>	
		<tr>
			<th>Line No.</th>
			<td><select name="lineFrom">
					<option value=""></option>
				<cfoutput query="line_qry">
					<option value="#line_qry.desp#" name="">#line_qry.desp#</option>
				</cfoutput>
				</select>
			</td>
			<td>-</td>
			<td>
				<select name="lineTo">
					<option value="">zzzzzzzzzz</option>
				<cfoutput query="line_qry">
					<option value="" name="">#line_qry.desp#</option>
				</cfoutput>
				</select>
			</td>
		</tr>	
		<tr>
			<th>Branch From</th>
			<td>
				<select name="branchFrom">
					<option value=""></option>
				<cfoutput query="branch_qry">
					<option name="">#branch_qry.brdesp#</option>
				</cfoutput>
				</select>
			</td>
			<td>-</td>
			<td>
				<select name="branchTo">
					<option value="">zzzz</option>
			<cfoutput query="branch_qry">
				<option name="">#branch_qry.brdesp#</option>
			</cfoutput>
			</select>
			</td>
		</tr>	
		<tr>
			<th>Department From</th>
			<td>
				<select name="deptFrom">
					<option value=""></option>
				<cfoutput query="dept_qry">
					<option name="">#dept_qry.deptdesp#</option>
				</cfoutput>
				</select>
			</td>
			<td>-</td>
			<td>
				<select name="deptTo">
					<option value="">zzzzzzzzzz</option>
				<cfoutput query="dept_qry">
					<option name="">#dept_qry.deptdesp#</option>
				</cfoutput>
				</select>
			</td>
		</tr>	
		<tr>
			<th>Category</th>
			<td>
				<select name="categoryFrom">
					<option value=""></option>
				<cfoutput query="category_qry">
					<option name="">#category_qry.desp#</option>
				</cfoutput>
				</select>
			</td>
			<td>-</td>
			<td>
				<select name="categoryTo">
					<option value="">zzzzzzzzzz</option>
				<cfoutput query="category_qry">
					<option name="">#category_qry.desp#</option>
				</cfoutput>
				</select>
			</td>
		</tr>		
		<tr>
			<th>Date From</th>
			<td><input type="text" name="dateFrom" value="<cfoutput>#system_start_date#</cfoutput>">
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateFrom);"></td>
		</tr>
		<tr>
			<th>Date To</th>
			<td><input type="text" name="dateTo" value="<cfoutput>#system_end_date#</cfoutput>" />
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateTo);"></td>
		</tr>
		<tr>
			<th>Order By</th>
			<td>
				<select id="stype" name="stype">
					<option id="code" value="PC_CODE">By Piece Code</option>
					<option id="date" value="WORK_DATE">By Date</option>
				</select>
			</td>
		</tr>
	</table>
	<br />

	<center>
		<input type="submit" name="ok" value="Ok" />
		<input type="button" name="exit" value="Exit" onclick="history.back()">
	</center>
	</form>
</div>
</body>
</html>