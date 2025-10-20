<cfparam name="status" default="">
<cfif form.newarea neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select area from icarea
		where area = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newarea#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The area, #form.newarea# already exist!">
	<cfelse>
		<cfset newcode = form.newarea>
		<cfset newdesp = form.newareadesp>
		<cfset oldcode = form.oldarea>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set area = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where area = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set area = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where area = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
			
		<cfquery name="update" datasource="#dts#">
			update #target_arcust#
			set area = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where area = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update #target_apvend#
			set area = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where area = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		
		
		<cfquery name="update" datasource="#dts#">
			update icarea
			set area = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where area = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changearea',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The area, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New area cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changearea.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>