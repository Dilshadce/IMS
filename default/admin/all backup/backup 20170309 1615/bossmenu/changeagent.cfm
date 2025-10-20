<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Agent</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldagent.value == ''){
		alert('Please Select An Old Agent');
		return false;
	}
	else{
		if(document.form.newagent.value == ''){
			alert('New Agent Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldagent.value == document.form.newagent.value){
			alert('Old Agent Cannot Same With New Agent!');
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
<form name="form" action="act_changeagent.cfm" method="post">
<H1>Change Agent</H1>
<cfquery name="getagent" datasource="#dts#">
	select agent, desp from icagent order by agent
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Agent</th>
		<td>
			<select name="oldagent" onchange="dispDesp(this,'newagentdesp');">
          		<option value="">Choose a agent</option>
          		<cfoutput query="getagent">
            		<option value="#convertquote(agent)#" title="#desp#">#agent# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New Agent</th>
		<td>
			<input type="text" name="newagent" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newagentdesp" id="newagentdesp" value="" size="60">
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