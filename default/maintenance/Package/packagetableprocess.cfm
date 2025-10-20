<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cfquery name="checkexist" datasource="#dts#">
    select * from package where packcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packcode#">
    </cfquery>
    <cfif checkexist.recordcount eq 0>
    <cfquery name="insertpackcode" datasource="#dts#">
    insert into package (packcode,packdesp,grossamt) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,'#val(grossamt)#')
    </cfquery>
    <cfelse>
    <cfquery name="updatepackcode" datasource="#dts#">
    update package set packdesp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,grossamt='#val(grossamt)#' where packcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packcode#">
    </cfquery>
    </cfif>
	
	<cfset status="The Package, #form.packcode# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deletePackage">
					Delete from package where packcode='#form.packcode#'
				</cfquery>
                
                <cfquery datasource='#dts#' name="deletePackage">
					Delete from packdet where packcode='#form.packcode#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Package, #form.packcode# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Package, #form.packcode# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
			<cfquery name="updatepackcode" datasource="#dts#">
    update package set packdesp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,grossamt='#val(grossamt)#' where packcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packcode#">
    </cfquery>
			<cfset status="The Package, #form.packcode# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_Packagetable.cfm?type=Package&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>