<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change team</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldteam.value == ''){
		alert('Please Select An Old team');
		return false;
	}
	else{
		if(document.form.newteam.value == ''){
			alert('New team Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldteam.value == document.form.newteam.value){
			alert('Old team Cannot Same With New team!');
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
<form name="form" action="act_changeteam.cfm" method="post">
<H1>Change team</H1>
<cfquery name="getteam" datasource="#dts#">
	select team, desp from icteam order by team
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old team</th>
		<td>
			<select name="oldteam" onChange="dispDesp(this,'newteamdesp');">
          		<option value="">Choose a team</option>
          		<cfoutput query="getteam">
            		<option value="#convertquote(team)#" title="#desp#">#team# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New team</th>
		<td>
			<input type="text" name="newteam" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newteamdesp" id="newteamdesp" value="" size="60">
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