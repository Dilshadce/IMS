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
<cfquery name="gettran" datasource="#dts#">
	select type from artran group by type
</cfquery>
<h3>
	<a href="servicereportmenu.cfm">Service Report Menu</a> >> 
	<a><font size="2">Print Service Report By Month</font></a></h3>

<cfquery name="getarea" datasource="#dts#">
	select area,desp from icarea order by area;
</cfquery>

<cfquery name="getservice" datasource="#dts#">
	select desp,servi from icservi
	order by servi
</cfquery>

<form name="salesmonth" action="l_servicereportproject.cfm" method="post" target="_blank">
<table width="50%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">

    <tr> 
        <th>Service From</th>
        <td><select name="servicefrom">
				<option value="">Choose an Service</option>
				<cfloop query="getservice">
				<option value="#servi#">#desp# - #servi#</option>
				</cfloop>
			</select>		</td>
    </tr>
    <tr> 
        <th>Service To</th>
        <td><select name="serviceto">
				<option value="">Choose an Service</option>
				<cfloop query="getservice">
				<option value="#servi#">#desp# - #servi#</option>
				</cfloop>
			</select>		</td>
    </tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
	<tr> 
        <th>project From</th>
        <td><select name="projectfrom">
					<cfquery name="getproject" datasource="#dts#">
						select source,project from project order by source
					</cfquery>
					<option value="">Choose an Project</option>
					<cfloop query="getproject">
					<option value="#getproject.source#">#getproject.source# - #getproject.project#</option>
					</cfloop>
			</select>		</td>
    </tr>
    <tr> 
        <th>project To</th>
        <td><select name="projectto">
				
					<cfquery name="getproject" datasource="#dts#">
						select source,project from project order by source
					</cfquery>
					<option value="">Choose an Project</option>
					<cfloop query="getproject">
					<option value="#getproject.source#">#getproject.source# - #getproject.project#</option>
					</cfloop>

			</select>		</td>
    </tr>
    <tr> 
        <td colspan="2"><hr></td>
    </tr>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>   
	 
</table>

</cfoutput>
</form>
</body>
</html>