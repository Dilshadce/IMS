<cfif isdefined('form.updateemailladdress')>
<cfquery name="updateemail" datasource="main">
UPDATE users SET useremail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.updateemailladdress)#"> WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
</cfquery>
<cfoutput>
<script type="text/javascript">
alert('Thank you for your patience and cooperation! Have a nice day!');
ColdFusion.Window.hide('updateemail');
</script>
</cfoutput>
</cfif>