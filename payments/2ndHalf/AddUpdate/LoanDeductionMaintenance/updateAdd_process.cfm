<cfif isdefined ("url.type")>
	
<cfquery name="del_qry" datasource="#dts#">
DELETE FROM loanmst WHERE entryno = "#url.entryno#"
</cfquery>	

<cflocation url="/payments/2ndHalf/AddUpdate/LoanDeductionMaintenance/updateAdd.cfm?empno=#url.empno#">

<cfelse>

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
 
<cfquery name="add_leave" datasource="#dts#">
INSERT INTO loanmst
(empno,accno,bankname,loanamt,dates1,datee1,dates2,datee2,loanret1,loanret2,dednum,fixed)
VALUES
("#form.empno#",
 "#form.accno#",
 "#form.bname#",
 #form.lamt#,
 #cfc_fdate#,
 #cfc_tdate#,
 #cfc_p1date#,
 #cfc_p2date#,
 #rpaymentamt#,
 #form.lpayamt#,
 #form.dnum#,
#fixed_point#)
</cfquery>
</cfif>

<cflocation url="/payments/2ndHalf/AddUpdate/LoanDeductionMaintenance/updateAdd.cfm?empno=#form.empno#">
