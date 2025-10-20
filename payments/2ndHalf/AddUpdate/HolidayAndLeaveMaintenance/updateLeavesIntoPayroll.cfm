<cftry>
<cfquery name="getdate" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfset mon = #numberformat(getdate.mmonth,'00')#>
<cfset yrs = getdate.myear>

<cfquery name="num_leave" datasource="#dts#">
SELECT * FROM pleave WHERE substr(lve_date,1,4)='#yrs#' and substr(lve_date,6,2)='#mon#'
</cfquery>

<cfquery name="updatezeroleave" datasource="#dts#">
UPDATE paytran SET AL = 0 WHERE empno not in (SELECT empno FROM pleave WHERE substr(lve_date,1,4)='#yrs#' and substr(lve_date,6,2)='#mon#' and LVE_TYPE = "AL" group by empno)
</cfquery>

<cfloop query="num_leave">

<cfquery name="sum_leave" datasource="#dts#">
SELECT sum(lve_day) as sumlve FROM pleave WHERE LVE_TYPE = "#num_leave.LVE_TYPE#" and empno = "#num_leave.empno#" and substr(lve_date,1,4)='#yrs#' and substr(lve_date,6,2)='#mon#'
</cfquery>

<cfquery name="Update_l" datasource="#dts#">
UPDATE paytran SET #num_leave.LVE_TYPE# = #sum_leave.sumlve# WHERE empno = "#num_leave.empno#"
</cfquery>

</cfloop>
<cfset status_msg="Success Update Leaves Into Payroll">
<cfcatch type="database">
<cfset status_msg="Fail To Update Leaves Into Payroll. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc"  action="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceLeave.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>
