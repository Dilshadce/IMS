<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldjob.value == ''){
		alert('Please Select A Job Code');
		return false;
	}
	else{
		if(document.form.newjob2.value == ''){
			alert('Job Code Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldjob.value == document.form.newjob2.value){
			alert('Old Job Code Cannot Same With New Job Code!');
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
<form name="form" action="act_changejob.cfm" method="post">
<H1>Change Job Code</H1>
<cfquery name="getjob" datasource="#dts#">
	select source, project from project where porj ="J" order by source 
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Job Code</th>
		<td>
			<select name="oldjob" onChange="dispDesp(this,'newitemdesp');">
          		<option value="">Choose a Job Code</option>
          		<cfoutput query="getjob">
            	<option value="#convertquote(source)#" title="#convertquote(project)#">#source# - #project#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<!--- <tr>
		<th>New Item No.</th>
		<td>
			<select name="newjob">
          		<option value="">Choose a product</option>
          		<cfoutput query="getjob">
            	<option value="#convertquote(source)#">#source# - #project#</option>
          		</cfoutput>
			</select>
		</td>
	</tr> --->
	<tr>
		<th>New Job Code</th>
		<td>
			<input type="text" name="newjob2" value="">
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