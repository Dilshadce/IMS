<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cftry>
		<cfinsert datasource='#dts#' tablename="icbranch" formfields="branch,desp,startwith">
		
		<cfcatch type="database">
			<h3 align="center">Error. This Branch Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Branch, #form.branch# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deletebranch">
					Delete from icbranch where branch='#form.branch#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Branch, #form.branch# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Branch, #form.branch# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
			<cfupdate datasource='#dts#' tablename="icbranch" formfields="branch,desp,startwith">
			<cfset status="The Branch, #form.branch# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_branchtable.cfm?type=icbranch&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>