<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cftry>
		<cfinsert datasource='#dts#' tablename="icbranchitemno" formfields="branchitemno,desp,itemno,branch">
		
		<cfcatch type="database">
			<h3 align="center">Error. This Branch Item No Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Branch Item No, #form.branchitemno# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deletebranchitemno">
					Delete from icbranchitemno where branchitemno='#form.branchitemno#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Branch Item No, #form.branchitemno# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Branch Item No, #form.branchitemno# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
			<cfupdate datasource='#dts#' tablename="icbranchitemno" formfields="branchitemno,desp,itemno,branch">
			<cfset status="The Branch Item No, #form.branchitemno# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_branchitemno.cfm?type=icbranchitemno&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>