<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Project</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldentryno.value == ''){
		alert('Please Select A Vehicle Entry No.');
		return false;
	}
	else{
		if(document.form.newentryno.value == ''){
			alert('Vehicle Entry No. Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldentryno.value == document.form.newentryno.value){
			alert('Old Vehicle Entry No. Cannot Same With Vehicle Entry No.!');
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
<form name="form" action="act_changevehicle.cfm" method="post">
<H1>Change Vehicles</H1>
<cfquery name="getvehicle" datasource="#dts#">
	select entryno, custname from vehicles order by entryno
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Vehicle Entry No</th>
		<td>
			<select name="oldentryno">
          		<option value="">Choose a Vehicle</option>
          		<cfoutput query="getvehicle">
            	<option value="#convertquote(entryno)#">#entryno# - #custname#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<!--- <tr>
		<th>New Item No.</th>
		<td>
			<select name="newproject">
          		<option value="">Choose a product</option>
          		<cfoutput query="getproject">
            	<option value="#convertquote(source)#">#source# - #project#</option>
          		</cfoutput>
			</select>
		</td>
	</tr> --->
	<tr>
		<th>New Vehicle Entry No</th>
		<td>
			<input type="text" name="newentryno" value="">
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