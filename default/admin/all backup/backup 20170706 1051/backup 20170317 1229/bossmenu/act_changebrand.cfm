<cfparam name="status" default="">
<cfif form.newbrand2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select brand from brand
		where brand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newbrand2#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Brand, #form.newbrand2# already exist!">
	<cfelse>
		<cfset newcode = form.newbrand2>
		<cfset newdesp = form.newitemdesp>
		<cfset oldcode = form.oldbrand>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set category = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where category = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icitem_last_year
			set brand = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where brand = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
			
		<cfquery name="update" datasource="#dts#">
			update icitem
			set brand = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where brand = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icmitem
			set brand = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where brand = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		
		<cfquery name="update" datasource="#dts#">
			update brand
			set brand = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where brand = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changebrand',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
		<cfset status="The Brand, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Brand cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changebrand.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>