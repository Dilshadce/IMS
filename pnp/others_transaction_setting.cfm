<html>
<head>
<title>Others Transaction Setting Profile</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfif isdefined("form.save")>
	<cfparam name="form.default_tax_included" default="" type="any">
	
	<cfupdate datasource="#dts#" tablename="others_transaction_setting" formfields="company_id,default_qty,default_tax_included">

	<script language="javascript" type="text/javascript">
		alert("Process Done !");
	</script>
</cfif>

<cfquery name="get_others_transaction_setting" datasource="#dts#">
	select 
	* 
	from others_transaction_setting;
</cfquery>

<body>
<h1 align="center">Others Transaction Setting Profile</h1>
<cfform>
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
		<tr>
			<th>Default Quantity</th>
			<th>Default Tax Included</th>
		</tr>
		<cfinput type="hidden" name="company_id" value="#get_others_transaction_setting.company_id#">
		<tr>
			<td align="center">
				<cfinput type="text" name="default_qty" value="#get_others_transaction_setting.default_qty#" validate="integer" message="Please Enter A Value" required="yes">
			</td>
			<td align="center">
				<input type="checkbox" name="default_tax_included" value="Y" <cfoutput>#iif(get_others_transaction_setting.default_tax_included eq "Y",DE("checked"),DE(""))#</cfoutput>>
			</td>
		</tr>
		<tr align="center">
			<td colspan="5">
				<input name="Save" type="submit" value="Save">
				<input name="Reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>

</body>
</html>