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
		}
		
		function validate_form(thisform)
		{ 
			with (thisform)
			{
			 if (validate_required(dateFrom,"Date From must be filled out!")==false
				|| validate_required(dateTo,"Date To must be filled out!")==false)
			  {dateFrom || dateTO.focus();return false;}
			 
			
			 var datef = document.getElementById('dateFrom').value;
			 var datefsplit = datef.split("/");
			 var datet = document.getElementById('dateTo').value;
			 var datetsplit = datet.split("/"); 
				if ( datefsplit[1] > datetsplit[1] || datefsplit[1] < datetsplit[1])
				{
				alert("The date of leave should be in same month.");
				return false;
				} 
			}
		
			var leaveType1 = document.eForm.leaveType.value;
			var national = document.eForm.national.value;
			var sex = document.eForm.sex.value;
			var mstatus = document.eForm.mstatus.value;
		
			 if(leaveType1 == "CC")
			 {
			  if (national == "SG" && sex =="F" && mstatus =="M")
			  {
			 	return true;
			  }
			else{
			 	alert("You are not qualify to apply Child Care Leave");
				return false;
			 	}
			  return true;
			 }
			 
		 }
		 
		function confirmDelete(entryno,type,empno) {
		var answer = confirm("Confirm Delete?")
		if (answer){
			window.location = "holidayLeaveMaintenanceLeave_process.cfm?type="+type+ "&entryno="+entryno+ "&empno="+empno;
			}
		else{
			
			}
		}
		
		function updateform(entryno){
			var var_lve_type = "lve_type__r"+entryno;
			var var_lve_dateFr = "lve_date__r"+entryno;
			var var_lve_day = "lve_day__r"+entryno;
			var var_lve_type__r1 = "lve_type__r1"+entryno;
			var newoption = document.getElementById(var_lve_type).value;
			var newoptionvalue= document.getElementById(var_lve_type__r1).value;
			
			document.getElementById('entryno').value= entryno;
			document.eForm.leaveType.options[1] = new Option(newoption, newoptionvalue, true, true)
			<!--- document.getElementById('leaveType').value = document.getElementById(var_lve_type).value; --->
			document.getElementById('dateFrom').value =  document.getElementById(var_lve_dateFr).value;
			document.getElementById('numDay').value =  document.getElementById(var_lve_day).value;
			document.getElementById('save').value =  "update";
		}
		
		
		
	</script>

	<!--- var objDropdown = document.getElementById('dropdown');
			var objOption = new Option('3','3');
		document.write(objOption.value);
		objDropdown.options[objDropdown.length] = objOption; --->

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
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name,national,sex,mstatus FROM pmast
WHERE empno='#url.empno#'
</cfquery>

<cfquery name="leave_qry" datasource="#dts#">
SELECT * FROM pleave WHERE empno='#getEmp_qry.empno#' ORDER BY lve_type, LVE_DATE 
</cfquery>

<body>
	
<div class="mainTitle">Maintain Leaves</div>
<div class="tabber">
	<cfoutput>
	<form name="eForm" action="holidayLeaveMaintenanceLeave_process.cfm?empno=#url.empno#" onSubmit="return validate_form(this)" method="post">
	<input type="hidden" name="entryno" id="entryno" value="">
    <table>
      <tr>
        <th>Employee No.</th>
        <td><input type="text" size="12"  name="empno" value="#getEmp_qry.empno#" readonly="yes"/></td>
      </tr>
      <tr>
        <th>Name</th>
        <td colspan="2"><input type="text" size="60" value="#getEmp_qry.name#" readonly="yes"/></td>
      </tr>
      <input type="hidden" name="national" value="#getEmp_qry.national#"  />
      <input type="hidden" name="sex" value="#getEmp_qry.sex#" />
      <input type="hidden" name="mstatus" value="#getEmp_qry.mstatus#" />
      <tr>
        <th>Leave Type</th>
        <td><select id="leaveType" name="leaveType">
            <option id="AL" value="AL">Annual Leave</option>
            <option id="MC" value="MC">Medical Leave</option>
            <option id="MT" value="MT">Maternity Leave</option>
            <option id="CC" value="CC">ChildCare Leave</option>
            <option id="MR" value="MR">Marriage Leave</option>
            <option id="CL" value="CL">Compassionate Leave</option>
            <option id="HL" value="HL">Hospital Leave</option>
            <option id="EX" value="EX">Examination Leave</option>
            <option id="PT" value="PT">Paternity Leave</option>
            <option id="AD" value="AD">Advance Leave</option>
            <option id="OPL" value="OPL">Other Pay Leave</option>
            <option id="LS" value="LS">Line Shut Down</option>
            <option id="AB" value="AB">Absent</option>
            <option id="NPL" value="NPL">No Pay Leave</option>
        </select></td>
      </tr>
      <tr>
        <th>Date From</th>
        <td><input type="text" size="15" name="dateFrom" id="dateFrom" value="" />
            <img src="/images/cal.gif" width=17 height=15 border=0 onclick="showCalendarControl(dateFrom);" /></td>
      </tr>
      <tr>
        <th>Date To</th>
        <td><input type="text" size="15" name="dateTo" id="dateTo" value="" />
            <img src="/images/cal.gif" width=17 height=15 border=0 onclick="showCalendarControl(dateTo);" /></td>
      </tr>
      <tr>
        <th>No. Of Day</th>
        <td><input type="text" size="12" name="numDay" value="1.0000" maxlength="6"/></td>
        <td><input name="allEmp" type="checkbox" value="allEmp" />
          For All Employee</td>
      </tr>
    </table>
  </cfoutput>
  <br />
	<center>
		<input type="submit" name="save" value="Save" id="save">
		<input type="button" name="exit" value="Exit" onclick="window.close()">
	</center>
	<br />
	</form>
	<!---input type="hidden" name="count" value="0" /--->
	<div style="width:100%; height:400px; overflow:auto;">
	<table class="form" border="0">
		<tr>
			<th width="280px">Type</th>
			<th width="80px">Date From</th>
            <th width="80px">Date To</th>
		  <th width="120px">No Of Date</th>
			<th>Action</th>
		</tr>
		
		<cfoutput query="leave_qry">
		
		<input type="hidden" name="entryno" id="entryno" value="#leave_qry.entryno#" />
		<tr onclick="updateform(#leave_qry.entryno#)">	
			<td>
				<input type="hidden" name="lve_type__r1#leave_qry.entryno#" id="lve_type__r1#leave_qry.entryno#" value="#leave_qry.lve_type#" >
				<input type="text" name="lve_type__r#leave_qry.entryno#" id="lve_type__r#leave_qry.entryno#"
						<cfif #leave_qry.lve_type# eq "AL"> value="Annual Leave"
						<cfelseif #leave_qry.lve_type# eq "MC"> value="Medical Leave"
						<cfelseif #leave_qry.lve_type# eq "MT"> value="Maternity Leave"
                        <cfelseif #leave_qry.lve_type# eq "CC"> value="Child Care Leave"
						<cfelseif #leave_qry.lve_type# eq "MR"> value="Marriage Leave"
						<cfelseif #leave_qry.lve_type# eq "CL"> value="Compassionate Leave"
						<cfelseif #leave_qry.lve_type# eq "HL"> value="Hospital Leave"
						<cfelseif #leave_qry.lve_type# eq "EX"> value="Examination Leave"
						<cfelseif #leave_qry.lve_type# eq "PT"> value="Paternity Leave"
						<cfelseif #leave_qry.lve_type# eq "AD"> value="Advance Leave"
						<cfelseif #leave_qry.lve_type# eq "OPL"> value="Other Pay Leave"
						<cfelseif #leave_qry.lve_type# eq "LS"> value="Line Shut Down"
						<cfelseif #leave_qry.lve_type# eq "AB"> value="Absent"
						<cfelseif #leave_qry.lve_type# eq "NPL"> value="No Pay Leave"
						</cfif>
						size="45" maxlength="10" />
			</td>
			<td>
				<input type="text" name="lve_date__r#leave_qry.entryno#" id="lve_date__r#leave_qry.entryno#" value="#lsdateformat(leave_qry.lve_date,"dd/mm/yyyy")#" size="12" />
			</td>
            <td>
				<input type="text" name="lve_date__t#leave_qry.entryno#" id="lve_date__t#leave_qry.entryno#" value="<cfif leave_qry.lve_date_to eq "" or leave_qry.lve_date_to eq "0000-00-00"><cfelse>#lsdateformat(leave_qry.lve_date_to,"dd/mm/yyyy")#</cfif>" size="12" />
			</td>
			<td>
				<input type="text" name="lve_day__r#leave_qry.entryno#" id="lve_day__r#leave_qry.entryno#" value="#leave_qry.lve_day#" size="18" />
			</td>
	  <td>
				<a href="##" onclick="confirmDelete(#leave_qry.entryno#,'del','#leave_qry.empno#')">
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