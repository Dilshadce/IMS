<cfparam name="status" default="">
<cfif form.newservice neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select servi from icservi
		where servi = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newservice#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Service Code, #form.newservice# already exist!">
	<cfelse>
		<cfset newcode = form.newservice>
		<cfset newdesp = form.newservicedesp>
		<cfset oldcode = form.oldservice>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and linecode ='SV'
		</cfquery>
		
		<cfif lcase(hcomid) eq "net_i">
			<cfquery name="update" datasource="#dts#">
				update contract_service
				set servi = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where servi = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery name="update" datasource="#dts#">
				update service_type
				set servi = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where servi = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
		</cfif>
		
		<cfquery name="update" datasource="#dts#">
			update icservi
			set servi = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where servi = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeservice',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Service Code, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Service Code cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeservice.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>