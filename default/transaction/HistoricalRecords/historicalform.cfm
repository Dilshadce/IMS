<html>
<head>
<title>Historical Reports</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../../stylesheet/stylesheet.css">
<script language="javascript" src="../../../scripts/date_format.js"></script>

<script type='text/javascript' src='../../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../../ajax/core/settings.js'></script>

<script type="text/javascript">
// begin: product search
function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.historicalreports.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.historicalreports.searchitemfr.value;
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

// begin: group search
function getGroup(type){
	if(type == 'groupfrom'){
		var inputtext = document.historicalreports.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.historicalreports.searchgroupto.value;
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
		var inputtext = document.historicalreports.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else if(type == 'suppto'){
		var inputtext = document.historicalreports.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult2);
	}
	else if(type == 'custfrom'){
		var inputtext = document.historicalreports.searchcustfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
	}
	else if(type == 'custto'){
		var inputtext = document.historicalreports.searchcustto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult2);
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

function getCustResult(custArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", custArray,"KEY", "VALUE");
}

function getCustResult2(custArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", custArray,"KEY", "VALUE");
}
// end: supplier search
</script>
</head>

<cfquery name="getcate" datasource="#dts#">
	select cate,desp from iccate order by cate
</cfquery>

<cfquery name="getuser" datasource="#dts#">
	select * from driver 
</cfquery> 

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>

<cfquery name="getarea" datasource="#dts#">
	select area,desp from icarea order by area 
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
<cfset newdate = #CreateDate(newyear, newmonth, newmonth)#>
<cfset vmonth = dateformat(newdate,"mmm yy")>

<cfset xnewmonth = newmonth + 11>	
<cfif xnewmonth gt 12>
	<cfset xnewmonth = xnewmonth - 12>
	<cfset xnewyear = newyear + 1>
<cfelse>
	<cfset xnewyear = newyear>
</cfif>
<cfset xnewdate = #CreateDate(xnewyear, xnewmonth, xnewmonth)#>

<cfset vmonthto = dateformat(xnewdate,"mmm yy")>

<!--- period 1 --->

<cfset newmonth1 = clsmonth + 1>	
<cfif newmonth1 gt 12>
	<cfset newmonth1 = newmonth1 - 12>
	<cfset newyear1 = clsyear + 1>
<cfelse>
	<cfset newyear1 = clsyear>
</cfif>
<cfset newdate1 = #CreateDate(newyear1, newmonth1, newmonth1)#>
<cfset vmonthto1 = dateformat(newdate1,"mmm yy")>

<!--- period 2 --->
<cfset newmonth2 = clsmonth + 2>	
<cfif newmonth2 gt 12>
	<cfset newmonth2 = newmonth2 - 12>
	<cfset newyear2 = clsyear + 1>
<cfelse>
	<cfset newyear2 = clsyear>
</cfif>
<cfset newdate2 = #CreateDate(newyear2, newmonth2, newmonth2)#>
<cfset vmonthto2 = dateformat(newdate2,"mmm yy")>
<!--- period 3 --->
<cfset newmonth3 = clsmonth + 3>	
<cfif newmonth3 gt 12>
	<cfset newmonth3 = newmonth3 - 12>
	<cfset newyear3= clsyear + 1>
<cfelse>
	<cfset newyear3 = clsyear>
</cfif>
<cfset newdate3 = #CreateDate(newyear3, newmonth3, newmonth3)#>
<cfset vmonthto3 = dateformat(newdate3,"mmm yy")>
<!--- period 4--->
<cfset newmonth4 = clsmonth + 4>	
<cfif newmonth4 gt 12>
	<cfset newmonth4 = newmonth4 - 12>
	<cfset newyear4= clsyear + 1>
<cfelse>
	<cfset newyear4 = clsyear>
</cfif>
<cfset newdate4 = #CreateDate(newyear4, newmonth4, newmonth4)#>
<cfset vmonthto4 = dateformat(newdate4,"mmm yy")>

<!--- period 5--->
<cfset newmonth5 = clsmonth + 5>	
<cfif newmonth5 gt 12>
	<cfset newmonth5 = newmonth5 - 12>
	<cfset newyear5= clsyear + 1>
<cfelse>
	<cfset newyear5 = clsyear>
</cfif>
<cfset newdate5 = #CreateDate(newyear5, newmonth5, newmonth5)#>
<cfset vmonthto5 = dateformat(newdate5,"mmm yy")>
<!--- period 6--->
<cfset newmonth6 = clsmonth + 6>	
<cfif newmonth6 gt 12>
	<cfset newmonth6 = newmonth6 - 12>
	<cfset newyear6= clsyear + 1>
<cfelse>
	<cfset newyear6 = clsyear>
</cfif>
<cfset newdate6 = #CreateDate(newyear6, newmonth6, newmonth6)#>
<cfset vmonthto6 = dateformat(newdate6,"mmm yy")>

<!--- period 7--->
<cfset newmonth7 = clsmonth + 7>	
<cfif newmonth7 gt 12>
	<cfset newmonth7 = newmonth7 - 12>
	<cfset newyear7= clsyear + 1>
<cfelse>
	<cfset newyear7 = clsyear>
</cfif>
<cfset newdate7 = #CreateDate(newyear7, newmonth7, newmonth7)#>
<cfset vmonthto7 = dateformat(newdate7,"mmm yy")>
<!--- period 8--->
<cfset newmonth8 = clsmonth + 8>	
<cfif newmonth8 gt 12>
	<cfset newmonth8 = newmonth8 - 12>
	<cfset newyear8= clsyear + 1>
<cfelse>
	<cfset newyear8 = clsyear>
</cfif>
<cfset newdate8 = #CreateDate(newyear8, newmonth8, newmonth8)#>
<cfset vmonthto8 = dateformat(newdate8,"mmm yy")>
<!--- period 9--->
<cfset newmonth9 = clsmonth + 9>	
<cfif newmonth9 gt 12>
	<cfset newmonth9 = newmonth9 - 12>
	<cfset newyear9= clsyear + 1>
<cfelse>
	<cfset newyear9 = clsyear>
</cfif>
<cfset newdate9 = #CreateDate(newyear9, newmonth9, newmonth9)#>
<cfset vmonthto9 = dateformat(newdate9,"mmm yy")>
<!--- period 10--->
<cfset newmonth10 = clsmonth + 10>	
<cfif newmonth10 gt 12>
	<cfset newmonth10 = newmonth10 - 12>
	<cfset newyear10= clsyear + 1>
<cfelse>
	<cfset newyear10 = clsyear>
</cfif>
<cfset newdate10 = #CreateDate(newyear10, newmonth10, newmonth10)#>
<cfset vmonthto10 = dateformat(newdate10,"mmm yy")>
<!--- period 11--->
<cfset newmonth11 = clsmonth + 11>	
<cfif newmonth11 gt 12>
	<cfset newmonth11 = newmonth11 - 12>
	<cfset newyear11= clsyear + 1>
<cfelse>
	<cfset newyear11 = clsyear>
</cfif>
<cfset newdate11 = #CreateDate(newyear11, newmonth11, newmonth11)#>
<cfset vmonthto11 = dateformat(newdate11,"mmm yy")>
<!--- period 12--->
<cfset newmonth12 = clsmonth + 12>	
<cfif newmonth12 gt 12>
	<cfset newmonth12 = newmonth12 - 12>
	<cfset newyear12= clsyear + 1>
<cfelse>
	<cfset newyear12 = clsyear>
</cfif>
<cfset newdate12 = #CreateDate(newyear12, newmonth12, newmonth12)#>
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
<cfset newdate13 = #CreateDate(newyear13, newmonth13, newmonth13)#>
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
<cfset newdate14 = #CreateDate(newyear14, newmonth14, newmonth14)#>
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
<cfset newdate15 = #CreateDate(newyear15, newmonth15, newmonth15)#>
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
<cfset newdate16 = #CreateDate(newyear16, newmonth16, newmonth16)#>
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
<cfset newdate17 = #CreateDate(newyear17, newmonth17, newmonth17)#>
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
<cfset newdate18 = #CreateDate(newyear18, newmonth18, newmonth18)#>
<cfset vmonthto18 = dateformat(newdate18,"mmm yy")>

<body>
<cfoutput>

<cfif historical eq "ViewBatchSummary">
<h2>Print View Batch Summary</h2>
	<form name="historicalreports" action="historical1.cfm?type=ViewBatchSummary" method="post" target="_blank">
	<table width="60%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
		<tr> 
        	<th>Period From</th>
        	<td><select name="periodfrom" onChange="displaymonth()">
				<option value="">Choose a Period</option>
				<option value="01" selected>1</option>
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
				<option value="12" selected>12</option>
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
			<td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
	</form>
<cfelseif historical eq "ListHistoricalBills">
	<cfquery name="getagent" datasource="#dts#">
		select agent,desp from #target_icagent# order by agent
	</cfquery>
	<cfquery name="getref" datasource="#dts#">
		select refno from artran where (type<>"do" and type<>"so" and type<>"quo" and type<>"po") order by refno
	</cfquery>
	<cfquery name="getdo" datasource="#dts#">
		select refno from artran where type="do" order by refno
	</cfquery>
	<cfquery name="getcust" datasource="#dts#">
		select custno, name from #target_arcust# order by custno
	</cfquery>
	<cfquery name="getsupp" datasource="#dts#">
		select name, custno from #target_apvend# order by custno
	</cfquery>
	
	<h2>Print List Historical Bills</h2>
	<form name="historicalreports" action="historical2.cfm?type=ListHistoricalBills" method="post" target="_blank">
	<table width="70%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
		<tr> 
        	<th>Period From</th>
        	<td><select name="periodfrom" onChange="displaymonth()">
				<option value="">Choose a Period</option>
				<option value="01" selected>1</option>
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
				<option value="12" selected>12</option>
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
			<td colspan="3"><hr></td>
		</tr>
		<tr> 
    		<th>Date From</th>
        	<td><input type="text" name="datefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> (DD/MM/YYYY)</td>
    	</tr>
    	<tr> 
        	<th>Date To</th>
        	<td><input type="text" name="dateto" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> (DD/MM/YYYY)</td>
    	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
		  	<th nowrap>Ref No From</th>
        	<td><select name="reffrom">
				<option value="">Choose a Ref No</option>
				<cfloop query="getref">
				<option value="#refno#">#refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
      	<tr> 
        	<th>Ref No To</th>
        	<td><select name="refto">
				<option value="">Choose a Ref No</option>
				<cfloop query="getref">
				<option value="#refno#">#refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
		  	<th nowrap>D.O No From</th>
        	<td><select name="dofrom">
				<option value="">Choose a D.O No</option>
				<cfloop query="getdo">
				<option value="#refno#">#refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
      	<tr> 
        	<th>D.O No To</th>
        	<td><select name="doto">
				<option value="">Choose a D.O No</option>
				<cfloop query="getdo">
				<option value="#refno#">#refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
		  	<th nowrap>Customer From</th>
        	<td><select name="custfrom">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcustfr" onKeyUp="getSupp('custfrom','Customer');">
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
					<input type="text" name="searchcustto" onKeyUp="getSupp('custto','Customer');">
				</cfif>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
		  	<th nowrap>Supplier From</th>
        	<td><select name="suppfrom">
				<option value="">Choose a Supplier</option>
				<cfloop query="getsupp">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchsuppfr" onKeyUp="getSupp('suppfrom','Supplier');">
				</cfif>
			</td>
      	</tr>
      	<tr> 
        	<th>Supplier To</th>
        	<td><select name="suppto">
				<option value="">Choose a Supplier</option>
				<cfloop query="getsupp">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchsuppto" onKeyUp="getSupp('suppto','Supplier');">
				</cfif>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
			<th>Term From</th>
			<td><input size="4" type="text" name="termfrom" maxlength="4"></td>
		</tr>
		<tr>
			<th>Term To</th>
			<td><input size="4" type="text" name="termto" maxlength="4"></td>
		</tr>
	  	<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr> 
        	<th>Agent From</th>
        	<td><select name="agentfrom">
				<option value="">Choose an Agent</option>
				<cfloop query="getagent">
				<option value="#agent#">#agent# - #desp#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
      	<tr> 
        	<th>Agent To</th>
        	<td><select name="agentto">
				<option value="">Choose an Agent</option>
				<cfloop query="getagent">
				<option value="#agent#">#agent# - #desp#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
			<th>Mark Type to Send</th>
			<td><h3><font size="1"><b>* System will consider all the type below if you unclick all of them !</b></font></h3></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="rc" checked> 'RC' Receive</td>
			<td><input type="checkbox" name="marktype" value="pr" checked> 'PR' Purchase Return</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="inv" checked> 'INV' Invoice</td>
			<td><input type="checkbox" name="marktype" value="do" checked> 'DO' Delivery Order</td>
		</tr>
		<tr>	
			<td><input type="checkbox" name="marktype" value="cs" checked> 'CS' Cash Sale</td>
			<td><input type="checkbox" name="marktype" value="cn" checked> 'CN' Credit Note</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="dn" checked> 'DN' Debit Note</td>
			<td><input type="checkbox" name="marktype" value="iss" checked> 'ISS' Issue</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="oai" checked> 'OAI' Adjustment Increace</td>
			<td><input type="checkbox" name="marktype" value="oar" checked> 'OAR' Adjustment Reduce</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="tr" checked> 'TR' Transfer</td>
		</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
			<th>Sort Method</th>
		</tr>
		<tr>
			<td><input type="checkbox" name="sort" value="wos_date"> Sort By Date</td>
			<td><input type="checkbox" name="sort" value="agenno"> Sort By Agent No</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="sort" value="custno" checked> Sort By Cust/Supp No</td>
			<td><input type="checkbox" name="sort" value="fperiod,type,refno"> Sort By Period + Type + Ref No</td>
		</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
			<th>Display Method</th>
		</tr>
		<tr><td><input type="radio" name="display" id="1" value="Post"> Post</td></tr>
		<tr><td><input type="radio" name="display" id="1" value="Unpost"> Unpost</td></tr>
		<tr><td><input type="radio" name="display" id="1" value="All" checked> All</td></tr>
		<tr> 
			<td colspan="3" align="right"><input type="submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
	</form>
<cfelseif historical eq "ListHistoricalPrice">
<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

	<cfquery name="getitem" datasource="#dts#">
		select itemno, desp from icitem order by itemno
	</cfquery>
	<cfquery name="getgroup" datasource="#dts#">
		select wos_group, desp from icgroup order by wos_group
	</cfquery>
	<cfquery name="getcust" datasource="#dts#">
		select custno, name from #target_arcust# order by custno
	</cfquery>
	<cfquery name="getsupp" datasource="#dts#">
		select name, custno from #target_apvend# order by custno
	</cfquery>
	<cfquery name="getlocation" datasource="#dts#">
		select location,desp from iclocation 
		<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
			where location in (#ListQualify(Huserloc,"'",",")#)
		</cfif>
		order by location
	</cfquery>
	<cfquery name = "getagent" datasource = "#dts#">
		select agent,desp from #target_icagent# order by agent
	</cfquery>
	<cfquery name="getref" datasource="#dts#">
		select refno from artran where (type<>"do" and type<>"so" and type<>"quo" and type<>"po") and refno <> '' and fperiod <> '99' group by refno order by refno
	</cfquery>
<h2>Print List Historical Price</h2>
	<form name="historicalreports" action="historical3.cfm?type=ListHistoricalPrice" method="post" target="_blank">
	<table width="70%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
		<tr>
			<th width="25%">Mark Type to Send</th>
			<td width="75%"><h3><font size="1"><b>* System will consider all the type below if you unclick all of them !</b></font></h3></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="rc"> 'RC' Receive</td>
			<td><input type="checkbox" name="marktype" value="pr"> 'PR' Purchase Return</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="inv" checked> 'INV' Invoice</td>
			<td><input type="checkbox" name="marktype" value="do"> 'DO' Delivery Order</td>
		</tr>
		<tr>	
			<td><input type="checkbox" name="marktype" value="cs"> 'CS' Cash Sale</td>
			<td><input type="checkbox" name="marktype" value="cn"> 'CN' Credit Note</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="dn"> 'DN' Debit Note</td>
			<td><input type="checkbox" name="marktype" value="iss"> 'ISS' Issue</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="oai"> 'OAI' Adjustment Increace</td>
			<td><input type="checkbox" name="marktype" value="oar"> 'OAR' Adjustment Reduce</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="marktype" value="trin,trou"> 'TR' Transfer</td>
		</tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	    <tr>
			<th>Sort By</th>
			<td>
				<select name="sortby">
					<option value="wos_date">Date</option>
					<option value="location">Location</option>
					<option value="agenno">Bill Agent</option>
					<option value="type,refno" selected>Reference No</option>
					<option value="itemno,type,refno">Item No + Reference No</option>
					<option value="custno,type,refno">Cust/Supp No + Reference No</option>
				</select>
				&nbsp;&nbsp;&nbsp;<input type="checkbox" name="includeservice"> Include Service Item
			</td>
		</tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	    <tr>
			<th>Heading</th>
			<td>
				<input name="heading" value="" size="60">
			</td>
		</tr>
	    <tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
		<tr>
	      	<th width="20%">Item From</th>
	      	<td width="80%">
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
	      	<td>
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
	      	<td colspan="100%"><hr></td>
	    </tr>
	    <tr>
	      	<th>Group From</th>
	      	<td>
				<select name="groupfrom">
	          		<option value="">Choose a Group</option>
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
	      	<th>Group To</th>
	      	<td>
				<select name="groupto">
	          		<option value="">Choose a Group</option>
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
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
		  	<th nowrap>Customer From</th>
        	<td><select name="custfrom">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcustfr" onKeyUp="getSupp('custfrom','Customer');">
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
					<input type="text" name="searchcustto" onKeyUp="getSupp('custto','Customer');">
				</cfif>
			</td>
      	</tr>
		<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
		  	<th nowrap>Supplier From</th>
        	<td><select name="suppfrom">
				<option value="">Choose a Supplier</option>
				<cfloop query="getsupp">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchsuppfr" onKeyUp="getSupp('suppfrom','Supplier');">
				</cfif>
			</td>
      	</tr>
      	<tr> 
        	<th>Supplier To</th>
        	<td><select name="suppto">
				<option value="">Choose a Supplier</option>
				<cfloop query="getsupp">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchsuppto" onKeyUp="getSupp('suppto','Supplier');">
				</cfif>
			</td>
      	</tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
		<tr> 
        	<th>Period From</th>
        	<td>
				<select name="periodfrom">
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
      		<td colspan="100%"><hr></td>
   	 	</tr>
		<tr>
			<th>Date From</th>
      		<td>
				<input name="datefrom" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)
			</td>
		</tr>
		<tr>
			<th>Date To</th>
      		<td>
				<input name="dateto" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)
			</td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<th nowrap><cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> From</th>
			<td>
				<select name="locfrom">
					<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          				<option value="">Choose a <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif></option>
					</cfif>
					<cfloop query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<th nowrap><cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> To</th>
			<td>
				<select name="locto">
					<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
          				<option value="">Choose a <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif></option>
					</cfif>
					<cfloop query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<th nowrap>Bill Agent</th>
			<td>
				<select name="billagent">
					<option value="">Choose a Agent</option>
					<cfloop query="getagent">
						<option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
		  	<th nowrap>Ref No From</th>
        	<td><select name="reffrom">
				<option value="">Choose a Ref No</option>
				<cfloop query="getref">
				<option value="#refno#">#refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
      	<tr> 
        	<th>Ref No To</th>
        	<td><select name="refto">
				<option value="">Choose a Ref No</option>
				<cfloop query="getref">
				<option value="#refno#">#refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
        <tr>
			<td colspan="100%"><hr></td>
		</tr>
        <tr>
        <th>Show FOC Only</th>
        <td><input type="checkbox" name="showfoc" id="showfoc" value=""></td>
        </tr>
		<tr> 
			<td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
	</form>
<!---<cfelseif>
<cfelseif>
<cfelseif>
<cfelseif>--->
</cfif>

<script language="JavaScript">
	function displaymonth(){
		
	if(document.historicalreports.periodfrom.value=="")
	{	document.historicalreports.periodto.value = "";}
	
	if(document.historicalreports.periodfrom.value=='01')		
	{	document.historicalreports.monthfrom.value='#vmonthto1#'; }
		
	else if(document.historicalreports.periodfrom.value=='02')	
	{	document.historicalreports.monthfrom.value='#vmonthto2#'; }
	
	else if(document.historicalreports.periodfrom.value=='03')	
	{	document.historicalreports.monthfrom.value='#vmonthto3#'; }
	
	else if(document.historicalreports.periodfrom.value=='04')	
	{	document.historicalreports.monthfrom.value='#vmonthto4#'; }
	
	else if(document.historicalreports.periodfrom.value=='05')	
	{	document.historicalreports.monthfrom.value='#vmonthto5#'; }
	
	else if(document.historicalreports.periodfrom.value=='06')	
	{	document.historicalreports.monthfrom.value='#vmonthto6#'; }
	
	else if(document.historicalreports.periodfrom.value=='07')	
	{	document.historicalreports.monthfrom.value='#vmonthto7#'; }
	
	else if(document.historicalreports.periodfrom.value=='08')	
	{	document.historicalreports.monthfrom.value='#vmonthto8#'; }
	
	else if(document.historicalreports.periodfrom.value=='09')	
	{	document.historicalreports.monthfrom.value='#vmonthto9#'; }
	
	else if(document.historicalreports.periodfrom.value=='10')	
	{	document.historicalreports.monthfrom.value='#vmonthto10#'; }
	
	else if(document.historicalreports.periodfrom.value=='11')	
	{	document.historicalreports.monthfrom.value='#vmonthto11#'; }
	
	else if(document.historicalreports.periodfrom.value=='12')	
	{	document.historicalreports.monthfrom.value='#vmonthto12#'; }
	
	else if(document.historicalreports.periodfrom.value=='13')	
	{	document.historicalreports.monthfrom.value='#vmonthto13#'; }
	
	else if(document.historicalreports.periodfrom.value=='14')	
	{	document.historicalreports.monthfrom.value='#vmonthto14#'; }
	
	else if(document.historicalreports.periodfrom.value=='15')	
	{	document.historicalreports.monthfrom.value='#vmonthto15#'; }
	
	else if(document.historicalreports.periodfrom.value=='16')	
	{	document.historicalreports.monthfrom.value='#vmonthto16#'; }
	
	else if(document.historicalreports.periodfrom.value=='17')	
	{	document.historicalreports.monthfrom.value='#vmonthto17#'; }
	
	else if(document.historicalreports.periodfrom.value=='18')	
	{	document.historicalreports.monthfrom.value='#vmonthto18#'; }
	
	if(document.historicalreports.periodto.value=='01')		
	{	document.historicalreports.monthto.value='#vmonthto1#'; }
		
	else if(document.historicalreports.periodto.value=='02')	
	{	document.historicalreports.monthto.value='#vmonthto2#'; }
	
	else if(document.historicalreports.periodto.value=='03')	
	{	document.historicalreports.monthto.value='#vmonthto3#'; }
	
	else if(document.historicalreports.periodto.value=='04')	
	{	document.historicalreports.monthto.value='#vmonthto4#'; }
	
	else if(document.historicalreports.periodto.value=='05')	
	{	document.historicalreports.monthto.value='#vmonthto5#'; }
	
	else if(document.historicalreports.periodto.value=='06')	
	{	document.historicalreports.monthto.value='#vmonthto6#'; }
	
	else if(document.historicalreports.periodto.value=='07')	
	{	document.historicalreports.monthto.value='#vmonthto7#'; }
	
	else if(document.historicalreports.periodto.value=='08')	
	{	document.historicalreports.monthto.value='#vmonthto8#'; }
	
	else if(document.historicalreports.periodto.value=='09')	
	{	document.historicalreports.monthto.value='#vmonthto9#'; }
	
	else if(document.historicalreports.periodto.value=='10')	
	{	document.historicalreports.monthto.value='#vmonthto10#'; }
	
	else if(document.historicalreports.periodto.value=='11')	
	{	document.historicalreports.monthto.value='#vmonthto11#'; }
	
	else if(document.historicalreports.periodto.value=='12')	
	{	document.historicalreports.monthto.value='#vmonthto12#'; }
	
	else if(document.historicalreports.periodto.value=='13')	
	{	document.historicalreports.monthto.value='#vmonthto13#'; }
	
	else if(document.historicalreports.periodto.value=='14')	
	{	document.historicalreports.monthto.value='#vmonthto14#'; }
	
	else if(document.historicalreports.periodto.value=='15')	
	{	document.historicalreports.monthto.value='#vmonthto15#'; }
	
	else if(document.historicalreports.periodto.value=='16')	
	{	document.historicalreports.monthto.value='#vmonthto16#'; }
	
	else if(document.historicalreports.periodto.value=='17')	
	{	document.historicalreports.monthto.value='#vmonthto17#'; }
	
	else if(document.historicalreports.periodto.value=='18')	
	{	document.historicalreports.monthto.value='#vmonthto18#'; }
	
	}
</script>
</cfoutput>
</form>
</body>
</html>