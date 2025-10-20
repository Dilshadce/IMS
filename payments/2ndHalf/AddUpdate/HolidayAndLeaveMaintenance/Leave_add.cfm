<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Maintain RD/PH Work</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>

	<!---script language="javascript">
	var row = 0;
	function appendRow()
	{
		//var tbl = document.getElementById(tblId);
		var tbl = document.getElementById('tit');
		var newRow = tbl.insertRow(tbl.rows.length);
		var count = parseInt(document.getElementById('count').value) + 1;
		document.getElementById('count').value = count;
		row=row+1;
		var newCel0 = newRow.insertCell(0);
		newCel0.innerHTML = '<input type="text" name="ntype__r'+row+'" size="45" maxlength="25" />';
		var newCel1 = newRow.insertCell(1);
		newCel1.innerHTML = '<input type="text" name="ndate__r'+row+'" size="18" maxlength="10" />';
		var newCel2 = newRow.insertCell(2);
		newCel2.innerHTML = '<input type="image" name="calender" src="/images/cal.gif" />';
		var newCel3 = newRow.insertCell(3);
		newCel3.innerHTML = '<input type="text" name="nday__r'+row+'" size="18" maxlength="10" />';
	}
	</script--->

	<!---<script language="javascript">
		function caldate(obj)
		{
			alert(document.eForm.dateFrom.value);
			var date1 = document.eForm.dateFrom.value;
			//var date1 = date;
			document.eForm.dateTo.value = date1+2;
		}
	</script--->
<script type="text/javascript">
	function validate_required(field,alerttxt)
	{
	with (field)
	{
	if (value==null||value=="")
	  {alert(alerttxt);return false;}
	else {return true}
	}
	}function validate_form(thisform)
	{
	with (thisform)
	{
	if (validate_required(dateFrom,"Date From must be filled out!")==false)
	  {dateFrom.focus();return false;}
	}
	}
</script>


</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name FROM pmast
WHERE empno='#url.empno#'
</cfquery>

<cfquery name="leave_qry" datasource="#dts#">
SELECT * FROM pleave WHERE empno='#getEmp_qry.empno#' ORDER BY lve_type 
</cfquery>

<body>
	
<div class="mainTitle">Maintain Leaves</div>
<div class="tabber">
	<cfoutput>
	<form name="eForm" action="Leave_process.cfm?empno=#url.empno#" onSubmit="return validate_form(this)" method="post">
	
	<table>
		<tr>
			<th>Employee No.</th>
			<td><input type="text" size="12"  name="empno" value="#getEmp_qry.empno#" readonly="yes"/></td>
		</tr>
		<tr>
			<th>Name</th>
			<td colspan="2"><input type="text" size="60" value="#getEmp_qry.name#" readonly="yes"/></td>
		</tr>
		<tr>
			<th>Leave Type</th>
			<td><select id="leaveType" name="leaveType">
					<option id="AL" value="Annual Leave">Annual Leave</option>
					<option id="MEDL" value="Medical Leave">Medical Leave</option>
					<option id="MATERL" value="Maternity Leave">Maternity Leave</option>
					<option id="MARRL" value="Marriage Leave">Marriage Leave</option>
					<option id="COMPAL" value="Compassionate Leave">Compassionate Leave</option>
					<option id="HOSPL" value="Hospital Leave">Hospital Leave</option>
					<option id="EXAML" value="Examination Leave">Examination Leave</option>
					<option id="PATERL" value="Paternity Leave">Paternity Leave</option>
					<option id="ADVL" value="Advance Leave">Advance Leave</option>
					<option id="OPL" value="Other Pay Leave">Other Pay Leave</option>
					<option id="LSDL" value="Line Shut Down">Line Shut Down</option>
					<option id="ABS" value="Absent">Absent</option>
					<option id="NOPL" value="No Pay Leave">No Pay Leave</option>
				</select></td>
		</tr>
		<tr>
			<th>Date From *</th>
			<td><input type="text" size="15" name="dateFrom" value="" id="dateFrom"/>
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateFrom);"></td>
		</tr>
		<tr>
			<th>Date To *</th>
			<td><input type="text" size="15" name="dateTo" value="" id="dateTo"/>
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateTo);"></td>
		</tr>
		<tr>
			<th>No. Of Day</th>
			<td><input type="text" size="12" name="numDay" value="" maxlength="5" /></td>
			<td><input type="checkbox" name="allEmp" value="allEmp" />For All Employee</td>
		</tr>
	</table>
	</cfoutput>
	<br />
	<center>
		<input type="submit" name="save" value="Save">
		<input type="button" name="exit" value="Exit" onclick="window.location.href='Leave.cfm';">
	</center>
	<br />
	</form>
	<!---input type="hidden" name="count" value="0" /--->
	<div style="width:100%; height:250px; overflow:auto;">
	<table class="form" border="0">
		<tr>
			<th width="280px">Type</th>
			<th width="120px">Date</th>
			<th width="120px">No Of Date</th>
			<th>Action</th>
		</tr>
		
		<cfoutput query="leave_qry">
		
		<input type="hidden" name="entryno" value="#leave_qry.entryno#" />
		<tr>
			<td>
				<input type="text" name="lve_type__r#leave_qry.empno#" value="#leave_qry.lve_type#" size="45" maxlength="10" />
			</td>
			<td>
				<input type="text" name="lve_date__r#leave_qry.empno#" value="#lsdateformat(leave_qry.lve_date,"dd/mm/yyyy")#" size="18" />
			</td>
			<td>
				<input type="text" name="lve_day__r#leave_qry.empno#" value="#leave_qry.lve_day#" size="18" />
			</td>
			<td>
				<a href="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/Leave_process.cfm?type=delete&entryno=#leave_qry.entryno#&empno=#leave_qry.empno#">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>			
			</td>
		</tr>
		</cfoutput>
	</table>
	</div>
	<br />
</div>
	
</body>

</table>