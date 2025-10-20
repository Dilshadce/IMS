<html>
<head>
<title>EXPORT TO CSV FILE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script type="text/javascript">
// begin: customer search
function getSuppCust(type,option){
	if(type == 'custfrom'){
		var inputtext = document.form.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppCustResult);		
	}
	else{
		var inputtext = document.form.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppCustResult2);
	}
}

function getSuppCustResult(suppcustArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", suppcustArray,"KEY", "VALUE");
}

function getSuppCustResult2(suppcustArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", suppcustArray,"KEY", "VALUE");
}
// end: customer search
</script>

</head>

<cfif type eq "arcust">
	<cfset title = "Copy Customer File to ARCUST.CSV">	
	<cfset ptype = target_arcust>
	<cfset ptype1 = "Customer">
<cfelseif type eq "apvend">
	<cfset title = "Copy Supplier File to APVEND.CSV">	
	<cfset ptype = target_apvend>
	<cfset ptype1 = "Supplier">
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>

<cfquery name="getcustsupp" datasource="#dts#">
   	select custno as xcustno,name from #ptype# order by custno
</cfquery>

<body>
<cfoutput>
<h2>#title#</h2>
<form name="form" action="export_to_csv_process.cfm?type=#type#" method="post">
<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">	
	<tr> 
    	<th>#ptype1# From</th>
        <td><select name="custfrom">
				<option value="">Choose a #ptype1#</option>
				<cfloop query="getcustsupp">
				<option value="#xcustno#">#xcustno# - #name#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchsuppfr" onkeyup="getSuppCust('custfrom','#ptype1#');">
			</cfif>
		</td>
    </tr>
    <tr> 
        <th>#ptype1# To</th>
        <td><select name="custto">
				<option value="">Choose a #ptype1#</option>
				<cfloop query="getcustsupp">
				<option value="#xcustno#">#xcustno# - #name#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchsuppto" onkeyup="getSuppCust('custto','#ptype1#');">
			</cfif>
		</td>
	</tr>    
	<tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>      
</table>
</form>
</cfoutput>
</body>
</html>