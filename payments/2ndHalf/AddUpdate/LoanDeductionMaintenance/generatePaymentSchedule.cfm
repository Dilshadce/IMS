<cftry>
<cfset empno=url.empno>
<cfquery name="select_loan_list" datasource="#dts#">
SELECT * FROM loanmst WHERE empno = "#empno#"
</cfquery>

<cfset entrynum = ArrayNew(1)>

<cfloop query="select_loan_list">
<cfset ArrayAppend(entrynum, #select_loan_list.entryno#)>
</cfloop>

<cfset loan_count = select_loan_list.recordcount>

<cfloop from="1" to="#loan_count#" index="i">
<cfset entryno1 = #entrynum[i]# >

<cfquery name="entry_list" datasource="#dts#">
SELECT * FROM loanmst WHERE entryno = #entryno1#
</cfquery>

<cfset loan_repayment = #entry_list.loanret1# >

<cfif #loan_repayment# gt 0>
<cfset loanamt = #entry_list.loanamt# >
<cfset for_month = loanamt / loan_repayment >

<cfset date_from = #entry_list.DATES1# >
<cfset for_month = ROUND(for_month) >

<cfset newdate = DateAdd('m', #for_month# , '#date_from#') >
<cfquery name="update_new_date" datasource="#dts#">
UPDATE loanmst SET DATEE1 = #newdate# WHERE entryno = #entryno1#
</cfquery>
 
</cfif>

</cfloop>

<cfset status_msg="Generate Repayment Schedule Success">
<cfcatch type="database">
<cfset status_msg="Generate Repayment Schedule Failed. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc" action="/payments/2ndHalf/AddUpdate/LoanDeductionMaintenance/updateAdd.cfm?empno=#url.empno#" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>