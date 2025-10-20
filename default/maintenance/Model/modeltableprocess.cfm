<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cftry>
		<cfinsert datasource='#dts#' tablename="vehiModel" formfields="Model,desp">
		
		<cfcatch type="database">
			<h3 align="center">Error. This Model Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Model, #form.Model# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deleteModel">
					Delete from vehiModel where Model='#form.Model#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Model, #form.Model# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Model, #form.Model# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
			<cfupdate datasource='#dts#' tablename="vehiModel" formfields="Model,desp">
			<cfset status="The Model, #form.Model# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_Modeltable.cfm?type=vehiModel&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>