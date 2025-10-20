<cfprocessingdirective pageencoding="UTF-8">

<cfif IsDefined('url.priceid')>
	<cfset URLpriceid = trim(urldecode(url.priceid))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
		
	<cfif url.action EQ "delete">
    	<cftry>
			<cfquery name="deleteCategory" datasource="#dts#">
				DELETE FROM manpowerpricematrixdetail
				WHERE priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLpriceid#">
			</cfquery>
			
			<cfquery name="deleteCategory" datasource="#dts#">
				DELETE FROM manpowerpricematrix
				WHERE priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLpriceid#">
			</cfquery>
			
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLpriceid#!\nError Message: #cfcatch.message#');
					window.open('pricematrixProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLpriceid# successfully!');
			window.open('pricematrixProfile.cfm','_self');
		</script>

	<cfelse>
		<script type="text/javascript">
			window.open('pricematrixProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('pricematrixProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>