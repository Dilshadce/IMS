<cfquery name="updatecust" datasource="main">
UPDATE users SET comsta = "#url.sta#" WHERE userbranch = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custno)#" >
</cfquery>