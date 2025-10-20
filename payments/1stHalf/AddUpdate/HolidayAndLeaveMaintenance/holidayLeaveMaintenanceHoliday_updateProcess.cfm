<cfset hol_count = numberformat(form.day_count,'.__')>

<cftry>
<cfquery name="update" datasource="#dts#">
UPDATE paytra1 p, pmast pm
SET	p.PH = "#evaluate('hol_count')#"
WHERE p.empno = pm.empno
<cfif #form.empno# neq "">
	AND pm.empno >= "#form.empno#"
</cfif>
<cfif #form.empno1# neq "">
	AND pm.empno <= "#form.empno1#"
</cfif>
<cfif #form.lineno# neq "">
	AND pm.plineno >= "#form.lineno#"
</cfif>
<cfif #form.lineno1# neq "">
	AND pm.plineno <= "#form.lineno1#"
</cfif>
<cfif #form.brcode# neq "">
	AND pm.brcode >= "#form.brcode#"
</cfif>
<cfif #form.brcode1# neq "">
	AND pm.brcode <= "#form.brcode1#"
</cfif>
<cfif #form.deptcode# neq "">
	AND pm.deptcode >= "#form.deptcode#"
</cfif>
<cfif #form.deptcode1# neq "">
	AND pm.deptcode <= "#form.deptcode1#"
</cfif>
<cfif #form.category# neq "">
	AND pm.category >= "#form.category#"
</cfif>
<cfif #form.category1# neq "">
	AND pm.category <= "#form.category1#"
</cfif>
<cfif #form.emp_code# neq "">
	AND pm.emp_code >= "#form.emp_code#"
</cfif>
<cfif #form.emp_code1# neq "">
	AND pm.emp_code <= "#form.emp_code1#"
</cfif>
</cfquery>
<cfset status_msg="Success Update Holiday">
<cfcatch type="database">
<cfset status_msg="Fail To Update Holiday. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc"  action="/payments/1stHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday_update.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>
