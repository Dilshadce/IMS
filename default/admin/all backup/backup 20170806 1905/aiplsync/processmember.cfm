<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sync Process</title>
</head>

<body>

<cfset dtslist= "kjpe_i,belco_i">
<cfloop list="#dtslist#" index="a">
<cfquery name="insertitemmatrix" datasource="#dts#">
insert ignore into #a#.member select * from member
</cfquery>

</cfloop>

<cfoutput>
<h1>Member Sync Successfully</h1>
</cfoutput>

</cfif>

</body>
</html>
