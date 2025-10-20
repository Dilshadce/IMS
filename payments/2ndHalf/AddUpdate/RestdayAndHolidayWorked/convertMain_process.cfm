<cftry>
<cfquery name="selectList" datasource="#dts#">
SELECT p.empno FROM paytran p, pmast pm
WHERE p.empno = pm.empno
<cfif #form.empnoFRom# neq "">
	AND pm.empno >= "#form.empnoFrom#"
</cfif>
<cfif #form.empnoTo# neq "">
	AND pm.empno <= "#form.empnoTo#"
</cfif>
<cfif #form.lineFrom# neq "">
	AND pm.plineno >= "#form.linenoFrom#"
</cfif>
<cfif #form.lineTo# neq "">
	AND pm.plineno <= "#form.linenoTo#"
</cfif>
<cfif #form.branchFrom# neq "">
	AND pm.brcode >= "#form.branchFrom#"
</cfif>
<cfif #form.branchTo# neq "">
	AND pm.brcode <= "#form.branchTo#"
</cfif>
<cfif #form.deptFrom# neq "">
	AND pm.deptcode >= "#form.deptFrom#"
</cfif>
<cfif #form.deptTo# neq "">
	AND pm.deptcode <= "#form.deptTo#"
</cfif>
<cfif #form.categoryFrom# neq "">
	AND pm.category >= "#form.categoryFrom#"
</cfif>
<cfif #form.categoryTo# neq "">
	AND pm.category <= "#form.categoryTo#"
</cfif>
<cfif #form.emp_code# neq "">
	AND pm.emp_code >= "#form.emp_code#"
</cfif>
<cfif #form.emp_code1# neq "">
	AND pm.emp_code <= "#form.emp_code1#"
</cfif>
</cfquery>

<cfquery name="getdate" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>
<cfset mon = #numberformat(getdate.mmonth,'00')# >
<cfset yrs = getdate.myear>


<cfloop query="selectList">

<cfquery name="get_list" datasource="#dts#">
SELECT SUM(Work_day) As TotalWD FROM pwork WHERE substr(work_date,1,4)<='#yrs#' and substr(work_date,6,2)<='#mon#' and empno = "#selectList.empno#"
</cfquery>

<cfset total_workday = #get_list.TotalWD#>

<cfquery name="update_AL" datasource="#dts#">
Update pmast SET aladj=#val(total_workday)# WHERE empno = "#selectList.empno#"
</cfquery>

</cfloop>

<cfset status_msg="Success Convert RD/PH to AL">
<cfcatch type="database">
<cfset status_msg="Fail To Convert RD/PH to AL. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc"  action="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/convertMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>

