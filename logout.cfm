<cfquery name="updatelastlogin" datasource="main">
	update users set lastlogin = '0000-00-00 00:00:00' where userid = '#huserid#' and userbranch = '#hcomid#'
</cfquery>
<cftry>
<cfquery datasource="main">
			insert into userlog 
			(
				userlogid,
				userlogtime,
				udatabase,
				uipaddress,
				status,
                		serverside
			) 
			values 
			(
				'#huserid#',
				now(),
				'#hcomid#',
				'#cgi.remote_Addr#',
				'Logout',
				'asia'
			)
</cfquery>
<cfcatch></cfcatch>
</cftry>

<cflogout>
<cfoutput> 
<cfif isdefined('url.goerp')>
<cflocation url="http://erp#url.goerp#.netiquette.com.sg/index.cfm?logout=1" addtoken="no">
</cfif>
<!--- <cfif lcase(HcomID) eq "simplysiti_i">
<script>
	window.open('http://simplysiti.fiatech.com.my/login/login.cfm?logout=yes', "_top");
</script>
<cfelse> --->
<script>
	window.open('/login/login.cfm?logout=yes', "_top");
</script>
<!--- </cfif>  --->
</cfoutput>
<cfabort>