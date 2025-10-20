<cfparam name="status" default="">
<cfif form.newteam neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select team from icteam
		where team = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newteam#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The team, #form.newteam# already exist!">
	<cfelse>
		<cfset newcode = form.newteam>
		<cfset newdesp = form.newteamdesp>
		<cfset oldcode = form.oldteam>
		
		<cfquery name="update" datasource="#dts#">
			update icagent
			set team = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where team = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>

		<cfquery name="update" datasource="#dts#">
			update icteam
			set team = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where team = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeteam',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The team, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New team cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeteam.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>