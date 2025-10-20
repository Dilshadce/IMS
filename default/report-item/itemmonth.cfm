<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Cust/Supp/Agent/Area Item Report By Month</title>
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
// begin: product search
function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.itemmonth.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.itemmonth.searchitemfr.value;
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

// begin: supplier search
function getSupp(type,option){
	if(type == 'custfrom'){
		var inputtext = document.itemmonth.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.itemmonth.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult2);
	}
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", suppArray,"KEY", "VALUE");
}

function getSuppResult2(suppArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", suppArray,"KEY", "VALUE");
}
// end: supplier search
</script>

</head>

<cfif type eq "customerproductmonth">
	<cfset trantype = "CUSTOMER - PRODUCT SALES">
<cfelseif type eq "agentcustomermonth">
	<cfset trantype = "AGENT - CUSTOMER SALES">	
</cfif>

<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lAGENT,agentlistuserid from gsetup
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<body>
<cfoutput>
<!--- <h2>Print #trantype# Report</h2> --->
<h3>
	<a href="itemreportmenu.cfm">Cust/Supp/Agent/Area Item Report Menu</a> >> 
	<a><font size="2">Print #trantype# Report</font></a>
</h3>

<cfif type is "customerproductmonth">
	<!--- <cfquery name="getcust" datasource="#dts#" >
		select custno, name from #target_arcust# order by custno
	</cfquery> --->
	<cfquery name="getcust" datasource="#dts#" >
		select custno, name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
	</cfquery>

	<form name="itemmonth" action="itemmonth1.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	<table width="80%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
    <input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />
    	<tr>
	  		<th>Report Format</th>
	  	</tr>
	  	<tr>
			<td><input type="radio" name="period" id="1" value="1" checked> <label for="1">Period(1-6)</label><br>
				<input type="radio" name="period" id="1" value="2"> <label for="1">Period(7-12)</label><br>
				<input type="radio" name="period" id="1" value="3"> <label for="1">Period(13-18)</label><br>
				<input type="radio" name="period" id="1" value="4"> <label for="1">One Year</label>
			</td>
			<td><input type="radio" name="label" id="2" value="salesvalue" checked> <label for="salesvalue">By Sales Value</label>
			<br><input type="radio" name="label" id="2" value="salesqty"> <label for="salesqty">By Sales Quantity</label>
            <br><input type="radio" name="label" id="2" value="salesvalueqty"> <label for="salesvalueqty">By Sales Quantity and value</label>
			</td>
	  	</tr>
		<tr>
			<td><br>
				<input type="radio" name="result" value="HTML" checked>HTML<br/>
				<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
			</td>
			<td><br><input type="checkbox" name="includesubtotal">Include Sub-Total</td>
		</tr>
		  <tr> 
			<td colspan="2"><hr></td>
		  </tr>
		  <tr> 
			<th>Item No From</th>
			<td><select name="itemfrom">
					<option value="">Choose an Item</option>
					<cfloop query="getitem">
					<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemfr" onKeyUp="getProduct('itemfrom');">
				</cfif>
			</td>
		  </tr>
		  <tr> 
			<th>Item No To</th>
			<td><select name="itemto">
					<option value="">Choose an Item</option>
					<cfloop query="getitem">
					<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemto" onKeyUp="getProduct('itemto');">
				</cfif>
			</td>
		  </tr>
		  <tr> 
			<td colspan="2"><hr></td>
		  </tr>
		  <tr> 
			<th>Customer From</th>
			<td><select name="custfrom">
					<option value="">Choose a Customer</option>
					<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppfr" onKeyUp="getSupp('custfrom','Customer');">
				</cfif>
			</td>
		  </tr>
		  <tr> 
			<th>Customer To</th>
			<td><select name="custto">
					<option value="">Choose a Customer</option>
					<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppto" onKeyUp="getSupp('custto','Customer');">
				</cfif>
			</td>
		  </tr>
		  <tr> 
			<td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
		  </tr>
	</table>
<cfelseif type eq "agentcustomermonth">
<cfoutput>
	<cfquery name="getagent" datasource="#dts#">
					select agent,desp from #target_icagent# where 0=0
                    <cfif alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and  ucase(agent)='#ucase(huserid)#' 
					</cfif>
					<cfelse>
					
					</cfif>
                         order by agent
					</cfquery>
    </cfoutput>
	<form name="itemmonth" action="itemmonth2.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	<table width="80%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
    	<tr><input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />
	  		<th>Report Format</th>
	  	</tr>
		<tr>
			<td><input type="radio" name="period" id="1" value="1" checked> <label for="1">Period(1-6)</label><br>
				<input type="radio" name="period" id="1" value="2"> <label for="1">Period(7-12)</label><br>
				<input type="radio" name="period" id="1" value="3"> <label for="1">Period(13-18)</label><br>
				<input type="radio" name="period" id="1" value="4"> <label for="1">One Year</label>
			</td>
			<td><input type="radio" name="label" id="2" value="salesvalue" checked> <label for="salesvalue">By Sales Value</label>
			<br><input type="radio" name="label" id="2" value="salesqty"> <label for="salesqty">By Sales Quantity</label>
			</td>
		</tr>
		<tr>
			<td><br>
				<input type="radio" name="result" value="HTML" checked>HTML<br/>
				<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
			</td>
			<td><br><input type="checkbox" name="includesubtotal">Include Sub-Total</td>
		</tr>
	  	<tr> 
        	<td colspan="2"><hr></td>
      	</tr>
		<tr> 
			<th>Item No From</th>
			<td><select name="itemfrom">
					<option value="">Choose an Item</option>
					<cfloop query="getitem">
					<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemfr" onKeyUp="getProduct('itemfrom');">
				</cfif>
			</td>
		</tr>
		<tr> 
			<th>Item No To</th>
			<td><select name="itemto">
					<option value="">Choose an Item</option>
					<cfloop query="getitem">
					<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemto" onKeyUp="getProduct('itemto');">
				</cfif>
			</td>
		</tr>
		<tr> 
        	<td colspan="2"><hr></td>
      	</tr>
		<tr> 
			<th>#getgeneral.lAGENT# From</th>
			<td><select name="agentfrom">
					<option value="">Choose an #getgeneral.lAGENT#</option>
					<cfloop query="getagent">
					<option value="#agent#">#agent# - #desp#</option>
					</cfloop>
				</select></td>
		</tr>
      	<tr> 
        	<th>#getgeneral.lAGENT# To</th>
        	<td><select name="agentto">
				<option value="">Choose an #getgeneral.lAGENT#</option>
				<cfloop query="getagent">
				<option value="#agent#">#agent# - #desp#</option>
				</cfloop>
				</select></td>
      	</tr>
      	<tr> 
        	<td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
      	</tr>      
    </table>
</cfif>
</cfoutput>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        <cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Item&fromto={fromto}" />
</form>
</body>
</html>