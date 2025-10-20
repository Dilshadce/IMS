<cfif type eq "Create">

	<cftry>
		<cfquery name="insertMenu" datasource="main">
				INSERT INTO help (menu_name, menu_level,menu_parent_id,menu_name2,menu_order)
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_level#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_parent_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_name2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_order#">
						
					);
			</cfquery>
			<cfquery name="getcompany" datasource="main">
				SELECT userbranch FROM users where 
				userDept  not in ('ck','kalam_a','steel05_a','steel_a') and
				<!--->userDept = 'demo_a' and--->
				userbranch not like '%_i' group by userbranch
			</cfquery>
			<cfquery datasource="main" name="getmenuid">
			select menu_id from help 
			where menu_name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_name#">
			and menu_level=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_level#">
			and menu_parent_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_parent_id#">
			and menu_order=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_order#">
			</cfquery>
			<cfloop query="getcompany">
				<cfset dts1 = getcompany.userbranch>
				<cftry>
				
					<cfcatch type="database">
						<cfset status_msg="Fail,#cfcatch.Detail#">
					</cfcatch>	
				</cftry>
			</cfloop>		
			
			
			
			
			
					
			<cfcatch type="database">
				<cfset status_msg="Fail,#cfcatch.Detail#">
			</cfcatch>
		</cftry>
		<cfset status_msg="Succcess added the menu.">

<cfelseif type eq "Edit">

	<cftry>
		<cfquery name="updateMenu" datasource="main">
				update help set
						menu_name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_name#">,
						menu_level=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_level#">,
						menu_parent_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_parent_id#">,
						menu_name2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_name2#">,
						menu_order=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menu_order#">
		
						where menu_id = '#form.menuId#';
			</cfquery>		
			<cfcatch type="database">
				<cfset status_msg="Fail,#cfcatch.Detail#">
				<cflocation url="testing.cfm?i=#status_msg#">
			</cfcatch>
		</cftry>
		<cfset status_msg="Succcess Edited the menu.">

<cfelseif type eq "Delete">

	<cftry>
		<cfquery name="deleteMenu2" datasource="main">
				delete from help where menu_id = '#form.menuId#';
		</cfquery>	
		<cfquery name="getcompany" datasource="main">
				SELECT userbranch FROM users where 
				userDept  not in ('ck','kalam_a','steel05_a','steel_a') and
				<!--->userDept = 'demo_a' and--->
				userbranch not like '%_i' group by userbranch
		</cfquery>
			<cfloop query="getcompany">
				<cfset dts1 = getcompany.userbranch>
				<cfquery name="deleteMenu2" datasource="#dts1#">
					delete from userpin where menu_id = '#form.menuId#';
				</cfquery>		
			</cfloop>
			
			
				
			<cfcatch type="database">
				<cfset status_msg="Fail,#cfcatch.Detail#">
			</cfcatch>
		</cftry>
		<cfset status_msg="Succcess deleted the menu.">
</cfif>

<form name="form1" action="menuMaintenance_view2.cfm?id=<cfoutput>#form.menu_parent_id#</cfoutput>" method="post">
	<input type="hidden" name="status" value="<cfoutput>#status_msg#</cfoutput>" />
	<input type="hidden" name="level" value="<cfoutput>#form.menu_parent_id#</cfoutput>" />
	
</form>

<script>
	form1.submit();
</script>