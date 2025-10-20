<cftry>
<cfquery datasource='#dts#' name='updateartranaddonremark'>
Update artran set
multiagent1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent1#">,
multiagent2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent2#">,
multiagent3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent3#">,
multiagent4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent4#">,
multiagent5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent5#">,
multiagent6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent6#">,
multiagent7 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent7#">,
multiagent8 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent8#">
where refno = '#form.currefno#' and type = '#tran#'
</cfquery>
<cfcatch type="any">
</cfcatch>
</cftry>