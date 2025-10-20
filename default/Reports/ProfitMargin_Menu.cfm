<html>
<head>
<title>View Profit Margin Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="pfrom" default="">
<cfparam name="pto" default="">
<cfparam name="Submit" default="">

<cfoutput>
<cfif pfrom neq "">
	<form action= "itemsearchp.cfm?get=from<cfif form.productto neq "">&productto=#productto#</cfif>" method="post" name="form123">
	</form>
	<script>
		form123.submit();
	</script>
	<cfabort>
<cfelseif pto neq "">
	<form action= "itemsearchp.cfm?get=to<cfif form.productfrom neq "">&productfrom=#productfrom#</cfif>" method="post" name="form123">
	</form>
	<script>
		form123.submit();
	</script>
	<cfabort>
<cfelseif Submit eq "Submit">
	<form name="form123" action= "profitmargin_menu2.cfm" method="post"  target="_blank">

			<input type="hidden" name="productfrom" value="#productfrom#">
			<input type="hidden" name="productto" value="#productto#">
			<input type="hidden" name="custfrom" value="#custfrom#">
			<input type="hidden" name="custto" value="#custto#">
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

<cfquery datasource="#dts#" name="getitem">
	select itemno, desp from icitem order by itemno
</cfquery>
<cfquery name="getcust" datasource="#dts#">
  select customerno, name from customer  order by customerno
</cfquery>
<cfquery name="getcate" datasource="#dts#">
  select cate, desp from iccate order by cate
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
<form action="ProfitMargin_Menu.cfm" method="post" target="_self" name="form">
  <cfoutput>
    <h2>Print Profit Margin Report</h2>
  </cfoutput>
  <p>&nbsp;</p>
  <table border="0" align="center" width="80%" class="data">
    <tr>
      <th width="16%">Product</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2" nowrap>
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
          <cfoutput query="getitem">
            <option value="#itemno#"<cfif itemno eq xitemfrom>selected</cfif>>#itemno#</option>
          </cfoutput> </select>
		  <input type="submit" name="pfrom" value="Search">
      </td>
    </tr>
    <tr>
      <th width="16%">Product</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2" nowrap>
        <cfif isdefined("get") and get eq "to">
	  		<cfset xitemto = itemno1>
		<cfelse>
			<cfset xitemto = "">
	 	</cfif>
	    <cfif isdefined("url.productto")>
			<cfset xitemto = #url.productto#>
	  	</cfif>
	      <select name="productto">
          <option value="">Choose a product</option>
          <cfoutput query="getitem">
            <option value="#itemno#"<cfif itemno eq xitemto>selected</cfif>>#itemno#</option>
          </cfoutput> </select> <input type="submit" name="pto" value="Search">
      </td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Customer</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="Custfrom">
          <option value="">Choose a Customer</option>
          <cfoutput query="getcust">
            <option value="#customerno#">#customerno#
            - #name#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th width="16%">Customer</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="Custto">
          <option value="">Choose a Customer</option>
          <cfoutput query="getcust">
            <option value="#customerno#">#customerno#
            - #name#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Valve Type</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="Catefrom">
          <option value="">Choose a Valve Type</option>
          <cfoutput query="getcate">
            <option value="#cate#">#cate#
            - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th width="16%">Valve Type</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="Cateto">
          <option value="">Choose a Valve Type</option>
          <cfoutput query="getcate">
            <option value="#cate#">#cate#
            - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Size</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="sizeidfrom">
          <option value="">Choose a Size</option>
          <cfoutput query="getsizeid">
            <option value="#sizeid#">#sizeid# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th width="16%">Size</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="sizeidto">
          <option value="">Choose a Size</option>
          <cfoutput query="getsizeid">
            <option value="#sizeid#">#sizeid# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Rating</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="Costcodefrom">
          <option value="">Choose a Rating</option>
          <cfoutput query="getCostcode">
            <option value="#costcode#">#costcode# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th width="16%">Rating</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="Costcodeto">
          <option value="">Choose a Rating</option>
          <cfoutput query="getCostcode">
            <option value="#costcode#">#costcode# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Material</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="coloridfrom">
          <option value="">Choose a Material</option>
          <cfoutput query="getcolorid">
            <option value="#colorid#">#colorid# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th width="16%">Material</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="coloridto">
          <option value="">Choose a Material</option>
          <cfoutput query="getcolorid">
            <option value="#colorid#">#colorid# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Manufacturer</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="groupfrom">
          <option value="">Choose a Manufacturer</option>
          <cfoutput query="getgroup">
            <option value="#wos_group#">#wos_group# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th width="16%">Manufacturer</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="groupto">
          <option value="">Choose a Manufacturer</option>
          <cfoutput query="getgroup">
            <option value="#wos_group#">#wos_group# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <th width="16%">Model</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="shelffrom">
          <option value="">Choose a Model</option>
          <cfoutput query="getshelf">
            <option value="#shelf#">#shelf# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th width="16%">Model</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="shelfto">
          <option value="">Choose a Model</option>
          <cfoutput query="getshelf">
            <option value="#shelf#">#shelf# - #desp#</option>
          </cfoutput> </select></td>
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
      <td width="79%"> <table width="365">
          <tr>
            <td><label>
              <input type="radio" name="rgSort" value="Item No" checked>
              Item No. </label></td>
          </tr>
          <tr>
            <td><label>
              <input type="radio" name="rgSort" value="Customer">
              Customer </label></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td width="20%">&nbsp;</td>
      <td width="8%">&nbsp;</td>
      <td width="60%"> <div align="right">
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
  <p>&nbsp;</p></form>
</body>
</html>