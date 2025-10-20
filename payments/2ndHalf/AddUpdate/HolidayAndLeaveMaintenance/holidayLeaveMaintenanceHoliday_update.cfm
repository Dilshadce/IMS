<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Maintain Holiday</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
</head>
<cfquery name="getdate" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfset mon = #numberformat(getdate.mmonth,'00')# >
<cfset yrs = getdate.myear>


<cfquery name="getHol" datasource="#dts#">
SELECT * FROM holtable WHERE substr(hol_date,1,4)='#yrs#' and substr(hol_date,6,2)='#mon#'
</cfquery>

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
<div class="mainTitle">Update Holidays</div>
<div class="tabber">
<font color="red" size="2.5"><cfif isdefined("form.status")><cfoutput>#form.status#</cfoutput></cfif></font>
	<form name=holForm action="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday_updateProcess.cfm" method="post"> 
   <cfoutput><input type="hidden" name="day_count" value="#gethol.recordcount#" /></cfoutput>
	<table>
		<tr>
        	<td>
			<h1>Holiday Available This Month</h1>
            <cfoutput query="getHol"><h2>#getHol.hol_desp#</h2><br /></cfoutput>
            </td>
		</tr>
	
		<tr>
			<th>Employee No.From</th>
			<td><select id="empno" name="empno">
				<option name="" value=""></option>
			<cfoutput query="getEmp_qry"><option name="empno" value="#getEmp_qry.empno#">#getEmp_qry.empno#</option></cfoutput>
			</select></td>
			<td>To</td>
			<td><select name="empno1">
				<option name="" value="">zzzzzz</option>
			<cfoutput query="getEmp_qry"><option name="empno" value="#getEmp_qry.empno#">#getEmp_qry.empno#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Line No.</th>
			<td><select name="lineno">
				<option name="" value=""></option>
			<cfoutput query="line_qry"><option name="line" value="#line_qry.lineno#">#line_qry.desp#</option></cfoutput>
			</select></td>
			<td>To</td>
			<td><select name="lineno1">
				<option name="" value="">zzzzzzzzzz</option>
			<cfoutput query="line_qry"><option name="line" value="#line_qry.lineno#">#line_qry.desp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Branch From</th>
			<td><select name="brcode">
				<option name="" value=""></option>
			<cfoutput query="branch_qry"><option name="line" value="#branch_qry.brcode#">#branch_qry.brdesp#</option></cfoutput>
			</select></td>
			<td>To</td>
			<td><select name="brcode1">
				<option name="" value="">zzzz</option>
			<cfoutput query="branch_qry"><option name="line" value="#branch_qry.brcode#">#branch_qry.brdesp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Department From</th>
			<td><select name="deptcode">
				<option name="" value=""></option>
			<cfoutput query="dept_qry"><option name="line" value="#dept_qry.deptcode#">#dept_qry.deptdesp#</option></cfoutput>
			</select></td>
			<td>To</td>
			<td><select name="deptcode1">
				<option name="" value="">zzzzzzzzzz</option>
			<cfoutput query="dept_qry"><option name="line" value="#dept_qry.deptcode#">#dept_qry.deptdesp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Category</th>
			<td><select name="category">
				<option name="" value=""></option>
			<cfoutput query="category_qry"><option name="line" value="#category_qry.category#">#category_qry.desp#</option></cfoutput>
			</select></td>
			<td>To</td>
			<td><select name="category1">
				<option name="" value="">zzzzzzzzzz</option>
			<cfoutput query="category_qry"><option name="line" value="#category_qry.category#">#category_qry.desp#</option></cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Employee Code From</th>
			<td><select name="emp_code">
				<option name="" value=""></option>
			<cfoutput query="getEmp_qry"><option name="empno" value="#getEmp_qry.emp_code#">#getEmp_qry.emp_code#</option></cfoutput>
			</select></td>
			<td>To</td>
			<td><select name="emp_code1">
				<option name="" value="">zzzzzzzzzzzz</option>
			<cfoutput query="getEmp_qry"><option name="empno" value="#getEmp_qry.emp_code#">#getEmp_qry.emp_code#</option></cfoutput>
			</select></td>
		</tr>	
	</table>
	<br />
	<center>
		<input type="Submit" name="ok" value="Ok">
		<input type="button" name="exit" value="Exit" onclick="window.close()">
	</center>
	</form>
</div>
</body>
</html>