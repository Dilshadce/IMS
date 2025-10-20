<cfparam name="status" default="">
<cfif form.newterm neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select term from #target_icterm#
		where term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newterm#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The term, #form.newterm# already exist!">
	<cfelse>
		<cfset newcode = form.newterm>
		<cfset newdesp = form.newtermdesp>
		<cfset oldcode = form.oldterm>
			
		<cfquery name="update" datasource="#dts#">
			update #target_arcust#
			set term = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where term = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update #target_apvend#
			set term = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where term = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set term = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where term = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>

		
		<cfquery name="update" datasource="#dts#">
			update #target_icterm#
			set term = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where term = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeterm',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The term, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New term cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeterm.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>