<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Project</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldproject.value == ''){
		alert('Please Select A Project Name');
		return false;
	}
	else{
		if(document.form.newproject2.value == ''){
			alert('Project Name Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldproject.value == document.form.newproject2.value){
			alert('Old Project Name Cannot Same With New Project Name!');
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
<form name="form" action="act_changeproject.cfm" method="post">
<H1>Change Project Name</H1>
<cfquery name="getproject" datasource="#dts#">
	select source, Project from project where porj = "P" order by source 
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Project Name</th>
		<td>
			<select name="oldproject" onChange="dispDesp(this,'newitemdesp');">
          		<option value="">Choose a Project</option>
          		<cfoutput query="getproject">
            	<option value="#convertquote(source)#" title="#convertquote(project)#">#source# - #project#</option>
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
		<th>New Project Name</th>
		<td>
			<input type="text" name="newproject2" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newitemdesp" id="newitemdesp" value="" size="60">
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