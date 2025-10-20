<html>
<head>
<title>View Assignment Slip Report</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<cfform name="dump1" id="dump1" method="post" action="bepsdumpprocess.cfm">
<table>
<tr>
<th>Date From</th>
<td><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10" required="yes" validateat="onsubmit">(DD/MM/YYYY)</td>
</tr>
<tr>
<th>Date to</th>
<td><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10" required="yes" validateat="onsubmit">(DD/MM/YYYY)</td>
</tr>
<tr>
<td colspan="2"><input type="submit" name="sub_btn" id="sub_btn" value="Generate"></td>
</tr>
</table>
</cfform>
</cfoutput>
</body>
</html>
