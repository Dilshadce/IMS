<cfif isdefined('form.sub_btn')>
<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and userPwd = "#hash(form.password)#"
</cfquery>

<cfif getAdminPass.recordcount neq 0>
<cfquery name="updatepost" datasource="#dts#">
UPDATE poststatus SET armstatus = "N"
</cfquery>
<h4>Cancel Success!</h4>
<cfelse>
<h4>Wrong Password</h4>
</cfif>

</cfif>

<html>
<head>
<title>Posting Log</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1 align="center">Cancel Import Arm</h1>
<cfoutput>
<h3 align="center">
<a href="armcancel.cfm">Cancel Import Arm</a>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postinglog.cfm">Posting Log</a>||&nbsp;&nbsp;&nbsp;<a href="postinglogreport.cfm">Posting Log Report</a><cfif hlinkams eq "Y">&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postingcheck.cfm">Check Inexistence at AMS</a></cfif>
</h3>
</cfoutput><cfform name="userarm" method="post" action="">
<table align="center">
<tr><td>
Please Enter Admin Password to Cancel the Arm
</td>
</tr>
<tr>
<td align="center"><cfinput type="password" name="password" id="password" required="yes" message="Password is Required" /></td>
</tr>
<tr>
<td align="center">
<cfinput type="submit" name="sub_btn" value="Go" />
</td>
</tr>
</table></cfform>
</body>
</html>