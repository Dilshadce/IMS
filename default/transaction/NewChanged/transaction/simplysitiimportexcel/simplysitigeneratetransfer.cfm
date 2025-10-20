<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title><cfif hcomid eq "pnp_i">Stock Card Details<cfelse>Stock Card Report</cfif></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/stylesheet/style.css"/>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
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
	
	function validate(){
		if (document.form.period.value=='')
		{
		alert('Kindly choose a period');
		return false;
		}
		return true;
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

<!--- ADD ON 11-09-2008 AND REPLACE THE BELOW ONE --->
<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,filteritemreport,ddlitem from gsetup
</cfquery>
<!--- Add On 13-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getlocation" datasource="#dts#">
	select location,desp from iclocation order by location
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp from icitem
</cfquery>

<!--- ADD ON 090708 --->
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

<body>

<h3>
	Generate Transfer
</h3>

<cfform action="simplysitigeneratetransfer2.cfm" name="form" method="post" target="_blank" onsubmit="return validate();">


<table border="0" align="center" width="80%" class="data">
		<tr>
        <td colspan="2">
        <input type="radio" name="radio1" id="radio1" value="generateitem" checked>Generate All Items into Max Qty Table<br>
        <input type="radio" name="radio1" id="radio1" value="generatemax" checked>Generate Maximum<br>
        <input type="radio" name="radio1" id="radio1" value="generatereport">View Qty needed to do transfer<br>
        <input type="radio" name="radio1" id="radio1" value="generatetr">Generate Transfer
        </td>
        </tr>
		<tr>
      		<th width="16%">Period</th>
      		<td colspan="2">
				<cfoutput>
				<cfselect name="period" required="yes" message="Please Choose a Period" onChange="document.getElementById('wos_date').value=this.options[this.selectedIndex].title" id="period">
					<option value="" title="#dateformat(now(),'DD/MM/YYYY')#">Choose a period</option>
					<option value="01" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('00'),DE('01')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="02" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('01'),DE('02')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="03" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('02'),DE('03')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="04" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('03'),DE('04')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="05" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('04'),DE('05')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="06" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('05'),DE('06')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="07" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('06'),DE('07')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="08" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('07'),DE('08')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="09" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('08'),DE('09')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="10" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('09'),DE('10')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="11" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('10'),DE('11')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="12" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('11'),DE('12')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="13" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('12'),DE('13')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="14" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('13'),DE('14')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="15" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('14'),DE('15')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="16" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('15'),DE('16')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="17" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('16'),DE('17')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="18" title="#dateformat(dateadd('m',iif(year(dateadd('d',1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd('d',1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE('17'),DE('18')),getgeneral.lastaccyear),'dd/mm/yyyy')#">Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</cfselect>
				</cfoutput>
			</td>
    	</tr>
         <tr><td colspan="100%"><hr></td></tr>
        <tr>
        <tr>
      		<th width="16%">Date</th>
      		<td colspan="2">
				<cfoutput>
				<cfinput type="text" name="wos_date" id="wos_date" value="#dateformat(now(),'DD/MM/YYYY')#" validate="eurodate" maxlength="10" size="15"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wos_date);">DD/MM/YYYY
                </cfoutput>
			</td>
    	</tr>
         <tr><td colspan="100%"><hr></td></tr>
        <th>Location From</th>
        <td>
        <cfoutput>
        <cfselect name="locationfrom" id="locationfrom">
        <cfloop query="getlocation">
        <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
        </cfloop>
        </cfselect>
        </cfoutput>
    	</td>    
    	</tr>
        <tr>
        <th>Location To</th>
        <td>
        <cfoutput>
        <cfselect name="locationto" id="locationto">
        <cfloop query="getlocation">
        <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
        </cfloop>
        </cfselect>
        </cfoutput>
    	</td>    
    	</tr>
         <tr><td colspan="100%"><hr></td></tr>
        <tr>
        <th>Item From</th>
        <td>
        <cfoutput>
        <cfselect name="itemfrom" id="itemfrom">
        <option value="">Choose a item no</option>
        <cfloop query="getitem">
        <option value="#getitem.itemno#">#getitem.itemno# - #getitem.desp#</option>
        </cfloop>
        </cfselect>
        </cfoutput>
    	</td>    
    	</tr>
        <tr>
        <th>Item To</th>
        <td>
        <cfoutput>
        <cfselect name="itemto" id="itemto">
        <option value="">Choose a item no</option>
        <cfloop query="getitem">
        <option value="#getitem.itemno#">#getitem.itemno# - #getitem.desp#</option>
        </cfloop>
        </cfselect>
        </cfoutput>
    	</td>    
    	</tr>
        <tr><td colspan="100%"><hr></td></tr>
        <tr>
        <th>New Item Qty</th>
        <td>
        <cfinput type="text" name="newqty" id="newqty" value="0" validate="float" message="Please Key in Numbers Only">
    	</td>
        </tr>
        <tr>
        <th>Adjustment %</th>
        <td>
        <cfinput type="text" name="adjust" id="adjust" value="0" range="-100,100" message="Please Key in from -100 to 100 Only">%
    	</td>    
    
   		</tr>
    	<tr>
        <th>Default Transfer From Address</th>
        <td>
        <cfoutput>
        <cfselect name="delocationfr" id="delocationfr">
        <cfloop query="getlocation">
        <option value="#getlocation.location#" <cfif getlocation.location eq '1-WAREHOUSE'>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
        </cfloop>
        </cfselect>
        </cfoutput>
    	</td>    
    	</tr>
    <tr>
      	<td colspan='7'><div align='center'><input type="Submit" name="Submit1" value="Submit"></div></td>
    </tr>
</table>
</cfform>
</body>
</html>