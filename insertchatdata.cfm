<cfquery name="insertdata" datasource="chattrack">
INSERT INTO chattrack (type,username,comid,tracktime)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dts#">,
now()
)
</cfquery>
<cfsetting showdebugoutput="no">