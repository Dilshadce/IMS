<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "444,100,438,23,16,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.code')>
	<cfset URLcode = trim(urldecode(url.code))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
   		
		<cfquery name="checkExist" datasource="#dts#">
			SELECT invnogroup 
            FROM invaddress
			WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.code)#">
		</cfquery>
		<cfif checkExist.recordcount>
		
			<cfquery name="createCode" datasource="#dts#">
					UPDATE invaddress SET
						name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        name2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name2)#">,      
                        add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                        add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                        add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                        add4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add4)#">,
						add5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add5)#">,
                        phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone)#">,
                        fax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fax)#">,
                        website=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.website)#">,
                        comuen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.comuen)#">,
                        gstno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.gstno)#">
					
					WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.code)#">
					
				</cfquery>
		
			<script type="text/javascript">
				alert('#trim(form.code)# has been updated successfully!');
				window.open('/latest/maintenance/invaddressProfile.cfm','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createCode" datasource="#dts#">
					INSERT INTO invaddress (invnogroup,name,name2,add1,add2,add3,add4,add5,phone,fax,website,comuen,gstno)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.code)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name2)#">,      
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add4)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add5)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fax)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.website)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.comuen)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.gstno)#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.code)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/invaddress.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.code)# has been updated successfully!');
				window.open('/latest/maintenance/invaddressProfile.cfm','_self');
			</script>
		</cfif>
	
</cfif>
</cfoutput>