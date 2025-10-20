<html>
<head>
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
	
<cfquery name="sdate_qry" datasource="#dts#">
SELECT * FROM holtable <cfif c neq "default">
WHERE  entryno = '#url.c#'</cfif>
</cfquery>

<body>

	<form name="eForm" action="/payments/1stHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday_process.cfm" method="post">
		<input type="hidden" name="count" id="count" value="0" />
		<table id="tit" class="form" border="0">
			
		<tr>
			<th width="100px" colspan="2">Date</th>
			<th width="380px">Description</th>
			<th width="120px" colspan="2">Action</th>
		</tr>
		<cfoutput query="sdate_qry">
		<tr>
			<td>
				<input type="hidden" name="entryno" value="#sdate_qry.entryno#" />
				<input type="text" name="hol_date__r#entryno#" value="#lsdateformat(sdate_qry.hol_date,"dd/mm/yyyy")#" size="18" maxlength="10" />
			</td>
			<td>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(hol_date__r#entryno#);">
			</td>
			<td>
				<input type="text" name="hol_desp__r#entryno#" value="#sdate_qry.hol_desp#" size="70" />
			</td>
	
			<td>
				<a href="##" onClick="confirmDelete(#sdate_qry.entryno#,'del')">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>			
			</td>
		</tr>
		</cfoutput>
		</table>
        </div>
	<br />
	<center>
		<input type="button" name="print" value="Print" onclick="window.open('holidayLeaveMaintenanceHoliday_print.cfm','windowname1', 'width=700 height=600 left=100 top=30');"/>
        
		<input type="reset" name="reset" value="Reset">
        <input type="button" name="update" value="update" onclick="window.open('/payments/1stHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday_update.cfm', 'windowname1', 'width=700, height=400, left=100, top=30');">
		<input type="button" name="add" value="ADD ROW" onClick="appendRow()">
		<input type="submit" name="save" value="Save">
		<input type="button" name="exit" value="Exit" onclick="window.location.href='hnlList.cfm';">
	</center>
	</form>
	</div>
	<br />
	
	</form>

</body>
</html>