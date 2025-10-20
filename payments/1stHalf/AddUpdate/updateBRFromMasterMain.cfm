<html>
<head>
	<title>1st Half payroll</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
<form name="uForm" action="updateBRFromMasterProcess.cfm" method="post">
<div class="mainTitle">1st Half Payroll - Update Basic Rate</div>
<font color="red" size="2.5"><cfif isdefined("form.status")><cfoutput>#form.status#</cfoutput></cfif></font>
<table class="form">
<tr>
	<td><strong>Update Basic Rate</strong></td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Update basic rate from master.</td>
</tr>
<tr>
	<td width="300px"><hr></td>
</tr>
<tr>
	<td><br /><br /><br /><br /><br /><br /></td>
</tr>
<tr>
	<td align="right">
		<input type="submit" name="upadte" value="Update">
		<input type="button" name="cancel" value="Cancel" onClick="window.location='/payments/1stHalf/addUpdate/addUpdateList.cfm'">
	</td>
</tr>
</table>
</form>
</cfoutput>
</body>

</html>