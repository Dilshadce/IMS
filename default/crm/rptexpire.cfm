<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
	
<h1>View All Customer Contract by Expiry Date</h1>
<br><br>
<hr>
<br>
<cfform name="rptexpire" action="rptexpire2.cfm" method="post">
<table align="center" class="data">
	<tr>
		<th>Expire by:</th>
		<td><cfoutput><cfinput name="expiredate" type="text" value="#dateformat(now(), "dd/mm/yyyy")#"></cfoutput>
	</tr>
	<tr>
		<th>Type</th>
		<td><p><label><input name="chktype" type="radio" value="1" checked>Expired</label><br>
			<label><input type="radio" name="chktype" value="2">No Contract</label><br></p>
		</td>
	</tr>
	<tr>
		<td></td>
		<td align="right" nowrap><input name="submit" type="submit" value="Submit"></td>
	</tr>
</table>
</cfform>
</body>
</html>