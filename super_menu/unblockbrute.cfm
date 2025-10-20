<cfif husergrpid eq "Super">
<html>
<head>
<title>Unblock Brute Users</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<h1>
Unblock Brute Users
</h1>
<h3>Please make sure user's identity has been indentify before unblock.</h3>
<cfset nowtimezone = dateformat(dateadd('n',-20,now()),'YYYY-MM-DD')&" "&timeformat(dateadd('n',-15,now()),'HH:MM:SS')>
    <cfquery name="checkbrute" datasource="main">
    select * from (
    SELECT count(id) as idtry,userid,companyid FROM tracklogin 
    where timetry >= "#nowtimezone#"
    group by ip,userid,companyid) as a where a.idtry >= 5
    </cfquery>
<table width="500px">
<tr>
<th width="200px">User ID</th>
<th width="200px">Company ID</th>
<th width="100px">Action</th>
</tr>
<cfloop query="checkbrute">
<tr>
<td>#checkbrute.userid#</td>
<td>#checkbrute.companyid#</td>
<td><a href="unblock.cfm?userid=#urlENCODEDFORMAT(checkbrute.userid)#&comid=#urlENCODEDFORMAT(checkbrute.companyid)#">Unblock</a></td>
</tr>
</cfloop>
</table>
</cfoutput>
</body>
</html>
</cfif>