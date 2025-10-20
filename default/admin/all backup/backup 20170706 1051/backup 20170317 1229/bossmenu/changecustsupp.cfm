<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change <cfoutput>#custtype#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<script type="text/javascript">	
function checkValidate(){
	if(document.form.oldcustno.value == ''){
		alert('Please Select An Old <cfoutput>#custtype#</cfoutput> No.');
		return false;
	}
	else{
		if(document.form.newcustno.value == ''){
			alert('New <cfoutput>#custtype#</cfoutput> No. Cannot Be Empty!');
			return false;
		}
		else if(document.form.oldcustno.value == document.form.newcustno.value){
			alert('Old Category Cannot Same With New <cfoutput>#custtype#</cfoutput> No.!');
			return false;
		}
		else if(document.form.newcustno.value.length != 8){
			alert('The <cfoutput>#custtype#</cfoutput> No Length Is Invalid.!');
			return false;
		}
		else{
			return true;
		}
	}
}

function dispDesp(custno){
	var ctype=document.form.ctype.value;
	DWREngine._execute(_maintenanceflocation, null, 'getCustSuppDesp', custno,ctype, showDesp);
}

function showDesp(CustSuppObject){	
	DWRUtil.setValue("newname", CustSuppObject.CUSTNAME);
	DWRUtil.setValue("newname2", CustSuppObject.CUSTNAME2);
}
</script>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>


</head>
<cfif url.custtype eq "Customer">
	<cfset ptype=target_arcust>
<cfelse>
	<cfset ptype=target_apvend>
</cfif>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<cfform name="form" action="act_changecustsupp.cfm" method="post">
<cfoutput><input type="hidden" name="ctype" value="#url.custtype#"></cfoutput>
<H1>Change <cfoutput>#custtype#</cfoutput></H1>
<cfquery name="getcustsupp" datasource="#dts#">
	select custno, concat(name,' ',name2) as custname from #ptype# order by custno
</cfquery>
<table align="center" width="60%" class="data">
	<tr>
		<th>Old <cfoutput>#custtype#</cfoutput> No.</th>
		<td>
			<select name="oldcustno" onChange="dispDesp(this.value);">
          		<option value="">Choose a <cfoutput>#custtype#</cfoutput></option>
          		<cfoutput query="getcustsupp">
            		<option value="#custno#">#custno# - #custname#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th>New <cfoutput>#custtype#</cfoutput> No.</th>
		<td>
        	<cfif getgsetup.custSuppNo eq '1'>
            <cfinput type="text" name="newcustno" mask="XXXX/XXX" value="">
            <cfelse>
			<cfinput type="text" name="newcustno" maxlength="8" value="">
            </cfif>
		</td>
	</tr>
	<tr>
		<th rowspan="2">Name</th>
		<td>
			<input type="text" name="newname" id="newname" value="" size="60" disabled>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" name="newname2" id="newname2" value="" size="60" disabled>
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
</cfform>
</body>
</html>