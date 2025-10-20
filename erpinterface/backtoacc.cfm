<cfsetting enablecfoutputonly="no">
<cfoutput>
<cfquery name="getpass" datasource="main">
SELECT userpwd FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#"> and userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#dts#">
</cfquery>
<cfif getpass.recordcount eq 0>
<cfabort>
</cfif>
<cfset currentURL = CGI.SERVER_NAME >
<cfif mid(currentURL,'4','1') eq "2">
<cfset servername = "ams2.netiquette.com.sg">
<cfelse>
<cfset servername = "ams.netiquette.com.sg">
</cfif>
<cfform target="_parent" preservedata="no" name="gocrm" id="gocrm" action="https://#servername#/erpinterface/index.cfm?crmin=y" method="post">
<input type="hidden" name="userid" id="userid" value="#huserid#">
<input type="hidden" name="userPwd" id="userPwd" value="#getpass.userpwd#">
<input type="hidden" name="companyid" id="companyid" value="#replace(dts,'_i','')#">
</cfform>
<script type="text/javascript">
document.getElementById('gocrm').submit();
</script>
</cfoutput>