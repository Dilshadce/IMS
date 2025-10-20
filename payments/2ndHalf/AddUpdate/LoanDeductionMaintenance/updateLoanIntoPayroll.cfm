<cftry>
<cfquery name="getdate" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfset mon = #numberformat(getdate.mmonth,'00')# >
<cfset yrs = getdate.myear>
<cfset datestart = CreateDate(#yrs#, #mon#, 1) >
<cfset dateend = CreateDate(#yrs#, #mon#, #DaysInMonth(datestart)#)>


<cfquery name="num_loan" datasource="#dts#">
SELECT * FROM loanmst WHERE DATES1 < #datestart# and DATEE1 > #dateend#
</cfquery>

<cfloop query="num_loan">
<cfset ded_basic = 0>
<cfquery name="select_basic_deduction" datasource="#dts#">
SELECT SUM(loanret1) as totalLoan FROM loanmst WHERE empno = #num_loan.empno# and DEDNUM = #num_loan.DEDNUM#
</cfquery>

<cfoutput>
<cfif num_loan.dednum lt 10>
<cfset dednum1 = "ded10"&#num_loan.DEDNUM#>
<cfelse>
<cfset dednum1 = "ded1"&#num_loan.DEDNUM#>
</cfif>
</cfoutput>
<cfset new_ded = select_basic_deduction.totalLoan >
<cfquery name="update_ded" datasource="#dts#">
UPDATE paytran SET #dednum1# = #new_ded# WHERE empno = #num_loan.empno#
</cfquery>
</cfloop>
<cfset status_msg="Update Loan Deduction Into Payroll Success">
<cfcatch type="database">
<cfset status_msg="Update Loan Deduction Into Payroll Failed. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc" action="/payments/2ndHalf/AddUpdate/LoanDeductionMaintenance/updateMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>

 