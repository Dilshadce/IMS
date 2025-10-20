<html>
<head>
<title>Recover Update Menu</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<h2 align="center">Please Select Atleast A Function</h2>

<form name="recover_update" action="recover_update.cfm" method="post" onSubmit="javascript:return confirm('Are You Sure ?');">
	<table width="30%" align="center" class="data">
		<tr>
			<th>Quantity - In/Out</th>
			<td><input type="checkbox" name="qtyinout"></td>
		</tr>
		<tr>
			<th>Quantity Batch - In/Out</th>
			<td><input type="checkbox" name="batch"></td>
		</tr>
		<tr>
			<th>Quantity Location Batch - In/Out</th>
			<td><input type="checkbox" name="locationbatch"></td>
		</tr>
		<tr>
			<th>Update Month Cost</th>
			<td><input type="checkbox" name="update_month_cost"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="Submit" name="Submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="Reset" name="Reset" value="Reset">
			</td>
		</tr>
	</table>
</form>

</body>
</html>