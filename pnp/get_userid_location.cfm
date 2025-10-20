<cfif tran eq "RC">
	<!--- <cfquery name="get_user_id_location" datasource="#dts#">
		select 
		rc_location 
		from pnp_special_setting 
		where company_id='IMS';
	</cfquery> --->
	
	<cfquery name="get_location" datasource="#dts#">
		select location
		from ictran
		where type='RC' and refno='#nexttranno#'
		limit 1
	</cfquery>
	
	<!--- <cfset xlocation = get_user_id_location.rc_location> --->
	<cfif get_location.recordcount neq 0>
		<cfset xlocation = get_location.location>
	<cfelse>
		<cfquery name="get_user_id_location" datasource="#dts#">
			select * 
			from user_id_location 
			where userid='#jsstringformat(preservesinglequotes(HUserID))#';
		</cfquery>
		
		<cfset xlocation = get_user_id_location.location>
	</cfif>
<cfelse>
	<cfquery name="get_user_id_location" datasource="#dts#">
		select 
		* 
		from user_id_location 
		where userid='#jsstringformat(preservesinglequotes(HUserID))#';
	</cfquery>
	
	<cfset xlocation = get_user_id_location.location>
</cfif>