<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Opening Value</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../../ajax/core/settings.js'></script>

<script type="text/javascript">

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

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp 
	from icitem 
	order by itemno; 
</cfquery>


<cfquery name="getgroup" datasource="#dts#">
	select wos_group,desp 
	from icgroup 
	order by wos_group; 
</cfquery>

<cfquery name="getcate" datasource="#dts#">
	select cate,desp 
	from iccate 
	order by cate; 
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select *
	from gsetup
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
        and (noactivelocation ='' or noactivelocation is null)
        
        <cfif lcase(hcomid) eq "simplysiti_i" and husergrpid eq "sales">
        and location not like '%OFFICE%' and location not like '%WAREHOUSE%'
        </cfif>
        
		order by <cfif (lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser">substring_index(location,'-',1)<cfelse>location</cfif>
	</cfquery>


<body>
<h1 align="center">Location Opening Value</h1>
<br>
<h2 style=" color:#F00">* FIFO Calculation Not Availiable In Location Status Calculation</h2>
<cfform action="locationopenqtysummary2.cfm" name="form" method="post" target="_blank">
	<table border="0" align="center" width="80%" class="data">
    <tr>
    <td colspan="100%"><input type="checkbox" name="include0" id="include0" value="1">Include 0 Qty</td>
    </tr>
		<tr>	
		</tr>
		<tr> 
			<th width="16%">Category </th>
			<td width="5%"><div align="center">From</div></td>
			<td colspan="2">
				<select name="Catefrom">
					<option value="">Choose a Category</option>
					<cfoutput query="getcate"> 
						<option value="#cate#">#cate# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcatefr" onKeyUp="getCategory('Catefrom');">
				</cfif>			</td>
		</tr>
		<tr> 
			<th width="16%">Category</th>
			<td width="5%"><div align="center">To</div></td>
			<td colspan="2">
				<select name="Cateto">
					<option value="">Choose a Category</option>
					<cfoutput query="getcate"> 
						<option value="#cate#">#cate# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchcateto" onKeyUp="getCategory('Cateto');">
				</cfif>			</td>
		</tr>
    	<tr> 
      		<td colspan="5"><hr></td>
    	</tr>
    	<tr> 
      		<th width="16%">Group</th>
      		<td width="5%"><div align="center">From</div></td>
      		<td colspan="2">
				<select name="groupfrom">
          			<option value="">Choose a Group</option>
          			<cfoutput query="getgroup"> 
            			<option value="#wos_group#">#wos_group# - #desp#</option>
          			</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupfr" onKeyUp="getGroup('groupfrom');">
				</cfif>			</td>
    	</tr>
    	<tr> 
      		<th width="16%">Group</th>
      		<td width="5%"><div align="center">To</div></td>
      		<td colspan="2">
				<select name="groupto">
          			<option value="">Choose a Group</option>
          			<cfoutput query="getgroup"> 
            			<option value="#wos_group#">#wos_group# - #desp#</option>
          			</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchgroupto" onKeyUp="getGroup('groupto');">
				</cfif>			</td>
    	</tr>
		<tr> 
			<td colspan="5"><hr></td>
		</tr>
        
		<tr> 
			<th width="16%">Item No</th>
			<td width="5%"> <div align="center">From</div></td>
			<td colspan="2">
				<select name="productfrom">
					<option value="">Choose a Product</option>
					<cfoutput query="getitem"> 
						<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">
				</cfif>			</td>
		</tr>
		<tr> 
			<th>Item No</th>
			<td><div align="center">To</div></td>
			<td colspan="2" nowrap>
				<select name="productto">
					<option value="">Choose a Product</option>
					<cfoutput query="getitem"> 
						<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
					</cfoutput>
				</select>
				<cfif getgeneral.filterall eq "1">
					<input type="text" name="searchitemto" onKeyUp="getProduct('productto');">
				</cfif>			</td>
		</tr>
		<tr> 
			<td colspan="5"><hr></td>
		</tr>
        <tr> 
        	<th><cfoutput>#getgeneral.lLOCATION#</cfoutput></th>
            <td><div align="center">From</div></td>
            <td colspan="2">
            	<select name="locfrom">
					<cfif lcase(hcomid) eq "pnp_i">
						<cfif getlocation.recordcount neq 1>
							<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
						</cfif>
					<cfelse>
	                	<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
	          				<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
						</cfif>
					</cfif>
					<!--- <option value="">Choose a Location</option> --->
                    <cfoutput query="getlocation"> 
                    	<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                    </cfoutput>
                </select>
            </td>
		</tr>
        
		<tr>
        	<th><cfoutput>#getgeneral.lLOCATION#</cfoutput></th>
            <td><div align="center">To</div></td>
            <td width="69%">
            	<select name="locto">
					<cfif lcase(hcomid) eq "pnp_i">
						<cfif getlocation.recordcount neq 1>
							<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
						</cfif>
					<cfelse>
						<cfif HUserGrpID eq 'Super' or getpin2.h4700 neq 'T'>
	          				<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
						</cfif>
					</cfif>
                	<!--- <option value="">Choose a Location</option> --->
                    <cfoutput query="getlocation"> 
                        <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                    </cfoutput>
                </select>
            </td>
            
        </tr>
        <tr> 
			<td colspan="5"><hr></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td width="10%"><input type="Submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
</cfform>

</body>
</html>