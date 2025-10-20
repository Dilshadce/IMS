<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Maintain Holiday</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<cfset date = #dateFormat(Now(), "dd/mm/yyyy")#>

<cfquery name="hol_qry" datasource="#dts#">
SELECT * FROM holtable
</cfquery>

<body>

<div class="tabber">
<table>
	<tr><td colspan="3" align="center"><h1>Holiday Listing</h1></tr>
	<tr><td colspan="3" align="right"><cfoutput>#date#</cfoutput></tr>
	<tr>
		<th width="80px">No.</th>
		<th width="180px">Date</th>
		<th width="400px">Description</th>
	</tr>
	
	<cfset i=1>
	<cfoutput query="hol_qry">
	<tr>
		<td>#i#</td>
		<td>#lsdateformat(hol_qry.hol_date,"dd/mm/yyyy")#</td>
		<td>#hol_qry.hol_desp#</td>
	</tr>
	<cfset i=i+1>
	</cfoutput>
	
	<tr><td colspan="3" align="center">-END-</td></tr>
</table>
</div>

</body>
</html>