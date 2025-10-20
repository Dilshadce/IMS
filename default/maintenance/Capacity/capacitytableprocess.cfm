<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cftry>
		<cfinsert datasource='#dts#' tablename="vehicapacity" formfields="Capacity,desp">
		
		<cfcatch type="database">
			<h3 align="center">Error. This Capacity Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Capacity, #form.Capacity# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deleteCapacity">
					Delete from vehicapacity where Capacity='#form.Capacity#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Capacity, #form.Capacity# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Capacity, #form.Capacity# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
			<cfupdate datasource='#dts#' tablename="vehicapacity" formfields="Capacity,desp">
			<cfset status="The Capacity, #form.Capacity# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_Capacitytable.cfm?type=vehicapacity&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>