<cfquery name="getEmp_qry" datasource="#dts#">
SELECT name,empno,plineno,brcode,deptcode,category,emp_code FROM pmast
WHERE 0=0 
		<cfif c neq ""> AND empno >= '#url.c#' </cfif><cfif p neq ""> AND empno <= '#url.p#' </cfif>
		<cfif a neq ""> AND emp_code >= '#url.a#' </cfif><cfif b neq ""> AND '#url.b#' </cfif> 
		<cfif m neq ""> AND plineno >= '#url.m#' </cfif><cfif n neq ""> AND '#url.n#' </cfif> 
		<cfif k neq ""> AND brcode >= '#url.k#' </cfif><cfif l neq ""> AND '#url.l#' </cfif>
		<cfif u neq ""> AND deptcode >= '#url.u#' </cfif><cfif v neq ""> AND '#url.v#' </cfif> 
		<cfif x neq ""> AND category >= '#url.x#' </cfif><cfif y neq ""> AND '#url.y#' </cfif>
</cfquery>

	<table>
		<tr>
			<th width="85px">Employee No.</th>
			<th width="370px">Name</th>
			<th width="50px">Action</th>
		</tr>
		<cfoutput query="getEmp_qry">
		<tr><input type="hidden" name="empno" value="#getEmp_qry.empno#" />
			<td><input type="text" size="12" name="empno" value="#getEmp_qry.empno#" readonly="yes" /></td>
			<td><input type="text" size="60" name="name" value="#getEmp_qry.name#" readonly="yes" /></td>
			<td>
				<a href="##" onclick="window.open('/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceLeave_add.cfm?empno=#getEmp_qry.empno#', 'windowname1', 'width=700, height=600, left=100, top=30');" />
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Add</a>
			</td>	
		</tr>
		</cfoutput>
	</table>
    	</div>
	
	<br />
	<center>
		<input type="button" name="update leaves into payroll" value="Update Leaves Into Payroll">
		<input type="button" name="cancel" value="Cancel" onclick="window.location.href='hnlList.cfm';">
	</center>
</div>