<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid from gsetup
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getcate" datasource="#dts#">
	select cate,desp from iccate order by cate
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
	select wos_group,desp from icgroup order by wos_group
</cfquery>

<cfquery name="getaddress" datasource="#dts#">
	select code,name from address order by code
</cfquery>

<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>
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
<!--- <cfquery name="getcust" datasource="#dts#">
	select custno, name from #target_arcust# order by custno
</cfquery> --->
<cfquery name="getcust" datasource="#dts#">
	select custno, name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
</cfquery> 

<cfquery name="getarea" datasource="#dts#">
	select * from icarea order by area
</cfquery>

<cfoutput>
<cfloop from="1" to="18" index="i">
<cfinvoke component="CFC.Date" method="getAppDateByPeriod" dts="#dts#" inputPeriod="#i#" returnvariable="newdate"/>
<cfset "vmonthto#i#" = dateformat(newdate,"mmm yy")>
</cfloop>
</cfoutput>

<html>
<head>
	<title>Cust/Supp/Agent/Area Item Report By Type</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link href="../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	
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
		var inputtext = document.itemsales.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.itemsales.searchitemfr.value;
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
		var inputtext = document.itemsales.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.itemsales.searchcateto.value;
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
		var inputtext = document.itemsales.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.itemsales.searchgroupto.value;
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
	if(type == 'custfrom'){
		var inputtext = document.itemsales.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.itemsales.searchsuppto.value;
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

<script src="../../scripts/CalendarControl.js" language="javascript"></script>
<cfoutput>
<script language="JavaScript">
function displaymonth(){
	var pfrom=document.itemsales.periodfrom.value;
	var pto=document.itemsales.periodto.value;
	
	if(pfrom==""){document.itemsales.monthfrom.value="";}
	else if(pfrom=='01'){   document.itemsales.monthfrom.value='#vmonthto1#'; }
	else if(pfrom=='02'){   document.itemsales.monthfrom.value='#vmonthto2#'; }
	else if(pfrom=='03'){	document.itemsales.monthfrom.value='#vmonthto3#'; }
	else if(pfrom=='04'){	document.itemsales.monthfrom.value='#vmonthto4#'; }
	else if(pfrom=='05'){	document.itemsales.monthfrom.value='#vmonthto5#'; }
	else if(pfrom=='06'){	document.itemsales.monthfrom.value='#vmonthto6#'; }
	else if(pfrom=='07'){	document.itemsales.monthfrom.value='#vmonthto7#'; }
	else if(pfrom=='08'){	document.itemsales.monthfrom.value='#vmonthto8#'; }
	else if(pfrom=='09'){	document.itemsales.monthfrom.value='#vmonthto9#'; }
	else if(pfrom=='10'){	document.itemsales.monthfrom.value='#vmonthto10#'; }
	else if(pfrom=='11'){	document.itemsales.monthfrom.value='#vmonthto11#'; }
	else if(pfrom=='12'){	document.itemsales.monthfrom.value='#vmonthto12#'; }
	else if(pfrom=='13'){	document.itemsales.monthfrom.value='#vmonthto13#'; }
	else if(pfrom=='14'){	document.itemsales.monthfrom.value='#vmonthto14#'; }
	else if(pfrom=='15'){	document.itemsales.monthfrom.value='#vmonthto15#'; }
	else if(pfrom=='16'){	document.itemsales.monthfrom.value='#vmonthto16#'; }
	else if(pfrom=='17'){	document.itemsales.monthfrom.value='#vmonthto17#'; }
	else if(pfrom=='18'){	document.itemsales.monthfrom.value='#vmonthto18#'; }
	
	if(pto==""){document.itemsales.monthto.value="";}
	else if(pto=='01')	{	document.itemsales.monthto.value='#vmonthto1#'; }
	else if(pto=='02'){	document.itemsales.monthto.value='#vmonthto2#'; }
	else if(pto=='03'){	document.itemsales.monthto.value='#vmonthto3#'; }
	else if(pto=='04'){	document.itemsales.monthto.value='#vmonthto4#'; }
	else if(pto=='05'){	document.itemsales.monthto.value='#vmonthto5#'; }
	else if(pto=='06'){	document.itemsales.monthto.value='#vmonthto6#'; }
	else if(pto=='07'){	document.itemsales.monthto.value='#vmonthto7#'; }
	else if(pto=='08'){	document.itemsales.monthto.value='#vmonthto8#'; }
	else if(pto=='09'){	document.itemsales.monthto.value='#vmonthto9#'; }
	else if(pto=='10'){	document.itemsales.monthto.value='#vmonthto10#'; }
	else if(pto=='11'){	document.itemsales.monthto.value='#vmonthto11#'; }
	else if(pto=='12'){	document.itemsales.monthto.value='#vmonthto12#'; }
	else if(pto=='13'){	document.itemsales.monthto.value='#vmonthto13#'; }
	else if(pto=='14'){	document.itemsales.monthto.value='#vmonthto14#'; }
	else if(pto=='15'){	document.itemsales.monthto.value='#vmonthto15#'; }
	else if(pto=='16'){	document.itemsales.monthto.value='#vmonthto16#'; }
	else if(pto=='17'){	document.itemsales.monthto.value='#vmonthto17#'; }
	else if(pto=='18'){	document.itemsales.monthto.value='#vmonthto18#'; }
}
</script>
</cfoutput>

<body>
<cfoutput>

<cfswitch expression="#type#">
	<cfcase value="customerproducttype">
		<cfset trantype = "CUSTOMER - PRODUCT SALES">
		<form name="itemsales" action="itemtype1.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	</cfcase>
	
	<cfcase value="productcustomertype">
		<cfset trantype = "PRODUCT - CUSTOMER SALES">
		<form name="itemsales" action="itemtype2.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	</cfcase>
	
	<cfcase value="agentproducttype">
		<cfset trantype = "AGENT - PRODUCT SALES">
		<form name="itemsales" action="itemtype3.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	</cfcase>
    <cfcase value="areacatetype">
		<cfset trantype = "AREA - CATEGORY SALES">
		<form name="itemsales" action="itemtype4.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	</cfcase>
    <cfcase value="headquaterproducttype">
		<cfset trantype = "HEADQUATER - PRODUCT SALES">
		<form name="itemsales" action="itemtype5.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	</cfcase>
    <cfcase value="addressproducttype">
		<cfset trantype = "ADDRESS - PRODUCT SALES">
		<form name="itemsales" action="itemtype6.cfm?trantype=#trantype#&alown=#alown#" method="post" target="_blank">
	</cfcase>
</cfswitch>

<!--- <h2>Print #trantype# Report By Type</h2> --->
<h3>
	<a href="itemreportmenu.cfm">Cust/Supp/Agent/Area Item Report Menu</a> >> 
	<a><font size="2">Print #trantype# Report By Type</font></a>
</h3>

<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">

<input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />
	<tr>
		<th>Report Format</th>
		<td>
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	</tr>
    <tr><td colspan="2"><hr></td></tr>
    <tr>
		<th>List FOC</th>
		<td>
			<input type="checkbox" name="foc" value="foc">List FOC
		</td>
	</tr>
	<tr><td colspan="2"><hr></td></tr>
	<tr> 
        <th>#getgeneral.lAGENT# From</th>
        <td><select name="agentfrom">
				<option value="">Choose an #getgeneral.lAGENT#</option>
				<cfloop query="getagent"><option value="#agent#">#agent# - #desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>
    <tr> 
        <th>#getgeneral.lAGENT# To</th>
        <td><select name="agentto">
				<option value="">Choose an #getgeneral.lAGENT#</option>
				<cfloop query="getagent"><option value="#agent#">#agent# - #desp#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr><td colspan="2"><hr></td></tr>
	<tr> 
        <th>Area From</th>
        <td><select name="areafrom">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
					<option value="#area#">#area# - #desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>
    <tr> 
        <th>Area To</th>
        <td><select name="areato">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
					<option value="#area#">#area# - #desp#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr><td colspan="2"><hr></td></tr>
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
				<cfloop query="getcust"><option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppto" onKeyUp="getSupp('custto','Customer');">
			</cfif>
		</td>
    </tr>
	<tr><td colspan="2"><hr></td></tr>
    <cfif type eq 'headquaterproducttype'>
    <tr>   
    <th>Headquater From</th>
      <td><select name="headquaterfrom">
				<option value="">Choose a Headquater</option>
				<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
			
				
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer2');" />&nbsp;
		</td>
    </tr>
	<tr><td colspan="2"><hr></td></tr>
    </cfif>
    <cfif type eq 'addressproducttype'>
    <tr>   
    <th>Address From</th>
      <td><select name="addressfrom">
				<option value="">Choose a Address</option>
				<cfloop query="getaddress">
					<option value="#code#">#code# - #name#</option>
				</cfloop>
			</select>
			
				
		</td>
    </tr>
    <tr> 
        <th>Address To</th>
      <td><select name="addressto">
				<option value="">Choose a Address</option>
				<cfloop query="getaddress"><option value="#code#">#code# - #name#</option>
				</cfloop>
	  </select>

				
		</td>
    </tr>
    </cfif>
	<tr><td colspan="2"><hr></td></tr>
    
   	<th>#getgeneral.lCATEGORY# From</th>
        <td><select name="catefrom">
				<option value="">Choose a #getgeneral.lCATEGORY#</option>
				<cfloop query="getcate">
					<option value="#cate#">#cate# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcatefr" onKeyUp="getCategory('catefrom');">
			</cfif>
		</td>
    </tr>
    <tr> 
        <th>#getgeneral.lCATEGORY# To</th>
        <td><select name="cateto">
				<option value="">Choose a #getgeneral.lCATEGORY#</option>
				<cfloop query="getcate">
					<option value="#cate#">#cate# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcateto" onKeyUp="getCategory('cateto');">
			</cfif>
		</td>
    </tr>
    <tr><td colspan="2"><hr></td></tr>
    <tr> 
        <th>#getgeneral.lGROUP# From</th>
        <td><select name="groupfrom">
				<option value="">Choose a #getgeneral.lGROUP#</option>
				<cfloop query="getgroup">
					<option value="#wos_group#">#wos_group# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupfr" onKeyUp="getGroup('groupfrom');">
			</cfif>
		</td>
    </tr>
    <tr> 
        <th>#getgeneral.lGROUP# To</th>
        <td><select name="groupto">
				<option value="">Choose a #getgeneral.lGROUP#</option>
				<cfloop query="getgroup">
					<option value="#wos_group#">#wos_group# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupto" onKeyUp="getGroup('groupto');">
			</cfif>
		</td>
    </tr>
    <tr><td colspan="2"><hr></td></tr>
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
    <tr><td colspan="2"><hr></td></tr>
    <tr> 
        <th>Period From</th>
        <td><select name="periodfrom" onChange="displaymonth()">
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
			</select>&nbsp;<input type="text" name="monthfrom" value="#vmonthto1#" size="6" readonly>
		</td>
    </tr>
    <tr> 
        <th>Period To</th>
        <td><select name="periodto" onChange="displaymonth()">
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
			</select>&nbsp;<input type="text" name="monthto" value="#vmonthto12#" size="6" readonly>
		</td>
	</tr>
    <tr> <td colspan="2"><hr></td></tr>
    <tr> 
        <th>Date From</th>
        <td><input type="text" name="datefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> 
			<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">(DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Date To</th>
        <td><input type="text" name="dateto" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> 
			<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">(DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>      
</table>
</form>
</cfoutput>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        <cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Item&fromto={fromto}" />
<cfwindow center="true" width="550" height="400" name="findCustomer2" refreshOnShow="true"
        title="Find Headquater" initshow="false"
        source="findCustomer2.cfm?type={tran}&fromto={fromto}" />
</body>
</html>
<!---
<cfset clsyear=year(getgeneral.lastaccyear)>	
<cfset clsmonth=month(getgeneral.lastaccyear)>
<!--- period default --->
<cfset newmonth=clsmonth+1>	

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
--->