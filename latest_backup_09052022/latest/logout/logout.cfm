<cfquery name="updatelastlogin" datasource="main">
	UPDATE users 
    SET 
    	lastlogin = '0000-00-00 00:00:00' 
    WHERE userid = '#huserid#' 
    AND userbranch = '#hcomid#'
</cfquery>

<cftry>
    <cfquery datasource="main">
    	INSERT INTO userlog(userlogid,userlogtime,udatabase,uipaddress,status,serverside) 
		VALUES(
				'#huserid#',
                NOW(),
                '#hcomid#',
                '#cgi.remote_Addr#',
                'Logout',
                'asia'
                )
    </cfquery>
	<cfcatch>
	</cfcatch>
</cftry>

<!---<cfif huserid neq 'mptest13'>
    <cfif left(huserid,6) neq "mptest" >
        <cfquery name="updateUserBranch" datasource="main">
            UPDATE users 
            SET 
                userbranch = 'manpower_i',
                userdept = 'manpower_i'
            WHERE userid = '#huserid#'
        </cfquery>
    </cfif>
</cfif>--->

<!---<cfif dts eq 'manpowertest_i'>
<cfset sessionrotate()>
</cfif>--->
<!---<cfif dts neq 'manpowertest_i'>--->
<cfset sessionInvalidate()>
<cflogout>
<!---</cfif>--->
	<cfoutput> 
        <cfif IsDefined('url.goerp')>
            <cflocation url="http://erp#url.goerp#.netiquette.com.sg/index.cfm?logout=1" addtoken="no">
        </cfif>
        <!---<cfif dts neq 'manpowertest_i'>--->
        <script>
            window.open("/login/login.cfm?logout=yes<cfif isdefined('msg')>&msg=sessionout</cfif>", "_top");
        </script>
        <!---</cfif>--->
        <!---<cfif dts eq 'manpowertest_i'>
         <script>
            window.open('/login/login.cfm?logout=yes&dts', "_top");
        </script>
        </cfif>--->
    </cfoutput>
<cfabort>