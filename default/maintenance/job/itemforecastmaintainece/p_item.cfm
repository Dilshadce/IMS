<html>
<head>
<title><cfoutput>Project</cfoutput> Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>


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
</script>
</head>


<body>
<cfquery name="getgroup" datasource="#dts#">
  select * from icitemforecast
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>

  <h1 align="center"><cfoutput>Item Forecast Report</cfoutput></h1>
<cfoutput>
    <h4 align = "center">
		<a href="index.cfm" onMouseOver="this.style.cursor='hand'">Assign Item Forecast</a>||<a href="icitemforecasttable.cfm">Item Forecast Listing</a>||<a href="p_item.cfm">Item Forecast Report</a>
  </h4>
  </cfoutput>

<cfform action="l_item.cfm" name="form" method="post" target="_blank">
  	<input type="hidden" name="Tick" value="0">

  <table border="0" align="center" width="90%" class="data">
  	<tr>
		<th colspan="3">Report Format</th>
	</tr>
	<tr>
	  	<td colspan="3">
			<input type="radio" name="period" id="1" value="1" checked> Period (1-6)<br/>
			<input type="radio" name="period" id="1" value="2"> Period (7-12)<br/>
			<input type="radio" name="period" id="1" value="3"> Period (13-18)<br/>
            <input type="radio" name="period" id="1" value="5"> Period&nbsp;&nbsp;&nbsp;
            <select name="poption" id="poption">
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
            </select>
		</td>
        </tr>
    <tr> 
      <th width="20%"><cfoutput>Item</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="productfrom">
          <option value=""><cfoutput>Choose a Item</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#itemno#">#itemno# - #desp# </option>
          </cfoutput> </select>			
		  <cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">
			</cfif>
            </td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Item</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="productto">
          <option value=""><cfoutput>Choose a Item</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#itemno#">#itemno# - #desp#</option>
          </cfoutput> </select>
		  <cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemto" onKeyUp="getProduct('productto');">
			</cfif> </td>
	  </td>
    </tr>

    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>

    <tr> 
      <td colspan="8"><hr></td>
    </tr>
    <tr> 
     
      <td width="5%"><div align="right"> 
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
</cfform>
</body>
</html>
