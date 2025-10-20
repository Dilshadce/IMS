<html>
<head>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
	
	
</head>
<body>
<cfquery name="employee_data" datasource="#dts#">
SELECT * , DATE_FORMAT(otdate,'%d/%m/%Y') as otdate1 FROM pmast as pm LEFT JOIN ot_record AS ot ON pm.empno=ot.empno WHERE ot.entryno="#url.entryno#" 
</cfquery>

 <cfquery name="ot_qry" datasource="#dts#">
SELECT ot_desp, ot_unit FROM ottable
WHERE ot_cou between 1 and 6
</cfquery>

<cfoutput>
<div>Maintain Daily Record</div>
<cfform name="tform" method="post" action="act_daily_Record.cfm?type=update&entryno=#url.entryno#">
<table >
	<input type="hidden" name="entryno" id="entryno" value="#url.entryno#">
	 <tr>
		<th>Employee Number:</th>
		<td><input name="empno" id="empno" type="text" value="#employee_data.empno#" readonly="true"/></td>
	</tr>
	<tr>
		<th>Employee Name:</th>
		<td><input name="name" id="name" type="text" value="#employee_data.name#" readonly="true"/></td>
	</tr>
	<tr>
		<th>Project:</th>
		<td><input name="project_desp" id="project_desp" type="text" value="#employee_data.project_desp#" readonly="true"/></td>
			
	</tr> 
	<tr>
		<th>Date </th>
		<td><input type="text" size="15" name="otdate" value="#employee_data.otdate1#" readonly="true"/>
		</td>
	</tr>
	 <cfquery name="prj_pay_qry" datasource="#dts#">
            select tot_dw from proj_pay where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#employee_data.empno#"> and project= "#employee_data.project_desp#"
        </cfquery>
    <tr>
		<th>Day of work </th>
		<td><cfinput name="dw" id="dw" type="text" value="#prj_pay_qry.tot_dw#" readonly="true"/></td>
	</tr>
	<tr>
		<th>MC:</th>
		<td><input name="mc" id="mc" type="text" value="#employee_data.mc#" /></td>
	</tr>
	<tr>
		<th>NPL</th>
		<td><input name="npl" id"npl" type="text"  value="#employee_data.npl#" /></td>
		<td><input name="allEmp" type="checkbox" value="allEmp" />
		  Update For All Employee in Same Project and Date.</td>
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
			<tr>
				<th>#ot_qry.ot_desp#</th>
				
				<td><cfinput type="text" id="timeFr#i#" name="timeFr#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time From as show." value="#evaluate('employee_data.timeFr#i#')#" >(hh:mm) 24hr</td>
				<td><cfinput type="text" id="timeTo#i#" name="timeTo#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time To as show." value="#evaluate('employee_data.timeTo#i#')#" >(hh:mm)24hr</td>
				<td><input name="OT_Hour#i#" id="OT_Hour#i#" type="text" value="#evaluate('employee_data.OT_Hour#i#')#"></td>
				<td><textarea name="desp#i#" id="desp#i#" row="1" col="5" >#evaluate('employee_data.desp#i#')#</textarea></td>
			</tr>
			<cfelse>
			<tr><input type="hidden" id="OT_name" name="OT_name" value="#ot_qry.ot_desp#" readonly="true">
				<th>#ot_qry.ot_desp#</th>
			
				<td><cfinput type="text" id="timeFr#i#" name="timeFr#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time From as show." value="#evaluate('employee_data.timeFr#i#')#" >(yyyymmdd)</td>
				<td><cfinput type="text" id="timeTo#i#" name="timeTo#i#" maxLength="5" validateat="onSubmit" validate="time" required="false" message="Please fill Time To as show." value="#evaluate('employee_data.timeTo#i#')#" >(yyyymmdd)</td>
				<td><input name="OT_Hour#i#" id="OT_Hour#i#" type="text" value="#evaluate('employee_data.OT_Hour#i#')#"></td>
				<td><textarea name="desp#i#" id="desp#i#" row="1" col="5" >#evaluate('employee_data.desp#i#')#</textarea></td>
			</tr>
			</cfif>
			<cfset i=i+1>
			</cfloop>
</table>	
<table>		
  			<tr>
				<td width="400"></td>
				<td><input type="submit" value="Save"></td>
				<td><input type="button" name="exit" value="Exit" onClick="window.location='normalPayEditForm.cfm?empno=#employee_data.empno#';"><td>
				<td></td>
				<td></td>
			</tr>	
</table>

	
</cfform>
</cfoutput>
</body>

</html>

