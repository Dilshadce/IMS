

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#dateFrom#" returnvariable="cfc_fdate" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#dateTo#" returnvariable="cfc_tdate" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#pdate1#" returnvariable="cfc_p1date" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#pdate2#" returnvariable="cfc_p2date" />

<cfif isdefined("form.fixed")>
<cfset monthvary = datediff('m','#form.dateFrom#', '#form.dateTo#')>

<cfif monthvary neq 0>
<cfset rpaymentamt = #form.lamt# / monthvary >
<cfelse>
<cfset rpaymentamt = #form.lamt# >
</cfif>

<cfelse>
<cfset rpaymentamt =  #form.rpayamt#>
</cfif>

 <cfif isdefined("form.fixed")>
 <cfset fixed_point =1>
 <cfelse>
 <cfset fixed_point =0>
 </cfif>
 
<cfquery name="update_qry" datasource="#dts#">
UPDATE loanmst
SET bankname = "#form.bname#",
	loanamt = #form.lamt#,
	dates1 = #cfc_fdate#,
	datee1 = #cfc_tdate#,
	dates2 = #cfc_p1date#,
	datee2 = #cfc_p2date#,
	loanret1 = #rpaymentamt#,
	loanret2 = #form.lpayamt#,
	dednum = #form.dnum#,
	fixed = #fixed_point#
WHERE entryno = "#form.entryno#"
</cfquery>

<cflocation url="/payments/2ndHalf/AddUpdate/LoanDeductionMaintenance/updateAdd.cfm?empno=#form.empno#">