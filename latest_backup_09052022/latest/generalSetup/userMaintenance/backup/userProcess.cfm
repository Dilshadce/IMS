<cfif IsDefined('url.userID')>
	<cfset URLuserID = trim(urldecode(url.userID))>
</cfif>

<cfif IsDefined('url.companyID')>
	<cfset URLuserCompanyID = LCASE(trim(urldecode(url.companyID)))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="main">
			SELECT userid
            FROM users
			WHERE userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userID)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.userID)# already exist!');
				window.open('/latest/generalSetup/userMaintenance/user.cfm?action=create&companyID=#URLuserCompanyID#','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="creatUser" datasource="main">
					INSERT INTO users ( userbranch,userdept,userID,userName,userPwd,userGrpId,userPhone,userEmail,
                    					userCty,location,itemgroup,project,job,created_by,linkToAMS,mobileaccess,emailsignature)
					VALUES
					(
                    	<!---Panel 1 --->
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(URLuserCompanyID)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(URLuserCompanyID)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userID)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userName)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#HASH(trim(form.userPassword))#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userLevel)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userPhone)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userEmail)#">,
                        <!---Panel 2 --->
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userCountry)#">,
                        <cfif form.location EQ ''>
                        	'All_loc',
                        <cfelse>
                        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">,
                        </cfif>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.group)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.project)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.job)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
                        '#HlinkAMS#',
						<cfif isdefined('form.mobileAccess')>'Y'<cfelse>'N'</cfif>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.emailsignature)#">
					)	
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.userID)#!\nError Message: #cfcatch.message#');
						window.open('/latest/generalSetup/userMaintenance/user.cfm?action=create&companyID=#URLuserCompanyID#','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.userID)# has been created successfully!');
				window.open('/latest/generalSetup/userMaintenance/userAdministration2.cfm?companyID=#URLuserCompanyID#','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">

		<cftry>
			<cfquery name="updateUser" datasource="main">
				UPDATE users
				SET
					<!---Panel 1 --->
                    username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userName)#">,
                    <cfif IsDefined('form.userPassword')>
                    	userPwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HASH(trim(form.userPassword))#">,
                    </cfif>
                    usergrpid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userLevel)#">,
                    userphone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userPhone)#">,
                    useremail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userEmail)#">,
                    <!---Panel 2 --->
                    userCty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userCountry)#">,
                    <cfif form.location EQ ''>
                    	location = 'All_loc',
                    <cfelse>
                    	location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">,
                    </cfif>
                    itemgroup = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.group)#">,
                    project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.project)#">,
                    job = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.job)#">,
                    created_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
                    linkToAMS = '#HlinkAMS#',
                    emailsignature = <cfqueryparam cfsqltype="cf_sql_varchar" value="#emailsignature#">,
					mobileaccess = <cfif isdefined('form.mobileAccess')>'Y'<cfelse>'N'</cfif>
				WHERE userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userID)#">;
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.userID)#!\nError Message: #cfcatch.message#');
				window.open('/latest/generalSetup/userMaintenance/user.cfm?action=update&companyID=#URLuserCompanyID#&userID=#form.userID#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.userID)# successfully!');
			window.open('/latest/generalSetup/userMaintenance/userAdministration2.cfm?companyID=#URLuserCompanyID#&userID=#form.userID#','_self');
		</script>
	<cfelseif url.action EQ "delete">
		<cftry>
        	<cfquery name="insertDeleteUserRecord" datasource="main">
				INSERT INTO users_d (userID,userPwd,userGrpID,userName,userBranch,userDept,
                					 userCty,lastLogin,userDirectory,linktoams,status,
                                     location,start_time,end_time,remark,deleteBy,deleteOn)
                SELECT 	a.userID,a.userPwd,a.userGrpID,a.userName,a.userBranch,a.userDept,
                		a.userCty,a.lastLogin,a.userDirectory,a.linktoams,a.status,
                        a.location,a.start_time,a.end_time,'','#HUserID#',NOW()
                FROM users AS a
                WHERE a.userID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLuserID#">;
			</cfquery>
			<cfquery name="deleteUser" datasource="main">
				DELETE FROM users
				WHERE userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLuserID#">;
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLuserID#!\nError Message: #cfcatch.message#');
					window.open('/latest/generalSetup/userMaintenance/userAdministration2.cfm?companyID=#URLuserCompanyID#&userID=#URLuserID#','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLuserID# successfully!');
			window.open('/latest/generalSetup/userMaintenance/userAdministration2.cfm?companyID=#URLuserCompanyID#&userID=#URLuserID#','_self');
		</script>

	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/userAdministration2.cfm?comid=#URLuserCompanyID#','_self');
		</script>
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/generalSetup/userMaintenance/userAdministration2.cfm?comid=#URLuserCompanyID#','_self');
	</script>
</cfif>
</cfoutput>