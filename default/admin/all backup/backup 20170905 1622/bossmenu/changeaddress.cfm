<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Address</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldAddress.value == ''){
		alert('Please Select An Old Address');
		return false;
	}
	else{
		if(document.form.newAddress.value == ''){
			alert('New Address Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldAddress.value == document.form.newAddress.value){
			alert('Old Address Cannot Same With New Address!');
			return false;
		}
		else{
			return true;
		}
	}
}

function dispname(obj,type){
	document.getElementById(type).value=obj.options[obj.selectedIndex].title;
}
</script>

</head>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<form name="form" action="act_changeAddress.cfm" method="post">
<H1>Change Address</H1>
<cfquery name="getAddress" datasource="#dts#">
	select code, name from address order by code
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Address</th>
		<td>
			<select name="oldAddress" onChange="dispname(this,'newAddressname');">
          		<option value="">Choose a Address</option>
          		<cfoutput query="getAddress">
            		<option value="#convertquote(code)#" title="#name#">#code# - #name#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New Address</th>
		<td>
			<input type="text" name="newAddress" value="" maxlength="8">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newAddressname" id="newAddressname" value="" size="60">
		</td>
	</tr>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" name="submit" value="Submit" onClick="return checkValidate();">
			<input type="button" name="back" value="Back" onClick="window.open('bossmenu.cfm','_self')">
		</td>
	</tr>
</table>
</form>
</body>
</html>