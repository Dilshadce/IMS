<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
<html>
<head>
<title>Batch Code Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<script src="/scripts/CalendarControl.js" language="javascript"></script>

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
function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}

function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.batchreport.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.batchreport.searchitemfr.value;
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
		var inputtext = document.batchreport.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.batchreport.searchcateto.value;
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
		var inputtext = document.batchreport.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.batchreport.searchgroupto.value;
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
<cfoutput>

<cfquery name="getcate" datasource="#dts#">
	select cate,desp from iccate order by cate
</cfquery>
	
<cfquery name="getgroup" datasource="#dts#">
	select wos_group,desp from icgroup order by wos_group
</cfquery>
	
<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem where (itemtype <> "SV" or itemtype is null) order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<cfswitch expression="#url.type#">
	<cfcase value="itembatchopening">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "ITEM - LOT NUMBER OPENING">
		<cfelse>
			<cfset trantype = "ITEM BATCH OPENING">
		</cfif>
		
		<form name="batchreport" action="itembatchopening.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="itembatchsales">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "ITEM - LOT NUMBER SALES">
		<cfelse>
			<cfset trantype = "ITEM BATCH SALES">
		</cfif>
		<form name="batchreport" action="itembatchsales.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="itembatchstatus">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "ITEM - LOT NUMBER STATUS">
		<cfelse>
			<cfset trantype = "ITEM BATCH STATUS">
		</cfif>
		<form name="batchreport" action="itembatchstatus.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="itembatchstockcard">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "ITEM - LOT NUMBER STOCK CARD">
		<cfelse>
			<cfset trantype = "ITEM BATCH STOCK CARD">
		</cfif>
        <cfif isdefined('url.stockcard2')>
        <form name="batchreport" action="itembatchstockcardA.cfm" method="post" target="_blank">
        <cfelse>
		<form name="batchreport" action="itembatchstockcard.cfm" method="post" target="_blank">
        </cfif>
	</cfcase>
	<cfcase value="batchlisting">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "LOT NUMBER - ITEM LISTING">
		<cfelse>
			<cfset trantype = "BATCH ITEM LISTING">
		</cfif>
		<form name="batchreport" action="batchitemlisting.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="locationitembatchopening">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "LOCATION ITEM - LOT NUMBER OPENING">
		<cfelse>
			<cfset trantype = "LOCATION ITEM BATCH OPENING">
		</cfif>
		<!--- <cfquery name="getlocation" datasource="#dts#">
			select location, desp from iclocation order by location
		</cfquery>  --->
		<cfquery name="getlocation" datasource="#dts#">
			select location, desp 
			from iclocation 
			<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
				where location in (#ListQualify(Huserloc,"'",",")#)
			</cfif>
			order by location
		</cfquery> 
		<form name="batchreport" action="locationitembatchopening.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="locationitembatchsales">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "LOCATION ITEM - LOT NUMBER SALES">
		<cfelse>
			<cfset trantype = "LOCATION ITEM BATCH SALES">
		</cfif>
		<!--- <cfquery name="getlocation" datasource="#dts#">
			select location, desp from iclocation order by location
		</cfquery> --->
		<cfquery name="getlocation" datasource="#dts#">
			select location, desp 
			from iclocation 
			<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
				where location in (#ListQualify(Huserloc,"'",",")#)
			</cfif>
			order by location
		</cfquery>
		<form name="batchreport" action="locationitembatchsales.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="locationitembatchstatus">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "LOCATION ITEM - LOT NUMBER STATUS">
		<cfelse>
			<cfset trantype = "LOCATION ITEM BATCH STATUS">
		</cfif>
		<!--- <cfquery name="getlocation" datasource="#dts#">
			select location, desp from iclocation order by location
		</cfquery> --->
		<cfquery name="getlocation" datasource="#dts#">
			select location, desp 
			from iclocation
			<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
				where location in (#ListQualify(Huserloc,"'",",")#)
			</cfif> 
			order by location
		</cfquery>
		<form name="batchreport" action="locationitembatchstatus.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="locationitembatchstockcard">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "LOCATION ITEM - LOT NUMBER STOCK CARD">
		<cfelse>
			<cfset trantype = "LOCATION ITEM BATCH STOCK CARD">
		</cfif>
		<!--- <cfquery name="getlocation" datasource="#dts#">
			select location, desp from iclocation order by location
		</cfquery> --->
		<cfquery name="getlocation" datasource="#dts#">
			select location, desp 
			from iclocation 
			<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
				where location in (#ListQualify(Huserloc,"'",",")#)
			</cfif>
			order by location
		</cfquery>
		<form name="batchreport" action="locationitembatchstockcard.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="itembatchstockcard2">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "ITEM - LOT NUMBER STOCK CARD">
		<cfelse>
			<cfset trantype = "ITEM BATCH STOCK CARD">
		</cfif>
		<form name="batchreport" action="itembatchstockcard2.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="locationitembatchstockcard2">
		<cfif checkcustom.customcompany eq "Y">
			<cfset trantype = "LOCATION ITEM - LOT NUMBER STOCK CARD">
		<cfelse>
			<cfset trantype = "LOCATION ITEM BATCH STOCK CARD">
		</cfif>
		<cfquery name="getlocation" datasource="#dts#">
			select location, desp 
			from iclocation 
			<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
				where location in (#ListQualify(Huserloc,"'",",")#)
			</cfif>
			order by location
		</cfquery>
		<form name="batchreport" action="locationitembatchstockcard2.cfm" method="post" target="_blank">
	</cfcase>
	<cfcase value="locationitembatchstatus2">
		<cfset trantype = "LOCATION STOCK BALANCE">
		<cfquery name="getlocation" datasource="#dts#">
			select location, desp 
			from iclocation
			<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
				where location in (#ListQualify(Huserloc,"'",",")#)
			</cfif> 
			order by location
		</cfquery>
		<form name="batchreport" action="locationitembatchstatus2.cfm" method="post" target="_blank">
	</cfcase>
</cfswitch>

<!--- <h2 align="center">Print #trantype# Report</h2> --->
<h3>
	<a href="batchcodereportmenu.cfm">#getgeneral.lCATEGORY#
	<cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>Batch Code</cfif> Report Menu</a> >> 
	<a><font size="2">Print #trantype# Report</font></a>
</h3>
<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
<input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />
	<cfif type neq "itembatchstockcard" and type neq "locationitembatchstockcard" and type neq "itembatchstockcard2" and type neq "locationitembatchstockcard2">
	<tr>
		<th>Report Format</th>
		<td colspan="3">
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br><br>
			<cfif url.type neq "itembatchopening" and url.type neq "batchlisting" and url.type neq "locationitembatchopening">
				<input type="checkbox" name="figure" value="yes"> With 0 Figure
			</cfif>
		</td>
	</tr>
	 <tr> 
        <td colspan="4"><hr></td>
    </tr>
	<cfelseif url.type neq "itembatchopening" and url.type neq "batchlisting" and url.type neq "locationitembatchopening">
	<tr>
		<th>Report Format</th>
		<td colspan="3"><input type="checkbox" name="figure" value="yes"> With 0 Figure</td>
	</tr>
	 <tr> 
        <td colspan="4"><hr></td>
    </tr>
	</cfif>
	<cfif ((url.type eq "locationitembatchstatus2" or url.type eq "locationitembatchstockcard2" or url.type eq "itembatchstockcard2" or url.type eq "locationitembatchstockcard") and lcase(HcomID) eq "jaynbtrading_i")>
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
					<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchcustfr" onKeyUp="getCust('custfrom','Customer');">
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
					<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;
<input type="text" name="searchcustto" onKeyUp="getCust('custto','Customer');">
				</cfif>
			</td>
	    </tr>
	    <tr> 
	        <td colspan="100%"><hr></td>
	    </tr>
	</cfif>
	<tr>  
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
        <th> To</th>
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
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
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
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <tr>   
    <th>Item No From</th>
        <td><select name="itemfrom">
				<option value="">Choose an Item</option>
				<cfloop query="getitem">
				<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;<input type="text" name="searchitemfr" onKeyUp="getProduct('itemfrom');">
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
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
	<cfif url.type eq "itembatchstatus" or url.type eq "locationitembatchstatus" or url.type eq "itembatchopening" or url.type eq "locationitembatchopening">
		<tr> 
			<th>Expire Date From</th>
			<td><input type="text" name="expdatefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> (DD/MM/YYYY)</td>
		</tr>
		<tr> 
			<th>Expire Date To</th>
			<td><input type="text" name="expdateto" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> (DD/MM/YYYY)</td>
		</tr>
		<tr> 
        	<td colspan="4"><hr></td>
    	</tr>
	</cfif>
	
	<cfif url.type eq "locationitembatchopening" or url.type eq "locationitembatchsales" or url.type eq "locationitembatchstatus" or url.type eq "locationitembatchstockcard" or url.type eq "locationitembatchstockcard2" or url.type eq "locationitembatchstatus2">
		<tr>
			<th>#getgeneral.lLOCATION# From</th>
			<td><select name="locationfrom">
					<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
						<option value="">Choose a #getgeneral.lLOCATION#</option>
					</cfif>
					<cfloop query="getlocation">
					<option value="#location#">#location# - #desp#</option>
					</cfloop>
				</select>
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
			</td>
		</tr>
		<tr> 
			<td colspan="4"><hr></td>
		</tr>
	</cfif>
	<cfif url.type neq "itembatchopening" and url.type neq "batchlisting" and url.type neq "locationitembatchopening" and url.type neq "locationitembatchstatus2">
		<tr> 
			<th>Period From</th>
			<td><select name="periodfrom" onChange="displaymonth()">
				<option value="" selected>Choose a Period</option>
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
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
				<option value="16">16</option>
				<option value="17">17</option>
				<option value="18">18</option>
				</select>&nbsp;<input type="text" name="monthfrom" value="#vmonth#" size="6" readonly>
			</td>
		</tr>
		<tr> 
			<th>Period To</th>
			<td><select name="periodto" onChange="displaymonth()">
				<option value="" selected>Choose a Period</option>
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
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
				<option value="16">16</option>
				<option value="17">17</option>
				<option value="18">18</option>
				</select>&nbsp;<input type="text" name="monthto" value="#vmonthto#" size="6" readonly>
			</td>
		</tr>
		<tr> 
			<td colspan="4"><hr></td>
		</tr>
	</cfif>
    <cfif url.type eq "itembatchsales" or url.type eq "locationitembatchsales" or type eq "itembatchstockcard2" or type eq "locationitembatchstockcard2" or url.type eq "locationitembatchstatus2" or url.type eq "itembatchstockcard">
		<tr> 
			<th>Date From</th>
			<td><input type="text" name="datefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> (DD/MM/YYYY)</td>
		</tr>
		<tr> 
			<th>Date To</th>
			<td><input type="text" name="dateto" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> (DD/MM/YYYY)</td>
		</tr>
		<tr> 
			<td colspan="4"><hr></td>
		</tr>
	</cfif>
	<tr> 
        <th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>Batch Code</cfif> From</th>
        <td><input type="text" name="batchcodefrom" validate="eurodate" message="Invalid Input" maxlength="18" size="18"></td>
    </tr>
    <tr> 
        <th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>Batch Code</cfif> To</th>
        <td><input type="text" name="batchcodeto" validate="eurodate" message="Invalid Input" maxlength="18" size="18"></td>
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
		<cfif url.type eq "itembatchopening" or url.type eq "locationitembatchopening">
			<cfquery name="getpermit" datasource="#dts#">
				select permit_no from obbatch where permit_no <> '' group by permit_no
				union 
				select permit_no2 as permit_no from obbatch where permit_no2 <> '' group by permit_no2
			</cfquery>
		<cfelse>
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
			</cfquery>
		</cfif>
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
				<cfif url.type eq "itembatchopening" or url.type eq "locationitembatchopening">
					<input type="text" name="searchpermitno" onKeyUp="getPermitno('opening',this.value);">
				<cfelse>
					<input type="text" name="searchpermitno" onKeyUp="getPermitno('',this.value);">
				</cfif>
			</td>
	    </tr>
	</cfif>
	<tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</form>

<cfif url.type neq "itembatchopening" and url.type neq "batchlisting" and url.type neq "locationitembatchopening">
	<script language="JavaScript">
		function displaymonth(){
		
		if(document.batchreport.periodfrom.value=="")
		{	document.batchreport.monthfrom.value = "";}
		
		if(document.batchreport.periodto.value=="")
		{	
			document.batchreport.monthto.value = "";}
		
		if(document.batchreport.periodfrom.value=='01')		
		{	document.batchreport.monthfrom.value='#vmonthto1#'; }
			
		else if(document.batchreport.periodfrom.value=='02')	
	
		{	document.batchreport.monthfrom.value='#vmonthto2#'; }
		
		else if(document.batchreport.periodfrom.value=='03')	
		{	document.batchreport.monthfrom.value='#vmonthto3#'; }
		
		else if(document.batchreport.periodfrom.value=='04')	
		{	document.batchreport.monthfrom.value='#vmonthto4#'; }
		
		else if(document.batchreport.periodfrom.value=='05')	
		{	document.batchreport.monthfrom.value='#vmonthto5#'; }
		
		else if(document.batchreport.periodfrom.value=='06')	
		{	document.batchreport.monthfrom.value='#vmonthto6#'; }
		
		else if(document.batchreport.periodfrom.value=='07')	
		{	document.batchreport.monthfrom.value='#vmonthto7#'; }
		
		else if(document.batchreport.periodfrom.value=='08')	
		{	document.batchreport.monthfrom.value='#vmonthto8#'; }
		
		else if(document.batchreport.periodfrom.value=='09')	
		{	document.batchreport.monthfrom.value='#vmonthto9#'; }
		
		else if(document.batchreport.periodfrom.value=='10')	
		{	document.batchreport.monthfrom.value='#vmonthto10#'; }
		
		else if(document.batchreport.periodfrom.value=='11')	
		{	document.batchreport.monthfrom.value='#vmonthto11#'; }
		
		else if(document.batchreport.periodfrom.value=='12')	
		{	document.batchreport.monthfrom.value='#vmonthto12#'; }
		
		else if(document.batchreport.periodfrom.value=='13')	
		{	document.batchreport.monthfrom.value='#vmonthto13#'; }
		
		else if(document.batchreport.periodfrom.value=='14')	
		{	document.batchreport.monthfrom.value='#vmonthto14#'; }
		
		else if(document.batchreport.periodfrom.value=='15')	
		{	document.batchreport.monthfrom.value='#vmonthto15#'; }
		
		else if(document.batchreport.periodfrom.value=='16')	
		{	document.batchreport.monthfrom.value='#vmonthto16#'; }
		
		else if(document.batchreport.periodfrom.value=='17')	
		{	document.batchreport.monthfrom.value='#vmonthto17#'; }
		
		else if(document.batchreport.periodfrom.value=='18')	
		{	document.batchreport.monthfrom.value='#vmonthto18#'; }
		
		if(document.batchreport.periodto.value=='01')		
		{	document.batchreport.monthto.value='#vmonthto1#'; }
			
		else if(document.batchreport.periodto.value=='02')	
		{	document.batchreport.monthto.value='#vmonthto2#'; }
		
		else if(document.batchreport.periodto.value=='03')	
		{	document.batchreport.monthto.value='#vmonthto3#'; }
		
		else if(document.batchreport.periodto.value=='04')	
		{	document.batchreport.monthto.value='#vmonthto4#'; }
		
		else if(document.batchreport.periodto.value=='05')	
		{	document.batchreport.monthto.value='#vmonthto5#'; }
		
		else if(document.batchreport.periodto.value=='06')	
		{	document.batchreport.monthto.value='#vmonthto6#'; }
		
		else if(document.batchreport.periodto.value=='07')	
		{	document.batchreport.monthto.value='#vmonthto7#'; }
		
		else if(document.batchreport.periodto.value=='08')	
		{	document.batchreport.monthto.value='#vmonthto8#'; }
		
		else if(document.batchreport.periodto.value=='09')	
		{	document.batchreport.monthto.value='#vmonthto9#'; }
		
		else if(document.batchreport.periodto.value=='10')	
		{	document.batchreport.monthto.value='#vmonthto10#'; }
		
		else if(document.batchreport.periodto.value=='11')	
		{	document.batchreport.monthto.value='#vmonthto11#'; }
		
		else if(document.batchreport.periodto.value=='12')	
		{	document.batchreport.monthto.value='#vmonthto12#'; }
		
		else if(document.batchreport.periodto.value=='13')	
		{	document.batchreport.monthto.value='#vmonthto13#'; }
		
		else if(document.batchreport.periodto.value=='14')	
		{	document.batchreport.monthto.value='#vmonthto14#'; }
		
		else if(document.batchreport.periodto.value=='15')	
		{	document.batchreport.monthto.value='#vmonthto15#'; }
		
		else if(document.batchreport.periodto.value=='16')	
		{	document.batchreport.monthto.value='#vmonthto16#'; }
		
		else if(document.batchreport.periodto.value=='17')	
		{	document.batchreport.monthto.value='#vmonthto17#'; }
		
		else if(document.batchreport.periodto.value=='18')	
		{	document.batchreport.monthto.value='#vmonthto18#'; }
		
		}
	</script>
</cfif>
</cfoutput>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        <cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Item&fromto={fromto}" />
</body>
</html>