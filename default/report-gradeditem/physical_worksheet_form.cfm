<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Graded Item Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../scripts/date_format.js"></script>

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script type="text/javascript">
	
function change_link(type)
{
	if(type == "physical"){
		if(document.form.update_actual_qty.checked==true)
		{
			document.form.action="physical_worksheet_adjust.cfm";
		}
		else
		{
			document.form.action="physical_worksheet_result.cfm";
		}
	}
	else{
		if(document.form.update_actual_qty.checked==true)
		{
			document.form.action="locitem_physical_worksheet_adjust.cfm";
		}
		else
		{
			document.form.action="locitem_physical_worksheet_result.cfm";
		}
	}
	
}

// begin: product search
function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.form.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.form.searchitemfr.value;
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
		var inputtext = document.form.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.form.searchcateto.value;
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
</script>

</head>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery>

<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<body>
<cfoutput>

<cfquery name="getcate" datasource="#dts#">
	select cate,desp from iccate order by cate
</cfquery>
	
<cfquery name="getgroup" datasource="#dts#">
	select wos_group,desp from icgroup order by wos_group
</cfquery>
	
<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno, desp 
	from icitem 
	where graded = 'Y'
	order by itemno
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno,desp from icitem 
	where graded = 'Y'
	order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfquery name="getshelf" datasource="#dts#">
    select shelf,desp 
	from icshelf 
	order by shelf
</cfquery>

<cfif url.type eq "locitemphysical">
	<cfquery name="getlocation" datasource="#dts#">
		select location,desp 
		from iclocation 
		<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
			where location in (#ListQualify(Huserloc,"'",",")#)
		</cfif>
		order by location
	</cfquery>
</cfif>

<cfswitch expression="#url.type#">
	<cfcase value="physical">
		<cfset trantype = "Graded Item Physical Worksheet">
		<form name="form" action="physical_worksheet_result.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="locitemphysical">
		<cfset trantype = "Location - Graded Item Physical Worksheet">
		<form name="form" action="locitem_physical_worksheet_result.cfm" method="post" target="_blank">
	</cfcase>
</cfswitch>

<!--- <h2>Print #trantype# Report</h2> --->
<h3>
	<a href="gradeditemreportmenu.cfm">Graded Item Report Menu</a> >> 
	<a><font size="2">Print #trantype# Report</font></a>
</h3>
<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr>
		<th>Report Format</th>
	</tr>
	<tr>
		<td colspan="3" nowrap>
			<input type="checkbox" name="with_qty" id="1" value="yes" checked> WITH QUANTITY<br/>
			<input type="checkbox" name="include_stock" id="2" value="yes"> INCLUDE 0 STOCK<br/>
			<input type="checkbox" name="update_actual_qty" id="3" value="yes" onClick="change_link('#url.type#');"> UPDATE ACTUAL QUANTITY<br/>
            <input type="checkbox" name="tranitemonly" id="4" value="yes">SHOW TRANSACTION ITEM ONLY<br/>
		</td>
	</tr>
	<cfif url.type eq "locitemphysical">
		<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
		<tr>
			<th nowrap>#getgeneral.lLOCATION# From</th>
			<td>
				<select name="locfrom">
					<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          				<option value="">Choose a #getgeneral.lLOCATION#</option>
					</cfif>
					<cfloop query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<th nowrap>#getgeneral.lLOCATION# To</th>
			<td>
				<select name="locto">
					<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          				<option value="">Choose a #getgeneral.lLOCATION#</option>
					</cfif>
					<cfloop query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfloop>
				</select>
			</td>
		</tr>
	</cfif>
	<tr>
      	<td colspan="3"><hr></td>
    </tr>
	<tr>
      	<th>Item From</th>
      	<td colspan="2">
			<select name="itemfrom">
          		<option value="">Choose an Item</option>
          		<cfloop query="getitem">
					<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemfr" onKeyUp="getProduct('itemfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>Item To</th>
      	<td colspan="2">
			<select name="itemto">
          		<option value="">Choose an Item</option>
          		<cfloop query="getitem">
					<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemto" onKeyUp="getProduct('itemto');">
			</cfif>
		</td>
    </tr>
	<tr>
      	<td colspan="3"><hr></td>
    </tr>
    <tr>
      	<th>#getgeneral.lCATEGORY# From</th>
      	<td colspan="2">
			<select name="catefrom">
          		<option value="">Choose a #getgeneral.lCATEGORY#</option>
          		<cfloop query="getcate">
					<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcatefr" onKeyUp="getCategory('catefrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>#getgeneral.lCATEGORY# To</th>
      	<td colspan="2">
			<select name="cateto">
          		<option value="">Choose a #getgeneral.lCATEGORY#</option>
          		<cfloop query="getcate">
					<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
				</cfloop>
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
      	<th>#getgeneral.lGROUP# From</th>
      	<td colspan="2">
			<select name="groupfrom">
          		<option value="">Choose a #getgeneral.lGROUP#</option>
          		<cfloop query="getgroup">
					<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupfr" onKeyUp="getGroup('groupfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>#getgeneral.lGROUP# To</th>
      	<td colspan="2">
			<select name="groupto">
          		<option value="">Choose a #getgeneral.lGROUP#</option>
          		<cfloop query="getgroup">
					<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
				</cfloop>
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
      	<th>#getgeneral.lMODEL# From</th>
      	<td colspan="2">
			<select name="shelffrom">
          		<option value="">Choose a #getgeneral.lMODEL#</option>
          		<cfloop query="getshelf">
					<option value="#getshelf.shelf#">#getshelf.shelf# - #getshelf.desp#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr>
      	<th>#getgeneral.lMODEL# To</th>
      	<td colspan="2">
			<select name="shelfto">
          		<option value="">Choose a #getgeneral.lMODEL#</option>
          		<cfloop query="getshelf">
					<option value="#getshelf.shelf#">#getshelf.shelf# - #getshelf.desp#</option>
				</cfloop>
			</select>
		</td>
    </tr>
	<tr>
      	<td colspan="3"><hr></td>
    </tr>
    <tr>
      	<th>Period</th>
      	<td colspan="2">
			<select name="period">
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
		</td>
    </tr>
	<tr>
      	<td colspan="3"><hr></td>
    </tr>
	<tr>
		<th>Date</th>
      	<td colspan="2">
			<input name="date" id="date" type="text" value="#dateformat(now(),'dd/mm/yyyy')#" size="11" maxlength="10" required="yes" validate="eurodate" message="Please Key In Correct Date Format !" mask="99/99/9999"> (DD/MM/YYYY)
			<font color="FF0000">Please Check Your Date With Your Selected Period !</font>
		</td>
	</tr>
	<tr>
      	<td align="right" colspan="3"><input type="Submit" name="Submit" value="generate"> &nbsp;&nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</form>
</cfoutput>
</body>
</html>