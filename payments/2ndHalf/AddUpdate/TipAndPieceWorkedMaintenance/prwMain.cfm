<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Piece Rates Work Maintenance</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name,emp_code FROM pmast WHERE paystatus = "A" and confid >= #hpin# order by length(empno),empno
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
<div class="mainTitle">Piece Rates Work Maintenance</div>
<div class="tabber">
	<font color="red" size="2.5"><cfif isdefined("form.status")><cfoutput>#form.status#</cfoutput></cfif></font>
	<table>
		<tr>
			<th>Employee No.From</th>
			<td><select id="fromEmpno" name="fromEmpno" onChange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?c='+this.options[this.selectedIndex].id+'&p='+document.getElementById('toEmpno').value+
					'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value=""></option>
			<cfoutput query="getEmp_qry">
				<option id="#getEmp_qry.empno#" value="#getEmp_qry.empno#">#getEmp_qry.empno#</option>
			</cfoutput>
			</select></td>
			<td>To</td>
			<td><select id="toEmpno" name="toEmpno" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?p='+this.options[this.selectedIndex].id+'&c='+document.getElementById('fromEmpno').value+
					'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);">
			<option value="">zzzzzz</option>
			<cfoutput query="getEmp_qry">
				<option id="#getEmp_qry.empno#" value="#getEmp_qry.empno#">#getEmp_qry.empno#</option>
			</cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Line No.</th>
			<td><select id="lineFrom" name="lineFrom" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?m='+this.options[this.selectedIndex].id+'&n='+document.getElementById('lineTo').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value=""></option>
			<cfoutput query="line_qry">
				<option id="#line_qry.lineno#" value="#line_qry.lineno#">#line_qry.lineno#</option>
			</cfoutput>
			</select></td>
			<td>To</td>
			<td><select id="lineTo" name="lineTo" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?n='+this.options[this.selectedIndex].id+'&m='+document.getElementById('lineFrom').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value="">zzzzzzzzzz</option>
			<cfoutput query="line_qry">
				<option id="#line_qry.lineno#" value="#line_qry.lineno#">#line_qry.lineno#</option>
			</cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Branch From</th>
			<td><select id="branchFrom" name="branchFrom" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?k='+this.options[this.selectedIndex].id+'&l='+document.getElementById('branchTo').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value=""></option>
			<cfoutput query="branch_qry">
				<option id="#branch_qry.brcode#" value="#branch_qry.brcode#">#branch_qry.brcode#</option>
			</cfoutput>
			</select></td>
			<td>To</td>
			<td><select id="branchTo" name="branchTo" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?l='+this.options[this.selectedIndex].id+'&k='+document.getElementById('branchFrom').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value="">zzzz</option>
			<cfoutput query="branch_qry">
				<option id="#branch_qry.brcode#" value="#branch_qry.brcode#">#branch_qry.brcode#</option>
			</cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Department From</th>
			<td><select id="deptFrom" name="deptFrom" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?u='+this.options[this.selectedIndex].id+'&v='+document.getElementById('deptTo').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
								'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value=""></option>
			<cfoutput query="dept_qry">
				<option id="#dept_qry.deptcode#" value="#dept_qry.deptcode#">#dept_qry.deptcode#</option>
			</cfoutput>
			</select></td>
			<td>To</td>
			<td><select id="deptTo" name="deptTo" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?v='+this.options[this.selectedIndex].id+'&u='+document.getElementById('deptFrom').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
								'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value="">zzzzzzzzzz</option>
			<cfoutput query="dept_qry">
				<option id="#dept_qry.deptcode#" value="#dept_qry.deptcode#">#dept_qry.deptcode#</option>
			</cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Category</th>
			<td><select id="categoryFrom" name="categoryFrom" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?x='+this.options[this.selectedIndex].id+'&y='+document.getElementById('categoryTo').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
								'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
									'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value);" />
			<option value=""></option>
			<cfoutput query="category_qry">
				<option id="#category_qry.category#" value="#category_qry.category#">#category_qry.category#</option>
			</cfoutput>
			</select></td>
			<td>To</td>
			<td><select id="categoryTo" name="categoryTo" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?y='+this.options[this.selectedIndex].id+'&x='+document.getElementById('categoryFrom').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&a='+document.getElementById('codeFrom').value+'&b='+document.getElementById('codeTo').value+
							'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
								'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
									'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value);" />
			<option value="">zzzzzzzzzz</option>
			<cfoutput query="category_qry">
				<option id="#category_qry.category#" value="#category_qry.category#">#category_qry.category#</option>
			</cfoutput>
			</select></td>
		</tr>	
		<tr>
			<th>Employee Code From</th>
			<td><select id="codeFrom" name="codeFrom" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?a='+this.options[this.selectedIndex].id+'&b='+document.getElementById('codeTo').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
							'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value=""></option>
			<cfoutput query="getEmp_qry">
			<option id="#getEmp_qry.emp_code#" value="#getEmp_qry.emp_code#" name="emp_code">#getEmp_qry.emp_code#</option>
			</cfoutput>
			</select></td>
			<td>To</td>
			<td><select id="codeTo" name="codeTo" onchange="ajaxFunction(document.getElementById('ajaxField'),'prwMain_ajax.cfm?b='+this.options[this.selectedIndex].id+'&a='+document.getElementById('codeFrom').value+
					'&c='+document.getElementById('fromEmpno').value+'&p='+document.getElementById('toEmpno').value+
						'&m='+document.getElementById('lineFrom').value+'&n='+document.getElementById('lineTo').value+
							'&k='+document.getElementById('branchFrom').value+'&l='+document.getElementById('branchTo').value+
								'&u='+document.getElementById('deptFrom').value+'&v='+document.getElementById('deptTo').value+
									'&x='+document.getElementById('categoryFrom').value+'&y='+document.getElementById('categoryTo').value);" />
			<option value="">zzzzzzzzzzzz</option>
			<cfoutput query="getEmp_qry">
			<option id="#getEmp_qry.emp_code#" value="#getEmp_qry.emp_code#" name="emp_code">#getEmp_qry.emp_code#</option>
			</cfoutput>
			</select></td>
		</tr>	
	</table>
	<div id="ajaxField" name="ajaxField">
	<table>
		<tr>
			<th width="85px">Employee No.</th>
			<th width="370px">Name</th>
			<th width="35px">Action</th>
		</tr>
		<cfoutput query="getEmp_qry">
		<tr>
			<td><input type="text" size="12" name="empno" value="#getEmp_qry.empno#" readonly="yes" /></td>
			<td><input type="text" size="60" name="name" value="#getEmp_qry.name#" readonly="yes" /></td>
			<td>
				<a href="##" onclick="window.open('/payments/2ndHalf/AddUpdate/TipAndPieceWorkedMaintenance/prwMain_add.cfm?empno=#getEmp_qry.empno#', 'windowname1', 'width=800, height=500, left=100, top=30');" />
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Add</a>
			</td>
		<tr>
		</cfoutput>
	</table>
	</div>
	
	<br />
    <form action="updatePieceWorkIntoPayroll.cfm" method="post">
   
	<center>
		<input type="submit" name="update piece work into payroll" value="Update Piece Work Into Payroll">
		<input type="button" name="cancel" value="Cancel" onclick="window.location.href='/payments/2ndHalf/AddUpdate/TipAndPieceWorkedMaintenance/tnpList.cfm';">
	</center>
    
     </form>
</div>
</body>
</html>