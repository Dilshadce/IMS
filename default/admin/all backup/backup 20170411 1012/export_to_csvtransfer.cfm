<html>
<head>
<title>EXPORT TO DBF FILE</title>
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

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>

<cfquery name="gettran" datasource="#dts#">
   	select * from artran where type='TR'
</cfquery>

<body>
<cfoutput>
<h2>EXPORT TO DBF FILE</h2>
<form name="form" action="export_to_csvtransfer_process.cfm" method="post">
<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">	
	<tr> 
    	<th>Transfer From</th>
        <td><select name="refnofrom">
				<option value="">Choose a Transfer</option>
				<cfloop query="gettran">
				<option value="#refno#">#refno#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr> 
        <th>Transfer To</th>
        <td><select name="refnoto">
				<option value="">Choose a Transfer</option>
				<cfloop query="gettran">
				<option value="#refno#">#refno# </option>
				</cfloop>
			</select>
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