<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Search</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
</head>

<cfquery name="getEmp_qry" datasource=#dts#>
SELECT empno,name FROM pmast
</cfquery>

<body>
<div style="width:100%; height:400px; overflow:auto;">
<table>
	<tr>
		<textarea cols="70" rows="5" readonly="yes"><cfoutput query="getEmp_qry">#getEmp_qry.empno#,#getEmp_qry.name#</cfoutput></textarea>
	</tr>
	<tr>
		<td>Look for:</td>
		<td><input type="text" name="" value=""></td>
		<td>Desp.(Left)</td>
		<td><input type="text" name="" value=""></td>
		<td>(Mid)</td>
		<td><input type="text" name="" value=""></td>
	</tr>
</table>
<br />
	<center>
		<input type="button" name="ok" value="Ok">
		<input type="button" name="cancel" value="Cancel" onclick="window.close()">
	</center>
</div>
</body>
</html>
