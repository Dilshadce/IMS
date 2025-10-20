<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="payroll_main">
			SELECT userID 
            FROM hmusers
			WHERE userID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.userEmail)#"> 
                  <!---and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.custno)#">--->
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This hiring manager email already exist!');
				window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrDetail.cfm?action=create','_self');
			</script>
		<cfelse>
			<!---<cftry>--->
            	<cfset defaultPassword = "">
                
        	<cfloop from="1" to="4" index="i">
            		<cfset alpha = #RandRange(Asc( 'A' ), Asc( 'Z' ), "SHA1PRNG")#>
            		<cfset defaultPassword = "#defaultPassword#" & "#chr(alpha)#">   
       			 </cfloop>
        
                <cfloop from="1" to="4" index="i">
                    <cfset defaultPassword = "#defaultPassword#" & "#RandRange(0, 9, 'SHA1PRNG')#"> 
                </cfloop>
                
				<cfquery name="createHM" datasource="payroll_main">
					INSERT INTO hmusers (userID, userPWD, userGrpID, userName, userCmpID, userDsn, userCty, userEmail, custno,realpass)
					VALUES(	
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userEmail#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hash(defaultPassword)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="ADMIN">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comID#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comID#_p">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="SINGAPORE">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userEmail#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#defaultPassword#">
					)
				</cfquery>
                
                <cfquery name="getlastid" datasource="payroll_main">
                SELECT LAST_INSERT_ID() as lastid
                </cfquery>
                <cfset hrmgrid = getlastid.lastid>
                <cfif isdefined('form.isLogin')>
                <cfinclude template="sendemail.cfm">
                </cfif>
<!---                 <cftry>

                    
                    <cfmail from="donotreply@manpower.com.my" to="#form.userEmail#" subject="Login Detail For MP4U" type="html">
                        Dear #form.userName#,<br/><br/>
                        Good day!<br>
<br>
Please kindly refer below for your login detail of MP4U.<br>
<br>
Username: #form.userEmail#<br>
Password: #defaultPassword#<br/><br>
You may login into MP4U at <a href="http://www.mp4u.com.my">http://www.mp4u.com.my</a>.<br>
Please kindly change your password upon first login.<br>
<br>
Best Regards,<br>
MP4U 
                  </cfmail>
                <cfcatch type="any">
                </cfcatch>
                </cftry> --->
                
			<script type="text/javascript">
				alert('Hiring Manager has been created successfully!');
				window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">	
		<!---<cftry>--->
			<cfquery name="updateHM" datasource="payroll_main">
				UPDATE hmusers
				SET userID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userEmail#">,
					userName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userName#">,
                    userEmail=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userEmail#">,
                    custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                    userCmpID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comID#">,
                    userDsn=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comID#_p"> 
                    <cfif isdefined('form.islogin') eq false>
                    ,status = ""
                    <cfelse>
                    ,status = "Y"
					</cfif>
				WHERE entryID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.id#">;
			</cfquery>  
		<script type="text/javascript">
			alert('Updated hiring manager successfully!');
			window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
    
		<cftry>
        	<cfquery name="getOldID" datasource="payroll_main">
                SELECT entryID  
                FROM hmusers
                WHERE entryID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.id)#">
            </cfquery>
            <cfquery name="checkexisted" datasource="#dts#">
            SELECT hrMgr,placementno FROM placement WHERE hrMgr = "getOldID.entryid"
            </cfquery>
            <cfif checkexisted.recordcount neq 0>
            <cfoutput>
            <cfsavecontent variable="listofplacement">
            <cfloop query="checkexisted">
            #checkexisted.placementno#\n
            </cfloop>
            </cfsavecontent>
			<script type="text/javascript">
				alert('Hiring Manager still existed in placement as below. System can not delete the hiring manager\n#listofplacement#');
            </script>
            <cfabort>
            </cfoutput>
			</cfif>
			<cfquery name="deleteHMUsers" datasource="payroll_main">
				DELETE FROM hmusers
				WHERE entryID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.id)#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete hiring manager!\nError Message: #cfcatch.message#');
					window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted hiring manager successfully!');
			window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
		</script>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>