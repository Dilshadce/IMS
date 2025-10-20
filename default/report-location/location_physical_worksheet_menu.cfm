<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title><cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Physical Worksheet Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_info(this.recordset);</script>
<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact2" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact2" event="ondatasetcomplete">show_info1(this.recordset);</script>

<script language="javascript" type="text/javascript">

	
function show_info(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("itemfrom");
		newArray = unescape(rset.fields("itemnolist").value);
		var itemnoArray = newArray.split(";;");
		newArray2 = unescape(rset.fields("itemdesclist").value);
		var itemdescArray = newArray2.split(";;");
		
		for(i=0;i<itemnoArray.length;i++){
			
			myoption = document.createElement("OPTION");
			if(itemnoArray[i] == '-1'){
				myoption.text = itemdescArray[i];
			}else{
				myoption.text = itemnoArray[i] + " - " + itemdescArray[i];
			}
			
			myoption.value = itemnoArray[i];
			document.location_physical_worksheet.itemfrom.options.add(myoption);
		}
		
	}
	
		function show_info1(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("itemto");
		newArray = unescape(rset.fields("itemnolist").value);
		var itemnoArray = newArray.split(";;");
		newArray2 = unescape(rset.fields("itemdesclist").value);
		var itemdescArray = newArray2.split(";;");
		
		for(i=0;i<itemnoArray.length;i++){
			
			myoption = document.createElement("OPTION");
			if(itemnoArray[i] == '-1'){
				myoption.text = itemdescArray[i];
			}else{
				myoption.text = itemnoArray[i] + " - " + itemdescArray[i];
			}
			
			myoption.value = itemnoArray[i];
			document.location_physical_worksheet.itemto.options.add(myoption);
		}
		
	}
	
	function getItem(){
		var text = document.location_physical_worksheet.letter.value;
		var w = document.location_physical_worksheet.searchtype.selectedIndex;
		var searchtype = document.location_physical_worksheet.searchtype.options[w].value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
function getItem1(){
		var text = document.location_physical_worksheet.letter1.value;
		var w = document.location_physical_worksheet.searchtype1.selectedIndex;
		var searchtype = document.location_physical_worksheet.searchtype1.options[w].value;
		if(text != ''){
			document.all.feedcontact2.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact2.charset=document.charset;
			document.all.feedcontact2.reset();
		}
	}

	function change_link()
	{
		if(document.location_physical_worksheet.update_actual_qty.checked==true)
		{
			document.location_physical_worksheet.action="location_physical_worksheet_adjust.cfm";
		}
		else
		{
			document.location_physical_worksheet.action="location_physical_worksheet_result.cfm";
		}
	}
	
	function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			}
	

function getlocation(type){
	if(type == 'locationto'){
		var inputtext = document.location_physical_worksheet.searchlocationto.value;
		DWREngine._execute(_reportflocation, null, 'locationlookup', inputtext, getlocationResult);
		
	}else{
		var inputtext = document.location_physical_worksheet.searchlocationfrom.value;
		DWREngine._execute(_reportflocation, null, 'locationlookup', inputtext, getlocationResult2);
	}
}

function getlocationResult(locationArray){
	DWRUtil.removeAllOptions("locationto");
	DWRUtil.addOptions("locationto", locationArray,"KEY", "VALUE");
}

function getlocationResult2(locationArray){
	DWRUtil.removeAllOptions("locationfrom");
	DWRUtil.addOptions("locationfrom", locationArray,"KEY", "VALUE");
}


// begin: product search
function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.location_physical_worksheet.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.location_physical_worksheet.searchitemfr.value;
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

// begin: category search
function getCategory(type){
	if(type == 'catefrom'){
		var inputtext = document.location_physical_worksheet.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.location_physical_worksheet.searchcateto.value;
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
		var inputtext = document.location_physical_worksheet.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.location_physical_worksheet.searchgroupto.value;
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

<cfquery name="getgeneral" datasource="#dts#">
	select 
	date_format(lastaccyear,'%d-%m-%Y') as lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,singlelocation,lbrand,filteritemreport,ddlitem
	from gsetup;
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getcate" datasource="#dts#">
    select cate,desp 
	from iccate 
	order by cate;
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
	select wos_group, desp 
	from icgroup 
	order by wos_group;
</cfquery>

<cfquery name="getbrand" datasource="#dts#">
	select brand, desp 
	from brand
	order by brand;
</cfquery>

<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno,desp 
	from icitem 
	order by itemno;
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno,<cfif lcase(hcomid) eq "vsolutionspteltd_i">concat(aitemno,' ------',desp) as desp<cfelse>desp</cfif> from icitem where (itemtype <> "SV" or itemtype is null) order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfquery name="getshelf" datasource="#dts#">
    select shelf,desp 
	from icshelf 
	order by shelf;
</cfquery>

<!--- <cfquery name="getlocation" datasource="#dts#">
    select location,desp 
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

<!--- <cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery> --->

<!--- <cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery> --->

<bo
<!--- <h1 align="center">View <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Physical Worksheet Report</h1> --->
<h3>
	<a href="location_listingmenu.cfm"><cfoutput>#getgeneral.lLOCATION#</cfoutput> Reports Menu</a> >> 
	<a><font size="2">View <cfoutput>#getgeneral.lLOCATION#</cfoutput> Physical Worksheet Report</font></a>
</h3>

<cfform action="location_physical_worksheet_result.cfm" name="location_physical_worksheet" method="post" target="_blank">
<table border="0" align="center" width="65%" class="data">
	<tr>
		<th>Report Format<input type="hidden" name="fromto" id="fromto" value="" /></th>
	</tr>
	<tr>
		<td nowrap>
        <input type="radio" name="result" value="HTML" checked>HTML<br/>
        <input type="radio" name="result" value="EXCELDEFAULT">EXCELDEFAULT<br/>
        <input type="checkbox" name="sortitem" id="1" value="yes">SORT BY ITEM NO<br/>
			<input type="checkbox" name="with_qty" id="1" value="yes" checked> WITH QUANTITY<br/>
			<input type="checkbox" name="include_stock" id="2" value="yes"> INCLUDE 0 STOCK<br/>
			<input type="checkbox" name="update_actual_qty" id="3" value="yes" onClick="change_link();"> UPDATE ACTUAL QUANTITY<br/>
            <cfif lcase(hcomid) neq "hempel_i"><input type="checkbox" name="generateitem" id="4" value="yes"> GENERATE ALL ITEM INTO LOCATION ITEM<br/></cfif>
			<input type="checkbox" name="generate_adjustment_transaction" id="4" value="yes"> GENERATE ADJUSTMENT TRANSACTIONS<br/>
            
		</td>
        <td>
        <input type="checkbox" name="exclude_actual" id="6" value="yes"> EXCLUDE 0 ACTUAL QTY<br/>
         <input type="checkbox" name="itemdespsort" id="itemdespsort" value="yes">SORT BY ITEM DESCRIPTION
        </td>
	</tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th>Item From</th>
      	<td colspan="2">
        	<cfif getgeneral.filteritemreport eq "1">
         
				<select id="itemfrom" name='itemfrom'>
					<option value=''>Please Filter The Item</option>
				</select> Filter by:
				<input id="letter" name="letter" type="text" size="8" onKeyup="getItem()"> in:
             
				<select id="searchtype" name="searchtype" onChange="getItem()">
                  <cfoutput>
                    <cfloop list="itemno,aitemno,desp,category,wos_group,brand" index="i">
                      <cfif #i# eq "itemno">
                        <cfset sitemdesp ="Item No">
                        <cfelseif #i# eq "aitemno">
                        <cfset sitemdesp ="Product Code">
                        <cfelseif #i# eq "desp">
                        <cfset sitemdesp ="Description">
                        <cfelseif #i# eq "category">
                        <cfset sitemdesp ="Category">
                        <cfelseif #i# eq "wos_group">
                        <cfset sitemdesp ="Group">
                        <cfelseif #i# eq "brand">
                        <cfset sitemdesp ="Brand">
                      </cfif>
                      <option value="#i#" <cfif #sitemdesp# eq #getgeneral.ddlitem#>selected</cfif>>#sitemdesp#</option>
                    </cfloop>
                  </cfoutput>
                </select>
        <cfelse>
        
			<select name="itemfrom" id="itemfrom">
          		<option value="">Choose an Item</option>
          		<cfoutput query="getitem">
					<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemfr" id="searchitemfr" onKeyUp="getProduct('itemfrom');">
			</cfif>
        </cfif>
		</td>
    </tr>
    <tr>
      	<th>Item To</th>
      	<td colspan="2">
        <cfif getgeneral.filteritemreport eq "1">
				<select id="itemto" name='itemto' >
					<option value=''>Please Filter The Item</option>
				</select> Filter by:
				<input id="letter1" name="letter1" type="text" size="8" onKeyup="getItem1()"> in:
             
				<select id="searchtype1" name="searchtype1" onChange="getItem1()">
                <cfoutput>
                    <cfloop list="itemno,aitemno,desp,category,wos_group,brand" index="i">
                <cfif #i# eq "itemno">
                <cfset sitemdesp ="Item No">
                <cfelseif #i# eq "aitemno">
                <cfset sitemdesp ="Product Code">
                <cfelseif #i# eq "desp">
                <cfset sitemdesp ="Description">
                <cfelseif #i# eq "category">
                <cfset sitemdesp ="Category">
                <cfelseif #i# eq "wos_group">
                <cfset sitemdesp ="Group">
                <cfelseif #i# eq "brand">
                <cfset sitemdesp ="Brand">
                </cfif>
                
                <option value="#i#" <cfif #sitemdesp# eq #getgeneral.ddlitem#>selected</cfif>>#sitemdesp#</option>
                </cfloop>
				</cfoutput>
				</select>
                <cfelse>
			<select name="itemto" id="itemto">
          		<option value="">Choose an Item</option>
          		<cfoutput query="getitem">
					<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemto" id="searchitemto" onKeyUp="getProduct('itemto');">
			</cfif>
            </cfif>
		</td>
    </tr>
    <!--- <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th>Category From</th>
      	<td colspan="2">
			<select name="catefrom">
          		<option value="">Choose a Category</option>
          		<cfoutput query="getcate">
					<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcatefr" onkeyup="getCategory('catefrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>Category To</th>
      	<td colspan="2">
			<select name="cateto">
          		<option value="">Choose a Category</option>
          		<cfoutput query="getcate">
					<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcateto" onkeyup="getCategory('cateto');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th>Group From</th>
      	<td colspan="2">
			<select name="groupfrom">
          		<option value="">Choose a Group</option>
          		<cfoutput query="getgroup">
					<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupfr" onkeyup="getGroup('groupfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>Group To</th>
      	<td colspan="2">
			<select name="groupto">
          		<option value="">Choose a Group</option>
          		<cfoutput query="getgroup">
					<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupto" onkeyup="getGroup('groupto');">
			</cfif>
		</td>
    </tr> --->
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfif getgeneral.singlelocation eq 'Y'>
    <tr>
      	<th><cfoutput>#getgeneral.lLOCATION#</cfoutput></th>
      	<td colspan="2">
			<select name="locationfrom">
          		<!--- <option value="">Choose a Location</option> --->
          		<cfoutput query="getlocation">
					<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
				</cfoutput>
			</select>
            
		</td>
    </tr>
    <cfelse>
	<tr>
      	<th><cfoutput>#getgeneral.lLOCATION#</cfoutput> From</th>
      	<td colspan="2">
			<select name="locationfrom">
				<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          			<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
				</cfif>
          		<!--- <option value="">Choose a Location</option> --->
          		<cfoutput query="getlocation">
					<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
				</cfoutput>
			</select>
            <input type="text" name="searchlocationfrom" id="searchlocationfrom" onKeyUp="getlocation('locationfrom');">
		</td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lLOCATION#</cfoutput> To</th>
      	<td colspan="2">
			<select name="locationto">
				<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          			<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
				</cfif>
          		<!--- <option value="">Choose a Location</option> --->
          		<cfoutput query="getlocation">
					<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
				</cfoutput>
			</select>
            <input type="text" name="searchlocationto" id="searchlocationto" onKeyUp="getlocation('locationto');">
		</td>
    </tr>
    </cfif>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lCATEGORY#</cfoutput> From</th>
      	<td colspan="2">
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
      	<th><cfoutput>#getgeneral.lCATEGORY#</cfoutput> To</th>
      	<td colspan="2">
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
      	<td colspan="3"><hr></td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lGROUP#</cfoutput> From</th>
      	<td colspan="2">
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
      	<th><cfoutput>#getgeneral.lGROUP#</cfoutput> To</th>
      	<td colspan="2">
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
      	<td colspan="5"><hr></td>
    </tr>
	<tr>
      	<th><cfoutput>#getgeneral.lMODEL#</cfoutput> From</th>
      	<td colspan="2">
			<select name="shelffrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lMODEL#</cfoutput></option>
          		<cfoutput query="getshelf">
					<option value="#getshelf.shelf#">#getshelf.shelf# - #getshelf.desp#</option>
				</cfoutput>
			</select>
		</td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lMODEL#</cfoutput> To</th>
      	<td colspan="2">
			<select name="shelfto">
          		<option value="">Choose a <cfoutput>#getgeneral.lMODEL#</cfoutput></option>
          		<cfoutput query="getshelf">
					<option value="#getshelf.shelf#">#getshelf.shelf# - #getshelf.desp#</option>
				</cfoutput>
			</select>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
	<tr>
      	<th><cfoutput>#getgeneral.lbrand#</cfoutput> From</th>
      	<td colspan="2">
			<select name="brandfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lbrand#</cfoutput></option>
          		<cfoutput query="getbrand">
					<option value="#getbrand.brand#">#getbrand.brand# - #getbrand.desp#</option>
				</cfoutput>
			</select>
		</td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lbrand#</cfoutput> To</th>
      	<td colspan="2">
			<select name="brandto">
          		<option value="">Choose a <cfoutput>#getgeneral.lbrand#</cfoutput></option>
          		<cfoutput query="getbrand">
					<option value="#getbrand.brand#">#getbrand.brand# - #getbrand.desp#</option>
				</cfoutput>
			</select>
		</td>
    </tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th>Period</th>
      	<td colspan="2">
			<select name="period" id="period" onChange="document.getElementById('target_date').value = this.options[this.selectedIndex].id;">
				<cfoutput>
                <cfset nowdate = dateformat(now(),"dd/mm/yyyy")>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'yyyy-mm-01')#>
                <cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
				<option value="01" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# >Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="02" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="03" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="04" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="05" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="06" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="07" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="08" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="09" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="10" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="11" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="12" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="13" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="14" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="15" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="16" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="17" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'yyyy-mm-01')#>
				<cfset lasdate=dateformat(createdate(left(lasdate,4),mid(lasdate,6,2),DaysInMonth(lasdate)),'dd/mm/yyyy')>
                <option value="18" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</cfoutput>
			</select>
		</td>
    </tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
	<tr>
		<th>Date</th>
		<td colspan="2">
			<cfinput name="target_date" id="target_date" type="text" value="#dateformat(now(),'dd/mm/yyyy')#" size="11" maxlength="10" required="yes" validate="eurodate" message="Please Key In Correct Date Format !" mask="99/99/9999"> (DD/MM/YYYY)
			<font color="FF0000">Please Check Your Date With Your Selected Period !</font>
		</td>
	</tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <td align="right" colspan="3"><input type="Submit" name="Submit" value="Print"></td>
      	<td align="right" colspan="3"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</cfform>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=item&fromto={fromto}" />
</body>
</html>