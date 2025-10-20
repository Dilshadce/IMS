<cfsetting showdebugoutput="no">   
<html>
<head>
<title>Posting Log</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1 align="center">Check Inexistance Transaction at AMS</h1>
<cfoutput>
<h3 align="center">
<a href="armcancel.cfm">Cancel Import Arm</a>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postinglog.cfm">Posting Log</a>||&nbsp;&nbsp;&nbsp;<a href="postinglogreport.cfm">Posting Log Report</a><cfif hlinkams eq "Y">&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postingcheck.cfm">Check Inexistence at AMS</a></cfif>
</h3>
</cfoutput>
<cfoutput>
<cfquery name="getlist" datasource="#dts#">
SELECT reference FROM #replace(dts,'_i','_a')#.glpost group by reference
</cfquery>
<cfquery name="getlist2" datasource="#dts#">
SELECT refno,type,wos_date,fperiod,posted from artran where posted = "P" and (void='' or void is null) and refno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getlist.reference)#" list="yes" separator=",">) and fperiod <> "99" and grand_bil <> 0 order by type,refno
</cfquery>
<table>
<tr>
<th>Type</th>
<th>Refno</th>
<th>Period</th>
<th>Date</th>
</tr>
<cfloop query="getlist2">
<tr>
<td>#getlist2.type#</td>
<td>#dateformat(getlist2.wos_date,'DD/MM/YYYY')#</td>
<td>#getlist2.refno#</td>
<td>#getlist2.fperiod#</td>
</tr>
</cfloop>
</table>
</cfoutput>
</body>
</html>