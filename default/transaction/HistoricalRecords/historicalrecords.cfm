<html>
<head>
<title>Historical Records</title>
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
		var inputtext = document.historicalrecords.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.historicalrecords.searchitemfr.value;
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
		var inputtext = document.historicalrecords.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.historicalrecords.searchgroupto.value;
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
		var inputtext = document.historicalrecords.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else if(type == 'suppto'){
		var inputtext = document.historicalrecords.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult2);
	}
	else if(type == 'custfrom'){
		var inputtext = document.historicalrecords.searchcustfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
	}
	else if(type == 'custto'){
		var inputtext = document.historicalrecords.searchcustto.value;
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

<cfquery name="getagent" datasource="#dts#">
		select agent,desp from #target_icagent# order by agent
	</cfquery>

<cfquery name="getuser" datasource="#dts#">
	select * from driver 
</cfquery>

<cfquery name="getterm" datasource="#dts#">
  select * from #target_icterm# order by term
</cfquery>

<cfquery name="getproject" datasource="#dts#">
	select * from #target_project# 
</cfquery> 


<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,brem1,brem2,brem3,brem4,lgroup from gsetup
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

<cfif historical eq "ListHistoricalBillsOrder">
	<cfquery name="getagent" datasource="#dts#">
		select agent from #target_icagent# order by agent
	</cfquery>
	<cfquery name="getref" datasource="#dts#">
		select refno from artran where type in ('SO','PO','QUO','SAM') and refno <> '' and fperiod <> '99' group by refno order by refno
	</cfquery>
	<!--- <cfquery name="getdo" datasource="#dts#">
		select refno from artran where type="do" order by refno
	</cfquery> --->
	<cfquery name="getcust" datasource="#dts#">
		select custno, name from #target_arcust# order by custno
	</cfquery>
	<cfquery name="getsupp" datasource="#dts#">
		select name, custno from #target_apvend# order by custno
	</cfquery>
	
	<h2>Print List Historical Bills Order</h2>
	<form name="historicalrecords" action="historical4.cfm?type=ListHistoricalBillsOrder" method="post" target="_blank">
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
			<th>Bill Type</th>
			<td><select name="billtype">
				<option value="">Choose a Type</option>
				<option value="PO">Purchase Order</option>
				<option value="SO">Sales Order</option>
				<option value="QUO">Quotation</option>
				<option value="SAMPLE">Sample</option>
				</select></td>
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
		</tr><tr> 
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
        	<th>Agent</th>
        	<td><select name="agent" id="select">
			
				<option value="">Choose a Agent</option>
			
			<cfloop query="getagent">
				<option value="#getagent.agent#">#getagent.agent#</option>
			</cfloop>
			</select>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
	<!--- 	<cfif billtype eq "PO"> --->
		<tr>
		  	<th nowrap>Supplier From</th>
        	<td><select name="suppfrom">
				<option value="">Choose a Supplier</option>
				<cfloop query="getsupp">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input size="10" type="text" name="searchsuppfr" onKeyUp="getSupp('suppfrom','Supplier');">
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
					<input size="10" type="text" name="searchsuppto" onKeyUp="getSupp('suppto','Supplier');">
				</cfif>
	
			</td>
      	</tr><tr> 
			<td colspan="3"><hr></td>
		</tr>
		<!--- <cfelse> --->
	<tr>
		  	<th nowrap>Customer From</th>
        	<td><select name="custfrom">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input size="12" type="text" name="searchcustfr" onKeyUp="getSupp('custfrom','Customer');">
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
					<input size="12" type="text" name="searchcustto" onKeyUp="getSupp('custto','Customer');">
				</cfif>
			</td>
      	</tr><!--- </cfif> --->
		
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<tr>
			<th>Term</th>
			<td><select name="terms" id="terms">
				<option value="">Choose a Terms</option>
				<cfloop query="getterm">
					<option value="#term#">#term#</option>
				</cfloop>
			</select></td>
		</tr>
		
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
		<!--- <tr>
			<th>Sort Method</th>
		</tr>
		
		<tr>
			<td><input type="checkbox" name="sort" value="custno" checked> Sort By Cust/Supp No</td>
			<td><input type="checkbox" name="sort" value="wos_date,type,refno"> Sort By Date + Type + Ref No</td>
			
		</tr>
		<tr>
		<td><input type="checkbox" name="sort" value="fperiod,type,refno"> Sort By Period + Type + Ref No</td>
		</tr> --->
		<tr>
			<th>Sort Method</th>
			<td>
				<select name="sort">
					<option value="custno" selected>By Cust/Supp No</option>
					<option value="wos_date,type,refno">By Date + Type + Ref No</option>
					<option value="fperiod,type,refno">By Period + Type + Ref No</option>
				</select>
			</td>
		</tr>
		<tr> 
			<td colspan="3" align="right"><input type="submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
	</form>
<cfelseif historical eq "ListHistoricalItemsOrder">
	<cfif lcase(hcomid) neq "nikbra_i">
		<cfquery name="getitem" datasource="#dts#">
			select itemno, desp from icitem order by itemno
		</cfquery>
	</cfif>	
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
		select refno from artran where type in ('SO','PO','QUO','SAM') and refno <> '' and fperiod <> '99' group by refno order by refno
	</cfquery>
	<!--- <cfquery name="getdo" datasource="#dts#">
		select refno from artran where type="do" order by refno
	</cfquery> --->
<h2>Print List Historical Items Order</h2>
	<form name="historicalrecords" action="historical5.cfm?type=ListHistoricalItemOrdes" method="post" target="_blank">
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
				</select>&nbsp;<input type="text" name="monthfrom" value="#vmonth#" size="6" readonly>			</td>
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
				</select>&nbsp;<input type="text" name="monthto" value="#vmonthto#" size="6" readonly>			</td>
      	</tr>
		<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<th>Type</th>
			<td><select name="type">
				<option value="">Choose a Type</option>
				<option value="PO">Purchase Order</option>
				<option value="SO">Sales Order</option>
				<option value="QUO">Quotation</option>
				<option value="SAM">Sample</option>
				</select></td>
		</tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	    <cfif lcase(hcomid) eq "nikbra_i">
		    <tr>
		      	<th width="20%">Item</th>
		      	<td width="80%">
					<input type="text" name="searchitemfr">
				</td>
		    </tr>
	    <cfelse>
			<tr>
		      	<th width="20%">Item From</th>
		      	<td width="80%">
					<select name="itemfrom">
		          		<option value="">Choose an Item</option>
		          		<cfloop query="getitem">
							<option value="#getitem.itemno#">#getitem.itemno# - #getitem.desp#</option>
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
							<option value="#getitem.itemno#">#getitem.itemno# - #getitem.desp#</option>
						</cfloop>
					</select>
					<cfif getgeneral.filterall eq "1">
						<input type="text" name="searchitemto" onKeyUp="getProduct('itemto');">
					</cfif>
				</td>
		    </tr>
		</cfif>
	    <tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	   
	    <tr>
	      	<th><!---Group--->#getgeneral.lgroup# From</th>
	      	<td>
				<select name="groupfrom">
	          		<option value="">Choose a <!---Group--->#getgeneral.lgroup#</option>
	          		<cfloop query="getgroup">
						<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupfr" onKeyUp="getGroup('groupfrom');">
				</cfif>			</td>
	    </tr>
	    <tr>
	      	<th><!---Group--->#getgeneral.lgroup# To</th>
	      	<td>
				<select name="groupto">
	          		<option value="">Choose a <!---Group--->#getgeneral.lgroup#</option>
	          		<cfloop query="getgroup">
						<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
					</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupto" onKeyUp="getGroup('groupto');">
				</cfif>			</td>
	    </tr>
	     <tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	   
		<tr>
			<th>Date From</th>
      		<td>
				<input name="datefrom" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)			</td>
		</tr>
		<tr>
			<th>Date To</th>
      		<td>
				<input name="dateto" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)			</td>
		</tr>
		<!--- <tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	   
		<tr>
			<th>Delivery Date From</th>
      		<td>
				<input name="deldatefrom" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)
			</td>
		</tr>
		<tr>
			<th>Delivery Date To</th>
      		<td>
				<input name="deldateto" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)
			</td>
		</tr> --->
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
				</cfif>			</td>
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
				</cfif>			</td>
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
				</cfif>			</td>
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
				</cfif>			</td>
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
				</select>			</td>
      	</tr>
      	<tr> 
        	<th>Ref No To</th>
        	<td><select name="refto">
				<option value="">Choose a Ref No</option>
				<cfloop query="getref">
				<option value="#refno#">#refno#</option>
				</cfloop>
				</select>			</td>
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
				</select>			</td>
		</tr>
	<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr> 
        	<th>Project</th>
        	<td><select name="project">
				<option value="">Choose a Project</option>
				<cfloop query="getproject">
				<option value="#source#">#source# - #project#</option>
				</cfloop>
				</select>			</td>
      	</tr>
	<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr> 
        	<th>GL Account</th>
        	<td>
				<input name="glaccount" value="" size="60">			</td>
      	</tr>
	<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	    <tr>
			<th>DO No</th>
			<td>
				<input name="dono" value="" size="60">			</td>
		</tr>
	    <tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	    <tr>
			<th>Heading</th>
			<td>
				<input name="heading" value="" size="60">			</td>
		</tr>
	    <tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
		<tr>
			<th>Location From</th>
			<td>
				<select name="locfrom">
          			<option value="">Choose a Location</option>
					<cfloop query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfloop>
				</select>			</td>
		</tr>
		<tr>
			<th nowrap>Location To</th>
			<td>
				<select name="locto">
          			<option value="">Choose a Location</option>
					<cfloop query="getlocation">
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfloop>
				</select>			</td>
		</tr>
		 <tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	     <tr>
			<th><!---Remark 1--->#getgeneral.brem1#</th>
			<td>
				<input name="brem1" value="" size="60">&nbsp;<input type="checkbox" name="includebrem1">			</td>
		</tr> 
        <tr>
			<th><!---Remark 2--->#getgeneral.brem2#</th>
			<td>
				<input name="brem2" value="" size="60">&nbsp;<input type="checkbox" name="includebrem2">			</td>
		</tr> 
        <tr>
			<th><!---Remark 3--->#getgeneral.brem3#</th>
			<td>
				<input name="brem3" value="" size="60">&nbsp;<input type="checkbox" name="includebrem3">			</td>
		</tr> 
        <tr>
			<th><!---Remark 4--->#getgeneral.brem4#</th>
			<td>
				<input name="brem4" value="" size="60">&nbsp;<input type="checkbox" name="includebrem4">			</td>
		</tr>
        <tr> 
        <th>Batch Code From</th>
        <td><input type="text" name="batchcodefrom" validate="eurodate" message="Invalid Input" maxlength="18" size="18"></td>
    </tr>
    <tr> 
        <th>Batch Code To</th>
        <td><input type="text" name="batchcodeto" validate="eurodate" message="Invalid Input" maxlength="18" size="18"></td>
    </tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	    <tr>
			<th>Sort Method</th>
			<td>
				<select name="sort">
					<option value="a.itemno" selected>By Item No</option>
					<option value="a.custno,a.refno">By Customer/Supplier No + Reference No</option>
					<option value="a.refno">By Reference No</option>
					<option value="brem1,brem2,brem3,brem4">By <!--- Remark 1 --->#getgeneral.brem1# + <!--- Remark 2 --->#getgeneral.brem2# + <!--- Remark 3 --->#getgeneral.brem3# + <!--- Remark 4 --->#getgeneral.brem4#</option>
                    <option value="rem5">By End User</option>
				</select>&nbsp;<input type="checkbox" name="includeservice"> Include Service Item			</td>
		</tr>
		<tr> 
			<td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
	</form>

</cfif>

<script language="JavaScript">
	function displaymonth(){
		
	if(document.historicalrecords.periodfrom.value=="")
	{	document.historicalrecords.periodto.value = "";}
	
	if(document.historicalrecords.periodfrom.value=='01')		
	{	document.historicalrecords.monthfrom.value='#vmonthto1#'; }
		
	else if(document.historicalrecords.periodfrom.value=='02')	
	{	document.historicalrecords.monthfrom.value='#vmonthto2#'; }
	
	else if(document.historicalrecords.periodfrom.value=='03')	
	{	document.historicalrecords.monthfrom.value='#vmonthto3#'; }
	
	else if(document.historicalrecords.periodfrom.value=='04')	
	{	document.historicalrecords.monthfrom.value='#vmonthto4#'; }
	
	else if(document.historicalrecords.periodfrom.value=='05')	
	{	document.historicalrecords.monthfrom.value='#vmonthto5#'; }
	
	else if(document.historicalrecords.periodfrom.value=='06')	
	{	document.historicalrecords.monthfrom.value='#vmonthto6#'; }
	
	else if(document.historicalrecords.periodfrom.value=='07')	
	{	document.historicalrecords.monthfrom.value='#vmonthto7#'; }
	
	else if(document.historicalrecords.periodfrom.value=='08')	
	{	document.historicalrecords.monthfrom.value='#vmonthto8#'; }
	
	else if(document.historicalrecords.periodfrom.value=='09')	
	{	document.historicalrecords.monthfrom.value='#vmonthto9#'; }
	
	else if(document.historicalrecords.periodfrom.value=='10')	
	{	document.historicalrecords.monthfrom.value='#vmonthto10#'; }
	
	else if(document.historicalrecords.periodfrom.value=='11')	
	{	document.historicalrecords.monthfrom.value='#vmonthto11#'; }
	
	else if(document.historicalrecords.periodfrom.value=='12')	
	{	document.historicalrecords.monthfrom.value='#vmonthto12#'; }
	
	else if(document.historicalrecords.periodfrom.value=='13')	
	{	document.historicalrecords.monthfrom.value='#vmonthto13#'; }
	
	else if(document.historicalrecords.periodfrom.value=='14')	
	{	document.historicalrecords.monthfrom.value='#vmonthto14#'; }
	
	else if(document.historicalrecords.periodfrom.value=='15')	
	{	document.historicalrecords.monthfrom.value='#vmonthto15#'; }
	
	else if(document.historicalrecords.periodfrom.value=='16')	
	{	document.historicalrecords.monthfrom.value='#vmonthto16#'; }
	
	else if(document.historicalrecords.periodfrom.value=='17')	
	{	document.historicalrecords.monthfrom.value='#vmonthto17#'; }
	
	else if(document.historicalrecords.periodfrom.value=='18')	
	{	document.historicalrecords.monthfrom.value='#vmonthto18#'; }
	
	if(document.historicalrecords.periodto.value=='01')		
	{	document.historicalrecords.monthto.value='#vmonthto1#'; }
		
	else if(document.historicalrecords.periodto.value=='02')	
	{	document.historicalrecords.monthto.value='#vmonthto2#'; }
	
	else if(document.historicalrecords.periodto.value=='03')	
	{	document.historicalrecords.monthto.value='#vmonthto3#'; }
	
	else if(document.historicalrecords.periodto.value=='04')	
	{	document.historicalrecords.monthto.value='#vmonthto4#'; }
	
	else if(document.historicalrecords.periodto.value=='05')	
	{	document.historicalrecords.monthto.value='#vmonthto5#'; }
	
	else if(document.historicalrecords.periodto.value=='06')	
	{	document.historicalrecords.monthto.value='#vmonthto6#'; }
	
	else if(document.historicalrecords.periodto.value=='07')	
	{	document.historicalrecords.monthto.value='#vmonthto7#'; }
	
	else if(document.historicalrecords.periodto.value=='08')	
	{	document.historicalrecords.monthto.value='#vmonthto8#'; }
	
	else if(document.historicalrecords.periodto.value=='09')	
	{	document.historicalrecords.monthto.value='#vmonthto9#'; }
	
	else if(document.historicalrecords.periodto.value=='10')	
	{	document.historicalrecords.monthto.value='#vmonthto10#'; }
	
	else if(document.historicalrecords.periodto.value=='11')	
	{	document.historicalrecords.monthto.value='#vmonthto11#'; }
	
	else if(document.historicalrecords.periodto.value=='12')	
	{	document.historicalrecords.monthto.value='#vmonthto12#'; }
	
	else if(document.historicalrecords.periodto.value=='13')	
	{	document.historicalrecords.monthto.value='#vmonthto13#'; }
	
	else if(document.historicalrecords.periodto.value=='14')	
	{	document.historicalrecords.monthto.value='#vmonthto14#'; }
	
	else if(document.historicalrecords.periodto.value=='15')	
	{	document.historicalrecords.monthto.value='#vmonthto15#'; }
	
	else if(document.historicalrecords.periodto.value=='16')	
	{	document.historicalrecords.monthto.value='#vmonthto16#'; }
	
	else if(document.historicalrecords.periodto.value=='17')	
	{	document.historicalrecords.monthto.value='#vmonthto17#'; }
	
	else if(document.historicalrecords.periodto.value=='18')	
	{	document.historicalrecords.monthto.value='#vmonthto18#'; }
	
	}
</script>
</cfoutput>
</form>
</body>
</html>