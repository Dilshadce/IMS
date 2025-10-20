<cfset status=true>
<cfset status_msg="">

<cfif isdefined("url.type")>
	<cfif isdefined("form.userDirectory") and form.userDirectory eq "on">
		<cfset userDirectory = 1>
	<cfelse>
		<cfset userDirectory = "">
	</cfif>
	<cfif url.type eq "create">
		<cfquery name="checkExist" datasource="main">
			select menu_id from menu
			where menu_no=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuNo#">
		</cfquery>
		
		<cfif checkExist.recordcount>
			<cfset status=false>
			<cfset status_msg="This Menu No (#form.menuNo#) Existed in System. Please try use other id again.">
		<cfelse>
			<cftry>
				<cfquery name="insertDb" datasource="main">
					insert into menu 
					(MENU_NO,MENU_NAME,MENU_NAME2,MENU_NAME3,MENU_URL,MENU_LEVEL,USERDIRECTORY,USERPIN)
					
					values 
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuNo#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuName2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuName3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuURL#">,
						'#menulvl#','#userDirectory#','#userpin#'
					)
				</cfquery>
				
				<cfset status_msg="Successfully Insert Information">
				<cfcatch type="database">
					<cfset status=false>
					<cfset status_msg="Fail to Insert Information. Error Message : #cfcatch.Detail#">
				</cfcatch>
			</cftry>
		</cfif>
	<cfelseif url.type eq "edit">
		<cftry>
			<cfquery name="updateDb" datasource="main">
				UPDATE MENU
				SET 
				MENU_NO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuNo#">,
				MENU_NAME=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuName#">,
				MENU_NAME2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuName2#">,
				MENU_NAME3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuName3#">,
				MENU_URL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuURL#">,
				MENU_LEVEL = '#menulvl#',
				USERDIRECTORY = '#userDirectory#',
				USERPIN = '#userpin#'
				WHERE MENU_ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuId#">
			</cfquery>
			
			<cfset status_msg="Successfully Update Information.">
			<cfcatch type="database">
				<cfset status=false>
				<cfset status_msg="Fail to Update Information. Error Message : #cfcatch.Detail#">
			</cfcatch>
		</cftry>
	<cfelseif url.type eq "delete">
		<cfquery name="deleteDb" datasource="main">
			Delete from menu
			WHERE menu_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.menuId#">
		</cfquery>
		<cfset status_msg="Successfully Delete Information">
	</cfif>
</cfif>


<form name="pc" action="menutable.cfm" method="post">
	<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
</form>

<script>
	pc.submit();
</script>

