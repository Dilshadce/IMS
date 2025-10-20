<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Attention No.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lAGENT,agentlistuserid from gsetup
</cfquery>

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldattnno.value == ''){
		alert('Please Select An Old Attention No.');
		return false;
	}
	else{
		if(document.form.newattnno2.value == ''){
			alert('New Attention No. Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldattnno.value == document.form.newattnno2.value){
			alert('Old Attention No. Cannot Same With New Attention No.!');
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


function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
									
// begin: product search
function getProduct(type){
	if(type == 'oldattnno'){
		var inputtext = document.form.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("oldattnno");
	DWRUtil.addOptions("oldattnno", itemArray,"KEY", "VALUE");
}
// end: product search

</script>

</head>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<form name="form" action="act_changeattentionno.cfm" method="post">
<H1>Change Attention No.</H1>
<cfquery name="getattn" datasource="#dts#">
	select * from attention order by attentionno
</cfquery>
<table align="center" width="60%" class="data">
	<tr><input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />
		<th>Old Attention No</th>
		<td>
			<select name="oldattnno" onChange="dispDesp(this,'newattnno');">
          		<option value="">Choose a Attention</option>
          		<cfoutput query="getattn">
            	<option value="#convertquote(attentionno)#" title="#convertquote(name)#">#attentionno# - #name#</option>
          		</cfoutput>
			</select>
               <!--- <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemfr" onKeyUp="getProduct('olditemno');">--->
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
		<th>New Attention No.</th>
		<td>
			<input type="text" name="newattnno2" value="" maxlength="54">
		</td>
	</tr>
	<tr>
		<th>Name</th>
		<td>
			<input type="text" name="newattnno" id="newattnno" value="" size="60">
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

<!---<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        <cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Item&fromto={fromto}" />--->
</body>
</html>