<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfquery name="getgeneral" datasource="#dts#">
	select filterall from gsetup
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getProductCode" datasource="#dts#">
	SELECT aitemno, desp 
    FROM icitem 
    ORDER BY aitemno;
</cfquery>

<cfif url.type eq "productmonth">
	<cfset trantype = "PRODUCT PURCHASE">	
	
	<cfquery name="getitem" datasource="#dts#">
		select itemno, desp from icitem order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
	</cfquery>
<cfelse>
	<cfset trantype = "VENDOR SUPPLY">	
	
	<cfquery name="getcust" datasource="#dts#" >
		select custno, name from #target_apvend# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
	</cfquery>
</cfif>

<html>
<head>
	<title>Purchase Report By Month</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script type="text/javascript">

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
	if(type == 'productto'){
		var inputtext = document.stockaging.searchProductto.value;
		DWREngine._execute(_reportflocation, null, 'productCodeLookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.stockaging.searchProductfr.value;
		DWREngine._execute(_reportflocation, null, 'productCodeLookup', inputtext, getProductResult2);
	}
}

function getProductResult(productArray){
	DWRUtil.removeAllOptions("productto");
	DWRUtil.addOptions("productto", productArray,"KEY", "VALUE");
}

function getProductResult2(productArray){
	DWRUtil.removeAllOptions("productfrom");
	DWRUtil.addOptions("productfrom", productArray,"KEY", "VALUE");
}
// end: product search


function getItem(type){
	if(type == 'itemto'){
		var inputtext = document.stockaging.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getItemResult);
		
	}else{
		var inputtext = document.stockaging.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getItemResult2);
	}
}

function getItemResult(itemArray){
	DWRUtil.removeAllOptions("itemto");
	DWRUtil.addOptions("itemto", itemArray,"KEY", "VALUE");
}

function getItemResult2(itemArray){
	DWRUtil.removeAllOptions("itemfrom");
	DWRUtil.addOptions("itemfrom", itemArray,"KEY", "VALUE");
}


// begin: supplier search
function getSupp(type,option){
	if(type == 'suppfrom'){
		var inputtext = document.salestype.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.salestype.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult2);
	}
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("suppfrom");
	DWRUtil.addOptions("suppfrom", suppArray,"KEY", "VALUE");
}

function getSuppResult2(suppArray){
	DWRUtil.removeAllOptions("suppto");
	DWRUtil.addOptions("suppto", suppArray,"KEY", "VALUE");
}
// end: supplier search

</script>

</head>

<body>
<cfoutput>
<!--- <h2>Print #trantype# Report (By Month)</h2> --->
<h3>
	<a href="purchasemenu.cfm">Purchase Report Menu</a> >> 
	<a><font size="2">Print #trantype# Report (By Month)</font></a>
</h3>

<cfif type is "productmonth">
<form name="salestype" action="purchasemonth1.cfm?trantype=#trantype#" method="post" target="_blank">
<table width="75%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr><input type="hidden" name="tran" id="tran" value="#target_apvend#" /><input type="hidden" name="fromto" id="fromto" value="" />
		<th>Report Format</th>
	</tr>
	<tr>
	  	<td><input type="radio" name="period" id="1" value="1" checked> <label for="1">Period (1-6)</label><br>
			<input type="radio" name="period" id="1" value="2"> <label for="1">Period (7-12)</label><br>
			<input type="radio" name="period" id="1" value="3"> <label for="1">Period (13-18)</label><br>
			<input type="radio" name="period" id="1" value="4"> <label for="1">One Year</label><br><br>
			
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	  	<td><input type="radio" name="label" id="2" value="salesvalue" checked> <label for="salesvalue">By Sales Value</label>
		<br><input type="radio" name="label" id="2" value="salesqty"> <label for="salesqty">By Sales Quantity</label>
		</td>
	</tr>
	<tr> 
        <td colspan="2"><hr></td>
    </tr>
	 <tr> 
		<th width="16%">Product From</th>
		<td colspan="2">
        <select name="productfrom" id="productfrom">
			<option value="">Choose a product</option>
			<cfloop query="getProductCode">
            	<option value="#convertquote(aitemno)#">#aitemno# - #desp#</option>
			</cfloop> 
		</select>
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findProduct');" />&nbsp;
			<input type="text" name="searchProductfr" id="searchProductfr" onKeyUp="getProduct('productfrom');">
		</cfif>
		</td>
    </tr>
    <tr> 
		<th>Product To</th>
		<td colspan="2" nowrap> 
        	<select name="productto">
				<option value="">Choose a product</option>
					<cfloop query="getProductCode">
                    	<option value="#convertquote(aitemno)#">#aitemno# - #desp#</option>
					</cfloop> 
			</select> 
		<cfif getgeneral.filterall eq "1">
			<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findProduct');" />&nbsp;
				<input type="text" name="searchProductto" id="searchProductto" onKeyUp="getProduct('productto');">
		</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th>Item From</th>
      	<td colspan="2">
			<select name="itemfrom">
          		<option value="">Choose an Item</option>
          		<cfloop query="getitem"><option value="#convertquote(itemno)#">#itemno# - #desp#</option></cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findItem');" />&nbsp;
				<input type="text" name="searchitemfr" id="searchitemfr" onKeyUp="getItem('itemfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>Item To</th>
      	<td colspan="2">
			<select name="itemto">
          		<option value="">Choose an Item</option>
          		<cfloop query="getitem"><option value="#convertquote(itemno)#">#itemno# - #desp#</option></cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findItem');" />&nbsp;
				<input type="text" name="searchitemto" id="searchitemto" onKeyUp="getItem('itemto');">
			</cfif>
		</td>
    </tr>
	<tr> 
      	<td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</form>  
<cfelse>
<form name="salestype" action="vendormonth1.cfm?trantype=#trantype#" method="post" target="_blank">
<table width="60%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
    <tr>
<input type="hidden" name="tran" id="tran" value="#target_apvend#" /><input type="hidden" name="fromto" id="fromto" value="" />

		<th>Report Format</th>
	</tr>
	<tr>
	  	<td colspan="2"><input type="radio" name="period" id="1" value="1" checked> <label for="1">Period (1-6)</label><br>
			<input type="radio" name="period" id="1" value="2"> <label for="1">Period (7-12)</label><br>
			<input type="radio" name="period" id="1" value="3"> <label for="1">Period (13-18)</label><br>
			<input type="radio" name="period" id="1" value="4"> <label for="1">One Year</label><br><br>
			
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	</tr>
	<tr> 
        <td colspan="2"><hr></td>
    </tr>
	<tr> 
        <th>Supplier From</th>
        <td><select name="suppfrom">
				<option value="">Choose a Supplier</option>
				<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppfr" onKeyUp="getSupp('suppfrom','Supplier');">
			</cfif>
		</td>
      </tr>
    <tr> 
        <th>Supplier To</th>
        <td><select name="suppto">
				<option value="">Choose a Supplier</option>
				<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				
<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppto" onKeyUp="getSupp('suppto','Supplier');">
			</cfif>
		</td>
    </tr>
	<tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</form>
</cfif>
</cfoutput>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="/default/AjaxSearch/findCustomer.cfm?type={tran}&fromto={fromto}" />
        
<cfwindow center="true" width="550" height="400" name="findItem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="/default/AjaxSearch/findItem.cfm?type=Item&fromto={fromto}" />
        
<cfwindow center="true" width="550" height="400" name="findProduct" refreshOnShow="true"
	title="Find Product" initshow="false"
source="/default/AjaxSearch/findProduct.cfm?type=Product&fromto={fromto}" />
</body>
</html>