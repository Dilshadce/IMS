<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Item Statues & Value Menu</title>
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


<!---<script type="text/javascript">

function show_info(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("productfrom");
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
			document.form.productfrom.options.add(myoption);
		}
		
	}
	
		function show_info1(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("productto");
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
			document.form.productto.options.add(myoption);
		}
		
	}

function getItem(){
		var text = document.form.letter.value;
		var w = document.form.searchtype.selectedIndex;
		var searchtype = document.form.searchtype.options[w].value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
function getItem1(){
		var text = document.form.letter1.value;
		var w = document.form.searchtype1.selectedIndex;
		var searchtype = document.form.searchtype1.options[w].value;
		if(text != ''){
			document.all.feedcontact2.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact2.charset=document.charset;
			document.all.feedcontact2.reset();
		}
	}
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
}// end: product search

// begin: category search
function getCategory(type){
	if(type == 'Catefrom'){
		var inputtext = document.form.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.form.searchcateto.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult2);
	}
}

function getCategoryResult(cateArray){
	DWRUtil.removeAllOptions("Catefrom");
	DWRUtil.addOptions("Catefrom", cateArray,"KEY", "VALUE");
}

function getCategoryResult2(cateArray){
	DWRUtil.removeAllOptions("Cateto");
	DWRUtil.addOptions("Cateto", cateArray,"KEY", "VALUE");
}
// end: category search

// begin: group search
function getGroup(type){
	if(type == 'groupfrom'){
		var inputtext = document.form.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.form.searchgroupto.value;
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

// begin: supplier search
function getSupp(type,option){
	if(type == 'suppfrom'){
		var inputtext = document.form.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.form.searchsuppto.value;
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
</script>--->
<script type="text/javascript">
	function show_info(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("productfrom");
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
			document.form.productfrom.options.add(myoption);
		}
		
	}
	
		function show_info1(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("productto");
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
			document.form.productto.options.add(myoption);
		}
		
	}

function getItem(){
		var text = document.form.letter.value;
		var w = document.form.searchtype.selectedIndex;
		var searchtype = document.form.searchtype.options[w].value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
function getItem1(){
		var text = document.form.letter1.value;
		var w = document.form.searchtype1.selectedIndex;
		var searchtype = document.form.searchtype1.options[w].value;
		if(text != ''){
			document.all.feedcontact2.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact2.charset=document.charset;
			document.all.feedcontact2.reset();
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

// begin: category search
function getCategory(type){
	if(type == 'Catefrom'){
		var inputtext = document.form.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.form.searchcateto.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult2);
	}
}

function getCategoryResult(cateArray){
	DWRUtil.removeAllOptions("Catefrom");
	DWRUtil.addOptions("Catefrom", cateArray,"KEY", "VALUE");
}

function getCategoryResult2(cateArray){
	DWRUtil.removeAllOptions("Cateto");
	DWRUtil.addOptions("Cateto", cateArray,"KEY", "VALUE");
}
// end: category search

// begin: group search
function getGroup(type){
	if(type == 'groupfrom'){
		var inputtext = document.form.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.form.searchgroupto.value;
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

// begin: supplier search
function getSupp(type,option){
	if(type == 'suppfrom'){
		var inputtext = document.form.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.form.searchsuppto.value;
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

function CheckAssign(){
	
	if(document.form.Cateto.value == ""){
		document.form.Cateto.value = trim(document.form.Catefrom.value);
	}
	if(document.form.groupto.value == ""){
		document.form.groupto.value = trim(document.form.groupfrom.value);
	}
	if(document.form.productto.value == ""){
		document.form.productto.value = trim(document.form.productfrom.value);
	}
	if(document.form.suppto.value == ""){
		document.form.suppto.value = trim(document.form.suppfrom.value);
	}
	
	setTimeout('clearFields()', 200); 
	return true;
}

// Clear Form
function clearFields(){
	document.form.reset();
}

// This function is for stripping leading and trailing spaces
function trim(str){     
	if(str != null){        
		var i;         
		for(i=0; i<str.length; i++){            
			if (str.charAt(i)!=" "){                
				str=str.substring(i,str.length);                 
				break;            
			}         
		}             
		for(i=str.length-1; i>=0; i--){            
			if(str.charAt(i)!=" "){                
				str=str.substring(0,i+1);                 
				break;            
			}         
		}                 
		if(str.charAt(0)==" "){            
			return "";         
		}else{            
			return str;         
		}   
	}
}
</script>

</head>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,cost,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION ,filteritemreport,ddlitem
	from gsetup
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno,desp 
	from icitem 
	order by itemno 
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno,desp from icitem where (itemtype <> "SV" or itemtype is null) order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif> 
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
	select wos_group,desp 
	from icgroup 
	order by wos_group
</cfquery>

<cfquery name="getcate" datasource="#dts#">
	select cate,desp 
	from iccate 
	order by cate
</cfquery>

<!--- <cfquery name="getsupp" datasource="#dts#">
    select custno,name 
	from #target_apvend#
	order by custno
</cfquery> --->
<cfquery name="getsupp" datasource="#dts#">
    select custno,name from #target_apvend# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
</cfquery>

<cfquery name="getlocation" datasource="#dts#">
	select location,desp 
	from iclocation 
	<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
		where location in (#ListQualify(Huserloc,"'",",")#)
	</cfif>
    	
 	order by location
</cfquery>

<body>
<cfswitch expression="#url.type#">
	<cfcase value="item_location">
		<!--- <h1 align="center">View Item - Location Status and Value</h1> --->
		<h3>
			<a href="location_listingmenu.cfm"><cfoutput>#getgeneral.lLOCATION#</cfoutput> Reports Menu</a> >> 
			<a><font size="2">View Item - <cfoutput>#getgeneral.lLOCATION#</cfoutput> Status and Value Report</font></a>
		</h3>
		<form action="location_status_result.cfm" name="form" method="post" target="_blank">
	</cfcase>
	
	<cfcase value="location_item">
		<!--- <h1 align="center">View Location - Item Status and Value</h1> --->
		<h3>
			<a href="location_listingmenu.cfm"><cfoutput>#getgeneral.lLOCATION#</cfoutput> Reports Menu</a> >> 
			<a><font size="2">View <cfoutput>#getgeneral.lLOCATION#</cfoutput> - Item Status and Value Report</font></a>
		</h3>
		<form action="location_status_result2.cfm" name="form" method="post" target="_blank">
	</cfcase>
</cfswitch>
	<h2 style=" color:#F00">* FIFO Calculation Not Availiable In Location Status Calculation</h2>
	<table border="0" align="center" width="70%" class="data">
		<tr><cfoutput><input type="hidden" name="tran" id="tran" value="#target_apvend#" /><input type="hidden" name="fromto" id="fromto" value="" /></cfoutput>
			<th>Report Format</th>
            <td>
             <input type="radio" name="result" value="HTML" checked>HTML<br/>
             <input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT</td>
		</tr>
		<tr>
			<td nowrap>
				<input type="checkbox" name="include0" id="1" value="yes" checked> <label for="include0">Include 0 Figure</label>
			</td>
			
				<td nowrap>
					<input type="checkbox" name="qty0" id="2" value="yes"> <label for="include0">Include 0 Quantity</label>
                   &nbsp;&nbsp;&nbsp; <input type="checkbox" name="dodate" id="dodate" value="yes" checked> <label for="include0">According to DO Date</label>
				</td>
		
		</tr>
		<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
		<tr> 
			<th width="15%">Product From</th>
			<td width="85%">
            	<cfif getgeneral.filteritemreport eq "1">
         
				<select id="productfrom" name='productfrom'>
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
				<select name="productfrom" id="productfrom">
					<option value="">Choose a product</option>
					<cfoutput query="getitem"> 
						<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">
				</cfif>
                </cfif>
			</td>
		</tr>
		<tr> 
			<th>Product To</th>
			<td nowrap>
            <cfif getgeneral.filteritemreport eq "1">
				<select id="productto" name='productto' >
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
				<select name="productto" id="productto">
					<option value="">Choose a product</option>
					<cfoutput query="getitem"> 
						<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
					<input type="text" name="searchitemto" onKeyUp="getProduct('productto');">
				</cfif>
            </cfif>
			</td>
		</tr>
		<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr> 
			<th><cfoutput>#getgeneral.lCATEGORY#</cfoutput> From</th>
			<td>
				<select name="Catefrom" id="catefrom">
					<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
					<cfoutput query="getcate"> 
						<option value="#cate#">#cate# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcatefr" onKeyUp="getCategory('Catefrom');">
				</cfif>
			</td>
		</tr>
		<tr> 
			<th><cfoutput>#getgeneral.lCATEGORY#</cfoutput> To</th>
			<td>
				<select name="Cateto" id="cateto">
					<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
					<cfoutput query="getcate"> 
						<option value="#cate#">#cate# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcateto" onKeyUp="getCategory('Cateto');">
				</cfif>
			</td>
		</tr>
    	<tr> 
      		<td colspan="100%"><hr></td>
    	</tr>
    	<tr> 
      		<th><cfoutput>#getgeneral.lGROUP#</cfoutput> From</th>
      		<td>
				<select name="groupfrom" id="groupfrom">
          			<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          			<cfoutput query="getgroup"> 
            			<option value="#wos_group#">#wos_group# - #desp#</option>
          			</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupfr" onKeyUp="getGroup('groupfrom');">
				</cfif>
			</td>
    	</tr>
    	<tr> 
      		<th><cfoutput>#getgeneral.lGROUP#</cfoutput> To</th>
      		<td>
				<select name="groupto" id="groupto">
          			<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          			<cfoutput query="getgroup"> 
            			<option value="#wos_group#">#wos_group# - #desp#</option>
          			</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupto" onKeyUp="getGroup('groupto');">
				</cfif>
			</td>
    	</tr>
		<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr> 
			<th>Supplier From</th>
			<td>
				<select name="suppfrom" id="suppfrom">
					<option value="">Choose a Supplier</option>
					<cfoutput query="getsupp"> 
						<option value="#custno#">#custno# - #name#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppfr" onKeyUp="getSupp('suppfrom','Supplier');">
				</cfif>
			</td>
		</tr>
		<tr> 
			<th>Supplier To</th>
			<td>
				<select name="suppto" id="suppto">
					<option value="">Choose a Supplier</option>
					<cfoutput query="getsupp"> 
					<option value="#custno#">#custno# - #name#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppto" onKeyUp="getSupp('suppto','Supplier');">
				</cfif>
			</td>
		</tr>
		<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
		<tr>
			<th nowrap><cfoutput>#getgeneral.lLOCATION#</cfoutput> From</th>
			<td>
				<select name="locationfrom">
					<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          				<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
					</cfif>
					<cfoutput query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr>
			<th nowrap><cfoutput>#getgeneral.lLOCATION#</cfoutput> To</th>
			<td>
				<select name="locationto">
					<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          				<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
					</cfif>
					<cfoutput query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr> 
      		<td colspan="100%"><hr></td>
    	</tr>
		<tr> 
			<th>Period From</th>
			<td>
				<cfoutput>
				<select name="periodfrom">
					<option value="01" selected>Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="02">Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="03">Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="04">Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="05">Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="06">Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="07">Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="08">Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="09">Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="10">Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="11">Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="12">Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="13">Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="14">Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="15">Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="16">Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="17">Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="18">Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</select>
				</cfoutput>
			</td>
		</tr>
		<tr> 
			<th>Period To</th>
			<td>
				<cfoutput><select name="periodto">
					<option value="01" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="02" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="03" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="04" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="05" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="06" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="07" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="08" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="09" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="10" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="11" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="12" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="13" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="14" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="15" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="16" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="17" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="18" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</select></cfoutput>
			</td> 
		</tr>
		<tr>
      		<td colspan="100%"><hr></td>
   	 	</tr>
		<tr>
			<th>Date From</th>
      		<td>
				<input name="datefrom" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)
			</td>
		</tr>
		<tr>
			<th>Date To</th>
      		<td>
				<input name="dateto" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)
			</td>
		</tr>
		<tr>
			<td colspan="100%" align="right"><input type="Submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
</form>

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        <cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Product&fromto={fromto}" />
</body>
</html>
