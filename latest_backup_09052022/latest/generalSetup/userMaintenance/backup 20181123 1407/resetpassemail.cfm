<cfif not IsDefined('url.userID')>
	<cfabort>
</cfif>
<cfoutput>
<cfset userid=URLDecode(url.userid)>
<cfset companyID=URLDecode(url.companyID)>

		<cfquery name="checkExist" datasource="main">
			SELECT userid,username,useremail,userbranch
            		FROM users
			WHERE userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(userid)#">
			AND userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(companyID)#">
		</cfquery>
            
        <cfquery name="reactivate" datasource="main">
			UPDATE users
            SET portalaccess="Y"
			WHERE userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(userid)#">
			AND userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(companyID)#">
		</cfquery>

		<cfif checkExist.recordcount neq 0>
		<cfset emailcheck="aa"&checkExist.useremail&"zz">
        
 		<cfmail from="donotreply@manpower.com.my" to="#trim(checkExist.useremail)#" subject="User Password" type="HTML">
                        Dear #checkExist.userName#,<br/><br/>
                        Kindly Click on Below Link To Reset Your Password : <br/>
			https://security.mp4u.com.my/resetpass.cfm?userid=#URLEncodedFormat(checkExist.userid)#&check=#hash(emailcheck)#
                </cfmail>
		
		<script type="text/javascript">
		alert('Email has been send!');
		window.open('/latest/generalSetup/userMaintenance/userAdministration2.cfm?comid=#companyID#','_self');
		</script>

		<cfelse>

		<script type="text/javascript">
		alert('No User Records Found');
		window.open('/latest/generalSetup/userMaintenance/userAdministration2.cfm?comid=#companyID#','_self');
		</script>

		</cfif>


</cfoutput>