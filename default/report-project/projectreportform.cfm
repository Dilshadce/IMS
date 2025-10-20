<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>
<cfquery datasource="#dts#" name="getmodule">
	select * from modulecontrol
</cfquery>

<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../scripts/date_format.js"></script>

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
</script>
</head>

<cfquery name="getproject" datasource="#dts#">
	select source,project from #target_project#
	where porj='P' 
	order by source
</cfquery>

<cfquery name="getjob" datasource="#dts#">
	select source,project from #target_project#
	where porj='J' 
	order by source
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp 
	from icitem 
	where (itemtype <> "SV" or itemtype is null) and (nonstkitem<>'T' or nonstkitem is null)
	order by itemno
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

<cfoutput>
<cfswitch expression="#url.type#">
	<cfcase value="listprojitem">
		<cfset trantype = getgeneral.lPROJECT&" Transaction Listing Report">
		<form name="form" action="projectreportresult.cfm?type=#url.type#" method="post" target="_blank">
	</cfcase>
	<cfcase value="salesiss">
		<cfset trantype = getgeneral.lPROJECT&" Sales and Issue Report">
		<form name="form" action="projectreportresult2.cfm?type=#url.type#" method="post" target="_blank">
	</cfcase>
	<cfcase value="projitemiss">
		<cfset trantype = getgeneral.lPROJECT&" Product Issue Report">
		<form name="form" action="projectreportresult3.cfm?type=#url.type#" method="post" target="_blank">
	</cfcase>
	<cfcase value="itemprojiss">
		<cfset trantype = "Item "&getgeneral.lPROJECT&" Issue Report">
		<form name="form" action="projectreportresult4.cfm?type=#url.type#" method="post" target="_blank">
	</cfcase>
</cfswitch>
</cfoutput>
<body>
<h3>
	<a href="projectreportmenu.cfm"><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report</a> >> 
	<a><font size="2"><cfoutput>#trantype#</cfoutput></font></a>
</h3>
<input type="hidden" name="fromto" id="fromto" value="" />
<table width="75%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">

	<cfif url.type eq "listprojitem">
     
		<tr>
			<th width="50%">Mark Type to Send</th>
			<td width="50%"><h3><font size="1"><b>* System will consider all the type below if you unclick all of them !</b></font></h3></td>
		</tr>
        <cfoutput>
          <tr>
        <td nowrap>
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br/>		</td>
        </tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="rc"> 'RC' #getGeneralInfo.lRC#</td>
			<td><input type="checkbox" name="marktype" value="pr"> 'PR' #getGeneralInfo.lPR#</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="inv" checked> 'INV' #getGeneralInfo.lINV#</td>
			<td><input type="checkbox" name="marktype" value="do"> 'DO' #getGeneralInfo.lDO#</td>
		</tr>
		<tr>	
			<td><input type="checkbox" name="marktype" value="cs"> 'CS' #getGeneralInfo.lCS#</td>
			<td><input type="checkbox" name="marktype" value="cn"> 'CN' #getGeneralInfo.lCN#</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="dn"> 'DN' #getGeneralInfo.lDN#</td>
			<td><input type="checkbox" name="marktype" value="iss"> 'ISS' #getGeneralInfo.lISS#</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="oai"> 'OAI' #getGeneralInfo.lOAI#</td>
			<td><input type="checkbox" name="marktype" value="oar"> 'OAR' #getGeneralInfo.lOAR#</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="trin,trou"> 'TR' Transfer</td>
            <td><input type="checkbox" name="marktype" value="po"> 'PO' #getGeneralInfo.lPO#</td>
		</tr>
        <tr>
			<td><input type="checkbox" name="marktype" value="so"> 'SO' #getGeneralInfo.lSO#</td>
			<td><input type="checkbox" name="marktype" value="quo"> 'QUO' #getGeneralInfo.lQUO#</td>
		</tr>
        </cfoutput>
		<tr>
	      	<td colspan="100%"><hr></td>
	   	</tr>
	</cfif>
    <cfif url.type neq "listprojitem">
    <tr>
        <td nowrap>
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br/>		</td>
        </tr>
        </cfif>
	<cfif url.type neq "itemprojiss">
    
		<tr> 
	        <th width="25%"><cfoutput>#getgeneral.lPROJECT#</cfoutput> From</th>
	        <td width="75%"><select name="projectfrom">
					<option value="">Choose a <cfoutput>#getgeneral.lPROJECT#</cfoutput></option>
					<cfoutput query="getproject">
						<option value="#source#">#source# - #project#</option>
					</cfoutput>
				</select>
			</td>
	    </tr>
	    <tr> 
	        <th><cfoutput>#getgeneral.lPROJECT#</cfoutput> To</th>
	        <td><select name="projectto">
					<option value="">Choose a <cfoutput>#getgeneral.lPROJECT#</cfoutput></option>
					<cfoutput query="getproject">
						<option value="#source#">#source# - #project#</option>
					</cfoutput>
				</select>
			</td>
	    </tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	</cfif>

		
		<tr> 
        
	        <th width="25%" <cfif getmodule.job neq "1"> style="visibility:hidden"</cfif>><cfoutput>#getgeneral.lJOB#</cfoutput> From</th>
 	        <td width="75%" <cfif getmodule.job neq "1"> style="visibility:hidden"</cfif>><select name="jobfrom">
					<option value="">Choose a <cfoutput>#getgeneral.lJOB#</cfoutput></option>
					<cfoutput query="getjob">
						<option value="#source#">#source# - #project#</option>
					</cfoutput>
				</select>
			</td>
	    </tr>
	    <tr> 
        
	        <th <cfif getmodule.job neq "1"> style="visibility:hidden"</cfif>><cfoutput>#getgeneral.lJOB#</cfoutput> To</th>
	        <td <cfif getmodule.job neq "1"> style="visibility:hidden"</cfif>><select name="jobto">
					<option value="">Choose a <cfoutput>#getgeneral.lJOB#</cfoutput></option>
					<cfoutput query="getjob">
						<option value="#source#">#source# - #project#</option>
					</cfoutput>
				</select>
			</td>
	    </tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>

	<tr>
      	<th width="25%">Product From</th>
      	<td width="75%">
			<select name="productfrom">
          		<option value="">Choose a product</option>
          		<cfoutput query="getitem">
            		<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
          		</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th>Product To</th>
      	<td>
			<select name="productto">
          		<option value="">Choose a product</option>
          		<cfoutput query="getitem">
            		<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
          		</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
				<input type="text" name="searchitemto" onKeyUp="getProduct('productto');">
			</cfif>
		</td>
    </tr>
	<tr>
      	<td colspan="100%"><hr></td>
    </tr>
	<tr>
      	<th><cfoutput>#getgeneral.lCATEGORY#</cfoutput> From</th>
      	<td>
			<select name="Catefrom">
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
			<select name="Cateto">
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
			<select name="groupfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup">
            		<option value="#wos_group#">#wos_group#</option>
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
			<select name="groupto">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup">
            		<option value="#wos_group#">#wos_group#</option>
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
	<cfoutput>
	<tr>
      	<th>Period From</th>
      	<td>
			<select name="periodfrom">
            <option value="">Choose a Period</option>
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
		</td>
    </tr>
	<tr>
      	<th>Period To</th>
      	<td>
			<select name="periodto">
				<option value="">Choose a Period</option>
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
	</cfoutput>
	<tr>
      	<td colspan="100%"><hr></td>
   	 </tr>
	<tr>
		<th>Date From</th>
      	<td>
			<input name="datefrom" type="text" value="" size="11"> (DD/MM/YYYY)
		</td>
	</tr>
	<tr>
		<th>Date To</th>
      	<td>
			<input name="dateto" type="text" value="" size="11"> (DD/MM/YYYY)
		</td>
	</tr>
	<tr>
      	<td colspan="100%"><hr></td>
    </tr>
	<tr>
		<td colspan="100%">
			&nbsp;<cfif url.type eq "listprojitem"><input type="checkbox" name="sortbycustno" id="sortbycustno" value="yes"> Sort By custno &nbsp;&nbsp;&nbsp;<input type="checkbox" name="seperatebilltype" id="seperatebilltype" value="yes" checked> Seperate Bill Type &nbsp;&nbsp;&nbsp;</cfif><input type="checkbox" name="usecostiniss" id="usecostiniss" value="yes"> Use cost in Issue&nbsp;&nbsp;<font size="1" color="red">Please run "Calculate cost of sales" first!</font>	
		</td>
	</tr>
	<tr>
      	<td colspan="100%"><hr></td>
    </tr>
	<tr>
      	<td colspan="100%" align="right"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>

<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Product&fromto={fromto}" />
</body>
</html>