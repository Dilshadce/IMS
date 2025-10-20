<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
<html>
<head>
<title>Batch Code Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script src="../../scripts/CalendarControl.js" language="javascript"></script>

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
		var inputtext = document.batchreport.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.batchreport.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult2);
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

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("itemto");
	DWRUtil.addOptions("itemto", itemArray,"KEY", "VALUE");
}

function getProductResult2(itemArray){
	DWRUtil.removeAllOptions("itemfrom");
	DWRUtil.addOptions("itemfrom", itemArray,"KEY", "VALUE");
}
// end: product search

// only for thaipore_i
function getPermitno(type,inputtext){
	DWREngine._execute(_reportflocation, null, 'permitnolookup', type,inputtext, getPermitnoResult);
}

function getPermitnoResult(permitArray){
	DWRUtil.removeAllOptions("permitno");
	DWRUtil.addOptions("permitno", permitArray,"KEY", "VALUE");
}

// begin: customer search
function getCust(type,option){
	if(type == 'custfrom'){
		var inputtext = document.batchreport.searchcustfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
		
	}
	else{
		var inputtext = document.batchreport.searchcustto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult2);
	}
}

function getCustResult(custArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", custArray,"KEY", "VALUE");
}

function getCustResult2(custArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", custArray,"KEY", "VALUE");
}
// end: customer search
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
	
<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem where (itemtype <> "SV" or itemtype is null) order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfquery name="getlocation" datasource="#dts#">
	select location, desp 
	from iclocation
	<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
		where location in (#ListQualify(Huserloc,"'",",")#)
	</cfif> 
	order by location
</cfquery>

<cfswitch expression="#url.type#">
	<cfcase value="monthly">
		<cfset trantype = "LOT NUMBER MONTHLY">	
		<form name="batchreport" action="itembatchmonth.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="bydate_tran">
		<cfset trantype = "LOT NUMBER - STOCK MOVEMENT">
		<form name="batchreport" action="itembatchtrans.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="salesreport">
		<cfset trantype = "LOT NUMBER - OUTSTANDING SALES ORDER">
		<form name="batchreport" action="itembatchso.cfm" method="post" target="_blank">
	</cfcase>
</cfswitch>

<!--- <h2 align="center">Print #trantype# Report</h2> --->
<h3>
	<a href="batchcodereportmenu.cfm"><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>Batch Code</cfif> Report Menu</a> >> 
	<a><font size="2">Print #trantype# Report</font></a>
</h3>
<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<cfif url.type eq "monthly">	
		<tr>
			<th>Report Format</th>
			<td colspan="3">
				<!--- <input type="radio" name="result" value="HTML" checked>HTML<br/>
				<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br><br> --->
                <input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br>
				<input type="checkbox" name="figure" value="yes"> With 0 Figure<br>
                <input type="checkbox" name="bylocation" value="yes"> Sort By Location<br>
                <input type="radio" name="locationqty" value="yes">List Location With Qty<br>
                <input type="radio" name="locationqty" value="no">List Location Without Qty<br>
			</td>
		</tr>
		<tr> 
	        <td colspan="100%"><hr></td>
	    </tr>
	</cfif>
	<cfif url.type eq "salesreport" or ((url.type eq "bydate_tran" or url.type eq "monthly") and lcase(HcomID) eq "jaynbtrading_i")>
		<!--- <cfquery name="getcust" datasource="#dts#">
			select name, custno from #target_arcust# order by custno
		</cfquery> --->
		<cfquery name="getcust" datasource="#dts#">
			select name, custno from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
		</cfquery>
		<tr>   
	    	<th>Customer From</th>
	        <td><select name="custfrom">
					<option value="">Choose a Customer</option>
					<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcustfr" onKeyUp="getCust('custfrom','Customer');">
				</cfif>
			</td>
	    </tr>
	    <tr>   
	    	<th>Customer To</th>
	        <td><select name="custto">
					<option value="">Choose a Customer</option>
					<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcustto" onKeyUp="getCust('custto','Customer');">
				</cfif>
			</td>
	    </tr>
	    <tr> 
	        <td colspan="100%"><hr></td>
	    </tr>
	</cfif>
    <tr>   
    	<th>Item No From</th>
        <td><select name="itemfrom">
				<option value="">Choose an Item</option>
				<cfloop query="getitem">
				<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
				</cfloop>
			</select>
				<input type="text" name="searchitemfr" onKeyUp="getProduct('itemfrom');">
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
				<input type="text" name="searchitemto" onKeyUp="getProduct('itemto');">
		</td>
    </tr>
    <tr> 
        <td colspan="100%"><hr></td>
    </tr>
	<tr>
		<th>#getgeneral.lLOCATION# From<input type="hidden" name="fromto" id="fromto" value="" /></th>
		<td><select name="locationfrom">
				<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
					<option value="">Choose a #getgeneral.lLOCATION#</option>
				</cfif>
				<cfloop query="getlocation">
					<option value="#location#">#location# - #desp#</option>
				</cfloop>
			</select>
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findlocation');" />
		</td>
	</tr>
	<tr> 
		<th>#getgeneral.lLOCATION# To</th>
		<td><select name="locationto">
				<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
					<option value="">Choose a #getgeneral.lLOCATION#</option>
				</cfif>
				<cfloop query="getlocation">
					<option value="#location#">#location# - #desp#</option>
				</cfloop>
			</select>
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findlocation');" />
		</td>
	</tr>
	<cfif url.type eq "monthly">
		<tr> 
			<td colspan="100%"><hr></td>
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
	<cfelseif url.type eq "bydate_tran">
		<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr> 
			<th>Date From</th>
			<td><input type="text" name="datefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10" value="#dateformat(now(),"dd/mm/yyyy")#"> (DD/MM/YYYY)</td>
		</tr>
		<tr> 
			<th>Date To</th>
			<td><input type="text" name="dateto" validate="eurodate" message="Invalid Input" maxlength="10" size="10" value="#dateformat(now(),"dd/mm/yyyy")#"> (DD/MM/YYYY)</td>
		</tr>
	</cfif>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	<tr> 
        <th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>Batch Code</cfif> From</th>
        <td><input type="text" name="batchcodefrom" size="18"></td>
    </tr>
    <tr> 
        <th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>Batch Code</cfif> To</th>
        <td><input type="text" name="batchcodeto" size="18"></td>
    </tr>
    <td colspan="100%"><hr></td>
    <tr> 
        <th><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></th>
        <td><input type="text" name="milcert" size="18"></td>
    </tr>
    <td colspan="100%"><hr></td>
    <tr> 
        <th>Import Permit</th>
        <td><input type="text" name="importpermit" size="18"></td>
    </tr>
	<cfif checkcustom.customcompany eq "Y">
		<cfquery name="getpermit" datasource="#dts#">
			select brem5 as permit_no from ictran where brem5 <> '' group by brem5
	        union
	        select brem7 as permit_no from ictran where brem7 <> '' group by brem7
	        union
	        select brem8 as permit_no from ictran where brem8 <> '' group by brem8
	        union 
	        select brem9 as permit_no from ictran where brem9 <> '' group by brem9
	        union
	        select brem10 as permit_no from ictran where brem10 <> '' group by brem10
            union
	        select importpermit as permit_no from ictran where importpermit <> '' group by importpermit
		</cfquery>	
		<cfif url.type neq "salesreport">	
			<tr> 
				<td colspan="100%"><hr></td>
			</tr>
			<tr> 
		        <th>Permit Number</th>
		        <td>
			        <select name="permitno">
						<option value="">Please select one</option>
						<cfloop query="getpermit">
							<option value="#getpermit.permit_no#">#getpermit.permit_no#</option>
						</cfloop>
					</select>				
					<input type="text" name="searchpermitno" onKeyUp="getPermitno('',this.value);">
				</td>
		    </tr>
		</cfif>
        
	</cfif>
	<tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</form>

</cfoutput>
<cfwindow center="true" width="550" height="400" name="findlocation" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="findlocation.cfm?type=Location&fromto={fromto}" />
</body>
</html>