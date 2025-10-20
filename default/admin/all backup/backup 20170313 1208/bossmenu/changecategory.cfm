<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Category</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldcategory.value == ''){
		alert('Please Select An Old Category');
		return false;
	}
	else{
		if(document.form.newcategory.value == ''){
			alert('New Category Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldcategory.value == document.form.newcategory.value){
			alert('Old Category Cannot Same With New Category!');
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
<form name="form" action="act_changecategory.cfm" method="post">
<H1>Change Category</H1>
<cfquery name="getcategory" datasource="#dts#">
	select cate, desp from iccate order by cate
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Category</th>
		<td>
			<select name="oldcategory" onchange="dispDesp(this,'newcategorydesp');">
          		<option value="">Choose a Category</option>
          		<cfoutput query="getcategory">
            		<option value="#convertquote(cate)#" title="#desp#">#cate# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New Category</th>
		<td>
			<input type="text" name="newcategory" value="">
		</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>
			<input type="text" name="newcategorydesp" id="newcategorydesp" value="" size="60">
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