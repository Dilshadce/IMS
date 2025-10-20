<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<cfquery name="getdealer_menu" datasource="#dts#">
	select * from dealer_menu
</cfquery>
</head>

<script language="JavaScript">
<!--- 	document.form.Tick.value = toString(val(document.form.Tick.value)+1); --->

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

</script>

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
<cfquery name="getgsetup" datasource='#dts#'>
  Select * from gsetup
</cfquery>

<body>
<h1 align="center">Export Item to Excel</h1>

<cfform action="export_itemexcel2.cfm" name="form" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
  <input type="hidden" name="Tick" value="0">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%">Product</th>
      <td width="5%"><div align="center">From</div></td>
      <td colspan="6"><select name="productfrom">
          <option value="">Choose a product</option>
          <cfoutput query="getitem">
            <option value="#itemno#">#itemno# 
              - #desp#</option>
          </cfoutput>
        </select>

          <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
            <input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">

      </td>
    </tr>
    <tr>
      <th>Product</th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap><select name="productto">
          <option value="">Choose a product</option>
          <cfoutput query="getitem">
            <option value="#itemno#">#itemno# 
              - #desp#</option>
          </cfoutput>
        </select>

           <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
            <input type="text" name="searchitemto" onKeyUp="getProduct('productto');">

      </td>
    </tr>
    <tr>
      <td colspan="8">&nbsp;</td>
    </tr>

    <tr>
      <th width="20%"><cfoutput>#getgsetup.lCATEGORY#</cfoutput></th>
      <td width="5%"><div align="center">From</div></td>
      <td width="20%"><select name="Catefrom">
          <option value="">Choose a <cfoutput>#getgsetup.lCATEGORY#</cfoutput></option>
          <cfoutput query="getcate">
            <option value="#cate#">#cate# - #desp#</option>
          </cfoutput>
      </select></td>
      </tr>
      <tr>
      <th width="20%"><cfoutput>#getgsetup.lCATEGORY#</cfoutput></th>
      <td width="5%"><div align="right">To</div></td>
      <td width="20%"><select name="Cateto">
          <option value="">Choose a <cfoutput>#getgsetup.lCATEGORY#</cfoutput></option>
          <cfoutput query="getcate">
            <option value="#cate#">#cate# 
              - #desp#</option>
          </cfoutput>
      </select></td>
    </tr>
    <tr>
      <td colspan="8"><hr></td>
    </tr>
    <tr>
      <th width="20%"><cfoutput>#getgsetup.lSIZE#</cfoutput></th>
      <td width="5%"><div align="center">From</div></td>
      <td width="20%"><select name="sizeidfrom">
          <option value="">Choose a <cfoutput>#getgsetup.lSIZE#</cfoutput></option>
          <cfoutput query="getsizeid">
            <option value="#sizeid#">#sizeid# 
              - #desp#</option>
          </cfoutput>
      </select></td>
      </tr>
      <tr>
      <th width="20%"><cfoutput>#getgsetup.lSIZE#</cfoutput></th>
      <td width="5%"><div align="right">To</div></td>
      <td width="20%"><select name="sizeidto">
          <option value="">Choose a <cfoutput>#getgsetup.lSIZE#</cfoutput></option>
          <cfoutput query="getsizeid">
            <option value="#sizeid#">#sizeid# 
              - #desp#</option>
          </cfoutput>
      </select></td>
    </tr>
    <tr>
      <td colspan="8"><hr></td>
    </tr>
    <tr>
      <th width="20%"><cfoutput>#getgsetup.lRATING#</cfoutput></th>
      <td width="5%"><div align="center">From</div></td>
      <td width="20%"><select name="Costcodefrom">
          <option value="">Choose a <cfoutput>#getgsetup.lRATING#</cfoutput></option>
          <cfoutput query="getCostcode">
            <option value="#costcode#">#costcode# 
              - #desp#</option>
          </cfoutput>
      </select></td>
      </tr>
      <tr>
      <th width="20%"><cfoutput>#getgsetup.lRATING#</cfoutput></th>
      <td width="5%"><div align="right">To</div></td>
      <td width="20%"><select name="Costcodeto">
          <option value="">Choose a <cfoutput>#getgsetup.lRATING#</cfoutput></option>
          <cfoutput query="getCostcode">
            <option value="#costcode#">#costcode# 
              - #desp#</option>
          </cfoutput>
      </select></td>
    </tr>
    <tr>
      <td colspan="8"><hr></td>
    </tr>
    <tr>
      <th width="20%"><cfoutput>#getgsetup.lMATERIAL#</cfoutput></th>
      <td width="5%"><div align="center">From</div></td>
      <td width="20%"><select name="coloridfrom">
          <option value="">Choose a <cfoutput>#getgsetup.lMATERIAL#</cfoutput></option>
          <cfoutput query="getcolorid">
            <option value="#colorid#">#colorid# 
              - #desp#</option>
          </cfoutput>
      </select></td>
      </tr>
      <tr>
      <th width="20%"><cfoutput>#getgsetup.lMATERIAL#</cfoutput></th>
      <td width="5%"><div align="right">To</div></td>
      <td width="20%"><select name="coloridto">
          <option value="">Choose a <cfoutput>#getgsetup.lMATERIAL#</cfoutput></option>
          <cfoutput query="getcolorid">
            <option value="#colorid#">#colorid# 
              - #desp#</option>
          </cfoutput>
      </select></td>
    </tr>
    <tr>
      <td colspan="8"><hr></td>
    </tr>
    <tr>
      <th width="20%"><cfoutput>#getgsetup.lGROUP#</cfoutput></th>
      <td width="5%"><div align="center">From</div></td>
      <td width="20%"><select name="groupfrom">
          <option value="">Choose a <cfoutput>#getgsetup.lGROUP#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#wos_group#">#wos_group# 
              - #desp#</option>
          </cfoutput>
      </select></td>
      </tr>
      <tr>
      <th width="20%"><cfoutput>#getgsetup.lGROUP#</cfoutput></th>
      <td width="5%"><div align="right">To</div></td>
      <td width="20%"><select name="groupto">
          <option value="">Choose a <cfoutput>#getgsetup.lGROUP#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#wos_group#">#wos_group# 
              - #desp#</option>
          </cfoutput>
      </select></td>
    </tr>
    <tr>
      <td colspan="8"><hr></td>
    </tr>
    <tr>
      <th width="20%"><cfoutput>#getgsetup.lMODEL#</cfoutput></th>
      <td width="5%"><div align="center">From</div></td>
      <td width="20%"><select name="shelffrom">
          <option value="">Choose a <cfoutput>#getgsetup.lMODEL#</cfoutput></option>
          <cfoutput query="getshelf">
            <option value="#shelf#">#shelf# 
              - #desp#</option>
          </cfoutput>
      </select></td>
      </tr>
      <tr>
      <th width="20%"><cfoutput>#getgsetup.lMODEL#</cfoutput></th>
      <td width="5%"><div align="right">To</div></td>
      <td width="20%"><select name="shelfto">
          <option value="">Choose a <cfoutput>#getgsetup.lMODEL#</cfoutput></option>
          <cfoutput query="getshelf">
            <option value="#shelf#">#shelf# 
              - #desp#</option>
          </cfoutput>
      </select></td>
    </tr>
    <tr>
      <td colspan="8"><hr></td>
    </tr>
   <tr>
    <td colspan="100%"><div align="center">
          <input type="Submit" name="Submit" value="Submit">
      </div></td>
  </tr>
  
  </table>
  <table border="0" align="center" width="90%" class="data"><tr><cfif getgsetup.gpricemin eq 1>
  </cfif>
  </tr>
  </table>
</cfform>
</body>
</html>

<cfif getdealer_menu.itemformat eq '2'>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem2.cfm?type=Product&fromto={fromto}" />
<cfelse>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Product&fromto={fromto}" />
        </cfif>