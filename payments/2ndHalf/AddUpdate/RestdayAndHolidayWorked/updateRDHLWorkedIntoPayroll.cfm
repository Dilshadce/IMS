<cftry>
<cfquery name="getdate" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfset mon = #numberformat(getdate.mmonth,'00')# >
<cfset yrs = getdate.myear>

<cfquery name="num_rdhlworked" datasource="#dts#">
SELECT * FROM pwork WHERE substr(work_date,1,4)='#yrs#' and substr(work_date,6,2)='#mon#'
</cfquery>

<cfloop query="num_rdhlworked">
<cfquery name="Update_l" datasource="#dts#">
UPDATE paytran, pwork SET paytran.#num_rdhlworked.WORK_TYPE# = #num_rdhlworked.WORK_DAY# WHERE paytran.empno = pwork.empno
</cfquery>
</cfloop>
<cfset status_msg="Success Update Rest Day and Public Holiday Worked Into Payroll">
<cfcatch type="database">
<cfset status_msg="Fail To Update Rest Day and Public Holiday Worked Into Payroll. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc"  action="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/maintainMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	 pc.submit();
</script>
