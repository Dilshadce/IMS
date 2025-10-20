
<cfoutput>
<cftry>
<cfquery name="select_paytran_data" datasource="#dts#">
SELECT * FROM paytran as pt LEFT JOIN pmast as pm ON pt.empno=pm.empno WHERE pm.paystatus = "A" <cfif isdefined("form.emp_list") and form.emp_list neq "">and #form.emp_type# like '%#form.emp_list#%'</cfif>
</cfquery>

<cfquery name="select_aw_amt" datasource="#dts#">
SELECT * FROM paytran where empno = "#select_paytran_data.empno#"
</cfquery>

<cfset j=0 >
<cfloop query="select_paytran_data">
<cfloop from="101" to="117" index="i">
<cfset aw_attrib = "aw" & #i# >
<cfquery name="update_all" datasource="#dts#">
Update paytran SET #aw_attrib#=#evaluate("form.aw1_#i#_#j#")# WHERE empno = "#select_paytran_data.empno#"
</cfquery>
</cfloop>
<cfset j=j+1>
</cfloop>

<!--- <cfset j=0 >
<cfloop query="select_paytran_data">
<cfloop from="101" to="106" index="i">
<cfset aw_attrib = "aw" & #i# >
<cfquery name="update_all" datasource="#dts#">
Update paytran SET #aw_attrib#=#evaluate("form.aw2_#i#_#j#")# WHERE empno = #select_paytran_data.empno#
</cfquery>
</cfloop>
<cfset j=j+1>
</cfloop>

<cfset j=0 >
<cfloop query="select_paytran_data">
<cfloop from="107" to="112" index="i">
<cfset aw_attrib = "aw" & #i# >
<cfquery name="update_all" datasource="#dts#">
Update paytran SET #aw_attrib#=#evaluate("form.aw3_#i#_#j#")# WHERE empno = #select_paytran_data.empno#
</cfquery>
</cfloop>
<cfset j=j+1>
</cfloop>

<cfset j=0 >
<cfloop query="select_paytran_data">
<cfloop from="113" to="117" index="i">
<cfset aw_attrib = "aw" & #i# >
<cfquery name="update_all" datasource="#dts#">
Update paytran SET #aw_attrib#=#evaluate("form.aw4_#i#_#j#")# WHERE empno = #select_paytran_data.empno#
</cfquery>
</cfloop>
<cfset j=j+1>
</cfloop> --->
<cfset status_msg="Add / Modify Allowance Process Success">
<cfcatch type="database">
<cfset status_msg="Add / Modify Allowance Process Failed. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc" action="/payments/2ndHalf/addUpdate/AddModifyAllowanceMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>

</cfoutput>