<!---<cfif not len(getAuthUser())>
	<cfset request.loginmessage = <!--- request.loginmessage &  --->"<br>You must be authorized to access that area ... Please login.">
	<cfinclude template="#Application.webroot#security/login.cfm">
</cfif>--->
<cfsetting enablecfoutputonly="no">
<cfoutput>
<cfquery name="getpass" datasource="main">
SELECT userpwd FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#"> and userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#dts#">
</cfquery>
<cfif getpass.recordcount eq 0>
<cfabort>
</cfif>
<cfform preservedata="no" name="gocrm" id="gocrm" action="https://crm.netiquette.com.sg/member/index.cfm?crmin=y" method="post">
<input type="hidden" name="j_username" id="j_username" value="#huserid#">
<input type="hidden" name="j_password" id="j_password" value="#getpass.userpwd#">
<input type="hidden" name="j_comid" id="j_comid" value="#replace(dts,'_i','')#">
</cfform>
<script type="text/javascript">
document.getElementById('gocrm').submit();
</script>
</cfoutput>