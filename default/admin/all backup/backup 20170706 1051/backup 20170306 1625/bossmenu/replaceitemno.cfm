<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Item No.</title>
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

function dispDesp(obj,type){
	document.getElementById(type).value=obj.options[obj.selectedIndex].title;
}


function selectlist(custno,fieldtype){

			document.getElementById(fieldtype).value=unescape(custno);
}
									
// begin: product search
function getProduct(type){
	if(type == 'olditemno'){
		var inputtext = document.form.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("olditemno");
	DWRUtil.addOptions("olditemno", itemArray,"KEY", "VALUE");
}
// end: product search

function getitem2(){
ajaxFunction(document.getElementById('changeitemajax'),'changeitemnoajax.cfm?itemno='+document.getElementById('searchitemfr').value);

setTimeout("dispDesp(document.getElementById('olditemno'),'newitemdesp');",500)	
	
}

</script>

</head>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<cfform name="form" action="act_replaceitemno.cfm" method="post">
<H1>Replace Item No.</H1>
<!---
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery>
--->
<table align="center" width="60%" class="data">
	<tr><input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />
		<th>Existing Item No.</th>
		<td>

			<cfinput type="text" name="olditemno" id="olditemno" required="yes" message="Existing Item No is Required" readonly>

                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='olditemno';ColdFusion.Window.show('finditem');" />
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
			<cfinput type="text" name="newitemno2" id="newitemno2" onChange="dispDesp(this,'newitemdesp');" required="yes" message="New Item No is Required" readonly>
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='newitemno2';ColdFusion.Window.show('finditem');" />
		</td>
	</tr>
	
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" name="submit" value="Submit" >
			<input type="button" name="back" value="Back" onClick="window.open('bossmenu.cfm','_self')">
		</td>
	</tr>
</table>
</cfform>

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        <cfwindow center="true" width="1000" height="500" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=&fromto={fromto}" />
</body>
</html>