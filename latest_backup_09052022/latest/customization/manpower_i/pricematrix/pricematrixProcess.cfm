<cfprocessingdirective pageencoding="UTF-8">

<cfif IsDefined('url.priceid')>
	<cfset URLpriceid = trim(urldecode(url.priceid))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
		
	<cfif url.action EQ "delete">
        
        <!---Added by Nieo 20181023 1041, to log changes in Price Structure--->
        <cfset priceid = URLpriceid>
            
        <cfinclude template="logchanges.cfm">
    
        <!---Added by Nieo 20181023 1041, to log changes in Price Structure--->
        
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
    <cfelseif url.action EQ "edit">
            <cfquery name="getPriceName" datasource="#dts#">
                SELECT pricename FROM  manpowerpricematrix
                WHERE priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.priceid#">
            </cfquery>
                
            <cfif getPriceName.pricename neq form.pricename>
            
                <cfquery name="updatepricename" datasource="#dts#">
                    UPDATE manpowerpricematrix
                    SET pricename=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pricename#">,
                    updated_on=now(),
                    updated_by="#Huserid#"
                    WHERE priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.priceid#">
                </cfquery>
                    
            </cfif>
        <script type="text/javascript">
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