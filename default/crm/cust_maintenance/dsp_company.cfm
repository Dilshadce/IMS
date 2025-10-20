<html>
<head>
</head>

<body>

<cfquery datasource="net_crm" name="getcompany">
    SELECT * FROM company
    <cfif comid neq "">
        WHERE comid = '#comid#'
    </cfif>
</cfquery>
<cfset thiscustid = getcompany.custid>

<cfquery name="getcust" datasource="net_crm">
	SELECT custid,custno,custname FROM customer 
	where custname != ''
	order by custno
</cfquery>

<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td>
            Customer
		</td>
		<td>
			:
		</td>
		<td>
			<select name="custid">
				<option value="">Select a Customer</option>
				<cfloop query="getcust"><option value="#getcust.custid#" <cfif getcust.custid eq thiscustid>selected</cfif>>#getcust.custno# - #getcust.custname#</option></cfloop>
        	</select>
		</td>
	</tr>
    <tr>
		<td>
            Company ID
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="comid" size="50" value="#getcompany.comid#">
		</td>
	</tr>
	<tr>
		<td>
            Company Name
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="comname" size="50" value="#getcompany.comname#">
		</td>
	</tr>
	<tr>
		<td>
			Attn
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="attn" size="50" value="#getcompany.attn#">
		</td>
	</tr>
	<tr>
		<td>
			Contact No
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="contactNo" size="50" value="#getcompany.contactNo#">
		</td>
	</tr>
    <tr>
		<td>
			Support Staff
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="supportStaff" size="50" value="#getcompany.supportStaff#">
		</td>
	</tr>
    <tr>
		<td>
			Programmer
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="programmer" size="50" value="#getcompany.programmer#">
		</td>
	</tr>
    <tr>
		<td>
			Active Status
		</td>
		<td>
			:
		</td>
		<td>
			<select name="status">
				<option value="Yes" <cfif getcompany.status eq "Yes">selected</cfif>>Yes</option>
				<option value="No" <cfif getcompany.status eq "No">selected</cfif>>No</option>
        	</select>
		</td>
	</tr>
    <tr><td colspan="3" height="5"></td></tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td>
			<input type="submit" value="Submit">
			<input type="button" value="Cancel" onClick="window.location.href='company.cfm';">
		</td>
	</tr>
</table>
</cfoutput>
<cfsetting showdebugoutput="no">

</body>
</html>
