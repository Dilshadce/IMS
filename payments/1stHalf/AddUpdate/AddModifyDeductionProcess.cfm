
<cfoutput>
<cftry>
<cfquery name="select_paytra1_data" datasource="#dts#">
SELECT * FROM paytra1 as pt LEFT JOIN pmast as pm ON pt.empno=pm.empno WHERE pm.paystatus = "A" <cfif isdefined("form.emp_list") and form.emp_list neq "">and #form.emp_type# like '%#form.emp_list#%'</cfif>
</cfquery>

<cfquery name="select_ded_amt" datasource="#dts#">
SELECT * FROM paytra1 where empno = "#select_paytra1_data.empno#"
</cfquery>

<cfset j=0 >
<cfloop query="select_paytra1_data">
<cfloop from="101" to="115" index="i">
<cfset ded_attrib = "ded" & #i# >
<cfquery name="update_all" datasource="#dts#">
Update paytra1 SET #ded_attrib#=#evaluate("form.ded1_#i#_#j#")# WHERE empno = "#select_paytra1_data.empno#"
</cfquery>
</cfloop>
<cfset j=j+1>
</cfloop>
<!--- 
<cfset j=0 >
<cfloop query="select_paytra1_data">
<cfloop from="101" to="110" index="i">
<cfset ded_attrib = "ded" & #i# >
<cfquery name="update_all" datasource="#dts#">
Update paytra1 SET #ded_attrib#=#evaluate("form.ded2_#i#_#j#")# WHERE empno = #select_paytra1_data.empno#
</cfquery>
</cfloop>
<cfset j=j+1>
</cfloop>

<cfset j=0 >
<cfloop query="select_paytra1_data">
<cfloop from="111" to="115" index="i">
<cfset ded_attrib = "ded" & #i# >
<cfquery name="update_all" datasource="#dts#">
Update paytra1 SET #ded_attrib#=#evaluate("form.ded3_#i#_#j#")# WHERE empno = #select_paytra1_data.empno#
</cfquery>
</cfloop>
<cfset j=j+1>
</cfloop>
 --->

<cfset status_msg="Add / Modify Deduction Process Success">
<cfcatch type="database">
<cfset status_msg="Add / Modify Deduction Process Failed. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc" action="/payments/1stHalf/addUpdate/AddModifyDeductionMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>

</cfoutput>