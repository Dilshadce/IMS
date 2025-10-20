<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='/scripts/ajax.js'></script>

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldrefno.value == ''){
		alert('Please Select A Old Reference No.');
		return false;
	}
	else{
			return true;
		}
	}
}
</script>

</head>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<cfform name="form" action="recovertransaction1.cfm" method="post">
<H1>Recover Transaction</H1>

<cfquery name="getrefnotype" datasource="#dts#">
	select frtype as refnotype 
	from iclink
	group by frtype 
</cfquery>

<cfquery name="getrefno" datasource="#dts#">
	select frrefno from iclink
	where frtype ='INV'
    group by frrefno
	order by frrefno
</cfquery>
<table align="center" width="60%" class="data">

<tr>
		<th>Type Of Transaction</th>
		<td>
			<select name="reftype" onChange="ajaxFunction(document.getElementById('ajaxField'),'getRefnofromiclink.cfm?reftype='+this.value);">
            <option value="">Please Select a Transaction Type</option>
          		<cfoutput query="getrefnotype">
					<cfif getrefnotype.refnotype eq "INV">
						<cfset refnoname = "Invoice">
					<cfelseif getrefnotype.refnotype eq "RC">
						<cfset refnoname = "Purchase Receive">
					<cfelseif getrefnotype.refnotype eq "PR">
						<cfset refnoname = "Purchase Return">
					<cfelseif getrefnotype.refnotype eq "DO">
						<cfset refnoname = "Delivery Order">
					<cfelseif getrefnotype.refnotype eq "CS">
						<cfset refnoname = "Cash Sales">
					<cfelseif getrefnotype.refnotype eq "CN">
						<cfset refnoname = "Credit Note">
					<cfelseif getrefnotype.refnotype eq "DN">
						<cfset refnoname = "Debit Note">
					<cfelseif getrefnotype.refnotype eq "ISS">
						<cfset refnoname = "Issue">
					<cfelseif getrefnotype.refnotype eq "PO">
						<cfset refnoname = "Purchase Order">
					<cfelseif getrefnotype.refnotype eq "SO">
						<cfset refnoname = "Sales Order">
					<cfelseif getrefnotype.refnotype eq "QUO">
						<cfset refnoname = "Quotation">
					<cfelseif getrefnotype.refnotype eq "ASSM">
						<cfset refnoname = "Assembly">
					<cfelseif getrefnotype.refnotype eq "TR">
						<cfset refnoname = "Transfer">
					<cfelseif getrefnotype.refnotype eq "OAI">
						<cfset refnoname = "Adjustment Increase">
					<cfelseif getrefnotype.refnotype eq "OAR">
						<cfset refnoname = "Adjustment Reduce">
					<cfelseif getrefnotype.refnotype eq "SAM">
						<cfset refnoname = "Sample">
					<cfelseif getrefnotype.refnotype eq "CT">
						<cfset refnoname = "Consignment Note">
                    <cfelse>
                    	<cfset refnoname = "Invoice">
					</cfif>
            		<option value="#refnotype#" <cfif getrefnotype.refnotype eq "INV">selected</cfif>>#refnoname#</option>
          		</cfoutput>
			</select>
		</td>
	</tr>

	<tr>
		<th>Transaction Number</th>
		<td>
			<div id="ajaxField" name="ajaxField">
	<select name="oldrefno">
					<option value="">Choose a Reference No.</option>
	          		<cfoutput query="getrefno">
	            		<option value="#frrefno#">#frrefno#</option>
	          		</cfoutput>
				</select>
			</div>
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