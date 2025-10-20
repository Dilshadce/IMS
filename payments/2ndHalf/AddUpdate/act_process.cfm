<cfif url.type eq "add">
	<cfquery name="select_emp_list" datasource="#dts#">
			select empno from paytran <cfif isdefined("form.allEMP") eq false>WHERE empno = "#form.empno#"</cfif>
		</cfquery>
		<cfloop query="select_emp_list" >
			<cfquery name="prj_emp" datasource="#dts#">
				select empno, project from proj_pay WHERE EMPNO = "#select_emp_list.EMPNO#" AND PROJECT = "#form.project_2#"
			</cfquery>
			<cfif prj_emp.recordcount eq 0>
				<cfquery name="insert_all" datasource="#dts#">
					INSERT INTO proj_pay(empno,project, tot_dw)
					VALUES (
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#select_emp_list.empno#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_2#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tot_dw#">
							)
				</cfquery>
			<cfelse>
				<cfquery name="insert_all" datasource="#dts#">
					update proj_pay
					set	tot_dw = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tot_dw#">
                    WHERE EMPNO = "#select_emp_list.EMPNO#" AND PROJECT = "#form.project_2#"
				</cfquery>
			</cfif>
		</cfloop> 
<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#form.empno#">
</cfif>