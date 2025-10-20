<cfquery name="getbom" datasource="#dts#">
	select * from billmat where itemno="#form.itemno#" and bomno="#form.bomno#"		
</cfquery>


<cftry>
<cfloop query="getbom">

<cfquery name="insertbom" datasource="#dts#">
	insert into billmat 
    (itemno,bomno,bmitemno,bmqty,bmlocation) 
    values
    (
    <cfqueryparam cfsqltype="cf_sql_char" value="#form.newitemno#">,
    <cfqueryparam cfsqltype="cf_sql_char" value="#form.newbomno#">,
    <cfqueryparam cfsqltype="cf_sql_char" value="#getbom.bmitemno#">,
    <cfqueryparam cfsqltype="cf_sql_char" value="#getbom.bmqty#">,
    <cfqueryparam cfsqltype="cf_sql_char" value="#getbom.bmlocation#">
    )
    
</cfquery>

</cfloop>
<cfset status="Copy Successful!">
<cfcatch>
<cfset status="Copy Fail!">
</cfcatch>
</cftry>

<html>
<head>
	<title></title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<center><h3>#status#</h3></center>
	<br><br>
	<form action="" method="post">
	<table>
		<tr><td>#status#</td></tr>
	</table>
	<br><br>
	<div align="center"><input type="button" value="Close" onClick="window.close();window.opener.location.reload();"></div>
	</form>
</cfoutput>
</body>
</html>
