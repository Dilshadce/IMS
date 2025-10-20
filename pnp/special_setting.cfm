<html>
<head>
<title>Special Setting Profile</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfif isdefined("form.save")>
	<cfupdate datasource="#dts#" tablename="pnp_special_setting" formfields="company_id,rc_location,inv_custno">

	<script language="javascript" type="text/javascript">
		alert("Process Done !");
	</script>
</cfif>

<cfquery name="get_special_setting" datasource="#dts#">
	select 
	* 
	from pnp_special_setting;
</cfquery>

<cfquery name="get_location" datasource="#dts#">
	select 
	location,
	desp 
	from iclocation 
	order by location;
</cfquery>

<cfquery name="get_customer_code" datasource="#dts#">
	select 
	custno,
	name 
	from #target_arcust# 
	order by custno;
</cfquery>

<body>
<h1 align="center">Special Setting Profile</h1>
<cfform>
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
		<tr>
			<th>Default Receive Location</th>
			<th>Default Invoice Customer Code</th>
		</tr>
		<cfinput type="hidden" name="company_id" value="#get_special_setting.company_id#">
		<tr>
			<td align="center">
				<select name="rc_location">
					<option value="">-</option>
					<cfoutput query="get_location">
						<option value="#get_location.location#" #iif(get_special_setting.rc_location eq get_location.location,DE("selected"),DE(""))#>#get_location.location# - #get_location.desp#</option>
					</cfoutput>
				</select>
			</td>
			<td align="center">
				<select name="inv_custno">
					<option value="">-</option>
					<cfoutput query="get_customer_code">
						<option value="#get_customer_code.custno#" #iif(get_special_setting.inv_custno eq get_customer_code.custno,DE("selected"),DE(""))#>#get_customer_code.custno# - #get_customer_code.name#</option>
					</cfoutput>
				</select>
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