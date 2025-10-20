<html>
<head>
<title>Forecast Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="pfrom" default="">
<cfparam name="pto" default="">
<cfparam name="Submit" default="">

<cfoutput>
<cfif pfrom neq "">
	<form action= "itemsearchf.cfm?get=from<cfif form.productto neq "">&productto=#productto#</cfif>" method="post" name="form123">
	</form>
	<script>
		form123.submit();
	</script>
	<cfabort>
<cfelseif pto neq "">
	<form action= "itemsearchf.cfm?get=to<cfif form.productfrom neq "">&productfrom=#productfrom#</cfif>" method="post" name="form123">
	</form>
	<script>
		form123.submit();
	</script>
	<cfabort>
<cfelseif Submit eq "Submit">
	<form name="form123" action= "forecast_report.cfm" method="post"  target="_blank">

			<input type="hidden" name="productfrom" value="#productfrom#">
			<input type="hidden" name="productto" value="#productto#">
			<input type="hidden" name="catefrom" value="#catefrom#">
			<input type="hidden" name="cateto" value="#cateto#">
			<input type="hidden" name="sizeidfrom" value="#sizeidfrom#">
			<input type="hidden" name="sizeidto" value="#sizeidto#">
			<input type="hidden" name="costcodefrom" value="#costcodefrom#">
			<input type="hidden" name="costcodeto" value="#costcodeto#">
			<input type="hidden" name="coloridfrom" value="#coloridfrom#">
			<input type="hidden" name="coloridto" value="#coloridto#">
			<input type="hidden" name="groupfrom" value="#groupfrom#">
			<input type="hidden" name="groupto" value="#groupto#">
			<input type="hidden" name="shelffrom" value="#shelffrom#">
			<input type="hidden" name="shelfto" value="#shelfto#">
			<input type="hidden" name="periodfrom" value="#periodfrom#">
			<input type="hidden" name="periodto" value="#periodto#">
			<input type="hidden" name="datefrom" value="#datefrom#">
			<input type="hidden" name="dateto" value="#dateto#">
			<input type="hidden" name="rgsort" value="#rgsort#">
	</form>
	<script>
		form123.submit();
	</script>

</cfif>
</cfoutput>

 <cfquery name="getitem" datasource="#dts#">
    select itemno, desp from icitem order by itemno
 </cfquery>
 <cfquery name="getcate" datasource="#dts#">
    select * from iccate order by cate
 </cfquery>
 <cfquery name="getsizeid" datasource="#dts#">
    select sizeid, desp from icsizeid order by sizeid
 </cfquery>
 <cfquery name="getcostcode" datasource="#dts#">
    select costcode, desp from iccostcode order by costcode
 </cfquery>
  <cfquery name="getcolorid" datasource="#dts#">
    select colorid, desp from iccolorid order by colorid
 </cfquery>
 <cfquery name="getshelf" datasource="#dts#">
    select shelf, desp from icshelf order by shelf
 </cfquery>
 <cfquery name="getgroup" datasource="#dts#">
    select wos_group, desp from icgroup order by wos_group
 </cfquery>

<body>
<h1 align="center">View Forecast Report</h1>
<form action="Forecast_menu.cfm" name="form" method="post">
  <table border="0" align="center" width="80%" class="data">
    <tr>
      <th width="16%">Product</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2">
	  <cfif isdefined("get") and get eq "from">
	 	<cfset xitemfrom = itemno1>
		<cfelse>
			<cfset xitemfrom = "">
	 	</cfif>
		<cfif isdefined("url.productfrom")>
			<cfset xitemfrom = #url.productfrom#>
	  	</cfif>
		<select name="productfrom">
          <option value="">Choose a product</option>
          <cfloop query="getitem">
            <cfoutput><option value="#itemno#"<cfif itemno eq xitemfrom>selected</cfif>>#itemno#
            </option></cfoutput>
          </cfloop> </select>
		  <input type="submit" name="pfrom" value="Search"></td>
    </tr>
    <tr>
      <th>Product</th>
      <td><div align="center">To</div></td>
      <td colspan="2" nowrap> <cfif isdefined("get") and get eq "to">
	  		<cfset xitemto = itemno1>
		<cfelse>
			<cfset xitemto = "">
	 	</cfif>
	    <cfif isdefined("url.productto")>
			<cfset xitemto = #url.productto#>
	  	</cfif>
	      <select name="productto">
          <option value="">Choose a product</option>
          <cfloop query="getitem">
            <cfoutput><option value="#itemno#"<cfif itemno eq xitemto>selected</cfif>>#itemno#
            </option></cfoutput>
          </cfloop> </select> <input type="submit" name="pto" value="Search"> </td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Valve Type</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="Catefrom">
          <option value="">Choose a Valve Type</option>
          <cfloop query="getcate">
            <cfoutput><option value="#cate#">#cate#
            - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <th width="16%">Valve Type</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="Cateto">
          <option value="">Choose a Valve Type</option>
          <cfloop query="getcate">
            <cfoutput><option value="#cate#">#cate#
            - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Size</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="sizeidfrom">
          <option value="">Choose a Size</option>
          <cfloop query="getsizeid">
            <cfoutput><option value="#sizeid#">#sizeid# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <th width="16%">Size</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="sizeidto">
          <option value="">Choose a Size</option>
          <cfloop query="getsizeid">
            <cfoutput><option value="#sizeid#">#sizeid# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Rating</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="Costcodefrom">
          <option value="">Choose a Rating</option>
          <cfloop query="getCostcode">
            <cfoutput><option value="#costcode#">#costcode# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <th width="16%">Rating</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="Costcodeto">
          <option value="">Choose a Rating</option>
          <cfloop query="getCostcode">
            <cfoutput><option value="#costcode#">#costcode# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Material</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="coloridfrom">
          <option value="">Choose a Material</option>
          <cfloop query="getcolorid">
            <cfoutput><option value="#colorid#">#colorid# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <th width="16%">Material</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="coloridto">
          <option value="">Choose a Material</option>
          <cfloop query="getcolorid">
            <cfoutput><option value="#colorid#">#colorid# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Manufacturer</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="groupfrom">
          <option value="">Choose a Manufacturer</option>
          <cfloop query="getgroup">
            <cfoutput><option value="#wos_group#">#wos_group# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <th width="16%">Manufacturer</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="groupto">
          <option value="">Choose a Manufacturer</option>
          <cfloop query="getgroup">
            <cfoutput><option value="#wos_group#">#wos_group# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Model</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="shelffrom">
          <option value="">Choose a Model</option>
          <cfloop query="getshelf">
           <cfoutput> <option value="#shelf#">#shelf# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <th width="16%">Model</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="shelfto">
          <option value="">Choose a Model</option>
          <cfloop query="getshelf">
            <cfoutput><option value="#shelf#">#shelf# - #desp#</option></cfoutput>
          </cfloop> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Period</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="periodfrom">
          <option value="">Choose a period</option>
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
        </select></td>
    </tr>
    <tr>
      <th width="16%">Period</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="periodto">
          <option value="">Choose a period</option>
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
          <option value="12"selected>12</option>
          <option value="13">13</option>
          <option value="14">14</option>
          <option value="15">15</option>
          <option value="16">16</option>
          <option value="17">17</option>
          <option value="18">18</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Date</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><input type="text" name="datefrom" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY) </td>
    </tr>
    <tr>
      <th width="16%">Date</th>
      <td width="5%"> <div align="center">To</div></td>
      <td width="79%"><input type="text" name="dateto" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY)&nbsp; </td>
    </tr>

    <tr>
      <td colspan="5"><hr></td>
    </tr>

    <tr>
      <th width="16%">Sort by</th>
      <td width="5%">&nbsp;</td>
      <td width="79%">
        <table width="365">
          <tr>
            <td><label><input name="rgSort" type="radio" value="Valve Type" checked> Valve Type</label></td>
          </tr>
          <tr>
            <td><label><input type="radio" name="rgSort" value="Size"> Size</label></td>
          </tr>
          <tr>
	        <td><label><input type="radio" name="rgSort" value="Rating"> Rating</label></td>
          </tr>
          <tr>
	        <td><label><input type="radio" name="rgSort" value="Material"> Material</label></td>
          </tr>
          <tr>
	        <td><label><input type="radio" name="rgSort" value="Manufacturer"> Manufacturer</label></td>
          </tr>
          <tr>
	        <td><label><input type="radio" name="rgSort" value="Model"> Model</label></td>
          </tr>
        </table>
      </td>
    </tr>
	<tr>
	  <td width="16%">&nbsp;</td>
	  <td width="5%">&nbsp;</td>
	  <td width="79%">
		<div align="right">
		  <input type="Submit" name="Submit" value="Submit">
		</div>
	  </td>
    </tr>
  </table>
</form>
</body>
</html>