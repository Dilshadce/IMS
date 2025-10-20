<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cftry>
    
    <cfif Hlinkams eq 'Y'>
    	<cfinsert datasource='#replace(dts,"_i","_a","all")#' tablename="icarea" formfields="area,desp">
    <cfelse>
		<cfinsert datasource='#dts#' tablename="icarea" formfields="area,desp">
	</cfif>
		<cfcatch type="database">
			<h3 align="center">Error. This Area Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Area, #form.area# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deletearea">
					Delete FROM #target_icarea# where area='#form.area#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Area, #form.area# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Area, #form.area# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
        	<cfif Hlinkams eq 'Y'>
            <cfupdate datasource='#replace(dts,"_i","_a","all")#' tablename="icarea" formfields="area,desp">
    		<cfelse>
			<cfupdate datasource='#dts#' tablename="icarea" formfields="area,desp">
            </cfif>
			<cfset status="The Area, #form.area# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_areatable.cfm?type=icarea&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>