<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sync Process</title>
</head>

<body>
<cfset target_from = "AIPL_I.icitem">
<cfset target_to = "KJPE_I.icitem">

<cfset target_from2 = "AIPL_I.icmitem">
<cfset target_to2 = "KJPE_I.icmitem">

<cfif isdefined('form.syncitem')>
<!---<cfquery name="truncateitem" datasource="#dts#">
truncate #target_to#
</cfquery>--->

<cfquery name="insertitemmatrix" datasource="#dts#">
insert ignore into #target_to2# select * from #target_from2#
</cfquery>

<cfquery name="insertitem" datasource="#dts#">
insert ignore into #target_to# select * from #target_from#
</cfquery>

<cfquery name="insertitem2" datasource="#dts#">
update #target_to# set wos_date='#dateformat(now(),'yyyy-mm-dd')#' where wos_date is null or wos_date='0000-00-00' 
</cfquery>

<cfoutput>
<h1>Item Sync Successfully</h1>
</cfoutput>

</cfif>

</body>
</html>
