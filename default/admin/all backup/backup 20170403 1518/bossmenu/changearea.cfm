<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Area</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldarea.value == ''){
		alert('Please Select An Old area');
		return false;
	}
	else{
		if(document.form.newarea.value == ''){
			alert('New area Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldarea.value == document.form.newarea.value){
			alert('Old area Cannot Same With New area!');
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
<form name="form" action="act_changearea.cfm" method="post">
<H1>Change area</H1>
<cfquery name="getarea" datasource="#dts#">
	select area, desp from icarea order by area
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old area</th>
		<td>
			<select name="oldarea" onChange="dispDesp(this,'newareadesp');">
          		<option value="">Choose a area</option>
          		<cfoutput query="getarea">
            		<option value="#convertquote(area)#" title="#desp#">#area# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New area</th>
		<td>
			<input type="text" name="newarea" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newareadesp" id="newareadesp" value="" size="60">
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