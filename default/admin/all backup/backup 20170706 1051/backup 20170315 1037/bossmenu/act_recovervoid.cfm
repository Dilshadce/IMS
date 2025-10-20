<cfparam name="status" default="">


	<cfquery name="checkexist" datasource="#dts#">
		select void from artran
		where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#"> and refno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
	</cfquery>
	
	<cfif checkexist.recordcount eq 0>
		<cfset status="This Transaction is not void / This Transaction Does not Exist">
	<cfelse>
		<cfset refno = form.oldrefno>
		<cfset reftype = form.reftype>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set void=''
			where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#"> and refno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update artran
			set void=''
			where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#"> and refno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update iserial
			set void=''
			where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#"> and refno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update igrade
			set void=''
			where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#"> and refno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
		</cfquery>
        
        	
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('Recover Void',<cfqueryparam cfsqltype="cf_sql_char" value="#reftype#">,<cfqueryparam cfsqltype="cf_sql_char" value="#refno#">,'#huserid#',now())
        </cfquery>
		<cfset status="#reftype# #refno# Has Been Unvoid !">
	</cfif>

<cfoutput>
	<form name="done" action="recovervoid.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>