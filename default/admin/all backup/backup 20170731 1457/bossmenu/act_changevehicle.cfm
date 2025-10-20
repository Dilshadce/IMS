<cfparam name="status" default="">
<cfif form.newentryno neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select entryno from vehicles
		where entryno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newentryno#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Project, #form.newentryno# already exist!">
	<cfelse>
		<cfset newcode = form.newentryno>
		<cfset oldcode = form.oldentryno>
		
		<cfquery name="update" datasource="#dts#">
			update vehicles
			set entryno = <cfqueryparam cfsqltype="cf_sql_char" value="#newentryno#">
			where entryno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldentryno#">
		</cfquery>
		
        		<cfquery name="update" datasource="#dts#">
			update artran
			set rem5 = <cfqueryparam cfsqltype="cf_sql_char" value="#newentryno#">
			where rem5 = <cfqueryparam cfsqltype="cf_sql_char" value="#oldentryno#">
		</cfquery>
		

        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changevehicle',<cfqueryparam cfsqltype="cf_sql_char" value="#oldentryno#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newentryno#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Vehicle Entry No. #oldentryno# Has Been Changed to #newentryno# !">
	</cfif>
<cfelse>
	<cfset status="The New Vehicle Entry No. cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changevehicle.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>