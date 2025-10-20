<cfif isdefined ("url.type")>
	<cfquery name="delete_qry" datasource="#dts#">
	DELETE FROM pleave WHERE entryno = '#url.entryno#'
	</cfquery>
	<cflocation url="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceLeave_add.cfm?empno=#url.empno#">

<cfelse>

	 <cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dateFrom#" returnvariable="cfc_lfdate" />
	 <cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dateTo#" returnvariable="cfc_ltdate" />

	 
	
		<cfif isdefined("form.allEMP")>
	
			<cfquery name="select_emp_list" datasource="#dts#">
			select empno from paytran
			</cfquery>
		
			<cfloop query="select_emp_list">
			
			<cfquery name="add_leave" datasource="#dts#">
			INSERT INTO pleave
			(EMPNO,LVE_TYPE,LVE_DATE,LVE_DAY,LVE_DATE_TO)
			VALUES
			("#select_emp_list.empno#",
			"#form.leaveType#",
			"#cfc_lfdate#",
			#numberformat(form.numDay,'.__')#,
            "#cfc_ltdate#"
            )
			</cfquery>
			
			</cfloop>
		
		<cfelseif form.save eq "update">
			<cfquery name="update_leave" datasource="#dts#">
			Update pleave 
			set LVE_TYPE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leaveType#">,
				LVE_DATE = "#cfc_lfdate#",
                LVE_DATE_TO = "#cfc_ltdate#",
				LVE_DAY = "#numberformat(form.numDay,'.__')#"
			where entryno="#form.entryno#"
			</cfquery>		
			 
			
		
		<cfelse>
		
			<cfquery name="add_leave" datasource="#dts#">
			INSERT INTO pleave
			(EMPNO,LVE_TYPE,LVE_DATE,LVE_DAY,LVE_DATE_TO)
			VALUES
			("#form.empno#",
			"#form.leaveType#",
			"#cfc_lfdate#",
			#numberformat(form.numDay,'.__')#,
            "#cfc_ltdate#")
			</cfquery>
		
		</cfif>
		<cflocation url="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceLeave_add.cfm?empno=#url.empno#">
	
<!--- <cfset date4 = datediff("d","#cfc_lfdate#","#cfc_ltdate#")+1>

<cfloop from="1" to="#date4#" index="i">

<cfquery name="add_leave" datasource="#dts#">
INSERT INTO pleave
(EMPNO,LVE_TYPE,LVE_DATE,LVE_DAY)
VALUES
(#form.empno#,
"#form.leaveType#",
#cfc_lfdate#,
#numberformat(form.numDay,'0')#)
</cfquery>

<cfset cfc_lfdate = dateadd('d',1,cfc_lfdate)>


</cfloop>
 --->
</cfif>
