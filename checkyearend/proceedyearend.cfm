<cfif isdefined('form.yearendid')>
<cfoutput>
<cfset datestart = dateadd('d',-1,now())>
<cfquery name="doublecheck" datasource="loadbal">
SELECT comstatus FROM yearend WHERE date(submited_on) Between "#dateformat(datestart,'YYYY-MM-DD')#" AND "#dateformat(now(),'YYYY-MM-DD')#" and id = "#form.yearendid#" and comstatus = "Proceed Year End"
</cfquery>
<cfif doublecheck.recordcount eq 0>

<h3>There have some issue with the year end. Please kindly contact our support at support@mynetiquette.com to proceed on year end.</h3>

<cfelse>
<cfquery name="verifypass" datasource="main">
SELECT userid FROM users WHERE userid = "#getauthuser()#"
AND userpwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(form.passfield)#"> AND userbranch = "#dts#"
</cfquery>
<cfif verifypass.recordcount eq 0>
<script type="application/javascript">
alert('Wrong Password!');
window.location.reload();
</script>
<cfabort>
<cfelse>
<cfquery name="insertyearend" datasource="loadbal">
UPDATE yearend SET comstatus = "Queuing Year End", progress = "0.00", yearend_by = "#getauthuser()#", yearend_on = now(), macaddress = "#cgi.remote_Addr#" WHERE id = "#form.yearendid#"
</cfquery>

<cfquery name="updateyearend" datasource="main">
UPDATE users SET isyearend ="Y" WHERE userbranch = "#dts#"
and left(userid,5) <> "Ultra" and usergrpid <> "SUPER"
</cfquery>


<script type="text/javascript">
alert('Year end is in progress! You will received an email after the year end has completed. You will be log out from system now.');
window.location.href='/logout.cfm';
</script>


</cfif>
</cfif>
</cfoutput>
</cfif>