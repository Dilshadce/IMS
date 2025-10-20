<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Billing Listing Menu</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<script language="javascript" type="text/javascript">

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
	function change_action(format_value)
	{
		if(format_value=="HTML")
		{
			document.getElementById("location_listing_report").action="location_listingreport_result_html.cfm";
		}
		else if(format_value=="EXCELDEFAULT")
		{
			document.getElementById("location_listing_report").action="location_listingreport_result_excel_default.cfm";
		}
	}
	
// begin: product search
function getProduct(type){
	if(type == 'productto'){
		var inputtext = document.location_listing_report.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.location_listing_report.searchitemfr.value;
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

// begin: category search
function getCategory(type){
	if(type == 'catefrom'){
		var inputtext = document.location_listing_report.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.location_listing_report.searchcateto.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult2);
	}
}

function getCategoryResult(cateArray){
	DWRUtil.removeAllOptions("catefrom");
	DWRUtil.addOptions("catefrom", cateArray,"KEY", "VALUE");
}

function getCategoryResult2(cateArray){
	DWRUtil.removeAllOptions("cateto");
	DWRUtil.addOptions("cateto", cateArray,"KEY", "VALUE");
}
// end: category search

// begin: group search
function getGroup(type){
	if(type == 'groupfrom'){
		var inputtext = document.location_listing_report.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.location_listing_report.searchgroupto.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult2);
	}
}

function getGroupResult(groupArray){
	DWRUtil.removeAllOptions("groupfrom");
	DWRUtil.addOptions("groupfrom", groupArray,"KEY", "VALUE");
}

function getGroupResult2(groupArray){
	DWRUtil.removeAllOptions("groupto");
	DWRUtil.addOptions("groupto", groupArray,"KEY", "VALUE");
}
// end: group search

</script>
</head>


<!---cfquery name="getgeneral" datasource="#dts#">
	select 
	date_format(lastaccyear,'%d-%m-%Y') as lastaccyear
	from gsetup;
</cfquery--->

<cfquery name="getgeneral" datasource="#dts#">
	select 
	date_format(lastaccyear,'%d-%m-%Y') as lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,singlelocation
	from gsetup;
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<!--- <cfquery name = "getitem" datasource = "#dts#">
	select 
	itemno,
	desp 
	from icitem 
	order by itemno;
</cfquery> --->
<cfquery name = "getitem" datasource = "#dts#">
	select itemno,desp from icitem order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfquery name = "getgroup" datasource = "#dts#">
	select 
	wos_group,
	desp 
	from icgroup 
	order by wos_group;
</cfquery>

<cfquery name = "getcate" datasource = "#dts#">
	select 
	cate,
	desp 
	from iccate 
	order by cate;
</cfquery>

<cfquery name = "getagent" datasource = "#dts#">
	select 
	agent,
	desp 
	FROM #target_icagent# 
	order by agent;
</cfquery>

<!--- <cfquery name="getlocation" datasource="#dts#">
	select 
	location,
	desp 
	from iclocation 
	order by location;
</cfquery> --->

<cfquery name="getlocation" datasource="#dts#">
	select location,desp 
	from iclocation 
	<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
		where location in (#ListQualify(Huserloc,"'",",")#)
	</cfif>
	order by location
</cfquery>

<body>


<h1>Grade Opening Quantity Maintenance</h1>
<cfform name="location_listing_report" action="grade_opening_qty_maintenance.cfm" method="post">
    <input type="hidden" name="fromto" id="fromto" value="" />
	<table border="0" align="center" width="80%" class="data">
		<tr>
			<th nowrap><cfoutput>#getgeneral.lCATEGORY#</cfoutput> From</th>
			<td>
				<select name="catefrom">
					<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
					<cfoutput query="getcate">
						<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
					</cfoutput>
				</select>
                <cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcatefr" onKeyUp="getCategory('catefrom');">
				</cfif>
			</td>
		</tr>
		<tr>
			<th nowrap><cfoutput>#getgeneral.lCATEGORY#</cfoutput> To</th>
			<td>
				<select name="cateto">
					<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
					<cfoutput query="getcate">
						<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
					</cfoutput>
				</select>
                <cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcateto" onKeyUp="getCategory('cateto');">
				</cfif>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<th nowrap><cfoutput>#getgeneral.lGROUP#</cfoutput> From</th>
			<td>
				<select name="groupfrom">
					<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
					<cfoutput query="getgroup">
						<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
					</cfoutput>
				</select>
                <cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupfr" onKeyUp="getGroup('groupfrom');">
				</cfif>
			</td>
		</tr>
		<tr>
			<th nowrap><cfoutput>#getgeneral.lGROUP#</cfoutput> To</th>
			<td>
				<select name="groupto">
					<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
					<cfoutput query="getgroup">
						<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
					</cfoutput>
				</select>
                <cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupto" onKeyUp="getGroup('groupto');">
				</cfif>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<th nowrap>Product From</th>
			<td>
				<select name="productfrom">
					<option value="">Choose a Product</option>
					<cfoutput query="getitem">
						<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
					</cfoutput>
				</select>
                <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">
				</cfif>
			</td>
		</tr>
		<tr>
			<th nowrap>Product To</th>
			<td>
				<select name="productto">
					<option value="">Choose a Product</option>
					<cfoutput query="getitem">
						<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
					</cfoutput>
				</select>
                <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemto" onKeyUp="getProduct('productto');">
				</cfif>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>

         <tr>
			<th nowrap><cfoutput>#getgeneral.lLOCATION#</cfoutput></th>
			<td>
				<cfselect name="loc" id="loc">
					<!--- <option value="">Choose a Location</option> --->
					<cfoutput query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfoutput>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="Submit" name="Submit" value="Submit">
			</td>
		</tr>
	</table>
</cfform>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Product&fromto={fromto}" />
</body>
</html>