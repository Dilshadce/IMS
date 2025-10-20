<cfif Not IsDefined('url.id')>
	<cfabort>
</cfif>

<cfoutput>    
	<cfset id = URLDecode(url.id)>
    
    <cfquery name="checkExist" datasource="payroll_main">
        SELECT entryID,userID,userName,userEmail
        FROM 
        <cfif #session.usercty# contains 'test'>
			hmuserstest
		<cfelse>
			hmusers
		</cfif>
        WHERE entryID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(id)#">
    </cfquery>
    
    <cfif checkExist.recordcount NEQ 0>
        <cfset emailCheck="aa"&checkExist.userEmail&"zz">
        
    <!---     <cfmail from="donotreply@manpower.com.my" to="#trim(checkExist.userEmail)#" subject="User Password">
            Dear #checkExist.userName#,<br/><br/>
            Kindly Click on Below Link To Reset Your Password :
            security.mp4u.com.my/resetPassword.cfm?id=#URLEncodedFormat(checkExist.entryID)#&check=#hash(emailCheck)#
        </cfmail> --->
        <cfset defaultPassword = "">
        <cfloop from="1" to="4" index="i">
            		<cfset alpha = #RandRange(Asc( 'A' ), Asc( 'Z' ), "SHA1PRNG")#>
            		<cfset defaultPassword = "#defaultPassword#" & "#chr(alpha)#">   
       			 </cfloop>
        
                <cfloop from="1" to="4" index="i">
                    <cfset defaultPassword = "#defaultPassword#" & "#RandRange(0, 9, 'SHA1PRNG')#"> 
                </cfloop>
        
        <cfquery name="updatepass" datasource="payroll_main">
                	UPDATE 
					<cfif #session.usercty# contains 'test'>
						hmuserstest
					<cfelse>
						hmusers
					</cfif>
                    SET 
                    userPWD = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Hash(defaultPassword)#">,
                    realpass = <cfqueryparam cfsqltype="cf_sql_varchar" value="#defaultPassword#">
                    WHERE entryID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(id)#">
                </cfquery>
                
                <cfset hrmgrid = trim(id)>
                <cfinclude template="sendemail.cfm">
        
        <script type="text/javascript">
            alert('Password Recovery Email has been send to #checkExist.userEmail#!');
            window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
        </script>
    <cfelse>
        <script type="text/javascript">
            alert('No User Records Found');
            window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm','_self');
        </script>
    </cfif>
</cfoutput>