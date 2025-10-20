<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Products Profile - Print Barcode</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
	
<script type="text/javascript">

function validate(){
	if(document.getElementById('colorid').value=='' || document.getElementById('supp').value=='')
	{
		alert('Please Choose Supplier/Album')
	}
	else
	{
	if(confirm('Are you confirm about updating Item Supplier?') ==true){
		itemform.submit();
	}
	}
	
}
</script>
</head>

<cfif isdefined('form.colorid')>
<cfquery name="updateicitem" datasource="#dts#">
	update icitem set supp='#form.supp#' where colorid='#form.colorid#'
</cfquery>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getcolorid" datasource="#dts#">
	select * from iccolorid order by colorid
</cfquery>

<cfquery name="getsupplier" datasource="#dts#">
	select * from #target_apvend# order by custno
</cfquery>

<body>
<cfquery datasource="#dts#" name="getsettingrecord">
		select * from print_barcode_setting where id="1"
</cfquery>


<h1 align="center">Update Supplier According to <cfoutput>#getgeneral.lmaterial#</cfoutput></h1>

<cfoutput>
	<h4>
		<cfif getpin2.h1310 eq 'T'><a href="icitem2.cfm?type=Create">Creating a New Item</a> </cfif>
		<cfif getpin2.h1320 eq 'T'>|| <a href="icitem.cfm?">List all Item</a> </cfif>
		<cfif getpin2.h1330 eq 'T'>|| <a href="s_icitem.cfm?type=icitem">Search For Item</a> </cfif>
		<cfif getpin2.h1340 eq 'T'>|| <a href="p_icitem.cfm">Item Listing</a> </cfif>
		|| <a href="icitem_setting.cfm">More Setting</a>
		<cfif getpin2.h1350 eq 'T'>|| <a href="printbarcode_filter.cfm">Print Barcode</a></cfif>
        <cfif getpin2.h1311 eq 'T' and getpin2.h13D0 eq 'T'>
		||<a href="edititemexpress.cfm">Edit Item Express</a> 
	</cfif>
    <cfif lcase(HcomID) eq "tcds_i">
    ||<a href="tcdsupdatesupplier.cfm">Update Supplier According To Label</a>
    </cfif>
	</h4>
</cfoutput>
<cfif isdefined('form.colorid')>
<cfoutput>
<h3>All #form.colorid# Items's Supplier has been changed to #form.supp#</h3>
</cfoutput>
</cfif>

<cfform name="itemform" action="tcdsupdatesupplier.cfm" method="post">

<table width="75%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr> 
    	<cfoutput><th>#getgeneral.lmaterial#</th></cfoutput>
        <td><cfselect name="colorid" id="colorid">
				<option value="">Choose an <cfoutput>#getgeneral.lmaterial#</cfoutput></option>
				<cfoutput query="getcolorid">
					<option value="#colorid#">#colorid# - #desp#</option>
				</cfoutput>
			</cfselect>
		</td>
    </tr>
    <tr> 
        <cfoutput><th>Supplier</th></cfoutput>
        <td><cfselect name="supp" id="supp">
				<option value="">Choose an Supplier</option>
				<cfoutput query="getsupplier">
					<option value="#getsupplier.custno#">#custno# - #name#</option>
				</cfoutput>
			</cfselect>
		</td>
    </tr>

    <tr>
      	<td align="right" colspan="3"><input type="Button" name="Submit" value="Submit" onClick="validate();"></td>
    </tr>
</table>

</cfform>
</body>
</html>