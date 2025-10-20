<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldenduser.value == ''){
		alert('Please Select A enduser Code');
		return false;
	}
	else{
		if(document.form.newenduser2.value == ''){
			alert('enduser Code Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldenduser.value == document.form.newenduser2.value){
			alert('Old enduser Code Cannot Same With New enduser Code!');
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
<form name="form" action="act_changeenduser.cfm" method="post">
<H1>Change End User No</H1>
<cfquery name="getenduser" datasource="#dts#">
	select * from driver  order by driverno
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old End User No</th>
		<td>
			<select name="oldenduser" onChange="dispDesp(this,'newitemdesp');">
          		<option value="">Choose a End User No</option>
          		<cfoutput query="getenduser">
            	<option value="#convertquote(driverno)#">#driverno# - #name#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>

	<tr>
		<th>New enduser Code</th>
		<td>
			<input type="text" name="newenduser2" value="">
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