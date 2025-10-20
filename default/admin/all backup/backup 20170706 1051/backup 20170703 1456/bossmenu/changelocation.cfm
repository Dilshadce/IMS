<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change location</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldlocation.value == ''){
		alert('Please Select An Old location');
		return false;
	}
	else{
		if(document.form.newlocation.value == ''){
			alert('New location Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldlocation.value == document.form.newlocation.value){
			alert('Old location Cannot Same With New location!');
			return false;
		}
		else{
			return true;
		}
	}
}

function dispDesp(obj,type){
	document.getElementById(type).value=obj.options[obj.selectedIndex].title;
}
</script>

</head>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<form name="form" action="act_changelocation.cfm" method="post">
<H1>Change Location</H1>
<cfquery name="getlocation" datasource="#dts#">
	select location, desp from iclocation order by location
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old location</th>
		<td>
			<select name="oldlocation" onChange="dispDesp(this,'newlocationdesp');">
          		<option value="">Choose a location</option>
          		<cfoutput query="getlocation">
            		<option value="#convertquote(location)#" title="#desp#">#location# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New location</th>
		<td>
			<input type="text" name="newlocation" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newlocationdesp" id="newlocationdesp" value="" size="60">
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