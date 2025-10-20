<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Material</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldcolorid.value == ''){
		alert('Please Select An Old colorid');
		return false;
	}
	else{
		if(document.form.newcolorid.value == ''){
			alert('New colorid Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldcolorid.value == document.form.newcolorid.value){
			alert('Old colorid Cannot Same With New colorid!');
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
<form name="form" action="act_changecolorid.cfm" method="post">
<H1>Change Material</H1>
<cfquery name="getcolorid" datasource="#dts#">
	select colorid, desp from iccolorid order by colorid
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Material</th>
		<td>
			<select name="oldcolorid" onChange="dispDesp(this,'newcoloriddesp');">
          		<option value="">Choose a Material</option>
          		<cfoutput query="getcolorid">
            		<option value="#convertquote(colorid)#" title="#desp#">#colorid# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New Material</th>
		<td>
			<input type="text" name="newcolorid" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newcoloriddesp" id="newcoloriddesp" value="" size="60">
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