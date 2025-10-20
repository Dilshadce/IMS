<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Sales Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
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
		var inputtext = document.saleslist.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.saleslist.searchitemfr.value;
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
		var inputtext = document.saleslist.searchcatefr.value;
		DWREngine._execute(_reportflocation, null, 'categorylookup', inputtext, getCategoryResult);
	}else{
		var inputtext = document.saleslist.searchcateto.value;
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
		var inputtext = document.saleslist.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.saleslist.searchgroupto.value;
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
function getCust(type,option){
	if(type == 'custfrom'){
		var inputtext = document.saleslist.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
		
	}
	else{
		var inputtext = document.saleslist.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult2);
	}
}

function getCustResult(suppArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", suppArray,"KEY", "VALUE");
}

function getCustResult2(suppArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", suppArray,"KEY", "VALUE");
}
// end: supplier search

</script>

</head>
<cfset type ="customerlist">
		<cfset trantype = "CUSTOMER ITEM SALES LISTING">

<!---cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery--->

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
<!--- <h2>Print #trantype# Report</h2> --->
<h3>
	<a><font size="2">Print Login and Logout REPORT</font></a>
</h3>


	<cfquery name="users" datasource="main">
		select userID,userName from users where userBranch="#dts#" and userGrpID<>'Super'
	</cfquery>
	

	<cfform name="reports" action="logoutreport2.cfm" method="post" target="_blank">
    
<table width="60%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">


	 <input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />
  
	<tr> 
        <th>User From</th>
        <td><select name="UserFrom">
				<option value="">Choose an User</option>
				<cfloop query="users">
				<option value="#userID#">#userID# - #userName#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr> 
        <th>User To</th>
        <td><select name="userto">
				<option value="">Choose an User</option>
				<cfloop query="users">
				<option value="#UserID#">#userID# - #userName#</option>
				</cfloop>
			</select>
		</td>
    </tr>    
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <tr> 
    	<th>Date From</th>
        <td><cfinput name="datefrom" type="text" value="" maxlength="10" size="10" validate="eurodate" message="Wrong date format!"> (DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Date To</th>
        <td><cfinput name="dateto" type="text" value="" maxlength="10" size="10" validate="eurodate" message="Wrong date format!" > (DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>      
</table>
</cfform>

<script type="text/javascript">
	function disable1()
		{
			if(document.saleslist.show.value == "all")
				{document.saleslist.custfrom.disabled = false;
				document.saleslist.custto.disabled = false;
				document.saleslist.custfrom.value = "";
				document.saleslist.custto.value = "";}
			else
				{document.saleslist.custfrom.disabled = true;
				document.saleslist.custto.disabled = true;
				document.saleslist.custfrom.value = "";
				document.saleslist.custto.value = "";}
		}
	function disable2()
	{
		if(document.saleslist.show.value == "option")
			{document.saleslist.custfrom.disabled = true;
			document.saleslist.custto.disabled = true;
			document.saleslist.custfrom.value = "";
			document.saleslist.custto.value = "";}
		else
			{document.saleslist.custfrom.disabled = false;
			document.saleslist.custto.disabled = false;
			document.saleslist.custfrom.value = "";
			document.saleslist.custto.value = "";}
	}
</script>

<script language="JavaScript">
	function displaymonth(){
	
	if(document.saleslist.periodfrom.value=="")
	{	document.saleslist.periodto.value = "";}
	
	if(document.saleslist.periodfrom.value=='01')		
	{	document.saleslist.monthfrom.value='#vmonthto1#'; }
		
	else if(document.saleslist.periodfrom.value=='02')	
	{	document.saleslist.monthfrom.value='#vmonthto2#'; }
	
	else if(document.saleslist.periodfrom.value=='03')	
	{	document.saleslist.monthfrom.value='#vmonthto3#'; }
	
	else if(document.saleslist.periodfrom.value=='04')	
	{	document.saleslist.monthfrom.value='#vmonthto4#'; }
	
	else if(document.saleslist.periodfrom.value=='05')	
	{	document.saleslist.monthfrom.value='#vmonthto5#'; }
	
	else if(document.saleslist.periodfrom.value=='06')	
	{	document.saleslist.monthfrom.value='#vmonthto6#'; }
	
	else if(document.saleslist.periodfrom.value=='07')	
	{	document.saleslist.monthfrom.value='#vmonthto7#'; }
	
	else if(document.saleslist.periodfrom.value=='08')	
	{	document.saleslist.monthfrom.value='#vmonthto8#'; }
	
	else if(document.saleslist.periodfrom.value=='09')	
	{	document.saleslist.monthfrom.value='#vmonthto9#'; }
	
	else if(document.saleslist.periodfrom.value=='10')	
	{	document.saleslist.monthfrom.value='#vmonthto10#'; }
	
	else if(document.saleslist.periodfrom.value=='11')	
	{	document.saleslist.monthfrom.value='#vmonthto11#'; }
	
	else if(document.saleslist.periodfrom.value=='12')	
	{	document.saleslist.monthfrom.value='#vmonthto12#'; }
	
	else if(document.saleslist.periodfrom.value=='13')	
	{	document.saleslist.monthfrom.value='#vmonthto13#'; }
	
	else if(document.saleslist.periodfrom.value=='14')	
	{	document.saleslist.monthfrom.value='#vmonthto14#'; }
	
	else if(document.saleslist.periodfrom.value=='15')	
	{	document.saleslist.monthfrom.value='#vmonthto15#'; }
	
	else if(document.saleslist.periodfrom.value=='16')	
	{	document.saleslist.monthfrom.value='#vmonthto16#'; }
	
	else if(document.saleslist.periodfrom.value=='17')	
	{	document.saleslist.monthfrom.value='#vmonthto17#'; }
	
	else if(document.saleslist.periodfrom.value=='18')	
	{	document.saleslist.monthfrom.value='#vmonthto18#'; }
	
	if(document.saleslist.periodto.value=='01')		
	{	document.saleslist.monthto.value='#vmonthto1#'; }
		
	else if(document.saleslist.periodto.value=='02')	
	{	document.saleslist.monthto.value='#vmonthto2#'; }
	
	else if(document.saleslist.periodto.value=='03')	
	{	document.saleslist.monthto.value='#vmonthto3#'; }
	
	else if(document.saleslist.periodto.value=='04')	
	{	document.saleslist.monthto.value='#vmonthto4#'; }
	
	else if(document.saleslist.periodto.value=='05')	
	{	document.saleslist.monthto.value='#vmonthto5#'; }
	
	else if(document.saleslist.periodto.value=='06')	
	{	document.saleslist.monthto.value='#vmonthto6#'; }
	
	else if(document.saleslist.periodto.value=='07')	
	{	document.saleslist.monthto.value='#vmonthto7#'; }
	
	else if(document.saleslist.periodto.value=='08')	
	{	document.saleslist.monthto.value='#vmonthto8#'; }
	
	else if(document.saleslist.periodto.value=='09')	
	{	document.saleslist.monthto.value='#vmonthto9#'; }
	
	else if(document.saleslist.periodto.value=='10')	
	{	document.saleslist.monthto.value='#vmonthto10#'; }
	
	else if(document.saleslist.periodto.value=='11')	
	{	document.saleslist.monthto.value='#vmonthto11#'; }
	
	else if(document.saleslist.periodto.value=='12')	
	{	document.saleslist.monthto.value='#vmonthto12#'; }
	
	else if(document.saleslist.periodto.value=='13')	
	{	document.saleslist.monthto.value='#vmonthto13#'; }
	
	else if(document.saleslist.periodto.value=='14')	
	{	document.saleslist.monthto.value='#vmonthto14#'; }
	
	else if(document.saleslist.periodto.value=='15')	
	{	document.saleslist.monthto.value='#vmonthto15#'; }
	
	else if(document.saleslist.periodto.value=='16')	
	{	document.saleslist.monthto.value='#vmonthto16#'; }
	
	else if(document.saleslist.periodto.value=='17')	
	{	document.saleslist.monthto.value='#vmonthto17#'; }
	
	else if(document.saleslist.periodto.value=='18')	
	{	document.saleslist.monthto.value='#vmonthto18#'; }
	
	}
</script>
</cfoutput>

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
</body>
</html>