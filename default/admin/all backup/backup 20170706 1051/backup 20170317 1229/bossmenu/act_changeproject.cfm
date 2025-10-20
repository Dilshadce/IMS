<cfparam name="status" default="">
<cfif form.newproject2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select source from project
		where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newproject2#"> and porj="P"
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Project, #form.newproject2# already exist!">
	<cfelse>
		<cfset newcode = form.newproject2>
		<cfset newdesp = form.newitemdesp>
		<cfset oldcode = form.oldproject>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set source = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where source = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
        		<cfquery name="update" datasource="#dts#">
			update artran
			set source = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where source = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update project
			set source = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where source = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> and porj ="P" 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeproject',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Project, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Project cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeproject.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>