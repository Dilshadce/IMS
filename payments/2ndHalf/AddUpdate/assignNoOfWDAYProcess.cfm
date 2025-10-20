<cfset update_attrib = form.option1>
<cftry>
<cfquery name="update" datasource="#dts#">
UPDATE paytran p, pmast pm
SET	p.#update_attrib# = "#evaluate('form.day_no')#"
WHERE p.empno = pm.empno
<cfif #form.empno_frm# neq "">
	AND pm.empno >= "#form.empno_frm#"
</cfif>
<cfif #form.empno_to# neq "">
	AND pm.empno <= "#form.empno_to#"
</cfif>
<cfif #form.line_frm# neq "">
	AND pm.plineno >= "#form.line_frm#"
</cfif>
<cfif #form.line_to# neq "">
	AND pm.plineno <= "#form.line_to#"
</cfif>
<cfif #form.branch_frm# neq "">
	AND pm.brcode >= "#form.branch_frm#"
</cfif>
<cfif #form.branch_to# neq "">
	AND pm.brcode <= "#form.branch_to#"
</cfif>
<cfif #form.dept_frm# neq "">
	AND pm.deptcode >= "#form.dept_frm#"
</cfif>
<cfif #form.dept_to# neq "">
	AND pm.deptcode <= "#form.dept_to#"
</cfif>
<cfif #form.cat_frm# neq "">
	AND pm.category >= "#form.cat_frm#"
</cfif>
<cfif #form.cat_to# neq "">
	AND pm.category <= "#form.cat_to#"
</cfif>
<cfif #form.empcode_frm# neq "">
	AND pm.emp_code >= "#form.empcode_frm#"
</cfif>
<cfif #form.empcode_to# neq "">
	AND pm.emp_code <= "#form.empcode_to#"
</cfif>
<cfif #form.payrtype# neq "">
	AND pm.payrtype = "#form.payrtype#"
</cfif>
</cfquery>
<cfset status_msg="Success Update #form.day_no# #update_attrib#">
<cfcatch type="database">
<cfset status_msg="Fail To #update_attrib#. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc" action="/payments/2ndHalf/addUpdate/assignNoOfWDAYMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>