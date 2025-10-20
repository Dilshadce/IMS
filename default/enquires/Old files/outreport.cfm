<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<html>
<head>
<title>Outstanding Report</title>

<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="../../scripts/ajax.js"></script>

<script type="text/javascript">

function selectlist2(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}

// begin: customer search
function getCust(type,option){
	if(type == 'custfrom'){
		var inputtext = document.form.searchcustfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
		
	}
	else{
		var inputtext = document.form.searchcustto.value;
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

	function selectlist(refno){		
	for (var idx=0;idx<document.getElementById('refnofrom').options.length;idx++) 
	{
        if (refno==document.getElementById('refnofrom').options[idx].value) 
		{
            document.getElementById('refnofrom').options[idx].selected=true;
			
        }
    }

	}
	function selectlist1(refno){		
	for (var idx=0;idx<document.getElementById('refnoto').options.length;idx++) 
	{
        if (refno==document.getElementById('refnoto').options[idx].value) 
		{
            document.getElementById('refnoto').options[idx].selected=true;
			
        }
    }

	}

// begin: product search
function getProduct(type){
	if(type == 'Productto'){
		var inputtext = document.form.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.form.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult2);
	}
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("Productto");
	DWRUtil.addOptions("Productto", itemArray,"KEY", "VALUE");
}

function getProductResult2(itemArray){
	DWRUtil.removeAllOptions("productfrom");
	DWRUtil.addOptions("productfrom", itemArray,"KEY", "VALUE");
}
// end: product search

</script>

</head>

<cfset refnotype=''>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lAGENT from gsetup
</cfquery>
<!--- Add On 12-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,custformat from dealer_menu limit 1
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
<cfset xnewmonth = newmonth + 17>
	
<cfif xnewmonth gt 24>
	<cfset xnewmonth = xnewmonth - 24>
	<cfset xnewyear = newyear + 2>
<cfelseif xnewmonth gt 12>
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

<!--- <cfquery name="getgeneral" datasource="#dts#">
	select filterall from gsetup
</cfquery> --->

<body>
<cfquery datasource="#dts#" name="getagent">
	select agent,desp FROM #target_icagent# order by agent
</cfquery>

<cfform action="outreport1.cfm?type=#type#" method="post" name="form" target="_blank">
	<cfif type eq 'DO' or type eq 'QUO'>
		
		<!--- <cfquery name="getcust" datasource="#dts#">
			select custno,name from #target_arcust# order by custno
		</cfquery> --->
		<cfquery name="getcust" datasource="#dts#">
			select custno,name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
		</cfquery>
		
		<cfquery name="getrefno" datasource="#dts#">
			select refno from artran where type = '#type#' order by refno
		</cfquery>
		
		<cfoutput><h1><center>Outstanding <cfif type eq 'QUO'>#gettranname.lQUO#<cfelse>#gettranname.lDO#</cfif></center></h1></cfoutput>
	
		<table align="center" border="0" width="70%" class="data">
        <cfif type eq '4' or type eq "6" or type eq "7" or type eq "8">
		<tr>
            <th>
            Format
            </th><td></td>
            <td><input type="radio" name="result" value="HTML" checked> HTML<br>
             <input type="radio" name="result" value="EXCEL"> EXCEL<br>
            </td>
        </tr>
        <tr>
    			<td colspan="3"><hr></td>
			</tr>
        </cfif>
        <cfoutput>
        <cfif type eq "3" or type eq "4">
        <input type="hidden" name="tran" id="tran" value="#target_apvend#" />

<cfelse>
<input type="hidden" name="tran" id="tran" value="#target_arcust#" />
</cfif>
</cfoutput>
<input type="hidden" name="fromto" id="fromto" value="" />
  			<tr>
      			<th width="27%">Customer</th>
      			<td width="10%"><div align="center">From</div></td>
    			<td width="63%">
					<select name="custfrom" id="custfrom">
          				<option value="">Choose a Customer</option>
          				<cfoutput query="getcust"> 
            				<option value="#custno#">#custno# - #name#</option>
          				</cfoutput>
					</select>
					<cfif getgeneral.filterall eq "1">
                    <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />
						<input type="text" name="searchcustfr" id="searchcustfr" onKeyUp="getCust('custfrom','Customer');" size="15">
					</cfif>
				</td>
      		</tr>
  			<tr>
      			<th>Customer</th>
    			<td><div align="center">To</div></td>
    			<td>
					<select name="custto" id="custto">
          				<option value="">Choose a Customer</option>
          				<cfoutput query="getcust"> 
           					<option value="#custno#">#custno# - #name#</option>
          				</cfoutput>
					</select>
					<cfif getgeneral.filterall eq "1">
                    <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />
						<input type="text" name="searchcustto" onKeyUp="getCust('custto','Customer');" id="searchcustto" size="15">
					</cfif>
				</td>
			</tr>
  			<tr>
    			<td colspan="3"><hr></td>
			</tr>
  			<tr>
      			<th>Reference No</th>
    			<td><div align="center">From</div></td>
    			<td>
					<select name="refnofrom" id="refnofrom">
          				<option value="">Choose a Refno</option>
          				<cfoutput query="getrefno"> 
            				<option value="#refno#">#refno#</option>
          				</cfoutput>
					</select>
				</td>
			</tr>
  			<tr>
      			<th>Reference No</th>
    			<td><div align="center">To</div></td>
    			<td>
					<select name="refnoto" id="refnoto">
          				<option value="">Choose a Refno</option>
          				<cfoutput query="getrefno"> 
            				<option value="#refno#">#refno#</option>
          				</cfoutput>
					</select>
				</td>
			</tr>
  			<tr>
    			<td colspan="3"><hr></td>
			</tr>
			<tr> 
				<th>Period</th>
				<td><div align="center">From</div></td>
				<td><select name="periodfrom" id="periodfrom" onChange="displaymonth()">
					<option value="">Choose a Period</option>
					<option value="01"selected>1</option>
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
					</select>&nbsp;<input type="text" id="monthfrom" name="monthfrom" value="<cfoutput>#vmonth#</cfoutput>" size="6" readonly>
				</td>
			</tr>
			<tr> 
				<th>Period</th>
				<td><div align="center">To</div></td>
				<td><select name="periodto" id="periodto" onChange="displaymonth()">
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
					<option value="18" selected>18</option>
					</select>&nbsp;<input type="text" name="monthto" value="<cfoutput>#vmonthto#</cfoutput>" size="6" id="monthto" readonly>
				</td>
			</tr>
			<tr>
    			<td colspan="3"><hr></td>
			</tr>
  			<tr>
      			<th>Date</th>
    			<td><div align="center">From</div></td>
    			<td><cfinput type="text" name="datefrom" id="datefrom" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
			</tr>
  			<tr>
      			<th>Date</th>
    			<td><div align="center">To</div></td>
    			<td><cfinput type="text" name="dateto" id="datefrom" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
			</tr>
            <cfif type eq "3">
            <tr>
            </tr>
            </cfif>
   			<tr>
    			<td colspan="3" align="right"><input name="submit" type="submit" value="Submit"></td>
			</tr>
		</table>
	<cfelse>
		<cfif type eq '3' or type eq '4'>
			<cfset title = target_apvend>
			<cfset title1 = "Supplier">
			<cfquery name="getrefno" datasource="#dts#">
				select a.refno from artran a,ictran b 
				where a.refno = b.refno 
				and a.type = b.type 
				and a.type = 'PO' 
				<!--- and a.order_cl = '' 
				and b.shipped < b.qty --->
				group by a.refno order by a.refno
			</cfquery>	
			
			<cfif type eq '3'>
				<h1><center>Outstanding <cfoutput>#gettranname.lPO#</cfoutput> Status</center></h1>
			<cfelse>
				<h1><center>Outstanding <cfoutput>#gettranname.lPO#</cfoutput> Details</center></h1>
			</cfif>
		<cfelse>		
			<cfset title = target_arcust>
			<cfset title1 = "Customer">
			<cfquery name="getrefno" datasource="#dts#">
				select a.refno from artran a, ictran b 
				where a.refno = b.refno 
				and a.type = b.type 
				and a.type = 'SO' 
				<!--- and a.order_cl ='' 
				and b.shipped < b.qty --->
				group by a.refno
				order by a.refno
			</cfquery>
			
			<cfif type eq '5'>
				<h1><center>Outstanding <cfoutput>#gettranname.lSO#</cfoutput> Status</center></h1>
			<cfelseif type eq '6'>
				<h1><center>Outstanding <cfoutput>#gettranname.lSO#</cfoutput> Details</center></h1>
			<cfelseif type eq '7'>
				<h1><center>Outstanding <cfoutput>#gettranname.lSO# to #gettranname.lPO#</cfoutput></center></h1>
            <cfelseif type eq '8'>
				<h1><center>Outstanding <cfoutput>#gettranname.lSO# to #gettranname.lPO# Material</cfoutput></center></h1>
			</cfif>
		</cfif>
	
		<!--- <cfquery name="getcust" datasource="#dts#">
			select custno,name from #title# order by custno
		</cfquery> --->
		<cfquery name="getcust" datasource="#dts#">
			select custno,name from #title# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
		</cfquery>
		
		<cfoutput>
		<table align="center" border="0" width="75%" class="data">
        <cfif type eq '4' or type eq "6" or type eq "7" or type eq "8" or type eq "3">
		<tr>
            <th>
            Format
            </th><td></td>
            <td><input type="radio" name="result" value="HTML" checked> HTML<br>
             <input type="radio" name="result" value="EXCEL"> EXCEL<br>
            </td>
        </tr>
        <tr>
    			<td colspan="3"><hr></td>
			</tr>
        </cfif>
        <cfif type eq '5'>
		<tr>
            <th>
            Format
            </th><td></td>
            <td><input type="radio" name="result" value="HTML" checked> HTML<br>
             <input type="radio" name="result" value="PDF"> PDF<br>
            </td>
        </tr>
        </cfif>
        <cfif type eq "3" or type eq "4">
        <input type="hidden" name="tran" id="tran" value="#target_apvend#" />

<cfelse>
<input type="hidden" name="tran" id="tran" value="#target_arcust#" />
</cfif>
        <input type="hidden" name="fromto" id="fromto" value="" />
  		<tr>
      		<th width="27%">#title1#</th>
      		<td width="10%"><div align="center">From</div></td>
    		<td width="63%">
				<select name="custfrom">
					<option value="">Choose a #title1#</option>
          			<cfloop query="getcust"> 
           				<option value="#custno#">#custno# - #name#</option>
          			</cfloop>
		  		</select>
		  		<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;
					<input type="text" name="searchcustfr" onKeyUp="getCust('custfrom','#title1#');" size="15">
				</cfif>
			    </td>
      	</tr>
  		<tr>
      		<th>#title1#</th>
    		<td><div align="center">To</div></td>
    		<td>
				<select name="custto">
          			<option value="">Choose a #title1#</option>
          			<cfloop query="getcust"> 
           				<option value="#custno#">#custno# - #name#</option>
          			</cfloop>
				</select>
				<cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />
					<input type="text" name="searchcustto" onKeyUp="getCust('custto','#title1#');" size="15">
				</cfif>
			</td>
  		</tr>
            <tr>
      	<td colspan="3"><hr></td>
    </tr>
    <tr>
      	<th >#getgeneral.lAGENT#</th>
      	<td ><div align="center">From</div></td>
      	<td >
			<select name="agentfrom">
          		<option value="">Choose a #getgeneral.lAGENT#</option>
          		<cfloop query="getagent">
            		<option value="#agent#">#agent# - #desp#</option>
          		</cfloop>
			</select>
		</td>
    </tr>
      <tr>
      	<th >#getgeneral.lAGENT#</th>
      	<td ><div align="center">To</div></td>
      	<td>
			<select name="agentto">
          		<option value="">Choose a #getgeneral.lAGENT#</option>
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
      		<th>Reference No</th>
    		<td><div align="center">From</div></td>
    		<td>
				<select name="refnofrom">
          			<option value="">Choose a Refno</option>
          			<cfloop query="getrefno"> 
            			<option value="#refno#">#refno#</option>
          			</cfloop>
				</select><cfif type eq '4' or type eq '6'><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findRefno');" /></cfif>
			</td>
		</tr>
  		<tr>
      		<th>Reference No</th>
    		<td><div align="center">To</div></td>
    		<td>
				<select name="refnoto">
          			<option value="">Choose a Refno</option>
          			<cfloop query="getrefno"> 
            			<option value="#refno#">#refno#</option>
          			</cfloop>
		</select><cfif type eq '4' or type eq '6'><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findRefno1');" /></cfif>
			</td>
		</tr>
        <cfif type eq '4' >
        <cfset refnotype='PO'>
		<cfelseif type eq '6'>
        <cfset refnotype='SO'>
        </cfif>
  		<tr>
    		<td colspan="3"><hr></td>    
  		</tr>
  		
		<cfif type neq '6'>
  			<!--- <cfquery name="getitem" datasource="#dts#">
				select itemno from icitem order by itemno
			</cfquery> --->
			<cfquery name="getitem" datasource="#dts#">
				select itemno from icitem order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
			</cfquery>
  			
			<tr>
      			<th>Product</th>
    			<td><div align="center">From</div></td>
    			<td>
					<select name="productfrom">
          				<option value="">Choose a Product</option>
          				<cfloop query="getitem"> 
            				<option value="#itemno#">#itemno#</option>
          				</cfloop>
					</select>
					<cfif getgeneral.filterall eq "1">
						<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');" size="15">
					</cfif>
				</td>
			</tr>
  			<tr>
      			<th>Product</th>
    			<td><div align="center">To</div></td>
    			<td>
					<select name="Productto">
          				<option value="">Choose a Product</option>
          				<cfloop query="getitem"> 
            				<option value="#itemno#">#itemno#</option>
          				</cfloop>
					</select>
					<cfif getgeneral.filterall eq "1">
						<input type="text" name="searchitemto" onKeyUp="getProduct('Productto');" size="15">
					</cfif>
				</td>    
  			</tr>
  			<tr>
    			<td colspan="3"><hr></td>    
  			</tr>
  		</cfif>
		<tr> 
			<th>Period</th>
			<td><div align="center">From</div></td>
			<td><select name="periodfrom" onChange="displaymonth()">
				<option value="">Choose a Period</option>
				<option value="01"selected>1</option>
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
				</select>&nbsp;<input type="text" name="monthfrom" value="<cfoutput>#vmonth#</cfoutput>" size="6" readonly>
			</td>
		</tr>
		<tr> 
			<th>Period</th>
			<td><div align="center">To</div></td>
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
				<option value="18" selected>18</option>
				</select>&nbsp;<input type="text" name="monthto" value="<cfoutput>#vmonthto#</cfoutput>" size="6" readonly>
			</td>
		</tr>
		<tr>
    		<td colspan="3"><hr></td>    
  		</tr>
  		<tr>
      		<th>Date</th>
    		<td><div align="center">From</div></td>
    		<td><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
		</tr>
  		<tr>
      		<th>Date</th>
    		<td><div align="center">To</div></td>
    		<td><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
		</tr>
  		<tr>
    		<td colspan="3"><hr></td>
		</tr>
  		<tr>
      		<th>Planning Delivery Date</th>
    		<td><div align="center">From</div></td>
    		<td><cfinput type="text" name="deldatefrom" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
		</tr>
  		<tr>
      		<th>Planning Delivery Date</th>
    		<td><div align="center">To</div></td>
    		<td><cfinput type="text" name="deldateto" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
		</tr>
        <tr>
         <th>
            Tick To Sort By Delivery Date
            </th><td></td>
            <td><input type="checkbox" name="sortbydelivery" value="checkbox"></td>
        </tr>
        <th>
            Tick To Sort By Item No 
            </th><td></td>
            <td><input type="checkbox" name="checkbox" value="checkbox"></td>
            <cfif type eq '4' or type eq '6'>
		<tr>
            <th>
            Include Order Clear Transaction
            </th><td></td>
            <td><input type="checkbox" name="checkbox1" value="checkbox1"></td>
        </tr>
        </cfif>
        <cfif type eq '6'>
		<tr>
            <th>
            With Price & Amount
            </th><td></td>
            <td><input type="checkbox" name="cbpriceamt" value="cbpriceamt" checked></td>
        </tr>
        </cfif>
   		<tr>
    		<td colspan="3" align="right"><input name="submit" type="submit" value="Submit"></td>
		</tr>
	</table>
	</cfoutput>
	</cfif>
</cfform>



<cfoutput>

<script language="JavaScript">
	function displaymonth(){
	
	if(document.form.periodfrom.value=="")
	{	document.form.periodto.value = "";}
	
	if(document.form.periodfrom.value=='01')		
	{	document.form.monthfrom.value='#vmonthto1#'; }
		
	else if(document.form.periodfrom.value=='02')	
	{	document.form.monthfrom.value='#vmonthto2#'; }
	
	else if(document.form.periodfrom.value=='03')	
	{	document.form.monthfrom.value='#vmonthto3#'; }
	
	else if(document.form.periodfrom.value=='04')	
	{	document.form.monthfrom.value='#vmonthto4#'; }
	
	else if(document.form.periodfrom.value=='05')	
	{	document.form.monthfrom.value='#vmonthto5#'; }
	
	else if(document.form.periodfrom.value=='06')	
	{	document.form.monthfrom.value='#vmonthto6#'; }
	
	else if(document.form.periodfrom.value=='07')	
	{	document.form.monthfrom.value='#vmonthto7#'; }
	
	else if(document.form.periodfrom.value=='08')	
	{	document.form.monthfrom.value='#vmonthto8#'; }
	
	else if(document.form.periodfrom.value=='09')	
	{	document.form.monthfrom.value='#vmonthto9#'; }
	
	else if(document.form.periodfrom.value=='10')	
	{	document.form.monthfrom.value='#vmonthto10#'; }
	
	else if(document.form.periodfrom.value=='11')	
	{	document.form.monthfrom.value='#vmonthto11#'; }
	
	else if(document.form.periodfrom.value=='12')	
	{	document.form.monthfrom.value='#vmonthto12#'; }
	
	else if(document.form.periodfrom.value=='13')	
	{	document.form.monthfrom.value='#vmonthto13#'; }
	
	else if(document.form.periodfrom.value=='14')	
	{	document.form.monthfrom.value='#vmonthto14#'; }
	
	else if(document.form.periodfrom.value=='15')	
	{	document.form.monthfrom.value='#vmonthto15#'; }
	
	else if(document.form.periodfrom.value=='16')	
	{	document.form.monthfrom.value='#vmonthto16#'; }
	
	else if(document.form.periodfrom.value=='17')	
	{	document.form.monthfrom.value='#vmonthto17#'; }
	
	else if(document.form.periodfrom.value=='18')	
	{	document.form.monthfrom.value='#vmonthto18#'; }
	
	if(document.form.periodto.value=='01')		
	{	document.form.monthto.value='#vmonthto1#'; }
		
	else if(document.form.periodto.value=='02')	
	{	document.form.monthto.value='#vmonthto2#'; }
	
	else if(document.form.periodto.value=='03')	
	{	document.form.monthto.value='#vmonthto3#'; }
	
	else if(document.form.periodto.value=='04')	
	{	document.form.monthto.value='#vmonthto4#'; }
	
	else if(document.form.periodto.value=='05')	
	{	document.form.monthto.value='#vmonthto5#'; }
	
	else if(document.form.periodto.value=='06')	
	{	document.form.monthto.value='#vmonthto6#'; }
	
	else if(document.form.periodto.value=='07')	
	{	document.form.monthto.value='#vmonthto7#'; }
	
	else if(document.form.periodto.value=='08')	
	{	document.form.monthto.value='#vmonthto8#'; }
	
	else if(document.form.periodto.value=='09')	
	{	document.form.monthto.value='#vmonthto9#'; }
	
	else if(document.form.periodto.value=='10')	
	{	document.form.monthto.value='#vmonthto10#'; }
	
	else if(document.form.periodto.value=='11')	
	{	document.form.monthto.value='#vmonthto11#'; }
	
	else if(document.form.periodto.value=='12')	
	{	document.form.monthto.value='#vmonthto12#'; }
	
	else if(document.form.periodto.value=='13')	
	{	document.form.monthto.value='#vmonthto13#'; }
	
	else if(document.form.periodto.value=='14')	
	{	document.form.monthto.value='#vmonthto14#'; }
	
	else if(document.form.periodto.value=='15')	
	{	document.form.monthto.value='#vmonthto15#'; }
	
	else if(document.form.periodto.value=='16')	
	{	document.form.monthto.value='#vmonthto16#'; }
	
	else if(document.form.periodto.value=='17')	
	{	document.form.monthto.value='#vmonthto17#'; }
	
	else if(document.form.periodto.value=='18')	
	{	document.form.monthto.value='#vmonthto18#'; }
	
	}
	

</script>
<cfwindow center="true" width="520" height="400" name="findRefno" refreshOnShow="true"
        title="Find Refno" initshow="false"
        source="/default/enquires/findRefno.cfm?type=#refnotype#" />
<cfwindow center="true" width="520" height="400" name="findRefno1" refreshOnShow="true"
        title="Find Refno" initshow="false"
        source="/default/enquires/findRefno1.cfm?type=#refnotype#" />
        

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer3.cfm?type={tran}&fromto={fromto}" />

</cfoutput>

</body>
</html>