<cfif isdefined('form.importschedule') or isdefined('form.exportschedule')>
<cfquery name="checkimport" datasource="#dts#">
SELECT * FROM FTPSchedule
</cfquery>
<cfif isdefined('form.importschedule') and form.importtimestart eq "">
<cfset form.importtimestart = "12:00 AM">
</cfif>
<cfif isdefined('form.exportschedule') and form.exporttimestart eq "">
<cfset form.exporttimestart = "12:00 AM">
</cfif>
<cfif checkimport.recordcount neq 0>
<cfquery name="updatedetail" datasource="#dts#">
UPDATE ftpschedule 
SET
importon = <cfif isdefined('form.importschedule')>'Y'<cfelse>'N'</cfif>,
importstart = <cfif isdefined('form.importschedule')>'#form.importtimestart#'<cfelse>''</cfif>,
exporton = <cfif isdefined('form.exportschedule')>'Y'<cfelse>'N'</cfif>,
exportstart = <cfif isdefined('form.exportschedule')>'#form.exporttimestart#'<cfelse>''</cfif>
WHERE posidid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.posidid#" >
</cfquery> 
<cfelse>
<cfquery name="insertdetail" datasource="#dts#">
INSERT INTO ftpschedule 
(
importon,importstart,exporton,exportstart,posidid
)
VALUES
(
<cfif isdefined('form.importschedule')>'Y'<cfelse>'N'</cfif>,
<cfif isdefined('form.importschedule')>'#form.importtimestart#'<cfelse>''</cfif>,
<cfif isdefined('form.exportschedule')>'Y'<cfelse>'N'</cfif>,
<cfif isdefined('form.exportschedule')>'#form.exporttimestart#'<cfelse>''</cfif>,
<cfqueryparam cfsqltype="cf_sql_integer" value="#form.posidid#" >
)
</cfquery>
</cfif>

<cfif isdefined('form.importschedule')>
<cfschedule action = "update"
    task = "posimport#dts##form.posidid#" 
    operation = "HTTPRequest"
    url = "http://crm.netiquette.com.sg/POS/getfile.cfm?type=import&dtsname=#dts#&posid=#form.posidid#"
    startDate = "#dateformat(now(),'YYYY-MM-DD')#"
    startTime = "#form.importtimestart#"
    interval = "daily"
    resolveURL = "Yes"
    requestTimeOut = "900">
<cfelse>
<cftry>
<cfschedule action="delete" task="posimport#dts##form.posidid#">
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>

<cfif isdefined('form.exportschedule')>
<cfschedule action = "update"
    task = "posexport#dts##form.posidid#" 
    operation = "HTTPRequest"
    url = "http://crm.netiquette.com.sg/POS/getfile.cfm?type=export&dtsname=#dts#&posid=#form.posidid#"
    startDate = "#dateformat(now(),'YYYY-MM-DD')#"
    startTime = "#form.exporttimestart#"
    interval = "daily"
    resolveURL = "Yes"
    requestTimeOut = "900">
<cfelse>
<cftry>
<cfschedule action="delete" task="posexport#dts##form.posidid#">
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>

<cfoutput>
<script type="text/javascript">
alert('Schedule Setup Successfully');
window.location.href="index.cfm?id=#form.posidid#";
</script>
</cfoutput>

<cfelse>

<cfoutput>
<cftry>
<cfschedule action="delete" task="posexport#dts##form.posidid#">
<cfcatch type="any">
</cfcatch>
</cftry>
<cftry>
<cfschedule action="delete" task="posimport#dts##form.posidid#">
<cfcatch type="any">
</cfcatch>
</cftry>
<cfquery name="deleteall" datasource="#dts#">
Delete FROM ftpschedule where posidid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.posidid#" >
</cfquery>

<script type="text/javascript">
alert('Import Schedule or Export Schedule is Canceled');
window.location.href="index.cfm?id=#form.posidid#";
</script>
</cfoutput>

</cfif>
