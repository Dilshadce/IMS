<cfquery datasource="#dts#" name="updateservice">
		update service_tran set comments = "#form.comments#" where serviceid = "#form.serviceid#"
</cfquery>		
<cfset status="The Job for #form.serviceid# had been successfully processed. ">


<cfoutput>
	<form name="done" action="viewjob.cfm" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>