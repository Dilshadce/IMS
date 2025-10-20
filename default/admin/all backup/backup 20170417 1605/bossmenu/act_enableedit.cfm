<cfparam name="status" default="">
		<cfset type = form.reftype>
		<cfset refno = form.oldrefno>
		
        
        <cfquery name="checkexist" datasource="#dts#">
		select * from unlocktran
		where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_char" value="#type#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="#type# #refno# Is Aready Unlocked !">
        <cfelse>
		<cfquery name="update" datasource="#dts#">
			update artran
			set unlocked = 'Y'
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_char" value="#type#">
		</cfquery>
        
        	<cfquery name="update1" datasource="#dts#">
			insert into unlocktran
            (type,refno,unlockby,unlockon) values (<cfqueryparam cfsqltype="cf_sql_char" value="#type#">,<cfqueryparam cfsqltype="cf_sql_char" value="#refno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
now())
		</cfquery>
		
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('enableedit','','','#huserid#',now())
        </cfquery>
        
		<cfset status="#type# #refno# Has Been Unlocked !">
</cfif>
<cfoutput>
	<form name="done" action="enableedit.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>