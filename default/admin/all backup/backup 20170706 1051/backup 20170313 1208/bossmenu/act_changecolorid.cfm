<cfparam name="status" default="">
<cfif form.newcolorid neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select colorid from iccolorid
		where colorid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newcolorid#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Material, #form.newcolorid# already exist!">
	<cfelse>
		<cfset newcode = form.newcolorid>
		<cfset newdesp = form.newcoloriddesp>
		<cfset oldcode = form.oldcolorid>
		
		
		
		
			
		<cfquery name="update" datasource="#dts#">
			update icitem
			set colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>

		
		
		<cfquery name="update" datasource="#dts#">
			update iccolorid
			set colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changecolorid',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Material, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Material cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changecolorid.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>