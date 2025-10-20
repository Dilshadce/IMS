<cfparam name="status" default="">
<cfif form.newlocation neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select location from iclocation
		where location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newlocation#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The location, #form.newlocation# already exist!">
	<cfelse>
		<cfset newcode = form.newlocation>
		<cfset newdesp = form.newlocationdesp>
		<cfset oldcode = form.oldlocation>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			UPDATE artran
			SET rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			WHERE rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
            AND type='TR'
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			UPDATE artran
			SET rem2 = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			WHERE rem2 = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
            AND type='TR'
		</cfquery>
        
        
        <cfquery name="update" datasource="#dts#">
			update ictrantemp
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update billmat
			set bmlocation = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where bmlocation = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
			
		<cfquery name="update" datasource="#dts#">
			update iserial
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update igrade
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update lobthob
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update locadjtran
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update locqdbf
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update logrdob
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>

		<cfquery name="update" datasource="#dts#">
			update iclocation
			set location = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where location = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changelocation',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The location, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New location cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changelocation.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>