<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Physical Worksheet Report</title>
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
			document.physical_worksheet.productfrom.options.add(myoption);
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
			document.physical_worksheet.productto.options.add(myoption);
		}
		
	}

function getItem(){
		var text = document.physical_worksheet.letter.value;
		var w = document.physical_worksheet.searchtype.selectedIndex;
		var searchtype = document.physical_worksheet.searchtype.options[w].value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
function getItem1(){
		var text = document.physical_worksheet.letter1.value;
		var w = document.physical_worksheet.searchtype1.selectedIndex;
		var searchtype = document.physical_worksheet.searchtype1.options[w].value;
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
		var inputtext = document.physical_worksheet.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.physical_worksheet.searchitemfr.value;
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
		var inputtext = document.physical_worksheet.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.physical_worksheet.searchcateto.value;
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
		var inputtext = document.physical_worksheet.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.physical_worksheet.searchgroupto.value;
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
		var inputtext = document.physical_worksheet.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.physical_worksheet.searchsuppto.value;
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
	
	if(document.physical_worksheet.Cateto.value == ""){
		document.physical_worksheet.Cateto.value = trim(document.physical_worksheet.Catefrom.value);
	}
	if(document.physical_worksheet.groupto.value == ""){
		document.physical_worksheet.groupto.value = trim(document.physical_worksheet.groupfrom.value);
	}
	if(document.physical_worksheet.productto.value == ""){
		document.physical_worksheet.productto.value = trim(document.physical_worksheet.productfrom.value);
	}
	if(document.physical_worksheet.suppto.value == ""){
		document.physical_worksheet.suppto.value = trim(document.physical_worksheet.suppfrom.value);
	}
	
	setTimeout('clearFields()', 200); 
	return true;
}

// Clear Form
function clearFields(){
	document.physical_worksheet.reset();
}

function change_link()
	{
		if(document.physical_worksheet.update_actual_qty.checked==true)
		{
			document.physical_worksheet.action="physical_worksheet_adjust.cfm";
		}
		else
		{
			document.physical_worksheet.action="physical_worksheet_result.cfm";
		}
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
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,filteritemreport,ddlitem,lbrand from gsetup
</cfquery>

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

<cfquery name="getitem" datasource="#dts#">
	select '' as itemno, 'Choose a Item' as desp
    UNION ALL
	select itemno,concat(itemno , ' - ' ,desp) as desp 
	from icitem where (itemtype <> "SV" or itemtype is null)  
	order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfquery name="getshelf" datasource="#dts#">
    select shelf,desp 
	from icshelf 
	order by shelf;
</cfquery>

<cfquery name="getProductCode" datasource="#dts#">
	SELECT aitemno, desp 
    FROM icitem 
	ORDER BY aitemno;
</cfquery>

<body>
<!--- <h1 align="center">View Physical Worksheet Report</h1> --->
<h3>
	<a href="stock_listingmenu.cfm">Inventory Listing Menu</a> >> 
	<a><font size="2">View Physical Worksheet Report</font></a>
</h3>

<cfform action="physical_worksheet_result.cfm" name="physical_worksheet" method="post" target="_blank">
<table border="0" align="center" width="70%" class="data">
	<tr>
		<th>Report Format<input type="hidden" name="fromto" id="fromto" value="" /></th>
        
	</tr>
	<tr>
		<td colspan="3" nowrap>
			<input type="checkbox" name="with_qty" id="1" value="yes" checked> WITH QUANTITY<br/>
			<input type="checkbox" name="include_stock" id="2" value="yes"> INCLUDE 0 STOCK<br/>
			<input type="checkbox" name="update_actual_qty" id="3" value="yes" onClick="change_link();"> UPDATE ACTUAL QUANTITY<br/>
			<input type="checkbox" name="generate_adjustment_transaction" id="4" value="yes"> GENERATE ADJUSTMENT TRANSACTIONS<br/>
            <input type="radio" name="result" value="HTML" checked>HTML<br/>
            <input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br/>
		</td>
	</tr>
	<tr>
      	<td colspan="3"><hr></td>
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
      	<td colspan="3"><hr></td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lCATEGORY#</cfoutput> From</th>
      	<td colspan="2">
			<select name="catefrom" id="catefrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
          		<cfoutput query="getcate">
					<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcatefr"  id="searchcatefr" onKeyUp="getCategory('catefrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lCATEGORY#</cfoutput> To</th>
      	<td colspan="2">
			<select name="cateto" id="cateto">
          		<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
          		<cfoutput query="getcate">
					<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcateto"  id="searchcateto" onKeyUp="getCategory('cateto');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="3"><hr></td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lGROUP#</cfoutput> From</th>
      	<td colspan="2">
			<select name="groupfrom"  id="groupfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup">
					<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupfr"  id="searchgroupfr" onKeyUp="getGroup('groupfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lGROUP#</cfoutput> To</th>
      	<td colspan="2">
			<select name="groupto"  id="groupto">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup">
					<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
				</cfoutput>
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
      	<th width="16%"><cfoutput>#getgeneral.lMODEL#</cfoutput> From</th>
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
      	<th width="16%"><cfoutput>#getgeneral.lMODEL#</cfoutput> To</th>
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
      	<td colspan="3"><hr></td>
    </tr>
    <tr>
      	<th width="16%">Period</th>
      	<td colspan="2">
			<select name="period" id="period" onChange="document.getElementById('date').value = this.options[this.selectedIndex].id;">
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
      	<td colspan="3"><hr></td>
    </tr>
	<th width="16%">Date</th>
      	<td colspan="2">
			<cfinput name="date" id="date" type="text" value="#dateformat(now(),'dd/mm/yyyy')#" size="11" maxlength="10" required="yes" validate="eurodate" message="Please Key In Correct Date Format !" mask="99/99/9999"> (DD/MM/YYYY)
			<font color="FF0000">Please Check Your Date With Your Selected Period !</font>
		</td>
    <tr>
      	<td align="right" colspan="3"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</cfform>
<cfwindow center="true" width="550" height="400" name="findItem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="/default/AjaxSearch/findItem.cfm?type=item&fromto={fromto}" />
        
<cfwindow center="true" width="550" height="400" name="findProduct" refreshOnShow="true"
	title="Find Product" initshow="false"
source="/default/AjaxSearch/findProduct.cfm?type=product&fromto={fromto}" />
</body>
</html>