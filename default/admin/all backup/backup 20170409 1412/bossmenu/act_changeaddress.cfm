<cfparam name="status" default="">
<cfif form.newaddress neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select code from address
		where code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newaddress#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The address, #form.newaddress# already exist!">
	<cfelse>
		<cfset newcode = form.newaddress>
		<cfset newname = form.newaddressname>
		<cfset oldcode = form.oldaddress>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set rem0 = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where rem0 = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update artran
			set rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
			
		<cfquery name="update" datasource="#dts#">
			update address
			set code = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newname#">
			where code = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeaddress',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The address, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New address cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeaddress.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>