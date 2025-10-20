<html>
<head>
	<title>2nd Half Payroll - Fixed Overtime Rate By Pay Group</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="emp_qry" datasource="#dts#">
SELECT *
FROM pmast where confid >= #hpin#
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

<cfquery name="ot_qry" datasource="#dts#">
SELECT ot_desp, ot_unit 
FROM ottable
WHERE ot_cou between 1 and 6
</cfquery>

<cfoutput>
<form name="fForm" action="/payments/2ndHalf/addUpdate/fixedOTRateByPayGroupMain_process.cfm" method="post">
<div class="mainTitle">2nd Half Payroll - Fixed Overtime Rate By Pay Group</div>
<table class="form">
<tr>
	<th colspan="4">Month Rate As Calculated From Personnel File</th>
</tr>
<tr>
	<td>Basic Rate From</td>
	<td><input type="text" name="brate_frm" value="2000.00"></td>
	<td>To</td>
	<td><input type="text" name="brate_to" value="1000000.00"></td>
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
<tr>
	<th colspan="4">Overtime <cfloop from="1" to="30" index="i">&nbsp;</cfloop> Rate</th>
</tr>
<cfset i=1>
<cfloop query="ot_qry">
<tr>
	<td width="130px">#ot_qry.ot_desp#</td>
	<td><input type="text" name="rate#i#" value="0.00" size="10">&nbsp;&nbsp; #ot_qry.ot_unit#</td>
</tr>
<cfset i=i+1>
</cfloop>
<tr>
	<td colspan="4" align="right"><br />
		<input type="submit" name="save" value="Save">
		<input type="button" name="cancel" value="Cancel" onclick="window.location='/payments/2ndHalf/addUpdate/addUpdateList.cfm'">	
	</td>
</tr>
</table>
</form>
</cfoutput>
</body>

</html>