<html>
<head>
	<title>2nd Half Payroll - Pay Allowance For</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="aw_qry" datasource="#dts#">
SELECT *
FROM awtable
WHERE aw_cou between 1 and 17
</cfquery>
	
<cfoutput>
<form name="pForm" action="" method="post">
<div class="mainTitle">Pay Allowance For</div>
<table class="form">
<tr>
	<td colspan="3"><strong>Step 1</strong></td>
</tr>
<tr>
	<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp; Clear Allowance to '0'.</td>
</tr>
<tr>
	<td width="400px" colspan="3"><hr><br /></td>
</tr>
<tr>
	<td>Allowance No.</td>
	<td>
	<select name="">
	<cfloop query="aw_qry">
		<option value="#aw_cou#">#aw_qry.aw_cou# | #aw_qry.aw_desp#</option>
	</cfloop>
	</select>
	</td>
	<td align="right"><input type="button" name="clear" value="Clear" onclick=""></td>
</tr>
<tr><td><br /><br /><br /><br /><br /><br /></td></tr>
<tr>
	<td colspan="3" align="right"><input type="button" name="cancel" value="Cancel" onclick="window.location='/payments/2ndHalf/addUpdate/addUpdateList.cfm'"></td>
</tr>
</table>
</form>
</cfoutput>
</body>

</html>