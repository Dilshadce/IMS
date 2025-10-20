<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Daily Checkout Report</title>
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

<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>


<!---cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery--->

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentuserid,AGENTLISTUSERID,lTEAM from gsetup
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
	<a><font size="2">Print Cash Sales Voucher Report</font></a></h3>

<cfquery name="getteam" datasource="#dts#">
		select team,desp from icteam order by team;
	</cfquery>


	<cfquery name="getarea" datasource="#dts#">
		select area,desp from icarea order by area 
	</cfquery>
    
    <cfquery name="getuserid" datasource="main">
		select userid,username from users where userbranch='#dts#'
        <cfif husergrpid eq 'super' or husergrpid eq 'admin'>
        <cfelse>
        and userid ='#huserid#'
        </cfif>
	</cfquery>
	

	<cfquery name="getcust" datasource="#dts#">
		select custno, name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
	</cfquery>
    
    
	
	<cfquery name="getcate" datasource="#dts#">
		select cate,desp from iccate order by cate
	</cfquery>
	
	<cfquery name="getgroup" datasource="#dts#">
		select wos_group,desp from icgroup order by wos_group
	</cfquery>
	
    <cfquery name="getcounter" datasource="#dts#">
		select counterid from counter order by counterid
	</cfquery>
	
	<cfquery name="getitem" datasource="#dts#">
		select itemno, desp from icitem order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
	</cfquery>
    
    <cfquery name="getlocation" datasource="#dts#">
		select <cfif (lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser"> substring_index(location,'-',1) as </cfif>location,<cfif (lcase(hcomid) eq "swisspost_i" or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser"> substring_index(location,'-',1) as </cfif>desp 
		from iclocation
        where 1=1 
		<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
			 and location in (#ListQualify(Huserloc,"'",",")#)
		</cfif>
        <cfif (lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser">
        	group by substring_index(location,'-',1)
		</cfif>
		order by <cfif (lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser">substring_index(location,'-',1)<cfelse>location</cfif>
	</cfquery>
	<form name="saleslist" action="cashsalesvoucher2.cfm?alown=#alown#" method="post" target="_blank">


<table width="70%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	
	
    <cfquery name="getagent" datasource="#dts#">
						select agent,desp from #target_icagent# where 0=0
                        <cfif alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and  ucase(agent)='#ucase(huserid)#'
					</cfif>
					<cfelse>
					
					</cfif> order by agent
					</cfquery>
                    
                    
               
	<tr> 
    	<th>#getgeneral.lAGENT# From</th>
        <td><select name="agentfrom">
				
					
					<option value="">Choose an #getgeneral.lAGENT#</option>
					<cfloop query="getagent">
					<option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
					</cfloop>

			</select>		</td>
    </tr>
    <tr> 
        <th>#getgeneral.lAGENT# To</th>
        <td><select name="agentto">
				
					<option value="">Choose an #getgeneral.lAGENT#</option>
					<cfloop query="getagent">
					<option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
					</cfloop>
			</select>		</td>
    </tr>
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <tr> 
    	<th>Counter</th>
        <td><select name="counter">
        
					<option value="">Choose a counter</option>
					<cfloop query="getcounter">
					<option value="#getcounter.counterid#">#getcounter.counterid#</option>
					</cfloop>

			</select>		</td>
    </tr>
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <tr> 
    	<th>User From</th>
        <td><select name="userfrom">
        
					<cfif husergrpid eq 'super' or husergrpid eq 'admin'>>
					<option value="">Choose an User</option>
                    </cfif>
					<cfloop query="getuserid">
					<option value="#getuserid.userid#">#getuserid.userid# - #getuserid.username#</option>
					</cfloop>

			</select>		</td>
    </tr>
    <tr> 
        <th>User To</th>
        <td><select name="userto">
					<cfif husergrpid eq 'super' or husergrpid eq 'admin'>>
					<option value="">Choose an User</option>
                    </cfif>
					<cfloop query="getuserid">
					<option value="#getuserid.userid#">#getuserid.userid# - #getuserid.username#</option>
					</cfloop>
			</select>		</td>
    </tr>
	
	
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <tr> 
        <th>Period From</th>
        <td><select name="periodfrom" onChange="displaymonth()">
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
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			</select>&nbsp;<input type="text" name="monthfrom" value="" size="6" readonly>		</td>
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
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			</select>&nbsp;<input type="text" name="monthto" value="" size="6" readonly>		</td>
    </tr>
    <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <tr> 
        	<th><cfoutput>#getgeneral.lLOCATION#</cfoutput> From</th>
            
            <td colspan="2">
            	<select name="locfrom">
	                	<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
	          				<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
						</cfif>
					<!--- <option value="">Choose a Location</option> --->
                    <cfloop query="getlocation"> 
                    	<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                    </cfloop>
                </select>
            </td>
		</tr>
        
		<tr>
        	<th><cfoutput>#getgeneral.lLOCATION#</cfoutput> To</th>
            <td width="69%">
            	<select name="locto">
					
						<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
	          				<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
						</cfif>
					
                	<!--- <option value="">Choose a Location</option> --->
                    <cfloop query="getlocation"> 
                        <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                    </cfloop>
                </select>
            </td>
            
        </tr>
        <tr> 
        <td colspan="4"><hr></td>
    </tr>
    <tr> 
    	<th>Date From</th>
        <td><input type="text" name="datefrom" value="#dateformat(now(),'DD/MM/YYYY')#" maxlength="10" size="11"> (DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Date To</th>
        <td><input type="text" name="dateto"  value="#dateformat(now(),'DD/MM/YYYY')#" maxlength="10" size="11"> (DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>      
</table>
</form>

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



</body>
</html>