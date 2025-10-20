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
<cfset servername = "erp2.netiquette.com.sg">
<cfelse>
<cfset servername = "erp.netiquette.com.sg">
</cfif>
<cfform target="_parent" preservedata="no" name="gocrm" id="gocrm" action="http://#servername#/techservices/index.cfm?crmin=y&erptype=#url.type#" method="post">
<input type="hidden" name="j_username" id="j_username" value="#huserid#">
<input type="hidden" name="j_password" id="j_password" value="#getpass.userpwd#">
<input type="hidden" name="j_comid" id="j_comid" value="#replace(dts,'_i','')#">
</cfform>
<script type="text/javascript">
document.getElementById('gocrm').submit();
</script>
</cfoutput>