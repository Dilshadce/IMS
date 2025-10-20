<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cftry>
		<cfinsert datasource='#dts#' tablename="vehiMake" formfields="Make,desp">
		
		<cfcatch type="database">
			<h3 align="center">Error. This Make Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Make, #form.Make# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deleteMake">
					Delete from vehiMake where Make='#form.Make#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Make, #form.Make# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Make, #form.Make# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
			<cfupdate datasource='#dts#' tablename="vehiMake" formfields="Make,desp">
			<cfset status="The Make, #form.Make# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_Maketable.cfm?type=vehiMake&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>