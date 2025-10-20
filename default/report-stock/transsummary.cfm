<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Sales Report By Type</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
			document.transsummary.productfrom.options.add(myoption);
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
			document.transsummary.productto.options.add(myoption);
		}
		
	}

function getItem(){
		var text = document.transsummary.letter.value;
		var w = document.transsummary.searchtype.selectedIndex;
		var searchtype = document.transsummary.searchtype.options[w].value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
function getItem1(){
		var text = document.transsummary.letter1.value;
		var w = document.transsummary.searchtype1.selectedIndex;
		var searchtype = document.transsummary.searchtype1.options[w].value;
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
		var inputtext = document.transsummary.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.transsummary.searchitemfr.value;
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
		var inputtext = document.transsummary.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.transsummary.searchcateto.value;
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
		var inputtext = document.transsummary.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.transsummary.searchgroupto.value;
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
		var inputtext = document.transsummary.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.transsummary.searchsuppto.value;
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
	
	if(document.transsummary.Cateto.value == ""){
		document.transsummary.Cateto.value = trim(document.transsummary.Catefrom.value);
	}
	if(document.transsummary.groupto.value == ""){
		document.transsummary.groupto.value = trim(document.transsummary.groupfrom.value);
	}
	if(document.transsummary.productto.value == ""){
		document.transsummary.productto.value = trim(document.transsummary.productfrom.value);
	}
	if(document.transsummary.suppto.value == ""){
		document.transsummary.suppto.value = trim(document.transsummary.suppfrom.value);
	}
	
	setTimeout('clearFields()', 200); 
	return true;
}

// Clear Form
function clearFields(){
	document.transsummary.reset();
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

<script language="javascript" src="../../scripts/date_format.js"></script>

<cfif type eq "Quantity">
	<cfset trantype = "QUANTITY">
	
<cfelseif type eq "Value">
	<cfset trantype = "VALUE">	

</cfif>


<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,filteritemreport,ddlitem,lbrand from gsetup
</cfquery>

<cfquery name="getProductCode" datasource="#dts#">
	SELECT aitemno, desp 
    FROM icitem 
    ORDER BY aitemno;
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>


<cfif isdefined("form.lastaccdaterange") and form.lastaccdaterange neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.lastaccdaterange#
		limit 1
	</cfquery>
	<cfset clsyear = year(form.lastaccdaterange)>
	<cfset clsmonth = month(form.lastaccdaterange)>
	<cfset thislastaccdate = form.lastaccdaterange>
<cfelse>

	<cfset clsyear = year(getgeneral.lastaccyear)>
	<cfset clsmonth = month(getgeneral.lastaccyear)>
	<cfset thislastaccdate = "">
</cfif>

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

<!--- <h2>Print Transaction Summary By #trantype#</h2> --->
<cfoutput>
<h3>
	<a href="stock_listingmenu.cfm">Inventory Listing Menu</a> >> 
	<a><font size="2">Print Transaction Summary By #trantype#</font></a>
</h3>
</cfoutput>
<cfquery name="getcate" datasource="#dts#">
	select cate,desp 
    from iccate 
    order by cate
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
	select wos_group,desp 
    from icgroup 
    order by wos_group
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno, desp 
    from icitem 
    where (itemtype <> "SV" or itemtype is null) 
    order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfif type eq "Quantity">
	<cfset actionForm = 'transsummary1.cfm?trantype=#trantype#'>
<cfelseif type eq "Value">
	<cfset actionForm = 'transsummary2.cfm?trantype=#trantype#'>
</cfif>




<cfoutput>
	<cfform name="transsummary" action="#actionForm#" method="post" target="_blank">
<input type="hidden" name="thislastaccdate" value="#thislastaccdate#">

<table width="75%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr>
		<th>Report Format<input type="hidden" name="fromto" id="fromto" value="" /></th>
	</tr>
	<tr>
	  	<td nowrap>
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br/>
			<input type="radio" name="result" value="EXCELBYGROUP">EXCEL BY GROUP
		</td>
	</tr>
	<tr>
		<td nowrap><input type="checkbox" name="include0" id="1" value="yes"> <label for="include0">Include 0 Figure</label></td>
	</tr>
	<tr> 
        <td colspan="2"><hr></td>
    </tr>
    <tr>
    
      	<th width="16%">Product To</th>
      	<td colspan="2">
        <cfif getgeneral.filteritemreport eq "1">
         
				<select id="productfrom" name='productfrom'>
					<option value=''>Please Filter The Item</option>
				</select> Filter by:
				<input id="letter" name="letter" type="text" size="8" onKeyup="getItem()"> in:
             
				<select id="searchtype" name="searchtype" onChange="getItem()">
                  
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
                  
                </select>
        <cfelse>
            <cfselect name="productfrom" id="productfrom" query="getitem" value="itemno" display="desp" />
			<cfif getgeneral.filterall eq "1">
            
				<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemfr" id="searchitemfr" onKeyUp="getProduct('productfrom');">
			</cfif>
            </cfif>
            
   		</td>
    </tr>
    <tr>
      	<th>Product From</th>
      	<td colspan="2" nowrap>
         <cfif getgeneral.filteritemreport eq "1">
				<select id="productto" name='productto' >
					<option value=''>Please Filter The Item</option>
				</select> Filter by:
				<input id="letter1" name="letter1" type="text" size="8" onKeyup="getItem1()"> in:
             
				<select id="searchtype1" name="searchtype1" onChange="getItem1()">
                
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
				
				</select>
                <cfelse>
			<cfselect name="productto" id="productto" query="getitem" value="itemno" display="desp" />
			<cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemto" id="searchitemto" onKeyUp="getProduct('productto');">
			</cfif>
            </cfif>		</td>
    </tr>
    <tr> 
    	<td colspan="2"><hr></td>
    </tr>
	<tr> 
    	<th>#getgeneral.lCATEGORY# From</th>
        <td>
        	<select name="catefrom" id="catefrom">
				<option value="">Choose a #getgeneral.lCATEGORY#</option>
				<cfloop query="getcate">
					<option value="#cate#">#cate# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcatefr" id="searchcatefr" onKeyUp="getCategory('catefrom');">
			</cfif>
		</td>
    </tr>
    <tr> 
        <th>#getgeneral.lCATEGORY# To</th>
        <td>
        	<select name="cateto" id="cateto">
				<option value="">Choose a #getgeneral.lCATEGORY#</option>
				<cfloop query="getcate">
				<option value="#cate#">#cate# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcateto" id="searchcateto" onKeyUp="getCategory('cateto');">
			</cfif>
		</td>
    </tr>
    <tr> 
    	<td colspan="2"><hr></td>
    </tr>
    <tr> 
        <th>#getgeneral.lGROUP# From</th>
        <td>
        	<select name="groupfrom" id="groupfrom">
				<option value="">Choose a #getgeneral.lGROUP#</option>
				<cfloop query="getgroup">
				<option value="#wos_group#">#wos_group# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupfr" id="searchgroupfr" onKeyUp="getGroup('groupfrom');">
			</cfif>
		</td>
	</tr>
    <tr> 
        <th>#getgeneral.lGROUP# To</th>
        <td>
        	<select name="groupto" id="groupto">
				<option value="">Choose a #getgeneral.lGROUP#</option>
				<cfloop query="getgroup">
				<option value="#wos_group#">#wos_group# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupto" id="searchgroupto" onKeyUp="getGroup('groupto');">
			</cfif>
		</td>
	</tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
   
    <tr> 
        <th>Period From</th>
        <td>
        	<select name="periodfrom" id="periodfrom" onChange="displaymonth()">
                <option value="">Choose a Period</option>
                <option value="01"selected>1</option>
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
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
			</select>&nbsp;
            <input type="text" name="monthfrom" id="monthfrom" value="#vmonth#" size="6" readonly>
		</td>
    </tr>
    <tr> 
        <th>Period To</th>
        <td>
        	<select name="periodto" id="periodto" onChange="displaymonth()">
                <option value="">Choose a Period</option>
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
                <option value="12"selected>12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
			</select>&nbsp;
            <input type="text" name="monthto"  id="monthto" value="#vmonthto#" size="6" readonly>
		</td>
	</tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
    <tr> 
        <th>Date From</th>
        <td><input type="text" name="datefrom" id="datefrom" maxlength="10" size="11"> (DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Date To</th>
        <td><input type="text" name="dateto" id="dateto" maxlength="10" size="11"> (DD/MM/YYYY)</td>
    </tr>
	<tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>


</cfform>
</cfoutput>

<cfoutput>
<script language="JavaScript">
	function displaymonth(){
	
	if(document.transsummary.periodfrom.value=="")
	{	document.transsummary.periodto.value = "";}
	
	if(document.transsummary.periodfrom.value=='01')		
	{	document.transsummary.monthfrom.value='#vmonthto1#'; }
		
	else if(document.transsummary.periodfrom.value=='02')	
	{	document.transsummary.monthfrom.value='#vmonthto2#'; }
	
	else if(document.transsummary.periodfrom.value=='03')	
	{	document.transsummary.monthfrom.value='#vmonthto3#'; }
	
	else if(document.transsummary.periodfrom.value=='04')	
	{	document.transsummary.monthfrom.value='#vmonthto4#'; }
	
	else if(document.transsummary.periodfrom.value=='05')	
	{	document.transsummary.monthfrom.value='#vmonthto5#'; }
	
	else if(document.transsummary.periodfrom.value=='06')	
	{	document.transsummary.monthfrom.value='#vmonthto6#'; }
	
	else if(document.transsummary.periodfrom.value=='07')	
	{	document.transsummary.monthfrom.value='#vmonthto7#'; }
	
	else if(document.transsummary.periodfrom.value=='08')	
	{	document.transsummary.monthfrom.value='#vmonthto8#'; }
	
	else if(document.transsummary.periodfrom.value=='09')	
	{	document.transsummary.monthfrom.value='#vmonthto9#'; }
	
	else if(document.transsummary.periodfrom.value=='10')	
	{	document.transsummary.monthfrom.value='#vmonthto10#'; }
	
	else if(document.transsummary.periodfrom.value=='11')	
	{	document.transsummary.monthfrom.value='#vmonthto11#'; }
	
	else if(document.transsummary.periodfrom.value=='12')	
	{	document.transsummary.monthfrom.value='#vmonthto12#'; }
	
	else if(document.transsummary.periodfrom.value=='13')	
	{	document.transsummary.monthfrom.value='#vmonthto13#'; }
	
	else if(document.transsummary.periodfrom.value=='14')	
	{	document.transsummary.monthfrom.value='#vmonthto14#'; }
	
	else if(document.transsummary.periodfrom.value=='15')	
	{	document.transsummary.monthfrom.value='#vmonthto15#'; }
	
	else if(document.transsummary.periodfrom.value=='16')	
	{	document.transsummary.monthfrom.value='#vmonthto16#'; }
	
	else if(document.transsummary.periodfrom.value=='17')	
	{	document.transsummary.monthfrom.value='#vmonthto17#'; }
	
	else if(document.transsummary.periodfrom.value=='18')	
	{	document.transsummary.monthfrom.value='#vmonthto18#'; }
	
	if(document.transsummary.periodto.value=='01')		
	{	document.transsummary.monthto.value='#vmonthto1#'; }
		
	else if(document.transsummary.periodto.value=='02')	
	{	document.transsummary.monthto.value='#vmonthto2#'; }
	
	else if(document.transsummary.periodto.value=='03')	
	{	document.transsummary.monthto.value='#vmonthto3#'; }
	
	else if(document.transsummary.periodto.value=='04')	
	{	document.transsummary.monthto.value='#vmonthto4#'; }
	
	else if(document.transsummary.periodto.value=='05')	
	{	document.transsummary.monthto.value='#vmonthto5#'; }
	
	else if(document.transsummary.periodto.value=='06')	
	{	document.transsummary.monthto.value='#vmonthto6#'; }
	
	else if(document.transsummary.periodto.value=='07')	
	{	document.transsummary.monthto.value='#vmonthto7#'; }
	
	else if(document.transsummary.periodto.value=='08')	
	{	document.transsummary.monthto.value='#vmonthto8#'; }
	
	else if(document.transsummary.periodto.value=='09')	
	{	document.transsummary.monthto.value='#vmonthto9#'; }
	
	else if(document.transsummary.periodto.value=='10')	
	{	document.transsummary.monthto.value='#vmonthto10#'; }
	
	else if(document.transsummary.periodto.value=='11')	
	{	document.transsummary.monthto.value='#vmonthto11#'; }
	
	else if(document.transsummary.periodto.value=='12')	
	{	document.transsummary.monthto.value='#vmonthto12#'; }
	
	else if(document.transsummary.periodto.value=='13')	
	{	document.transsummary.monthto.value='#vmonthto13#'; }
	
	else if(document.transsummary.periodto.value=='14')	
	{	document.transsummary.monthto.value='#vmonthto14#'; }
	
	else if(document.transsummary.periodto.value=='15')	
	{	document.transsummary.monthto.value='#vmonthto15#'; }
	
	else if(document.transsummary.periodto.value=='16')	
	{	document.transsummary.monthto.value='#vmonthto16#'; }
	
	else if(document.transsummary.periodto.value=='17')	
	{	document.transsummary.monthto.value='#vmonthto17#'; }
	
	else if(document.transsummary.periodto.value=='18')	
	{	document.transsummary.monthto.value='#vmonthto18#'; }
	
	}
</script>
</cfoutput>
        
<cfwindow center="true" width="550" height="400" name="findItem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="/default/AjaxSearch/findItem.cfm?type=item&fromto={fromto}" />
        
<cfwindow center="true" width="550" height="400" name="findProduct" refreshOnShow="true"
	title="Find Product" initshow="false"
source="/default/AjaxSearch/findProduct.cfm?type=product&fromto={fromto}" />
</body>
</html>