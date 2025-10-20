<cfparam name="status" default="">
<cfif form.newenduser2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select source from project
		where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newenduser2#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The enduser, #form.newenduser2# already exist!">
	<cfelse>
		<cfset newcode = form.newenduser2>
		<cfset oldcode = form.oldenduser>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set van = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where van = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        	<cfquery name="update" datasource="#dts#">
			update artran
			set van = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where van = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update driver
			set driverno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where driverno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeenduser',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
		<cfset status="The End User No, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New End User No cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeenduser.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>