<html>
<head>
<title>Customer Listing</title>
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
function getCustomer(type){
	if(type == 'customerto'){
		var inputtext = document.form.searchcustto.value;
		DWREngine._execute(_reportflocation, null, 'customerlookup', inputtext, getCustomerResult);
		
	}else{
		var inputtext = document.form.searchcustfr.value;
		DWREngine._execute(_reportflocation, null, 'customerlookup', inputtext, getCustomerResult2);
	}
}

function getCustomerResult(itemArray){
	DWRUtil.removeAllOptions("customerto");
	DWRUtil.addOptions("customerto", itemArray,"KEY", "VALUE");
}

function getCustomerResult2(itemArray){
	DWRUtil.removeAllOptions("customerfrom");
	DWRUtil.addOptions("customerfrom", itemArray,"KEY", "VALUE");
}
// end: product search

</script>

<cfquery name="getcust" datasource="#dts#">
  select custno, name from #target_arcust# order by custno 
</cfquery>


<body>
<h1 align="center">Export Customer to Excel</h1>

<cfform action="export_custexcel2.cfm" name="form" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
  <input type="hidden" name="Tick" value="0">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%">Customer No.</th>
      <td width="5%"><div align="center">From</div></td>
      <td colspan="6"><select name="customerfrom">
          <option value="">Choose a customer</option>
          <cfoutput query="getcust">
            <option value="#custno#">#custno# 
              - #name#</option>
          </cfoutput>
        </select>
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;
            <input type="text" name="searchcustfr" onKeyUp="getCustomer('customerfrom');">

      </td>
    </tr>
    <tr>
      <th>Customer</th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap><select name="customerto">
          <option value="">Choose a customer</option>
          <cfoutput query="getcust">
            <option value="#custno#">#custno# 
              - #name#</option>
          </cfoutput>
        </select>
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />
        &nbsp;
            <input type="text" name="searchcustto" onKeyUp="getCustomer('customerto');">

      </td>
    </tr>
    <tr>
      <td colspan="8">&nbsp;</td>
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
  <table border="0" align="center" width="90%" class="data">
  </table>
</cfform>
</body>
</html>

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type=#target_arcust#&fromto={fromto}" />