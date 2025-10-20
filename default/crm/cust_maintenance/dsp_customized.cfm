<html>
<head>
</head>

<body>

<cfquery datasource="net_crm" name="getinfo">
    SELECT * FROM customized_function
    WHERE cfid = '#cfid#'
</cfquery>

<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<input type="hidden" name="cfid" value="#cfid#">
	<tr>
		<td>
			Company ID
		</td>
		<td>
			:
		</td>
		<td>
			<cfoutput><input type="text" name="comid" size="50" value="#getinfo.comid#" readonly></cfoutput>
		</td>
	</tr>
	<tr>
		<td>
			Customized Function
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="function" size="50" value="#getinfo.function#">
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			:
		</td>
		<td>
			<textarea cols="50" rows="5" wrap="hard" name="desp">#getinfo.desp#</textarea>
		</td>
	</tr>
	<tr>
		<td>&nbsp;
			
		</td>
		<td>&nbsp;
			
		</td>
		<td>
			<input type="submit" value="Submit">
			<input type="button" value="Cancel" onClick="window.location.href='customized_function.cfm?comid=#getinfo.comid#';">
		</td>
	</tr>
</table>
</cfoutput>
<cfsetting showdebugoutput="no">

</body>
</html>
