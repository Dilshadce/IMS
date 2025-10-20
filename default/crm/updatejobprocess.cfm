<cfquery datasource="#dts#" name="updateservice">
		update service_tran set s_status = "#form.s_status#", comments = "#form.comments#" where serviceid = "#form.serviceid#"
</cfquery>		
<cfset status="The Job for #custno# had been successfully processed. ">


<cfoutput>
	<form name="done" action="viewjob.cfm" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>