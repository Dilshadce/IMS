<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldbrand.value == ''){
		alert('Please Select A Brand Name');
		return false;
	}
	else{
		if(document.form.newbrand2.value == ''){
			alert('Brand Name Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldbrand.value == document.form.newbrand2.value){
			alert('Old Brand Name Cannot Same With New Brand Name!');
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
<form name="form" action="act_changebrand.cfm" method="post">
<H1>Change Brand Name</H1>
<cfquery name="getbrand" datasource="#dts#">
	select brand, desp from brand order by brand
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Brand Name</th>
		<td>
			<select name="oldbrand" onChange="dispDesp(this,'newitemdesp');">
          		<option value="">Choose a product</option>
          		<cfoutput query="getbrand">
            	<option value="#convertquote(brand)#" title="#convertquote(desp)#">#brand# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<!--- <tr>
		<th>New Item No.</th>
		<td>
			<select name="newbrand">
          		<option value="">Choose a product</option>
          		<cfoutput query="getbrand">
            	<option value="#convertquote(brand)#">#brand# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr> --->
	<tr>
		<th>New Brand Name</th>
		<td>
			<input type="text" name="newbrand2" value="">
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