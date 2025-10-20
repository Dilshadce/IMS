<cfparam name="status" default="">
<cfif form.newagent neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select agent from icagent
		where agent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newagent#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Agent, #form.newagent# already exist!">
	<cfelse>
		<cfset newcode = form.newagent>
		<cfset newdesp = form.newagentdesp>
		<cfset oldcode = form.oldagent>
			
		<cfquery name="update" datasource="#dts#">
			update #target_arcust#
			set AGENT = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where AGENT = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
			
		<cfquery name="update" datasource="#dts#">
			update iserial
			set AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icl3p
			set AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icl3p2
			set AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where AGENNO = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icagent
			set agent = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where agent = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeagent',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Agent, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Agent cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeagent.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>