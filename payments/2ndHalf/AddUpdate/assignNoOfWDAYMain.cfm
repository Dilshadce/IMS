<html>
<head>
	<title>2nd Half Payroll</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">

<script language="javascript">

function showDisable()
{
	document.getElementById("desp").disabled = true;
	document.getElementById("oDesp").disabled = true;
}

function addLoadEvent()
	{
		/* This function adds tabberAutomatic to the window.onload event,
		so it will run after the document has finished loading.*/
		var oldOnLoad;
		/* Taken from: http://simon.incutio.com/archive/2004/05/26/addLoadEvent */
		oldOnLoad = window.onload;
		if (typeof window.onload != 'function') {
			window.onload = function(){
				showDisable()
			};
		}else{
			window.onload = function() {
				oldOnLoad();
				showDisable()
			};
		}
	}
	addLoadEvent();

</script>

</head>

<body>
<cfquery name="emp_qry" datasource="#dts#">
SELECT empno, name, emp_code
FROM pmast
ORDER BY empno
</cfquery>

<cfquery name="line_qry" datasource="#dts#">
SELECT lineno, desp
FROM tlineno
ORDER BY lineno
</cfquery>

<cfquery name="bra_qry" datasource="#dts#">
SELECT brcode, brdesp
FROM branch
ORDER BY brcode
</cfquery>

<cfquery name="dept_qry" datasource="#dts#">
SELECT deptcode, deptdesp
FROM dept
ORDER BY deptcode
</cfquery>

<cfquery name="cat_qry" datasource="#dts#">
SELECT category, desp
FROM category
ORDER BY category
</cfquery>

<cfoutput>
<form name="aForm" action="/payments/2ndHalf/addUpdate/assignNoOfWDAYProcess.cfm" method="post">
<div class="mainTitle">Assign No. Of WDAY</div>
<font color="red" size="2.5"><cfif isdefined("form.status")><cfoutput>#form.status#</cfoutput></cfif></font>
<table class="form">
<tr>
	<th colspan="4">Assign No. Of Working Day</th>
</tr>
<tr>
	<td>Option</td>
	<td>
	<select name="option1">
		<option value="DW">Days Worked</option>
		<option value="PH">Public Holiday</option>
		<option value="AL">Anual Leave</option>
		<option value="MC">Medical Leave</option>
		<option value="MT">Maternity Leave</option>
		<option value="MR">Marriage Leave</option>
		<option value="CL">Compassionate Leave</option>
		<option value="HL">Hospital Leave</option>
		<option value="EX">Examination Leave</option>
		<option value="PT">Paternity Leave</option>
		<option value="AD">Advance Leave</option>
		<option value="OPL">Other Pay Leave</option>
		<option value="LS">Line Shut Down</option>
		<option value="NPL">No Pay Leave</option>
		<option value="AB">Absent</option>
		<option value="ONPL">Other No Pay Leave</option>
	</select>
	</td>
</tr>
<tr>
	<td>Employee No.</td>
	<td>
	<select name="empno_frm">
		<option value=""></option>
		<cfloop query="emp_qry">
		<option value="#empno#">#emp_qry.empno# | #emp_qry.name#</option>
		</cfloop>
	</select>
	</td>
	<td>-</td>
	<td>
	<select name="empno_to">
		<option value="">zzzzzz</option>
		<cfloop query="emp_qry">
		<option value="#empno#">#emp_qry.empno# | #emp_qry.name#</option>
		</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Line No.</td>
	<td>
	<select name="line_frm">
		<option value=""></option>
		<cfloop query="line_qry">
		<option value="#lineno#">#line_qry.lineno# | #line_qry.desp#</option>
		</cfloop>
	</select>
	</td>
	<td>-</td>
	<td>
	<select name="line_to">
		<option value="">zzzzzz</option>
		<cfloop query="line_qry">
		<option value="#lineno#">#line_qry.lineno# | #line_qry.desp#</option>
		</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Branch From</td>
	<td>
	<select name="branch_frm">
		<option value=""></option>
		<cfloop query="bra_qry">
		<option value="#brcode#">#bra_qry.brcode# | #bra_qry.brdesp#</option>
		</cfloop>
	</select>
	</td>
	<td>-</td>
	<td>
	<select name="branch_to">
		<option value="">zzzzzz</option>
		<cfloop query="bra_qry">
		<option value="#brcode#">#bra_qry.brcode# | #bra_qry.brdesp#</option>
		</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Department From</td>
	<td>
	<select name="dept_frm">
		<option value=""></option>
		<cfloop query="dept_qry">
		<option value="#deptcode#">#dept_qry.deptcode# | #dept_qry.deptdesp#</option>
		</cfloop>
	</select>
	</td>
	<td>-</td>
	<td>
	<select name="dept_to">
		<option value="">zzzzzz</option>
		<cfloop query="dept_qry">
		<option value="#deptcode#">#dept_qry.deptcode# | #dept_qry.deptdesp#</option>
		</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Category</td>
	<td>
	<select name="cat_frm">
		<option value=""></option>
		<cfloop query="cat_qry">
		<option value="#category#">#cat_qry.category# | #cat_qry.desp#</option>
		</cfloop>
	</select>
	</td>
	<td>-</td>
	<td>
	<select name="cat_to">
		<option value="">zzzzzz</option>
		<cfloop query="cat_qry">
		<option value="#category#">#cat_qry.category# | #cat_qry.desp#</option>
		</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Employee Code From</td>
	<td>
	<select name="empcode_frm">
		<option value=""></option>
		<cfloop query="emp_qry">
		<option value="#empno#">#emp_qry.emp_code# | #emp_qry.name#</option>
		</cfloop>
	</select>
	</td>
	<td>-</td>
	<td>
	<select name="empcode_to">
		<option value="">zzzzzz</option>
		<cfloop query="emp_qry">
		<option value="#empno#">#emp_qry.emp_code# | #emp_qry.name#</option>
		</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Pay Rate Type</td>
	<td>
	<select name="payrtype">
		<option value="">All</option>
		<option value="M">Monthly</option>
		<option value="D">Daily</option>
		<option value="H">Hourly</option>
		
	</select>
	</td>
</tr>
<tr id="desp">
	<td>Other Description</td>
	<td><input type="text" name="oDesp" value="" size="5"></td>
</tr>
<tr>
	<td>No. Of Days</td>
	<td><input type="text" name="day_no" value="0.00" size="10"></td>
</tr>
<tr>
	<td colspan="2"><input type="checkbox" name="" value="" checked>Update all records</td>
</tr>
<tr>
	<td colspan="2"><strong>*If untick, only update records where days = 0</strong></td>
</tr>
<tr>
	<td colspan="4" align="right"><br />
		<input type="submit" name="ok" value="OK">
		<input type="button" name="cancel" value="Cancel" onClick="window.location='/payments/2ndHalf/addUpdate/addUpdateList.cfm'">
	</td>
</tr>
</table>
</form>
</cfoutput>
</body>

</html>