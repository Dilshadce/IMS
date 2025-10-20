<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Products Profile - Print Barcode</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	
<script type="text/javascript">
// begin: product search
function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.itemform.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.itemform.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult2);
	}
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("itemto");
	DWRUtil.addOptions("itemto", itemArray,"KEY", "VALUE");
}

function getProductResult2(itemArray){
	DWRUtil.removeAllOptions("itemfrom");
	DWRUtil.addOptions("itemfrom", itemArray,"KEY", "VALUE");
}
// end: product search

// calculate the ASCII code of the given character
function CalcKeyCode(aChar) {
  var character = aChar.substring(0,1);
  var code = aChar.charCodeAt(0);
  return code;
}

function selectlist(itemno,fieldname) {
  document.getElementById(fieldname).value=itemno;
}

function checkNumber(val) {
  var strPass = val.value;
  var strLength = strPass.length;
  var lchar = val.value.charAt((strLength) - 1);
  var cCode = CalcKeyCode(lchar);

  /* Check if the keyed in character is a number
     do you want alphabetic UPPERCASE only ?
     or lower case only just check their respective
     codes and replace the 48 and 57 */

  if (cCode < 48 || cCode > 57 ) {
    var myNumber = val.value.substring(0, (strLength) - 1);
    val.value = myNumber;
  }
  return false;
}
</script>
</head>
<cfquery name="getgeneral" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>
<cfquery name="getdealer_menu" datasource="#dts#">
	SELECT custSuppSortBy,productSortBy 
    FROM dealer_menu 
    LIMIT 1;
</cfquery>
<cfquery name="getitem" datasource="#dts#">
	SELECT itemno, desp,despa 
    FROM icitem 
    ORDER BY <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfquery name="getrcno" datasource="#dts#">
	SELECT refno,name 
    FROM artran 
    WHERE type='RC' 
    ORDER BY refno;
</cfquery>

<body>
<cfquery datasource="#dts#" name="getsettingrecord">
	SELECT * 
    FROM print_barcode_setting 
    WHERE id="1";
</cfquery>

<cfset noofcopy = getsettingrecord.no_copies>
<cfset hdwide = getsettingrecord.wide_version>
<cfset barcode = getsettingrecord.bar_code>
<cfset format2 = getsettingrecord.format_2>
<cfset format3 = getsettingrecord.format_3>
<cfset format4 = getsettingrecord.format_4>
<cfset format5 = getsettingrecord.format_5>
<cfset format6 = getsettingrecord.format_6>
<cfset format7 = getsettingrecord.format_7>
<cfset spacing = getsettingrecord.spacing>
<cfset topspacing = getsettingrecord.top_spacing>
<cfset leftspacing = getsettingrecord.left_spacing>
<cfset fontsize = getsettingrecord.font_size>  
<cfset barcodewidth = getsettingrecord.barcodewidth>  


<h1 align="center">Print Barcode</h1>
<cfoutput>
	<h4>
		<cfif getpin2.h1310 eq 'T'><cfif lcase(hcomid) eq 'tcds_i'>
    	<a href="tcdsicitem2.cfm?type=Create">Creating a New Item</a> 
    <cfelse>
		<a href="icitem2.cfm?type=Create">Creating a New Item</a> 
    </cfif> </cfif>
		<cfif getpin2.h1320 eq 'T'>|| <a href="icitem.cfm?">List all Item</a> </cfif>
		<cfif getpin2.h1330 eq 'T'>|| <a href="s_icitem.cfm?type=icitem">Search For Item</a> </cfif>
		<cfif getpin2.h1340 eq 'T'>|| <a href="p_icitem.cfm">Item Listing</a> </cfif>
		|| <a href="icitem_setting.cfm">More Setting</a>
		<cfif getpin2.h1350 eq 'T'>|| <a href="printbarcode_filter.cfm">Print Barcode</a></cfif>
        <cfif getpin2.h1311 eq 'T' and getpin2.h13D0 eq 'T'>
		||<a href="edititemexpress.cfm">Edit Item Express</a> 
	</cfif>
	</h4>
</cfoutput>

<cfform name="itemform" action="printbarcode.cfm" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
<table width="75%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
 	<tr <cfif getpin2.h2100 neq 'T'>style="visibility:hidden"</cfif>> 
        <cfoutput><th>Purchase Receive No</th></cfoutput>
        <td>
            <input type="text" name="rcno" id="rcno" value="">
            <img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findRefno');" />
		</td>
    </tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
	<tr> 
    	<cfoutput><th>#getgeneral.litemno# From</th></cfoutput>
        <td>
        <cfif getitem.recordcount gt 1000>
        <input type="text" name="itemfrom" id="itemfrom" value="">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />
        <cfelse>
        	<select name="itemfrom">
				<option value="">Choose an <cfoutput>#getgeneral.litemno#</cfoutput></option>
				<cfoutput query="getitem">
					<option value="#convertquote(itemno)#">#itemno# - #desp# #despa#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemfr" onKeyUp="getProduct('itemfrom');">
			</cfif>
        </cfif>
		</td>
    </tr>
    <tr> 
        <cfoutput><th>#getgeneral.litemno# To</th></cfoutput>
        <td>
        <cfif getitem.recordcount gt 1000>
        <input type="text" name="itemto" id="itemto" value="">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />
        
        <cfelse>
        <select name="itemto">
				<option value="">Choose an <cfoutput>#getgeneral.litemno#</cfoutput></option>
				<cfoutput query="getitem">
					<option value="#convertquote(itemno)#">#itemno# - #desp# #despa#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemto" onKeyUp="getProduct('itemto');">
			</cfif>
        </cfif>
		</td>
    </tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
	<tr>
		<th>No. of copies</th>
		<td><cfinput type="text" name="noofcopy" id="noofcopy" size="10" value="#noofcopy#" onKeyUp="javascript:checkNumber(itemform.noofcopy);"></td>
	</tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
    <tr>
		<th nowrap>Print using Bar Code Field in Item Profile</th>
		<td><input type="checkbox" name="barcode" id="barcode" <cfif barcode eq "1">checked</cfif>></td>
	</tr>
    <tr>
		<th>Spacing</th>
		<td><cfinput type="text" name="spacing" id="spacing" value="#spacing#" validate="float" ></td>
	</tr>
    <tr>
		<th>Top Spacing</th>
		<td><cfinput type="text" name="topspacing" id="topspacing" value="#topspacing#" validate="float" ></td>
	</tr>
    <tr>
		<th>Left Spacing</th>
		<td><cfinput type="text" name="leftspacing" id="leftspacing" value="#leftspacing#" validate="float" ></td>
	</tr>
    <tr>
		<th>Font Size</th>
		<td><cfinput type="text" name="fontsize" id="fontsize" value="#fontsize#" validate="float" ></td>
	</tr>
    <tr>
		<th>Barcode Width</th>
		<td><cfinput type="text" name="barcodewidth" id="barcodewidth" value="#barcodewidth#" validate="float" ></td>
	</tr>
    <tr>
      	<td align="right" colspan="3"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>

</cfform>
</body>
</html>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=item&fromto={fromto}" />
        
<cfwindow center="true" width="520" height="400" name="findRefno" refreshOnShow="true"
        title="Find Refno" initshow="false"
        source="findRefno.cfm?type=RC" />