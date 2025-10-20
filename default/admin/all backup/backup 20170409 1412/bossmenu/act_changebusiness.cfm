<cfparam name="status" default="">
<cfif form.newbusiness2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select source from project
		where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newbusiness2#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The business, #form.newbusiness2# already exist!">
	<cfelse>
		<cfset newcode = form.newbusiness2>
		<cfset oldcode = form.oldbusiness>

        	<cfquery name="update" datasource="#dts#">
			update #target_arcust#
			set business = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where business = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update #target_apvend#
			set business = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where business = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update business
			set business = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where business = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changebusiness',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
		<cfset status="The Business No, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Business No cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changebusiness.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>