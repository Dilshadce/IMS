<cfparam name="status" default="">
<cfif form.newgroup neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select wos_group from icgroup
		where wos_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newgroup#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Group, #form.newgroup# already exist!">
	<cfelse>
		<cfset newcode = form.newgroup>
		<cfset newdesp = form.newgroupdesp>
		<cfset oldcode = form.oldgroup>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icitem_last_year
			set wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
			
		<cfquery name="update" datasource="#dts#">
			update icitem
			set wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icmitem
			set wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update locqdbf
			set wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icgroup
			set wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changegroup',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Group, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Group cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changegroup.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>