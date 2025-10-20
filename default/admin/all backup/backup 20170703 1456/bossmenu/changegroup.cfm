<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Group</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldgroup.value == ''){
		alert('Please Select An Old Group');
		return false;
	}
	else{
		if(document.form.newgroup.value == ''){
			alert('New Group Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldgroup.value == document.form.newgroup.value){
			alert('Old Group Cannot Same With New Group!');
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
<form name="form" action="act_changegroup.cfm" method="post">
<H1>Change Group</H1>
<cfquery name="getgroup" datasource="#dts#">
	select wos_group, desp from icgroup order by wos_group
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Group</th>
		<td>
			<select name="oldgroup" onchange="dispDesp(this,'newgroupdesp');">
          		<option value="">Choose a Group</option>
          		<cfoutput query="getgroup">
            		<option value="#convertquote(wos_group)#" title="#desp#">#wos_group# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New Group</th>
		<td>
			<input type="text" name="newgroup" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newgroupdesp" id="newgroupdesp" value="" size="60">
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