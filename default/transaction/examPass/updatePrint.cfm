<cfquery name="updatePrinted" datasource="#dts#">
Update artran SET printed = "Y" where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#"> and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
</cfquery>