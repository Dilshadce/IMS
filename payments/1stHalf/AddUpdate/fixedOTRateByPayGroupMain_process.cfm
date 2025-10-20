<cfloop from="1" to="6" index="i">
<cfquery name="update" datasource="#dts#">
UPDATE paytra1 p, pmast pm
SET	p.RATE#i# = "#evaluate('form.rate#i#')#" 
WHERE p.empno = pm.empno and pm.paystatus = "A" and confid >= #hpin#
<cfif #form.brate_frm# neq "">
	AND pm.brate >= "#form.brate_frm#"
</cfif>
<cfif #form.brate_to# neq "">
	AND pm.brate <= "#form.brate_to#"
</cfif>
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
</cfloop>

<cflocation url="/payments/1stHalf/addUpdate/fixedOTRateByPayGroupMain.cfm">