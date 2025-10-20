<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Unvoid Transaction</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='/scripts/ajax.js'></script>

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldrefno.value == ''){
		alert('Please Select A Reference No.');
		return false;
	}
	else{
			return true;
		}
	}
</script>

</head>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<cfform name="form" action="act_recovervoid.cfm" method="post">
<H1>Unvoid Transaction</H1>

<cfquery name="getrefnotype" datasource="#dts#">
	select type as refnotype 
	from artran where void='Y'
	group by type 
</cfquery>

<cfquery name="getrefno" datasource="#dts#">
	select refno from artran
	where type ='INV' and void='Y'
    group by refno
	order by refno
</cfquery>
<cfset refnoname = "">
<table align="center" width="60%" class="data">

<tr>
		<th>Type Of Transaction</th>
		<td>
			<select name="reftype" onChange="ajaxFunction(document.getElementById('ajaxField'),'getvoidrefno.cfm?reftype='+this.value);">
            <option value="">Please Select a Transaction Type</option>
          		<cfoutput query="getrefnotype">
					<cfif trim(getrefnotype.refnotype) eq "INV">
						<cfset refnoname = "Invoice">
					<cfelseif trim(getrefnotype.refnotype) eq "RC">
						<cfset refnoname = "Purchase Receive">
					<cfelseif trim(getrefnotype.refnotype) eq "PR">
						<cfset refnoname = "Purchase Return">
					<cfelseif trim(getrefnotype.refnotype) eq "DO">
						<cfset refnoname = "Delivery Order">
					<cfelseif trim(getrefnotype.refnotype) eq "CS">
						<cfset refnoname = "Cash Sales">
					<cfelseif trim(getrefnotype.refnotype) eq "CN">
						<cfset refnoname = "Credit Note">
					<cfelseif trim(getrefnotype.refnotype) eq "DN">
						<cfset refnoname = "Debit Note">
					<cfelseif trim(getrefnotype.refnotype) eq "ISS">
						<cfset refnoname = "Issue">
					<cfelseif trim(getrefnotype.refnotype) eq "PO">
						<cfset refnoname = "Purchase Order">
					<cfelseif trim(getrefnotype.refnotype) eq "SO">
						<cfset refnoname = "Sales Order">
					<cfelseif trim(getrefnotype.refnotype) eq "QUO">
						<cfset refnoname = "Quotation">
					<cfelseif trim(getrefnotype.refnotype) eq "ASSM">
						<cfset refnoname = "Assembly">
					<cfelseif trim(getrefnotype.refnotype) eq "TR">
						<cfset refnoname = "Transfer">
					<cfelseif trim(getrefnotype.refnotype) eq "OAI">
						<cfset refnoname = "Adjustment Increase">
					<cfelseif trim(getrefnotype.refnotype) eq "OAR">
						<cfset refnoname = "Adjustment Reduce">
					<cfelseif trim(getrefnotype.refnotype) eq "SAM">
						<cfset refnoname = "Sample">
					<cfelseif trim(getrefnotype.refnotype) eq "CT">
						<cfset refnoname = "Consignment Note">
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
	            		<option value="#refno#">#refno#</option>
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