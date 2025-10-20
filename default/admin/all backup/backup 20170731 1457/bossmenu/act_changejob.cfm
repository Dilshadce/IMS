<cfparam name="status" default="">
<cfif form.newjob2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select source from project
		where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newjob2#"> and porj= "J"
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The job, #form.newjob2# already exist!">
	<cfelse>
		<cfset newcode = form.newjob2>
		<cfset newdesp = form.newitemdesp>
		<cfset oldcode = form.oldjob>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set job = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where job = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        	<cfquery name="update" datasource="#dts#">
			update artran
			set job = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where job = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update project
			set source = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where source = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> and porj = "J"
		</cfquery>
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changejob',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
		<cfset status="The Job Code, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Job code cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changejob.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>