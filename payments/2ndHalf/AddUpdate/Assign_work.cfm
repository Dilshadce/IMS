<cfoutput>
<cfquery name="project_qry" datasource="#dts#">
    SELECT project,desp FROM project p;
</cfquery>

		<table>
			<tr>
				<th width="100px">Project Code</th>
				<th width="200px">Project Description</th>
				<th width="100px">DW</th>
				<th width="100px">Action</th>
			</tr>
				
				<cfloop query = "project_qry">
					<cfquery name="proj_pay" datasource="#dts#">
						SELECT tot_dw FROM proj_pay where project = "#project_qry.project#" and empno = "#URLDecode(url.empno)#"  
					</cfquery>
					<form method="post" action="act_process.cfm?type=add">
						<tr>
							<input type="hidden" name="empno" id="empno" value="#url.empno#">
							<td>#project_qry.project#</td>
							<input type="hidden" name="project_2" id="project_2" value="#project_qry.project#">
							<td>#project_qry.desp#</td>
							<td><input type="text" name="tot_dw" id="tot_dw" value="#val(proj_pay.tot_dw)#"/></td>
							<td><input name="allEmp" type="checkbox" value="allEmp" />For All Employee</td>
							<td><input type="submit" value="Save" ></td>
						</tr>
					</form>
				</cfloop>
			</table>
			This is daily report module.
			That Total day of work is come from dairy record report.
			Please kindly have a check and then tell me where need to modify...TQ
</cfoutput>