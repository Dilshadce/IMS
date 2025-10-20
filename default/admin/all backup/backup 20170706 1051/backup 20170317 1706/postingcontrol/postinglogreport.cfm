<html>
<head>
<title>Posting Log</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/scripts/date_format.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

</head>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>
<script type="text/javascript">

</script>

<body>
<cfoutput>
	<h1>Print Posting Log Report</h1>
    <cfoutput>
<h3 align="center">
<a href="armcancel.cfm">Cancel Import Arm</a>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postinglog.cfm">Posting Log</a>||&nbsp;&nbsp;&nbsp;<a href="postinglogreport.cfm">Posting Log Report</a><cfif hlinkams eq "Y">&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postingcheck.cfm">Check Inexistence at AMS</a></cfif>
</h3>
</cfoutput>
	<form name="form" action="postinglogreport1.cfm" method="post" target="_blank">
	<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
		<tr>
			<th>Refno</th>
	      	<td>
				<input name="refnofrom" type="text" value="" size="30">
			</td>
		</tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
		<tr align="center">
			<td colspan="100%">
				<input name="Submit" type="submit" value="Submit">&nbsp;&nbsp;
				<input name="Reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
	</form>
</cfoutput>
</body>
</html>