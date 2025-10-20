<cfinclude template = "../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Item No.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../ajax/core/engine.js'></script>
<script type='text/javascript' src='../ajax/core/util.js'></script>
<script type='text/javascript' src='../ajax/core/settings.js'></script>

<script type="text/javascript">
function checkValidate(){
	if(document.form.olditemno.value == ''){
		alert('Please Select An Old Item No.');
		return false;
	}
	else{
		if(document.form.newitemno2.value == ''){
			alert('New Item No. Cannot Be Empty!');
			return false;
		}
		else if(document.form.olditemno.value == document.form.newitemno2.value){
			alert('Old Item No. Cannot Same With New Item No.!');
			return false;
		}
		else{
			return true;
		}
	}
}

function getDesp(itemno){
	DWREngine._execute(_maintenanceflocation, null, 'getItemDesp', escape(itemno), showDesp);
}
	
function showDesp(itemObject){	
	
	DWRUtil.setValue("newitemdesp", itemObject.ITEMDESP);	
}
</script>

</head>
<body>
<form name="form" action="act_changeitemno.cfm" method="post" target="_blank">
<H1>Change Item No.</H1>
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old Item No.</th>
		<td>
			<select name="olditemno" onchange="getDesp(this.value);">
          		<option value="">Choose a product</option>
          		<cfoutput query="getitem">
            	<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<!--- <tr>
		<th>New Item No.</th>
		<td>
			<select name="newitemno">
          		<option value="">Choose a product</option>
          		<cfoutput query="getitem">
            	<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
	</tr> --->
	<tr>
		<th>New Item No.</th>
		<td>
			<input type="text" name="newitemno2" value="">
		</td>
	</tr>
	<tr>
		<th>New Item Description</th>
		<td>
			<input type="text" name="newitemdesp" id="newitemdesp" value="" size="60">
		</td>
	</tr>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" name="submit" value="Submit" onClick="return checkValidate();">
		</td>
	</tr>
</table>
</form>
</body>
</html>