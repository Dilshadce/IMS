<cfset tabList = "timesheet,leave,claim">
<cfoutput>
<cftry>
    <cfquery name="updateNotiSetting" datasource="#dts#">
        Update notisetting
        SET   <cfloop from="1" to="21" index="i">
        		template#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Evaluate('form.template#i#')#">,
                <cfif IsDefined('form.setting#i#')>
                	setting#i# = 'Y',
                <cfelse>
                    setting#i# = 'N',
                </cfif>
                days#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Evaluate('form.days#i#')#">,
                hours#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Evaluate('form.hours#i#')#"><cfif i LT 21>,</cfif>
              </cfloop>
    </cfquery>
    <cfquery name="updateNotiSetting" datasource="#dts#">
        INSERT INTO notisettingat (
            <cfloop from="1" to="21" index="i">
            	template#i#,
                setting#i#,
                days#i#,
                hours#i#,      
            </cfloop>
            remark, updated_by, updated_on
        )
        VALUES (
           <cfloop from="1" to="21" index="i">
           		<cfqueryparam cfsqltype="cf_sql_varchar" value="#Evaluate('form.template#i#')#">,
				<cfif IsDefined('form.setting#i#')>
                	'Y',
                <cfelse>
                    'N',
                </cfif>
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#Evaluate('form.days#i#')#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#Evaluate('form.hours#i#')#">,
           </cfloop>
           "UPDATE",
           "#Huserid#",
           "#DateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#"
        ) 
    </cfquery>
    <script type="text/javascript">
		alert("Update notification setting successfully!");
		window.location.href = "/latest/customization/manpower_i/notiSetting/notiSetting.cfm";
	</script>
<cfcatch type="any">
	<script type="text/javascript">
		alert("Failed to update notification setting!");	
		window.history.go(-1);
	</script>
</cfcatch>
</cftry>
</cfoutput>