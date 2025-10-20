<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldbusiness.value == ''){
		alert('Please Select A business Code');
		return false;
	}
	else{
		if(document.form.newbusiness2.value == ''){
			alert('business Code Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldbusiness.value == document.form.newbusiness2.value){
			alert('Old business Code Cannot Same With New business Code!');
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
<form name="form" action="act_changebusiness.cfm" method="post">
<H1>Change business No</H1>
<cfquery name="getbusiness" datasource="#dts#">
	select * from business  order by business
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Business No</th>
		<td>
			<select name="oldbusiness" onChange="dispDesp(this,'newitemdesp');">
          		<option value="">Choose a Business No</option>
          		<cfoutput query="getbusiness">
            	<option value="#convertquote(business)#">#business# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>

	<tr>
		<th>New business Code</th>
		<td>
			<input type="text" name="newbusiness2" value="">
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