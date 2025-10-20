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

<cfquery name="getgeneral" datasource="#dts#">
	select cost,lastaccyear,cost,includemisc,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,filteritemreport,ddlitem,lbrand 
	from gsetup
</cfquery>

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

<cfif getgeneral.cost eq "FIFO">

function checkpost()
{
	
	if(document.getElementById('discounted').checked == true)
	{
	form.action = "itemstatus23.cfm";
	}
	
	else
	{
	form.action = "itemstatus2.cfm";
	}
}
<cfelse>

function checkpost()
{
	if(document.getElementById('itemgroup').checked == true)
	{
	form.action = "itemstatus2group.cfm";
	}
	else
	{
	form.action = "itemstatus2.cfm";
	}
}

</cfif>
</script>

</head>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp 
	from icitem where (itemtype <> "SV" or itemtype is null) 
	order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif> 
</cfquery>

<cfquery name="getbrand" datasource="#dts#">
	select distinct(brand) 
	from icitem 
	where brand <> '' 
	order by brand ;
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
	select wos_group,desp 
	from icgroup 
	order by wos_group; 
</cfquery>

<cfquery name="getcate" datasource="#dts#">
	select cate,desp 
	from iccate 
	order by cate; 
</cfquery>

<cfquery name="getsupp" datasource="#dts#">
    select custno,name 
	from #target_apvend#
	order by custno;
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
	<cfset diffmth= DateDiff("m",getdate.LastAccDate,getdate.ThisAccDate)>
<cfelse>
	<cfset clsyear = year(getgeneral.lastaccyear)>
	<cfset clsmonth = month(getgeneral.lastaccyear)>
	<cfset thislastaccdate = "">
</cfif>
<body>
<h3>
	<a href="stock_listingmenu.cfm">Inventory Listing Menu</a> >> 
	<a><font size="2">View Item Status and Value</font></a>
</h3>

<cfif getgeneral.cost eq 'MONTH'>
<h2 style="color:#F00">*Kindly Run Calculation Of Cost By Month In Sales Report Before Runing This Report</h2>
</cfif>

<cfform action="itemstatus2.cfm" name="form" id="form" method="post" target="_blank" onsubmit="checkpost();">
	<cfoutput><input type="hidden" name="thislastaccdate" value="#thislastaccdate#"></cfoutput>
	<table border="0" align="center" width="80%" class="data">
    <tr>
			<th colspan="100%">Report Format<cfoutput><input type="hidden" name="tran" id="tran" value="#target_apvend#" /><input type="hidden" name="fromto" id="fromto" value="" /></cfoutput></th>
		</tr>
    <tr>
	  	<td nowrap>
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br/>
            <input type="radio" name="result" value="PDF">PDF
		</td>
        <td></td>
			<td nowrap>
				<input type="checkbox" name="include0" id="1" value="yes"> <label for="include0">Include 0 Figure</label>
                <input type="checkbox" name="printform" id="2" value="yes"> <label for="include0">Print Style</label>
                <input type="checkbox" name="dodate" id="dodate" value="yes" checked> <label for="include0">According to DO Date</label>
                <cfif getgeneral.cost neq "FIFO" and getgeneral.cost neq "LIFO">
                <input type="checkbox" name="qty0" id="3" value="yes"> <label for="include0">Include 0 Quantity</label>
                <input type="checkbox" name="itemgroup" id="itemgroup" value="yes"> <label for="include0" <cfif lcase(hcomid) neq "kimtron_i">checked</cfif>>Item Grouping</label>
                </cfif>
				
            <cfif getgeneral.cost eq "FIFO">

            <br/><input type="checkbox" name="fifocost" id="3" value="yes"> <label for="include0">FIFO COST</label>
            <input type="checkbox" name="discounted" id="discounted" value="yes"> <label for="include0">Discounted Cost</label>
            <input type="checkbox" name="misccost" id="misccost" value="yes" <cfif getgeneral.includemisc eq '1'>checked</cfif>> <label for="include0">With Misc Cost</label>
            
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
             <cfif getgeneral.filteritemreport eq "1">
				<select id="productfrom" name='productfrom' >
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
					<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">
				</cfif>
                </cfif>
			</td>
		</tr>
		<tr> 
			<th>Product</th>
			<td><div align="center">To</div></td>
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
				<select name="productto" id="productto">
					<option value="">Choose a product</option>
					<cfoutput query="getitem"> 
						<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchitemto" onKeyUp="getProduct('productto');">
				</cfif>
                </cfif>
			</td>
		</tr>
		<tr> 
			<td colspan="5"><hr></td>
		</tr>
		<tr> 
			<th width="16%"><cfoutput>#getgeneral.lCATEGORY#</cfoutput></th>
			<td width="5%"><div align="center">From</div></td>
			<td colspan="2">
				<select name="Catefrom" id="Catefrom">
					<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
					<cfoutput query="getcate"> 
						<option value="#cate#">#cate# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcatefr" id="searchcatefr" onKeyUp="getCategory('Catefrom');">
				</cfif>
			</td>
		</tr>
		<tr> 
			<th width="16%"><cfoutput>#getgeneral.lCATEGORY#</cfoutput></th>
			<td width="5%"><div align="center">To</div></td>
			<td colspan="2">
				<select name="Cateto" id="Cateto">
					<option value="">Choose a <cfoutput>#getgeneral.lCATEGORY#</cfoutput></option>
					<cfoutput query="getcate"> 
						<option value="#cate#">#cate# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcateto" id="searchcateto" onKeyUp="getCategory('Cateto');">
				</cfif>
			</td>
		</tr>
    	<tr> 
      		<td colspan="5"><hr></td>
    	</tr>
    	<tr> 
      		<th width="16%"><cfoutput>#getgeneral.lGROUP#</cfoutput></th>
      		<td width="5%"><div align="center">From</div></td>
      		<td colspan="2">
				<select name="groupfrom" id="groupfrom">
          			<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          			<cfoutput query="getgroup"> 
            			<option value="#wos_group#">#wos_group# - #desp#</option>
          			</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupfr" id="searchgroupfr" onKeyUp="getGroup('groupfrom');">
				</cfif>
			</td>
    	</tr>
    	<tr> 
      		<th width="16%"><cfoutput>#getgeneral.lGROUP#</cfoutput></th>
      		<td width="5%"><div align="center">To</div></td>
      		<td colspan="2">
				<select name="groupto" id="groupto">
          			<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          			<cfoutput query="getgroup"> 
            			<option value="#wos_group#">#wos_group# - #desp#</option>
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
			<th width="16%">Supplier</th>
			<td width="5%"><div align="center">From</div></td>
			<td colspan="2">
				<select name="suppfrom" id="suppfrom">
					<option value="">Choose a Supplier</option>
					<cfoutput query="getsupp"> 
						<option value="#custno#">#custno# - #name#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppfr" onKeyUp="getSupp('suppfrom','Supplier');">
				</cfif>
			</td>
		</tr>
		<tr> 
			<th width="16%">Supplier</th>
			<td width="5%"><div align="center">To</div></td>
			<td colspan="2">
				<select name="suppto" id="suppto">
					<option value="">Choose a Supplier</option>
					<cfoutput query="getsupp"> 
						<option value="#custno#">#custno# - #name#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="button" size="10" value="Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppto" onKeyUp="getSupp('suppto','Supplier');">
				</cfif>
			</td>
		</tr>
		<tr> 
			<td colspan="5"><hr></td>
		</tr>
		<tr> 
			<th width="16%"><cfoutput>#getgeneral.lbrand#</cfoutput></th>
			<td width="5%"><div align="center">From</div></td>
			<td colspan="2">
				<select name="brandfrom" id="brandfrom">
					<option value="">Choose a <cfoutput>#getgeneral.lbrand#</cfoutput></option>
					<cfoutput query="getbrand"> 
						<option value="#brand#">#brand#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr> 
			<th width="16%"><cfoutput>#getgeneral.lbrand#</cfoutput></th>
			<td width="5%"><div align="center">To</div></td>
			<td colspan="2">
				<select name="brandto" id="brandto">
					<option value="">Choose a <cfoutput>#getgeneral.lbrand#</cfoutput></option>
					<cfoutput query="getbrand"> 
						<option value="#brand#">#brand#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr> 
      		<td colspan="5"><hr></td>
    	</tr>
		<tr> 
			<th width="16%">Period</th>
			<td width="5%"><div align="center">From</div></td>
			<td colspan="2">
				<cfoutput>
				<cfif isdefined("form.lastaccdaterange") and form.lastaccdaterange neq "">
					<select name="periodfrom" id="periodfrom">
						<cfloop from="1" to="#diffmth#" index="a">
							<option value="#numberformat(a,"00")#">Period #numberformat(a,"00")# - #dateformat(dateadd('m',iif(year(dateadd("d",1,form.lastaccdaterange)) eq year(form.lastaccdaterange) and month(dateadd("d",1,form.lastaccdaterange)) eq month(form.lastaccdaterange),DE(numberformat((a-1),"00")),DE(numberformat((a),"00"))),form.lastaccdaterange),'mmm yyyy')#</option>
						</cfloop>
					</select>
				<cfelse>
					<select name="periodfrom" id="periodfrom">
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
				</cfif>
				</cfoutput>
			</td>
		</tr>
		<tr> 
			<th width="16%">Period</th>
			<td width="5%"> <div align="center">To</div></td>
			<td colspan="2">
			<cfoutput>
				<cfif isdefined("form.lastaccdaterange") and form.lastaccdaterange neq "">
					<select name="periodto" id="periodto">
						<cfloop from="1" to="#diffmth#" index="a">
							<option value="#numberformat(a,"00")#">Period #numberformat(a,"00")# - #dateformat(dateadd('m',iif(year(dateadd("d",1,form.lastaccdaterange)) eq year(form.lastaccdaterange) and month(dateadd("d",1,form.lastaccdaterange)) eq month(form.lastaccdaterange),DE(numberformat((a-1),"00")),DE(numberformat((a),"00"))),form.lastaccdaterange),'mmm yyyy')#</option>
						</cfloop>
					</select>
				<cfelse>
					<select name="periodto" id="periodto">
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
					</select>
				</cfif>
				</cfoutput>
			</td> 
		</tr>
                <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
        <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2"><cfinput type="text" name="datefrom" id="datefrom" maxlength="10" validate="eurodate" size="10">(DD/MM/YYYY)</td>
    </tr>
    <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td width="69%"><cfinput type="text" name="dateto" id="dateto" maxlength="10" validate="eurodate" size="10">(DD/MM/YYYY)&nbsp;</td>
        </tr>

		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td width="10%">
            	<input type="Submit" name="Submit" value="Submit">
            </td>
		</tr>
	</table>
</cfform>

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="/default/AjaxSearch/findCustomer.cfm?type={tran}&fromto={fromto}" />
</body>
</html>