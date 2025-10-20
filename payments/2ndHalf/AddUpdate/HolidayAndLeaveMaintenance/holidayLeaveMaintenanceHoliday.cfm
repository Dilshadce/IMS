<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Maintain Holidays - Holiday Table</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
	<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
	
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
		newCel0.innerHTML = '<input type="text" name="ndate__r'+row+'" size="18" maxlength="10" />';
		var newCel1 = newRow.insertCell(1);
		newCel1.innerHTML = '<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(ndate__r'+row+');">';
		var newCel2 = newRow.insertCell(2);
		newCel2.innerHTML = '<input type="text" name="ndesp__r'+row+'" size="70" maxlength="12" />';
	}
	
	function confirmDelete(entryno,type) {
	var answer = confirm("Confirm Delete?")
	if (answer){
		window.location = "holidayLeaveMaintenanceHoliday_process.cfm?type="+type+ "&entryno="+entryno;
		}
	else{
		
		}
	}
	
	</script>
	
</head>

<cfquery name="holiday_qry" datasource="#dts#">
SELECT * FROM holtable ORDER BY hol_date ASC
</cfquery>

<body>
	<div class="mainTitle">Holiday Table</div>
	<div class="tabber">
	<table>
		<tr>
			<td>Search :</td>
			<td><select id="sdate" name="sdate" onChange="ajaxFunction(document.getElementById('ajaxField'),'holidayLeaveMaintenanceholiday_ajax.cfm?c='+this.options[this.selectedIndex].id);">
				<option id="default"  value="default">All</option>
				<cfoutput query="holiday_qry">
				<option id="#holiday_qry.entryno#" value="#holiday_qry.entryno#">#lsdateformat(holiday_qry.hol_date,"dd/mm/yyyy")#</option>
				</cfoutput>
			</select></td>
		</tr>
	</table>
	<div id="ajaxField" name="ajaxField">
	<form name="eForm" action="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday_process.cfm" method="post">
		<input type="hidden" name="count" id="count" value="0" />
		<table id="tit" class="form" border="0">
			
		<tr>
			<th width="100px" colspan="2">Date</th>
			<th width="380px">Description</th>
			<th width="120px" colspan="2">Action</th>
		</tr>
		<cfoutput query="holiday_qry">
		<tr><input type="hidden" name="entryno" value="#holiday_qry.entryno#" />
			<td><input type="text" name="hol_date__r#entryno#" value="#lsdateformat(holiday_qry.hol_date,"dd/mm/yyyy")#" size="18" maxlength="10" /></td>
	  <td>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(hol_date__r#entryno#);">			</td>
			<td>
				<input type="text" name="hol_desp__r#entryno#" value="#holiday_qry.hol_desp#" size="70" />			</td>
			<!--- <td>
				<a href="##" onclick="window.open('/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday_update.cfm?entryno=#holiday_qry.entryno#', 'windowname1', 'width=700, height=400, left=100, top=30');">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Update</a>
			</td>	 --->
			<td>
				<a href="##" onclick="confirmDelete(#holiday_qry.entryno#,'del')">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>			</td>
		</tr>
		</cfoutput>
		</table>
	  </div>
	<br />
	<center>
		<input type="button" name="print" value="Print" onclick="window.open('holidayLeaveMaintenanceHoliday_print.cfm','windowname1', 'width=700 height=600 left=100 top=30');"/>
        
		<input type="reset" name="reset" value="Reset">
        <input type="button" name="update" value="update" onclick="window.open('/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday_update.cfm', 'windowname1', 'width=700, height=400, left=100, top=30');">
		<input type="button" name="add" value="ADD ROW" onClick="appendRow()">
		<input type="submit" name="save" value="Save">
		<input type="button" name="exit" value="Exit" onclick="window.location.href='hnlList.cfm';">
	</center>
	</form>
	</div>
</body>
</html>
