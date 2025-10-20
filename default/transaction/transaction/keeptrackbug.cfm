<cfquery name="updateagent" datasource="#dts#">
INSERT INTO keeptrackbug
(type,refno,billaction,changedvalue,changedtype,custno,created_by,created_on)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.agenno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.fieldtype#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
now()
)
</cfquery>
