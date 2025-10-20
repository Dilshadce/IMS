<cfparam name="status" default="">
<cfif form.newcategory neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select cate from iccate
		where cate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newcategory#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Category, #form.newcategory# already exist!">
	<cfelse>
		<cfset newcode = form.newcategory>
		<cfset newdesp = form.newcategorydesp>
		<cfset oldcode = form.oldcategory>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set category = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where category = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icitem_last_year
			set category = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where category = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
			
		<cfquery name="update" datasource="#dts#">
			update icitem
			set category = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where category = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icmitem
			set category = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where category = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update locqdbf
			set category = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where category = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iccate
			set cate = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdesp#">
			where cate = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changecategory',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Category, #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Category cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changecategory.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>