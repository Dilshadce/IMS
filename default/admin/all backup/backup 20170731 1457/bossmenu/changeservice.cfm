<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Service Code</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldservice.value == ''){
		alert('Please Select An Old Service Code');
		return false;
	}
	else{
		if(document.form.newservice.value == ''){
			alert('New Service Code Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldservice.value == document.form.newservice.value){
			alert('Old Service Code Cannot Same With New Service Code!');
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
<form name="form" action="act_changeservice.cfm" method="post">
<H1>Change Service Code</H1>
<cfquery name="getservice" datasource="#dts#">
	select servi, desp from icservi order by servi
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Service Code</th>
		<td>
			<select name="oldservice" onchange="dispDesp(this,'newservicedesp');">
          		<option value="">Choose a Service</option>
          		<cfoutput query="getservice">
            		<option value="#convertquote(servi)#" title="#desp#">#servi# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New Service Code</th>
		<td>
			<input type="text" name="newservice" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newservicedesp" id="newservicedesp" value="" size="60">
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