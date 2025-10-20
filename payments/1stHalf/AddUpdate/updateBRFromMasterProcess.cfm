<cftry>
<cfquery name="get_masterBR_qry" datasource="#dts#">
UPDATE paytra1 , pmast SET paytra1.brate = pmast.brate WHERE paytra1.empno = pmast.empno
</cfquery>
<cfset status_msg="Success Update All Basic Rate From Master">
<cfcatch type="database">
<cfset status_msg="Fail To Update Basic Rate From Master. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc" action="/payments/1stHalf/addUpdate/updateBRFromMasterMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>