<cfif isdefined('dts')>
<cfif getauthuser() neq "">
<cfquery name="checkemail" datasource="main">
SELECT useremail FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
</cfquery>
<cfif checkemail.useremail eq "">
<cfajaximport tags="cfform">
<cfwindow name="updateemail" center="true" closable="true" height="400" width="500" source="/updateemail/fillinemail.cfm" modal="true" refreshonshow="true" initshow="true">
</cfwindow>
</cfif>
</cfif>
</cfif>