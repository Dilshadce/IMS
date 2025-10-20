<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sync Process</title>
</head>

<body>
<cfset target_agent = replacenocase(dts,"_i","_a","all")&".icagent">
<cfset target_project = replacenocase(dts,"_i","_a","all")&".project">
<cfset target_area = replacenocase(dts,"_i","_a","all")&".icarea">
<cfif isdefined('form.syncpro')>
<cfset projecterrordesp = "">
<cfquery name="getproject" datasource="#dts#">
SELECT * FROM #target_project#
</cfquery>
<cfloop query="getproject">
<cfquery name="checkproject" datasource="#dts#">
SELECT source FROM project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.source#">
</cfquery>
<cfif checkproject.recordcount eq 0>
<cfif getproject.COMPLETED eq "N">
<cfset completedpro = 0>
<cfelse>
<cfset completedpro = 1>
</cfif>
<cfquery name="insertproject" datasource="#dts#">
INSERT INTO project (SOURCE,PROJECT,PORJ,COMPLETED,CONTRSUM,DETAIL1,DETAIL2,DETAIL3)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.SOURCE#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.PROJECT#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.PORJ#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#completedpro#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.CONTRSUM#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.DETAIL1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.DETAIL2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.DETAIL3#">
)
</cfquery>
</cfif>
</cfloop>


<cfquery name="getproject" datasource="#dts#">
SELECT * FROM project
</cfquery>
<cfloop query="getproject">
<cfquery name="checkproject" datasource="#dts#">
SELECT source FROM #target_project# where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.source#">
</cfquery>
<cfif checkproject.recordcount eq 0>
<cfif getproject.COMPLETED eq "0">
<cfset completedpro = "N">
<cfelse>
<cfset completedpro = "Y">
</cfif>
<cftry>
<cfquery name="insertproject" datasource="#replacenocase(dts,"_i","_a","all")#">
INSERT INTO project (SOURCE,PROJECT,PORJ,COMPLETED,CONTRSUM,DETAIL1,DETAIL2,DETAIL3,DATEFROM,DATETO,DATECOMM,DATEPREINS,DATEHANDOVER,PROJECTTEAM,STATUS,REMARK)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.SOURCE#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.PROJECT#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.PORJ#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#completedpro#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.CONTRSUM#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.DETAIL1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.DETAIL2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getproject.DETAIL3#">,
'0000-00-00 00:00:00',
'0000-00-00 00:00:00',
'0000-00-00 00:00:00',
'0000-00-00 00:00:00',
'0000-00-00 00:00:00',
"",
"",
""
)
</cfquery>
<cfcatch type="any">
<cfset projecterrordesp = projecterrordesp&getproject.SOURCE&" - "&cfcatch.Detail&"<br />">
</cfcatch>
</cftry>
</cfif>
</cfloop>

<cfoutput>
<cfif projecterrordesp neq "">
<h1>Project Sync Error Occur- Below project didnt sync successfully</h1>
#projecterrordesp#
<cfelse>
<h1>Project Sync Successfully</h1>
</cfif>
</cfoutput>
</cfif>

<cfif isdefined('form.syncagent')>
<cfset agenterrordesp = "">
<cfquery name="getagent" datasource="#dts#">
SELECT * FROM #target_agent#
</cfquery>
<cfloop query="getagent">
<cfquery name="checkagent" datasource="#dts#">
SELECT agent FROM icagent where agent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.agent#">
</cfquery>
<cfif checkagent.recordcount eq 0>
<cfquery name="insertagent" datasource="#dts#">
INSERT INTO icagent (AGENT,DESP,COMMSION1,HP)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.agent#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.DESP#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.COMMSION1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.HP#">
)
</cfquery>
</cfif>
</cfloop>


<cfquery name="getagent" datasource="#dts#">
SELECT * FROM icagent
</cfquery>
<cfloop query="getagent">
<cfquery name="checkagent" datasource="#dts#">
SELECT agent FROM #target_agent# where agent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.agent#">
</cfquery>
<cfif checkagent.recordcount eq 0>
<!--- <cftry> --->
<cfquery name="insertagent" datasource="#replacenocase(dts,"_i","_a","all")#">
INSERT INTO icagent (AGENT,DESP,COMMSION1,HP)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.agent#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.DESP#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(getagent.COMMSION1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getagent.HP#">
)</cfquery>
<!--- <cfcatch type="any">
<cfset agenterrordesp = agenterrordesp&getagent.agent&" - "&cfcatch.Detail&"<br />">
</cfcatch>
</cftry> --->
</cfif>
</cfloop>

<cfoutput>
<cfif agenterrordesp neq "">
<h1>Agent Sync Error Occur- Below agent didnt sync successfully</h1>
#agenterrordesp#
<cfelse>
<h1>Agent Sync Successfully</h1>
</cfif>
</cfoutput>
</cfif>

<cfif isdefined('form.syncarea')>
<cfset areaerrordesp = "">
<cfquery name="getarea" datasource="#dts#">
SELECT * FROM #target_area#
</cfquery>
<cfloop query="getarea">
<cfquery name="checkarea" datasource="#dts#">
SELECT area FROM icarea where area = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.areacode#">
</cfquery>
<cfif checkarea.recordcount eq 0>
<cfquery name="insertarea" datasource="#dts#">
INSERT INTO icarea (area,DESP)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.areacode#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.areaDESP#">
)
</cfquery>
</cfif>
</cfloop>


<cfquery name="getarea" datasource="#dts#">
SELECT * FROM icarea
</cfquery>
<cfloop query="getarea">
<cfquery name="checkarea" datasource="#dts#">
SELECT areacode FROM #target_area# where areacode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.area#">
</cfquery>
<cfif checkarea.recordcount eq 0>
<!--- <cftry> --->
<cfquery name="insertarea" datasource="#replacenocase(dts,"_i","_a","all")#">
INSERT INTO icarea (areacode,areaDESP)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.area#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.DESP#">
)</cfquery>
<!--- <cfcatch type="any">
<cfset areaerrordesp = areaerrordesp&getarea.area&" - "&cfcatch.Detail&"<br />">
</cfcatch>
</cftry> --->
</cfif>
</cfloop>

<cfoutput>
<cfif areaerrordesp neq "">
<h1>Area Sync Error Occur- Below area didnt sync successfully</h1>
#areaerrordesp#
<cfelse>
<h1>Area Sync Successfully</h1>
</cfif>
</cfoutput>
</cfif>
</body>
</html>
