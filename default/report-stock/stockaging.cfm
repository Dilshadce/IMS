<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Stock Aging Report</title>
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
			document.stockaging.productfrom.options.add(myoption);
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
			document.stockaging.productto.options.add(myoption);
		}
		
	}

function getItem(){
		var text = document.stockaging.letter.value;
		var w = document.stockaging.searchtype.selectedIndex;
		var searchtype = document.stockaging.searchtype.options[w].value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
function getItem1(){
		var text = document.stockaging.letter1.value;
		var w = document.stockaging.searchtype1.selectedIndex;
		var searchtype = document.stockaging.searchtype1.options[w].value;
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
		var inputtext = document.stockaging.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.stockaging.searchitemfr.value;
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
		var inputtext = document.stockaging.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.stockaging.searchcateto.value;
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
		var inputtext = document.stockaging.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.stockaging.searchgroupto.value;
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
		var inputtext = document.stockaging.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.stockaging.searchsuppto.value;
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
	
	if(document.stockaging.Cateto.value == ""){
		document.stockaging.Cateto.value = trim(document.stockaging.Catefrom.value);
	}
	if(document.stockaging.groupto.value == ""){
		document.stockaging.groupto.value = trim(document.stockaging.groupfrom.value);
	}
	if(document.stockaging.productto.value == ""){
		document.stockaging.productto.value = trim(document.stockaging.productfrom.value);
	}
	if(document.stockaging.suppto.value == ""){
		document.stockaging.suppto.value = trim(document.stockaging.suppfrom.value);
	}
	
	setTimeout('clearFields()', 200); 
	return true;
}

// Clear Form
function clearFields(){
	document.stockaging.reset();
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

<!--- Add On 13-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getcate" datasource="#dts#">
    select cate,desp from iccate order by cate
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
	select wos_group, desp from icgroup order by wos_group
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select "" as itemno, "Choose a Product" as desp union all
	select itemno,concat(itemno," - ",desp) as desp from icitem where (itemtype <> 'SV' or itemtype is null)  order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfquery name="getProductCode" datasource="#dts#">
	SELECT aitemno, desp 
    FROM icitem 
    ORDER BY aitemno;
</cfquery>

<cfquery name="getsupp" datasource="#dts#">
    select custno,name from #target_apvend# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,filteritemreport,ddlitem,lbrand from gsetup
</cfquery>

<cfset clsyear = year(getgeneral.lastaccyear)>
<cfset clsmonth = month(getgeneral.lastaccyear)>
<!--- period default --->
<cfset newmonth = clsmonth + 1>

<cfif newmonth gt 12>
	<cfset newmonth = newmonth - 12>
	<cfset newyear = clsyear + 1>
<cfelse>
	<cfset newyear = clsyear>
</cfif>

<cfset newdate = CreateDate(newyear, newmonth, newmonth)>
<cfset vmonth = dateformat(newdate,"mmm yy")>
<cfset xnewmonth = newmonth + 11>

<cfif xnewmonth gt 12>
	<cfset xnewmonth = xnewmonth - 12>
	<cfset xnewyear = newyear + 1>
<cfelse>
	<cfset xnewyear = newyear>
</cfif>

<cfset xnewdate = CreateDate(xnewyear, xnewmonth, xnewmonth)>
<cfset vmonthto = dateformat(xnewdate,"mmm yy")>
<!--- period 1 --->
<cfset newmonth1 = clsmonth + 1>

<cfif newmonth1 gt 12>
	<cfset newmonth1 = newmonth1 - 12>
	<cfset newyear1 = clsyear + 1>
<cfelse>
	<cfset newyear1 = clsyear>
</cfif>

<cfset newdate1 = CreateDate(newyear1, newmonth1, newmonth1)>
<cfset vmonthto1 = dateformat(newdate1,"mmm yy")>
<!--- period 2 --->
<cfset newmonth2 = clsmonth + 2>

<cfif newmonth2 gt 12>
	<cfset newmonth2 = newmonth2 - 12>
	<cfset newyear2 = clsyear + 1>
<cfelse>
	<cfset newyear2 = clsyear>
</cfif>

<cfset newdate2 = CreateDate(newyear2, newmonth2, newmonth2)>
<cfset vmonthto2 = dateformat(newdate2,"mmm yy")>
<!--- period 3 --->
<cfset newmonth3 = clsmonth + 3>

<cfif newmonth3 gt 12>
	<cfset newmonth3 = newmonth3 - 12>
	<cfset newyear3= clsyear + 1>
<cfelse>
	<cfset newyear3 = clsyear>
</cfif>

<cfset newdate3 = CreateDate(newyear3, newmonth3, newmonth3)>
<cfset vmonthto3 = dateformat(newdate3,"mmm yy")>
<!--- period 4--->
<cfset newmonth4 = clsmonth + 4>

<cfif newmonth4 gt 12>
	<cfset newmonth4 = newmonth4 - 12>
	<cfset newyear4= clsyear + 1>
<cfelse>
	<cfset newyear4 = clsyear>
</cfif>

<cfset newdate4 = CreateDate(newyear4, newmonth4, newmonth4)>
<cfset vmonthto4 = dateformat(newdate4,"mmm yy")>
<!--- period 5--->
<cfset newmonth5 = clsmonth + 5>

<cfif newmonth5 gt 12>
	<cfset newmonth5 = newmonth5 - 12>
	<cfset newyear5= clsyear + 1>
<cfelse>
	<cfset newyear5 = clsyear>
</cfif>

<cfset newdate5 = CreateDate(newyear5, newmonth5, newmonth5)>
<cfset vmonthto5 = dateformat(newdate5,"mmm yy")>
<!--- period 6--->
<cfset newmonth6 = clsmonth + 6>

<cfif newmonth6 gt 12>
	<cfset newmonth6 = newmonth6 - 12>
	<cfset newyear6= clsyear + 1>
<cfelse>
	<cfset newyear6 = clsyear>
</cfif>

<cfset newdate6 = CreateDate(newyear6, newmonth6, newmonth6)>
<cfset vmonthto6 = dateformat(newdate6,"mmm yy")>
<!--- period 7--->
<cfset newmonth7 = clsmonth + 7>

<cfif newmonth7 gt 12>
	<cfset newmonth7 = newmonth7 - 12>
	<cfset newyear7= clsyear + 1>
<cfelse>
	<cfset newyear7 = clsyear>
</cfif>

<cfset newdate7 = CreateDate(newyear7, newmonth7, newmonth7)>
<cfset vmonthto7 = dateformat(newdate7,"mmm yy")>
<!--- period 8--->
<cfset newmonth8 = clsmonth + 8>

<cfif newmonth8 gt 12>
	<cfset newmonth8 = newmonth8 - 12>
	<cfset newyear8= clsyear + 1>
<cfelse>
	<cfset newyear8 = clsyear>
</cfif>

<cfset newdate8 = CreateDate(newyear8, newmonth8, newmonth8)>
<cfset vmonthto8 = dateformat(newdate8,"mmm yy")>
<!--- period 9--->
<cfset newmonth9 = clsmonth + 9>

<cfif newmonth9 gt 12>
	<cfset newmonth9 = newmonth9 - 12>
	<cfset newyear9= clsyear + 1>
<cfelse>
	<cfset newyear9 = clsyear>
</cfif>

<cfset newdate9 = CreateDate(newyear9, newmonth9, newmonth9)>
<cfset vmonthto9 = dateformat(newdate9,"mmm yy")>
<!--- period 10--->
<cfset newmonth10 = clsmonth + 10>

<cfif newmonth10 gt 12>
	<cfset newmonth10 = newmonth10 - 12>
	<cfset newyear10= clsyear + 1>
<cfelse>
	<cfset newyear10 = clsyear>
</cfif>

<cfset newdate10 = CreateDate(newyear10, newmonth10, newmonth10)>
<cfset vmonthto10 = dateformat(newdate10,"mmm yy")>
<!--- period 11--->
<cfset newmonth11 = clsmonth + 11>

<cfif newmonth11 gt 12>
	<cfset newmonth11 = newmonth11 - 12>
	<cfset newyear11= clsyear + 1>
<cfelse>
	<cfset newyear11 = clsyear>
</cfif>

<cfset newdate11 = CreateDate(newyear11, newmonth11, newmonth11)>
<cfset vmonthto11 = dateformat(newdate11,"mmm yy")>
<!--- period 12--->
<cfset newmonth12 = clsmonth + 12>

<cfif newmonth12 gt 12>
	<cfset newmonth12 = newmonth12 - 12>
	<cfset newyear12= clsyear + 1>
<cfelse>
	<cfset newyear12 = clsyear>
</cfif>

<cfset newdate12 = CreateDate(newyear12, newmonth12, newmonth12)>
<cfset vmonthto12 = dateformat(newdate12,"mmm yy")>
<!--- period 13--->
<cfset newmonth13 = clsmonth + 13>

<cfif newmonth13 gt 24>
	<cfset newmonth13 = newmonth13 - 24>
	<cfset newyear13= clsyear + 2>
<cfelseif newmonth13 gt 12>
	<cfset newmonth13 = newmonth13 - 12>
	<cfset newyear13= clsyear + 1>
<cfelse>
	<cfset newyear13 = clsyear>
</cfif>

<cfset newdate13 = CreateDate(newyear13, newmonth13, newmonth13)>
<cfset vmonthto13 = dateformat(newdate13,"mmm yy")>
<!--- period 14--->
<cfset newmonth14 = clsmonth + 14>

<cfif newmonth14 gt 24>
	<cfset newmonth14 = newmonth14 - 24>
	<cfset newyear14= clsyear + 2>
<cfelseif newmonth14 gt 12>
	<cfset newmonth14 = newmonth14 - 12>
	<cfset newyear14= clsyear + 1>
<cfelse>
	<cfset newyear14 = clsyear>
</cfif>

<cfset newdate14 = CreateDate(newyear14, newmonth14, newmonth14)>
<cfset vmonthto14 = dateformat(newdate14,"mmm yy")>
<!--- period 15--->
<cfset newmonth15 = clsmonth + 15>

<cfif newmonth15 gt 24>
	<cfset newmonth15 = newmonth15 - 24>
	<cfset newyear15= clsyear + 2>
<cfelseif newmonth15 gt 12>
	<cfset newmonth15 = newmonth15 - 12>
	<cfset newyear15= clsyear + 1>
<cfelse>
	<cfset newyear15 = clsyear>
</cfif>

<cfset newdate15 = CreateDate(newyear15, newmonth15, newmonth15)>
<cfset vmonthto15 = dateformat(newdate15,"mmm yy")>
<!--- period 16--->
<cfset newmonth16 = clsmonth + 16>

<cfif newmonth16 gt 24>
	<cfset newmonth16 = newmonth16 - 24>
	<cfset newyear16= clsyear + 2>
<cfelseif newmonth16 gt 12>
	<cfset newmonth16 = newmonth16 - 12>
	<cfset newyear16= clsyear + 1>
<cfelse>
	<cfset newyear16 = clsyear>
</cfif>

<cfset newdate16 = CreateDate(newyear16, newmonth16, newmonth16)>
<cfset vmonthto16 = dateformat(newdate16,"mmm yy")>
<!--- period 17--->
<cfset newmonth17 = clsmonth + 17>

<cfif newmonth17 gt 24>
	<cfset newmonth17 = newmonth17 - 24>
	<cfset newyear17= clsyear + 2>
<cfelseif newmonth17 gt 12>
	<cfset newmonth17 = newmonth17 - 12>
	<cfset newyear17= clsyear + 1>
<cfelse>
	<cfset newyear17 = clsyear>
</cfif>

<cfset newdate17 = CreateDate(newyear17, newmonth17, newmonth17)>
<cfset vmonthto17 = dateformat(newdate17,"mmm yy")>
<!--- period 18--->
<cfset newmonth18 = clsmonth + 18>

<cfif newmonth18 gt 24>
	<cfset newmonth18 = newmonth18 - 24>
	<cfset newyear18= clsyear + 2>
<cfelseif newmonth18 gt 12>
	<cfset newmonth18 = newmonth18 - 12>
	<cfset newyear18= clsyear + 1>
<cfelse>
	<cfset newyear18 = clsyear>
</cfif>

<cfset newdate18 = CreateDate(newyear18, newmonth18, newmonth18)>
<cfset vmonthto18 = dateformat(newdate18,"mmm yy")>

<body>
<!--- <h1 align="center">View Stock Aging Report</h1> --->
<h3>
	<a href="stock_listingmenu.cfm">Inventory Listing Menu</a> >> 
	<a><font size="2">View Stock Aging Report</font></a>
</h3>
<cfform action="stockaging1.cfm" name="stockaging" id="stockaging" method="post" target="_blank">
<table border="0" align="center" width="70%" class="data">
	<tr>
		<th>Report Format<cfoutput><input type="hidden" name="tran" id="tran" value="#target_apvend#" /><input type="hidden" name="fromto" id="fromto" value="" /></cfoutput></th>
	</tr>
	<tr>
		<td nowrap>
			<input type="checkbox" name="include0" id="1" value="yes"> <label for="include0">Include 0 Figure</label><br/><br/>
			<input type="radio" name="view" value="view6" checked> View - 6 Columns<br/>
			<input type="radio" name="view" value="view12"> View - 12 Columns<br/><br/>
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
		<td nowrap>
			<input type="radio" name="type" value="bymonth" checked> By Month<br/>
			<input type="radio" name="type" value="byyear" disabled> By Year<br/><br/><br/><br/><br/><br/>
			<input type="checkbox" name="includeCategory" id="1" value="yes"> <label for="includeCategory">Include Category</label>
            <input type="checkbox" name="recalculateinout" id="1" value="yes"> <label for="recalculateinout">Recaulculate In/Out Figure</label>
		</td>
	</tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
     <tr>
    
      	<th width="16%">Product From</th>
      	<td colspan="2">
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
            <cfselect name="productfrom" id="productfrom" query="getitem" value="itemno" display="desp" />
			<cfif getgeneral.filterall eq "1">
            
				<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemfr" id="searchitemfr" onKeyUp="getProduct('productfrom');">
			</cfif>
            </cfif>
            
   		</td>
    </tr>
    <tr>
      	<th>Product To</th>
      	<td colspan="2" nowrap>
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
			<cfselect name="productto" id="productto" query="getitem" value="itemno" display="desp" />
			<cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemto" id="searchitemto" onKeyUp="getProduct('productto');">
			</cfif>
            </cfif>		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lCATEGORY#</cfoutput> From</th>
      	<td colspan="2">
			<select name="catefrom" id="catefrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
          		<cfoutput query="getcate"><option value="#cate#">#cate# - #desp#</option></cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcatefr"  id="searchcatefr" onKeyUp="getCategory('catefrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lCATEGORY#</cfoutput> To</th>
      	<td colspan="2">
			<select name="cateto" id="cateto">
          		<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
          		<cfoutput query="getcate"><option value="#cate#">#cate# - #desp#</option></cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcateto"  id="searchcateto" onKeyUp="getCategory('cateto');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lGROUP#</cfoutput> From</th>
      	<td colspan="2">
			<select name="groupfrom" id="groupfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup"><option value="#wos_group#">#wos_group#</option></cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupfr" id="searchgroupfr" onKeyUp="getGroup('groupfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th><cfoutput>#getgeneral.lGROUP#</cfoutput> To</th>
      	<td colspan="2">
			<select name="groupto" id="groupto">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup"><option value="#wos_group#">#wos_group#</option></cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupto" id="searchgroupto" onKeyUp="getGroup('groupto');">
			</cfif>
		</td>
    </tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th>Supplier From</th>
      	<td colspan="2">
			<select name="suppfrom" id="suppfrom">
          		<option value="">Choose a Supplier</option>
          		<cfoutput query="getsupp"><option value="#custno#">#custno# - #name#</option></cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppfr"  id="searchsuppfr" onKeyUp="getSupp('suppfrom','Supplier');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>Supplier To</th>
      	<td colspan="2">
			<select name="suppto" id="suppto">
          		<option value="">Choose a Supplier</option>
          		<cfoutput query="getsupp"><option value="#custno#">#custno# - #name#</option></cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppto" id="searchsuppto" onKeyUp="getSupp('suppto','Supplier');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th>Period To</th>
      	<td colspan="2">
			<select name="periodto" id="periodto"  onChange="displaymonth()">	
          	<option value="01">1</option>
          	<option value="02">2</option>
          	<option value="03">3</option>
          	<option value="04">4</option>
          	<option value="05">5</option>
          	<option value="06">6</option>
          	<option value="07">7</option>
         	<option value="08">8</option>
         	<option value="09">9</option>
         	<option value="10">10</option>
          	<option value="11">11</option>
          	<option value="12" selected>12</option>
          	<option value="13">13</option>
          	<option value="14">14</option>
          	<option value="15">15</option>
          	<option value="16">16</option>
          	<option value="17">17</option>
          	<option value="18">18</option>
        	</select>&nbsp;<input type="text" name="monthto"  id="monthto" value="<cfoutput>#vmonthto#</cfoutput>" size="6" readonly>
		</td>
    </tr>
    <tr>
      	<td align="right" colspan="3"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</cfform>

<cfoutput>
<script language="JavaScript">
	function displaymonth(){
	if(document.stockaging.periodto.value=='')
	{	document.stockaging.monthto.value='';}

	if(document.stockaging.periodto.value=='01')
	{	document.stockaging.monthto.value='#vmonthto1#'; }

	else if(document.stockaging.periodto.value=='02')
	{	document.stockaging.monthto.value='#vmonthto2#'; }

	else if(document.stockaging.periodto.value=='03')
	{	document.stockaging.monthto.value='#vmonthto3#'; }

	else if(document.stockaging.periodto.value=='04')
	{	document.stockaging.monthto.value='#vmonthto4#'; }

	else if(document.stockaging.periodto.value=='05')
	{	document.stockaging.monthto.value='#vmonthto5#'; }

	else if(document.stockaging.periodto.value=='06')
	{	document.stockaging.monthto.value='#vmonthto6#'; }

	else if(document.stockaging.periodto.value=='07')
	{	document.stockaging.monthto.value='#vmonthto7#'; }

	else if(document.stockaging.periodto.value=='08')
	{	document.stockaging.monthto.value='#vmonthto8#'; }

	else if(document.stockaging.periodto.value=='09')
	{	document.stockaging.monthto.value='#vmonthto9#'; }

	else if(document.stockaging.periodto.value=='10')
	{	document.stockaging.monthto.value='#vmonthto10#'; }

	else if(document.stockaging.periodto.value=='11')
	{	document.stockaging.monthto.value='#vmonthto11#'; }

	else if(document.stockaging.periodto.value=='12')
	{	document.stockaging.monthto.value='#vmonthto12#'; }

	else if(document.stockaging.periodto.value=='13')
	{	document.stockaging.monthto.value='#vmonthto13#'; }

	else if(document.stockaging.periodto.value=='14')
	{	document.stockaging.monthto.value='#vmonthto14#'; }

	else if(document.stockaging.periodto.value=='15')
	{	document.stockaging.monthto.value='#vmonthto15#'; }

	else if(document.stockaging.periodto.value=='16')
	{	document.stockaging.monthto.value='#vmonthto16#'; }

	else if(document.stockaging.periodto.value=='17')
	{	document.stockaging.monthto.value='#vmonthto17#'; }

	else if(document.stockaging.periodto.value=='18')
	{	document.stockaging.monthto.value='#vmonthto18#'; }

	}
</script>
</cfoutput>

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="/default/AjaxSearch/findCustomer.cfm?type={tran}&fromto={fromto}" />
        
<cfwindow center="true" width="550" height="400" name="findItem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="/default/AjaxSearch/findItem.cfm?type=item&fromto={fromto}" />
        
<cfwindow center="true" width="550" height="400" name="findProduct" refreshOnShow="true"
	title="Find Product" initshow="false"
source="/default/AjaxSearch/findProduct.cfm?type=product&fromto={fromto}" />
</body>
</html>
