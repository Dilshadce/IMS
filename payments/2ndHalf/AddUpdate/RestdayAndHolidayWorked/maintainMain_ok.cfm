<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Maintain RD/PH Work</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	<script language="javascript">
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
	</script>
	
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name FROM pmast
</cfquery>

<cfquery name="pwork_qry" datasource="#dts#">
SELECT * FROM pwork
</cfquery>

<body>
<div class="mainTitle">Maintain RD/PH Work</div>
<div class="tabber">
	<table>
		<tr>
			<th>Employee No.</th>
			<td><input type="text" size="12" name="" value="" /></td>
		</tr>
		<tr>
			<th>Name</th>
			<td colspan="2"><input type="text" size="60" name="" value="" /></td>
		</tr>
	</table>
	
	<form name="eForm" action="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/maintainMain_process.cfm" method="post">
	<input type="hidden" name="count" id="count" value="0" />
	<table id="tit" class="form" border="0">
		<tr>
			<th width="280px">Type</th>
			<th width="150px" colspan="2">Date</th>
			<th width="120px">No Of Date</th>
		</tr>
		<cfoutput query="pwork_qry">
		<input type="hidden" name="empno" value="#pwork_qry.empno#" />
		<tr>
			<td>
				<input type="text" name="work_type__r#pwork_qry.empno#" value="#pwork_qry.work_type#" size="45" maxlength="10" />
			</td>
			<td>
				<input type="text" name="work_date__r#pwork_qry.empno#" value="#pwork_qry.work_date#" size="18" />
			</td>
			<td>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl();">
			</td>
			<td>
				<input type="text" name="work_day__r#pwork_qry.empno#" value="#pwork_qry.work_day#" size="18" />
			</td>
			<td>
				<a href="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/maintainMain_process.cfm?type=delete&empno=#pwork_qry.empno#">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>			
			</td>
		</tr>
		</cfoutput>
	</table>
	<br />
	<center>
		<input type="button" name="add" value="Add" onClick="appendRow()">
		<input type="submit" name="save" value="Save">
		<input type="button" name="exit" value="Exit" onclick="window.close()">
	</center>
</div>	
</body>
</table>