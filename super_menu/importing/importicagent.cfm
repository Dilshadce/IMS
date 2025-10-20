<!---icagent --->
<cfquery name="moveicagent" datasource="importfromdbf">
SELECT * FROM icagent
</cfquery>

<cfloop query="moveicagent">

<cfquery name="inserticagent" datasource="#dts#">
INSERT IGNORE INTO icagent
(
AGENT,
DESP,
COMMSION1,
HP,
discontinueagent,
agentID,
agentlist,
TEAM
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicagent.AGENT)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveicagent.DESP)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveicagent.COMMISION1)#">,
'',
'',
'',
'',
''
)
</cfquery>

</cfloop>

