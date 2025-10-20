<cfif isdefined('url.type') eq false>
<h1>Invalid Page Navigation</h1>
<cfabort />
</cfif>
<html>
<head>
<title>Recurring Transaction Group</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
</head>
<body>
<cfoutput>
<h4>
	<a href="recurrtable2.cfm?type=Create">Creating a New Recurring Group</a>||
	<a href="recurrmain.cfm">List all Recurring Group</a>
</h4>
<h1>
#url.type# Recurring Group
</h1>
<cfif url.type eq "Create">
<cfset desp = "">
<cfset recurrtype = "1">
<cfset nextdate = dateformat(now(),'dd/mm/yyyy')>
<cfelseif url.type eq "Edit" or url.type eq "Delete">
<cfquery name="getrecurr" datasource="#dts#">
SELECT desp,recurrtype,nextdate FROM recurrgroup WHERE groupid = "#url.id#"
</cfquery>
<cfset desp = getrecurr.desp >
<cfset recurrtype = getrecurr.recurrtype >
<cfset nextdate = dateformat(getrecurr.nextdate,'dd/mm/yyyy')>
</cfif>

<cfform name="recurr" id="recurr" action="recurrpro.cfm" method="post">
<cfif isdefined('url.id')>
<input type="hidden" name="groupid" id="groupid" value="#url.id#">
</cfif>
<table align="center" class="data" width="450">
<tr>
<th>Recurring Group Name</th>
<td>:</td>
<td>
<cfinput type="text" name="desp" id="desp" value="#desp#" required="yes" message="Recurring Group Name is Required" />
</td>
</tr>
<tr>
<th>Generate one in</th>
<td>:</td>
<td>
<select name="recurrtype" id="recurrtype">
<cfloop list="1,2,3,4,5,6,7,8,9,10,11,12" index="i">
<option value="#i#" <cfif recurrtype eq i>Selected</cfif>>#i# Month</option>
</cfloop>
</select>
</td>
</tr>
<tr>
<th>Next Generated Date</th>
<td>:</td>
<td>
<cfinput type="text" name="nextdate" id="nextdate" validate="eurodate" validateat="onsubmit" value="#nextdate#" required="yes" message="Next Generated Date is Required" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(nextdate);">
</td>
</tr>
<tr>
<td colspan="3" align="center"><input type="submit" value="#url.type#" name="submitbtn" id="submitbtn" /></td>
</tr>
</table>
</cfform>
</cfoutput>
</body>
</html>