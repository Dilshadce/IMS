<cfif husergrpid eq "Super">
<cfquery name="resetbrute" datasource="main">
        DELETE FROM tracklogin WHERE companyid = <cfqueryparam cfsqltype="cf_sql_char" value="#URLDECODE(url.comid)#">
        and userid = <cfqueryparam cfsqltype="cf_sql_char" value="#URLDECODE(url.userid)#">
        </cfquery>
<cfoutput>
<script type="text/javascript">
alert('Unblock Success!');
window.location.href="unblockbrute.cfm"
</script>
</cfoutput>
</cfif>