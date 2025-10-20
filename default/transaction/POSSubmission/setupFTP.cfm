<cfif isdefined('form.save_btn')>
<cfif form.ftppass neq form.ftpconpass>
<cfoutput>
<script type="text/javascript">
alert('FTP password is not same with FTP confirm Password. Please kindly check.');
history.go(-1);
</script>
</cfoutput>
<cfabort>
</cfif>


<cftry>
<cfftp connection="testftp" server="#form.ftphost#" username="#form.ftpuser#" password="#form.ftppass#" port="#form.ftpport#" action="open" stoponerror="yes">
<cfcatch type="any">
<cfoutput>
<script type="text/javascript">
alert('FTP Establish Connection Fail. Please kindly check the FTP detail.');
history.go(-1);
</script>
<cfabort>
</cfoutput>
</cfcatch>
</cftry>
<cfftp connection="testftp" action="close" stoponerror="yes">

<cfquery name="checkexist" datasource="#dts#">
SELECT * FROM POSFTP
</cfquery>

<cfif checkexist.recordcount neq 0>
<cfquery name="updatedetail" datasource="#dts#">
UPDATE POSFTP SET
tenantno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tenantno#">,
ftphost = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftphost#">,
ftpport = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpport#">,
ftpuser = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpuser#">,
ftppass = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftppass#">
</cfquery>
<cfelse>
<cfquery name="insertdetail" datasource="#dts#">
INSERT INTO POSFTP
(ftphost,ftpport,ftpuser,ftppass,tenantno)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tenantno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftphost#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpport#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpuser#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftppass#">
)
</cfquery>
</cfif>
<script type="text/javascript">
alert('FTP connection established Successfully!');
</script>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Setup FTP</title>
</head>
<body>
<h1>POS Submission</h1>
<h4>
<a href="POSSubmission.cfm">Daily Sales Submission</a>||
<a href="SetupFtp.cfm">Setup FTP</a>
</h4>
<cfquery name="getFTP" datasource="#dts#">
SELECT * FROM POSFTP
</cfquery>
<cfif getFTP.recordcount neq 0>
<cfset tenantno= getFTP.tenantno>
<cfset ftphost = getFTP.ftphost>
<cfset ftpuser = getFTP.ftpuser>
<cfset ftppass = getFTP.ftppass>
<cfset ftpport = getFTP.ftpport>
<cfelse>
<cfset tenantno="">
<cfset ftphost = "">
<cfset ftpuser = "">
<cfset ftppass = "">
<cfset ftpport = "21">

</cfif>

<cfform name="setupftp" action="" method="post">
<table align="center" width="70%">
<tr><th>Tenant Number</th>
<td>:</td>
<td><cfinput type="text" name="tenantno" id="tenantno" value=""  size="35" required="yes"></td></tr>
<tr>
<th>Ftp Host</th>
<td>:</td>
<td><cfinput type="text" name="ftphost" id="ftphost" size="35" required="yes" message="FTP Host is Required" value="#ftphost#"/></td>
</tr>
<tr>
<th>Ftp Port</th>
<td>:</td>
<td><cfinput type="text" name="ftpport" id="ftpport" size="35" required="yes"  message="FTP PORT is Required" value="#ftpport#" /></td>
</tr>
<tr>
<th>FTP Username</th>
<td>:</td>
<td>
<cfinput type="text" name="ftpuser" id="ftpuser" size="35" required="yes" message="FTP Username is Required" value="#ftpuser#"/>
</td>
</tr>
<tr>
<th>FTP Password</th>
<td>:</td>
<td>
<cfinput type="password" name="ftppass" id="ftppass" size="35" required="yes" message="FTP Password is Required" value="#ftppass#" />
</td>
</tr>
<tr>
<th>FTP Confirm Password</th>
<td>:</td>
<td>
<cfinput type="password" name="ftpconpass" id="ftpconpass" size="35" required="yes" message="FTP Confirm Password is Required" value="#ftppass#" />
</td>
</tr>
<tr>
<td colspan="3" align="center"><input type="submit" name="save_btn" value="Save" /></td>
</tr>
</table>
</cfform>
</body>
</html>
