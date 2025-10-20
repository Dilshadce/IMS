<html>
<head>
<title>View Audit Trail</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1 align="center">View Audit Trail of Boss Menu</h1>
<form name="form" action="viewaudit_bossmenu1.cfm" method="post" target="_blank">
<table border="0" align="center" width="65%" class="data">
	<tr>
		<th>Type</th>
		<td>&nbsp;</td>
		<td colspan="2">
			<select name="type">
				<option value="">Choose a Type</option>
					<option value="changeagent">Agent</option>
                    <option value="changebrand">Brand</option>
                    <option value="changecategory">Category</option>
                    <option value="changecustsupp">Customer/Supplier No</option>
                    <option value="changedate">Date of Bill</option>
                    <option value="changeenduser">Driver</option>
                    <option value="changegroup">Group</option>
                    <option value="changeitemno">Item No</option>
                    <option value="changejob">Job</option>
                    <option value="changeproject">Project</option>
                    <option value="changerefno">Bill Ref No</option>
                    <option value="changeservice">Service</option>

			</select>
		</td>
	</tr>
	
	<tr> 
        <td colspan="4" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</form>

</body>
</html>