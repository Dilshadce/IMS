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
		if (validate_required(date,"Date must be filled out!")==false)
		  {date.focus();return false;}
		}
		}
		
		function confirmDelete(entryno,type,empno) {
		var answer = confirm("Confirm Delete?")
		if (answer){
			window.location = "maintainMain_process.cfm?type="+type+ "&entryno="+entryno+ "&empno="+empno;
			}
		else{
			
			}
		}
	</script>	
	
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
	
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name FROM pmast
WHERE empno='#empno#'
</cfquery>

<cfquery name="pwork_qry" datasource="#dts#">
SELECT * FROM pwork WHERE empno='#getEmp_qry.empno#'
</cfquery>

<body>
<div class="mainTitle">Maintain RD/PH Work</div>
<div class="tabber">
	<cfoutput>
	<form name="eForm" action="maintainMain_process.cfm"  onSubmit="return validate_form(this)"  method="post">
	<table>
		<tr>
			<th>Employee No.</th>
			<td><input type="text" size="12" name="empno" value="#getEmp_qry.empno#" /></td>
		</tr>
		<tr>
			<th>Name</th>
			<td colspan="2"><input type="text" size="60" name="name" value="#getEmp_qry.name#" /></td>
		</tr>
		<tr>
			<th>Type</th>
			<td><select id="leaveType" name="leaveType">
					<option id="RD" value="hr5">Rest Day</option>
					<option id="PH" value="hr6">Public Holiday</option>
				</select></td>
		</tr>
		<tr>
			<th>Date</th>
			<td><input type="text" size="15" name="date" value="" />
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(date);"></td>
		</tr>
		<tr>
			<th>No. Of Day</th>
			<td><input type="text" size="12" name="numDay" value="1.00" maxlength="5"/></td>
			<td><input type="checkbox" name="allEMP" value="" />For All Employee</td>
		</tr>
	</table>
	</cfoutput>
	<br />
	<center>
		<input type="submit" name="save" value="Save">
		<input type="button" name="exit" value="Exit" onclick="window.close()">
	</center>
	<br />
	</form>
	 
	<!---input type="hidden" name="count" value="0" />
	<table id="tit" class="form" border="0"--->
	<table class="form" border="0">
		<tr>
			<th width="280px">Type</th>
			<th width="120px">Date</th>
			<th width="80px">No Of Date</th>
			<th>Action</th>
		</tr>
		
		<cfoutput query="pwork_qry">
		<input type="hidden" name="empno" value="#pwork_qry.empno#" />
		<input type="hidden" name="entryno" value="#pwork_qry.entryno#" />
		<tr>
			<td>
            <cfset work_type1="">
            <cfif pwork_qry.work_type eq "hr5">
            <cfset work_type1 = "Rest Day">
            <cfelseif pwork_qry.work_type eq "hr6">
            <cfset work_type1 = "Public Holiday">
            </cfif>
				<input type="text" name="work_type__r#pwork_qry.empno#" value="#work_type1#" size="45" maxlength="10" />
			</td>
			<td>
				<input type="text" name="work_date__r#pwork_qry.empno#" value="#lsdateformat(pwork_qry.work_date,"dd/mm/yyyy")#" size="18" />
			</td>
			<td>
				<input type="text" name="work_day__r#pwork_qry.empno#" value="#pwork_qry.work_day#" size="18" />
			</td>
			<td>
				<a href="##" onclick="confirmDelete(#pwork_qry.entryno#,'del','#pwork_qry.empno#')">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>			
			</td>
		</tr>
		</cfoutput>
	</table>
	<br />
</div>	
</body>
</table>