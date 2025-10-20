<cfsetting enablecfoutputonly="no">
<html>
<head>
<link rel="stylesheet" href="/stylesheet/stylesheet.css"/>

</head>
<body>
<!--- <cfquery name="getinfo" datasource="main">
	select * from startupwarning
	where comid='#dts#'
</cfquery> --->

<cfquery name="getinfo" datasource="main">
	SELECT * FROM startupwarning
	WHERE (comid='#dts#' or comid='all')
	limit 1
</cfquery>

<cfoutput>
	<h3>#getinfo.Message#</h3>
	#replace(tostring(getinfo.Details),chr(10),"<br/>","all")#
	
	<cfset date1=createDate(year(now()),month(now()),day(now()))>
	<cfset date2=createDate(year(getinfo.duedate),month(getinfo.duedate),day(getinfo.duedate))>
	<div align="center"><h3>Days Left: #DateDiff("d", date1, date2)#</h3></div>
</cfoutput>
	<div align="center"><input type="button" name="btnContinue" id="btnContinue" <cfif DateDiff("d", date1, date2) gte 0>value="Click To Continue" onClick="closeMessage()"<cfelse>Value="Please contact administrator"</cfif> disabled="true"></div>
</body>
</html>