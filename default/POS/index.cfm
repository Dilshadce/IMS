<html>
<head>
<title>Import / Export POS Data</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1>Setup FTP</h1>
<h4>
<a href="createlist.cfm?type=create">Create POS Channel</a>||
<a href="listpos.cfm">List POS Channel</a>||
<a href="SetupFtp.cfm">Setup FTP</a>||
<a href="recalculatetax.cfm">Recalculate Tax for POS Bills</a>
</h4>
<cfform name="inoutpos" method="post" action="getfile.cfm">
<cfquery name="getposchannel" datasource="#dts#">
SELECT posid,posfolder FROM poschannel WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
</cfquery>
<h1><cfoutput>#getposchannel.posid#</cfoutput></h1>
<input type="hidden" name="posidnew" id="posidnew" value="<cfoutput>#url.id#</cfoutput>" >
<table align="center" width="50%">
<tr>
<th>Import POS Data</th>
<td>:</td>
<td>
<input type="checkbox" name="importpos" id="importpos" value="import">
</td>
</tr>
<tr>
<th>Export POS Data</th>
<td>:</td>
<td>
<input type="checkbox" name="exportpos" id="exportpos" value="export">
</td>
</tr>
<tr>
<td colspan="3" align="center">
<input type="submit" name="importdata" value="Import / Export Now" onClick="ColdFusion.Window.show('processing');" />
</td>
</tr>
</table>
</cfform>
<br/>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Processing....Please Wait" modal="true" resizable="false" >
<h1>Processing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
</cfwindow>
<cfquery name="checkimportschedule" datasource="#dts#">
SELECT * FROM FTPSchedule WHERE posidid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
</cfquery>
<cfif checkimportschedule.recordcount neq 0>
<cfset importon = checkimportschedule.importon>
<cfset importstart = checkimportschedule.importstart>
<cfset exporton = checkimportschedule.exporton>
<cfset exportstart = checkimportschedule.exportstart>
<cfelse>
<cfset importon = "N">
<cfset importstart = "">
<cfset exporton = "N">
<cfset exportstart = "">
</cfif>

<cfform action="scheduleprocess.cfm" method="post" name="schedule">
<input type="hidden" name="posidid" id="posidid" value="<cfoutput>#url.id#</cfoutput>">
<table align="center" width="50%">
<tr>
<th>On Import Schedule</th>
<td>:</td>
<td><input type="checkbox" name="importschedule" id="importschedule" value="importschedule" <cfif importon eq "Y"> checked </cfif> /></td>
</tr>
<tr>
<td>Import Time Start</td>
<td>:</td>
<td>
<cfinput type="text" name="importtimestart" id="importtimestart" value="#importstart#">&nbsp;(12:00 AM)
</td>
</tr>
<tr>
<th>On Export Schedule</th>
<td>:</td>
<td><input type="checkbox" name="exportschedule" id="exportschedule" value="exportschedule" <cfif exporton eq "Y"> checked </cfif> /></td>
</tr>
<tr>
<td>Export Time Start</td>
<td>:</td>
<td>
<cfinput type="text" name="exporttimestart" id="exporttimestart" value="#exportstart#">&nbsp;(12:00 AM)
</td>
</tr>
<tr>
<td colspan="3" align="center"><input type="submit" name="Save_btn" id="Save_btn" value="Save" /></td>
</tr>
</table>
</cfform>

</body>
</html>