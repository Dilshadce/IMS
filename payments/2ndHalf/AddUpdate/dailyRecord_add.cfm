<html>
<head>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
	<script language="javascript">
		function validate_required()
		{
			var valproject_desp = document.getElementById('project_desp').value;
			var msg="";
			if(valproject_desp == "")
			{
			
				msg = msg + "Project is required.\n";
			}
			
			if(msg != "")
		   	{
		   		alert(msg);
		   		return false;
		   	}
			else
			{
			return true;
			}
			
		}
	</script>
	
</head>
<body>
<cfquery name="employee_data" datasource="#dts#">
SELECT * FROM pmast as pm WHERE pm.empno="#URLDecode(url.empno)#"
</cfquery>

<cfquery name="ot_qry" datasource="#dts#">
SELECT ot_desp, ot_unit FROM ottable
WHERE ot_cou between 1 and 6
</cfquery>


<cfquery name="project_qry" datasource="#dts#">
SELECT project, desp FROM project
where project = "#URLDecode(url.project)#"
</cfquery>

<cfoutput>
<div>Maintain Daily Record</div>
<cfform name="tform" method="post" action="act_daily_Record.cfm?type=add" onsubmit="return validate_required()">
<table >
	<tr>
		<th>Employee Number:</th>
		<td><input name="empno" id="empno" type="text" value="#url.empno#" readonly/></td>
	</tr>
	<tr>
		<th>Employee Name:</th>
		<td><input type="text" value="#employee_data.name#" readonly="true"/></td>
	</tr>
	<tr>
		<th>Project:</th>
		<td><input id="project_desp" name="project_desp" type="text" value="#URLDecode(url.project)#" readonly="true"/></td>
			<!--- <select id="project_desp" name="project_desp">
				<cfloop query="project_qry">
					<option value="#project_qry.project#">#project_qry.desp#</option>
				</cfloop>	
			</select> --->
			
		</td>
	</tr>
	<tr>
		<th>Date </th>
		<td><input type="text" size="15" name="otdate" id="otdate" value="#dateformat(now(),'dd/mm/yyyy')#" />
		<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('otdate'));"></td>
	</tr>
        <cfquery name="prj_pay_qry" datasource="#dts#">
            select tot_dw from proj_pay where empno = "#URLDecode(url.empno)#" and project= "#URLDecode(url.project)#"
        </cfquery>
    <tr>
		<th>Day of work :</th>
		<td><input name="dw" id="dw" type="text" value="#prj_pay_qry.tot_dw#" readonly="true"/></td>
	</tr>
	<tr>
		<th>MC:</th>
		<td><input name="mc" id="mc" type="text" value="0" /></td>
	</tr>
	<tr>
		<th>NPL</th>
		<td><input name="npl" id"npl" type="text"  value="0" /></td>
		<td><input name="allEmp" type="checkbox" value="allEmp" />For All Employee</td>
	</tr>
</table>
<hr>
<table >
			<tr>
				<th></th>
				<th width="100">OT FROM</th>
				<th>OT TO</th>
				<th>TOTAL HOUR</th>
				<th>OT DESCRIPTION</th>
			</tr>
			
			
			<cfset i=1>
			<cfloop query="ot_qry">
				<cfif i lte 4>
				<tr><input type="hidden" id="OT_name" name="OT_name" value="#ot_qry.ot_desp#" readonly="true">
					<th>#ot_qry.ot_desp#</th>
					<td><cfinput type="text" id="timeFr#i#" name="timeFr#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time From as show." value="" >(hh:mm)</td>
					<td><cfinput type="text" id="timeTo#i#" name="timeTo#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time To as show." value="" >(hh:mm)</td>
					<td><input name="OT_Hour#i#" id="OT_Hour#i#" type="text" value=""></td>
					<td><textarea name="desp#i#" id="desp#i#" row="1" col="5" ></textarea></td>
				</tr>
			<cfelse>
				<tr><input type="hidden" id="OT_name" name="OT_name" value="#ot_qry.ot_desp#" readonly="true">
					<th>#ot_qry.ot_desp#</th>
					<td><cfinput type="text" id="timeFr#i#" name="timeFr#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time From as show." value="" >(yyyymmdd)</td>
					<td><cfinput type="text" id="timeTo#i#" name="timeTo#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time To as show." value="" >(yyyymmdd)</td>
					<td><input name="OT_Hour#i#" id="OT_Hour#i#" type="text" value=""></td>
					<td><textarea name="desp#i#" id="desp#i#" row="1" col="5" ></textarea></td>
				</tr>
			</cfif>
			<cfset i=i+1>
			</cfloop>
</table>	
<table>		
  			<tr>
				<td width="400"></td>
				<td><input type="submit" value="Save" ></td>
				<td><input type="button" name="exit" value="Exit" onClick="window.location='normalPayEditForm.cfm?empno=#employee_data.empno#';"><td>
				<td></td>
				<td></td>
			</tr>	
</table>		

	
</cfform>
</cfoutput>
</body>

</html>

