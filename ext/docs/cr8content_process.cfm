<cfif type eq "Create">

<!--- <cfoutput>#form.elm3#</cfoutput> --->

<cfquery name="insertContent" datasource="main">
				update help set
						title=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title#">,
						simple_desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
						content=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.content#">
						
						where menu_id = '#url.menu_id#';
			</cfquery>
			<cfset status_msg="Succcess Inserted Content.">

<cfquery datasource="main" name="getmenuid">
			select menu_parent_id from help 
			where menu_id='#url.menu_id#';
			
			</cfquery>		
			
</cfif>

<form name="form1" action="menuMaintenance_view2.cfm?id=<cfoutput>#getmenuid.menu_parent_id#</cfoutput>" method="post">
	<input type="hidden" name="status" value="<cfoutput>#status_msg#</cfoutput>" />
	<input type="hidden" name="level" value="<cfoutput>#getmenuid.menu_parent_id#</cfoutput>" />
	
</form>

<script>
	form1.submit();
</script>