<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Serial Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
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
				
// begin: supplier search
function getCust(type,option){
	if(type == 'custfrom'){
		var inputtext = document.saleslist.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
		
	}
	else{
		var inputtext = document.saleslist.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult2);
	}
}

function getCustResult(suppArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", suppArray,"KEY", "VALUE");
}

function getCustResult2(suppArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", suppArray,"KEY", "VALUE");
}
// end: supplier search					
// begin: product search
function getProduct(type){
	if(type == 'productto'){
		var inputtext = document.form.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.form.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult2);
	}
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("productto");
	DWRUtil.addOptions("productto", itemArray,"KEY", "VALUE");
}

function getProductResult2(itemArray){
	DWRUtil.removeAllOptions("productfrom");
	DWRUtil.addOptions("productfrom", itemArray,"KEY", "VALUE");
}
// end: product search

// begin: serialno search
function getSerial(type){
	if(type == 'serialto'){
		var inputtext = document.form.searchserialfr.value;
		DWREngine._execute(_reportflocation, null, 'serialnolookup', inputtext, getSerialResult);
		
	}else{
		var inputtext = document.form.searchserialfr.value;
		DWREngine._execute(_reportflocation, null, 'serialnolookup', inputtext, getSerialResult2);
	}
}

function getSerialResult(serialArray){
	DWRUtil.removeAllOptions("serialto");
	DWRUtil.addOptions("serialto", serialArray,"KEY", "VALUE");
}

function getSerialResult2(serialArray){
	DWRUtil.removeAllOptions("serialfrom");
	DWRUtil.addOptions("serialfrom", serialArray,"KEY", "VALUE");
}
// end: serialno search

// begin: location search
function getLocation(type){
	if(type == 'locto'){
		var inputtext = document.form.locfrom.value;
		DWREngine._execute(_reportflocation, null, 'locationlookup', inputtext, getLocationResult);
		
	}else{
		var inputtext = document.form.locfrom.value;
		DWREngine._execute(_reportflocation, null, 'locationlookup', inputtext, getLocationResult);
	}
}

function getLocationResult(serialArray){
	DWRUtil.removeAllOptions("locto");
	DWRUtil.addOptions("locto", locationArray,"KEY", "VALUE");
}

function getSerialResult2(serialArray){
	DWRUtil.removeAllOptions("locfrom");
	DWRUtil.addOptions("locfrom", locationArray,"KEY", "VALUE");
}
// end: location search



</script>

</head>
<!--- ADD ON 300908 --->
<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lLOCATION,lserial from gsetup
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getcust" datasource="#dts#">
		select custno, name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
	</cfquery>

<cfquery datasource="#dts#" name="getlocation">
	select * from iclocation 
	<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and  Huserloc neq "All_loc">
		where location in (#ListQualify(Huserloc,"'",",")#)
	</cfif>
	order by location
</cfquery>

<cfquery datasource="#dts#" name="getserial">
	 select distinct(serialno) from iserial where type not in ('QUO','PO','SO','SAM') order by serialno
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno, <cfif lcase(hcomid) eq "vsolutionspteltd_i">concat(aitemno,' ------',desp) as desp<cfelse>desp</cfif> from icitem where (itemtype <> "SV" or itemtype is null) and wserialno = "T" order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif> 
</cfquery>
<cfif type eq "ref">
	<cfset reporttitle="Serial Report - Transaction Listing by Reference No">
<cfelseif type eq "item">
	<cfset reporttitle="Serial Report - Transaction Listing by Item">
<cfelseif type eq "status">
	<cfset reporttitle="Serial Report - Item - Serial No Status">
<cfelseif type eq "sale">
	<cfset reporttitle="Serial Report - Serial No - Sales Listing">
</cfif>
<body>
<cfform action="serialreport2.cfm?type=#type#" name="form" method="post" target="_blank">
<h3>
	<a href="other_listingmenu.cfm">Others Report Menu</a> >> 
	<a><font size="2"><cfoutput>#reporttitle#</cfoutput></font></a>
</h3>

<cfif type eq "ref">
	<!--- <h1>Serial Report - Transaction Listing by Reference No</h1> --->
	<table border="0" align="center" width="65%" class="data">
	<tr>
		<th>Report Format<input type="hidden" name="fromto" id="fromto" value="" /></th>
		<td colspan="4">
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	</tr>
	 <tr> 
        <td colspan="5"><hr></td>
    </tr>
	<tr> 
      <th width="16%">Type</th>
      <td width="5%"></td>
      <td colspan="2">
		<select name="dtype">
	  		<option value="">Choose a Type</option>	 	  
	  		<option value="CS">Cash Sales</option>
	  		<option value="CN">Credit Note</option>
	  		<option value="DN">Debit Note</option>
	  		<option value="DO">Delivery Order</option>
	  		<option value="INV">Invoice</option>
	  		<option value="RC">Purchase Receive</option>
	  		<option value="PR">Purchase Return</option>	  	  
	  	</select>
	  </td>
    </tr>
	<tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th width="16%">Date</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY) </td>
    </tr>
    <tr> 
      <th width="16%">Date</th>
      <td width="5%"> <div align="center">To</div></td>
      <td width="69%" colspan="2"><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY)&nbsp; </td>      
    </tr>
	<tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th><cfoutput>Location</cfoutput></th>
      <td><div align="center">From</div></td>
      <td colspan="2">      
            <input type="text" name="locfrom" id="locfrom"size="10">        
      	<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findLocation');" />&nbsp;
        </cfif>       
	  </td>
	</tr>
	<tr> 
		<th><cfoutput>Location</cfoutput></th>
		<td><div align="center">To</div></td>
		<td width="69%" colspan="2">       
            <input type="text" name="locto" id="locto"size="10">  
            <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findLocation');" />&nbsp;
            </cfif>    
		</td>
	</tr>
	<tr>
      <td colspan="5"><hr></td>
    </tr>
	
	<tr> 
      <th width="16%">Product</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
      	<input type="text" name="productfrom" id="productfrom"size="10">
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th>Product</th>
      <td><div align="center">To</div></td>
      <td colspan="2" nowrap> 
		<input type="text" name="productto" id="productto"size="10">
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    
    <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">    
      	<input type="text" name="serialfrom" id="serialfrom"size="10">     
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findserial');" />
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2">
     	 <input type="text" name="serialto" id="serialto"size="10"> 
		<cfif getgeneral.filterall eq "1">
       		<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findserial');" />
		</cfif>
	  </td>
    </tr>
<tr>
      <td colspan="5" align="right"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
	
    
  </table>
<cfelseif type eq "item">
	<!--- <h1>Serial Report - Transaction Listing by Item</h1> --->
	<table border="0" align="center" width="65%" class="data">
	<tr>
		<th>Report Format<input type="hidden" name="fromto" id="fromto" value="" /></th>
		<td colspan="4">
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	</tr>
	<tr> 
        <td colspan="5"><hr></td>
    </tr>
	<tr>
		<th>Show</th>
		<td colspan="4">
			<select name="serialstatus">
				<option value="All" selected>All <cfoutput>#getgeneral.lserial#</cfoutput></option>
				<option value="Unused">Unused <cfoutput>#getgeneral.lserial#</cfoutput>.</option>
				<option value="Used">Used <cfoutput>#getgeneral.lserial#</cfoutput>.</option>
			</select>
		</td>
	</tr>
	<tr> 
        <td colspan="5"><hr></td>
    </tr>
	<tr> 
      <th width="16%">Date</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY) </td>
    </tr>
    <tr> 
      <th width="16%">Date</th>
      <td width="5%"> <div align="center">To</div></td>
      <td width="69%" colspan="2"><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY)&nbsp; </td>      
    </tr>
	<tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th><cfoutput>Location</cfoutput></th>
      <td><div align="center">From</div></td>
      <td colspan="2">      
            <input type="text" name="locfrom" id="locfrom"size="10">        
      	<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findLocation');" />&nbsp;
        </cfif>       
	  </td>
	</tr>
	<tr> 
		<th><cfoutput>Location</cfoutput></th>
		<td><div align="center">To</div></td>
		<td width="69%" colspan="2">       
            <input type="text" name="locto" id="locto"size="10">  
            <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findLocation');" />&nbsp;
            </cfif>    
		</td>
	</tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
	
	<tr> 
      <th width="16%">Product</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
      	<input type="text" name="productfrom" id="productfrom"size="10">
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th>Product</th>
      <td><div align="center">To</div></td>
      <td colspan="2" nowrap> 
		<input type="text" name="productto" id="productto"size="10">
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
    </tr>
    
	<tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
		<input type="text" name="serialfrom" id="serialfrom"size="10">
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findserial');" />
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2">
		<input type="text" name="serialto" id="serialto" size="10">
		<cfif getgeneral.filterall eq "1">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findserial');" />
		</cfif>
	  </td>
    </tr>
<tr>
      <td colspan="5" align="right"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
	
    
  </table>
<cfelseif type eq "status">
<!--- <h1>Serial Report - Item - Serial No Status</h1> --->
	<table border="0" align="center" width="65%" class="data">
	<tr>
		<th>Report Format<input type="hidden" name="fromto" id="fromto" value="" /></th>
		<td colspan="4">
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	</tr>
	 <tr> 
        <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th><cfoutput>Location</cfoutput></th>
      <td><div align="center">From</div></td>
      <td colspan="2">      
            <input type="text" name="locfrom" id="locfrom"size="10">        
      	<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findLocation');" />&nbsp;
        </cfif>       
	  </td>
	</tr>
	<tr> 
		<th><cfoutput>Location</cfoutput></th>
		<td><div align="center">To</div></td>
		<td width="69%" colspan="2">       
            <input type="text" name="locto" id="locto"size="10">  
            <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findLocation');" />&nbsp;
            </cfif>    
		</td>
	</tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
	
	<tr> 
      <th width="16%">Product</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
      <input type="text" name="productfrom" id="productfrom" size="10">
		
		<cfif getgeneral.filterall eq "1">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th>Product</th>
      <td><div align="center">To</div></td>
      <td colspan="2" nowrap>
      <input type="text" name="productto" id="productto" size="10"> 
		
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
      <tr>
      <td colspan="5"><hr></td>
    </tr>
      <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
      <input type="text" name="serialfrom" id="serialfrom" size="10"> 
     
		<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findserial');" />
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2">
      	<input type="text" name="serialto" id="serialto" size="10"> 
    	<cfif getgeneral.filterall eq "1">
        	<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findserial');" />
		</cfif>
	  </td>
    </tr>
    </tr>
<tr>
      <td colspan="5" align="right"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
	
    
  </table>
<cfelseif type eq "sale">
<!--- <h1>Serial Report - Serial No - Sales Listing</h1> --->
	<table border="0" align="center" width="65%" class="data">
	<tr>
		<th>Report Format<input type="hidden" name="fromto" id="fromto" value="" /></th>
		<td colspan="4">
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	</tr>
	 <tr> 
        <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th><cfoutput>Location</cfoutput></th>
      <td><div align="center">From</div></td>
      <td colspan="2">      
            <input type="text" name="locfrom" id="locfrom"size="10">        
      	<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findLocation');" />&nbsp;
        </cfif>       
	  </td>
	</tr>
	<tr> 
		<th><cfoutput>Location</cfoutput></th>
		<td><div align="center">To</div></td>
		<td width="69%" colspan="2">       
            <input type="text" name="locto" id="locto"size="10">  
            <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findLocation');" />&nbsp;
            </cfif>    
		</td>
	</tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
	
	<tr> 
      <th width="16%">Product</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
      <input type="text" name="productfrom" id="productfrom" size="10"> 
		
		<cfif getgeneral.filterall eq "1">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th>Product</th>
      <td><div align="center">To</div></td>
      <td colspan="2" nowrap> 
      <input type="text" name="productto" id="productto" size="10">
      
		<cfif getgeneral.filterall eq "1">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
		</cfif>
	  </td>
    </tr>
    
	<tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
      <input type="text" name="serialfrom" id="serialfrom" size="10">
      
		
		<cfif getgeneral.filterall eq "1">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findserial');" />	
		</cfif>
	  </td>
    </tr>
    <tr> 
      <th width="16%">Serial</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2">
		<input type="text" name="serialto" id="serialto" size="10">
		<cfif getgeneral.filterall eq "1">       	
			<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findserial');" />
		</cfif>
	  </td>
    </tr>
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <cfoutput>
	<tr>   
    	<th>Customer</th>
        <td><div align="center">From</div></td>
        <td>
        <input type="text" name="custfrom" id="custfrom" size="10">
        
        
            <cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;
			</cfif>
		</td>
	</tr>
    <tr> 
        <th>Customer</th>
        <td><div align="center">To</div></td>
        <td> 
        	<input type="text" name="custto" id="custto" size="10">
            <cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;
			</cfif>
		</td>
    </tr>
    </cfoutput>
    
<tr>
      <td colspan="5" align="right"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>

  
  </table>
</cfif>
    
</cfform>
<cfwindow center="true" width="590" height="400" name="finditem" refreshOnShow="true"
        title="Find Product" initshow="false"
        source="finditem.cfm?type=product&fromto={fromto}" />
        
<cfwindow center="true" width="590" height="400" name="findserial" refreshOnShow="true"
        title="Find Serial" initshow="false"
        source="findserial.cfm?type=product&fromto={fromto}" />
        
<cfwindow center="true" width="590" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type=#target_arcust#&fromto={fromto}" />
        
<cfwindow center="true" width="590" height="400" name="findLocation" refreshOnShow="true"
        title="Find Location" initshow="false"
        source="findLocation.cfm?type=location&fromto={fromto}" />
</body>
</html>
