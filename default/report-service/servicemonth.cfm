<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Sales Report By Month</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script type="text/javascript">

// begin: product search
function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.salesmonth.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.salesmonth.searchitemfr.value;
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
		var inputtext = document.salesmonth.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.salesmonth.searchcateto.value;
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
		var inputtext = document.salesmonth.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.salesmonth.searchgroupto.value;
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

<!--- ADD ON 190908 --->
<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery>
<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<body>
<cfoutput>
<!--- <h2>Print #trantype# Sales Report By Month</h2> --->
<h3>
	<a href="salesmenu.cfm">Sales Report Menu</a> >> 
	<a><font size="2">Print Service Report By Month</font></a></h3>

<cfquery name="getagent" datasource="#dts#">
	select agent,desp from icagent order by agent
</cfquery>

<cfquery name="getarea" datasource="#dts#">
	select area,desp from icarea order by area;
</cfquery>

<form name="salesmonth" action="salesmonth1.cfm" method="post" target="_blank">
<table width="50%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr>
	  	<th>Report Format</th>
	</tr>
	<tr>
	  	<td><input type="radio" name="period" id="1" value="1" checked> <label for="1">Period (1-6)</label><br>
			<input type="radio" name="period" id="1" value="2"> <label for="1">Period (7-12)</label><br>
			<input type="radio" name="period" id="1" value="3"> <label for="1">Period (13-18)</label><br>
			<input type="radio" name="period" id="1" value="4"> <label for="1">One Year</label>		</td>
		<td>
			<br><br><br><br><br>
			<input type="checkbox" name="include" value="yes"> Include DN/CN		</td>
	</tr>
	<tr> 
        <td colspan="2"><hr></td>
    </tr>
	<tr> 
        <th>#getgeneral.lAGENT# From</th>
        <td><select name="agentfrom">
				<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super'>
					<cfquery name="getagent" datasource="#dts#">
						select agent,desp from icagent where agent = '#HUserID#'
					</cfquery>
					<option value="#getagent.agent#">#getagent.agent#-#getagent.desp#</option>
				<cfelse>
					<cfquery name="getagent" datasource="#dts#">
						select agent,desp from icagent order by agent
					</cfquery>
					<option value="">Choose an #getgeneral.lAGENT#</option>
					<cfloop query="getagent">
					<option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
					</cfloop>
				</cfif>
			</select>		</td>
    </tr>
    <tr> 
        <th>#getgeneral.lAGENT# To</th>
        <td><select name="agentto">
				<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super'>
					<cfquery name="getagent" datasource="#dts#">
						select agent,desp from icagent where agent = '#HUserID#'
					</cfquery>
					<option value="#getagent.agent#">#getagent.agent#-#getagent.desp#</option>
				<cfelse>
					<cfquery name="getagent" datasource="#dts#">
						select agent,desp from icagent order by agent
					</cfquery>
					<option value="">Choose an #getgeneral.lAGENT#</option>
					<cfloop query="getagent">
					<option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
					</cfloop>
				</cfif>
			</select>		</td>
    </tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
	<tr> 
        <th>Area From</th>
        <td><select name="areafrom">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
				<option value="#area#">#area#</option>
				</cfloop>
			</select>		</td>
    </tr>
    <tr> 
        <th>Area To</th>
        <td><select name="areato">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
				<option value="#area#">#area#</option>
				</cfloop>
			</select>		</td>
    </tr>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>      
</table>

</cfoutput>
</form>
</body>
</html>