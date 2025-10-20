<html>
<head>
</head>

<body>

<cfquery datasource="net_crm" name="getcust">
    SELECT * FROM customer
    <cfif custid neq "">
        WHERE custid = '#custid#'
    </cfif>
</cfquery>

<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<input type="hidden" name="custid" value="#custid#">
	<tr>
		<td>
			Customer No
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="custno" size="50" value="#getcust.custno#" maxlength="12">
		</td>
	</tr>
	<tr>
		<td>
			Customer Name
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="custname" size="50" value="#getcust.custname#">
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
			<textarea cols="50" rows="5" wrap="hard" name="desp">#getcust.desp#</textarea>
		</td>
	</tr>
	<tr>
		<td>
			Comment
		</td>
		<td>
			:
		</td>
		<td>
			<textarea cols="50" rows="5" wrap="hard" name="comment">#getcust.comment#</textarea>
		</td>
	</tr>
	<tr>
		<td>&nbsp;
			
		</td>
		<td>&nbsp;
			
		</td>
		<td>
			<input type="submit" value="Save">
			<input type="button" value="Cancel" onClick="window.location.href='customer.cfm';">
		</td>
	</tr>
</table>
</cfoutput>
<cfsetting showdebugoutput="no">

</body>
</html>
