<html>
<head>
<title>View User Login History</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../scripts/date_format.js"></script>
</head>

<body>
<h1 align="center">View User Login History</h1>
<cfform name="form" action="viewloginhistory1.cfm" method="post" target="_blank">
<table border="0" align="center" width="50%" class="data">

	<tr>
		<th>Date From</th>
		<td><cfinput name="datefrom" type="text" value="" maxlength="10" size="10" validate="eurodate" message="Wrong date format!"> (DD/MM/YYYY)</td>
	</tr>
	<tr>
		<th>Date To</th>
		<td><cfinput name="dateto" type="text" value="" maxlength="10" size="10" validate="eurodate" message="Wrong date format!" > (DD/MM/YYYY)</td>
	</tr>
	<tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</cfform>

</body>
</html>