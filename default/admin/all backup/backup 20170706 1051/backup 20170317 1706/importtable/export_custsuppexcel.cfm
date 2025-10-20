<cfif url.type eq "debtor">
    <cfset headertype = "Customer">
    <cfset custvpend= "arcust">
    <cfset custtype= "#target_arcust#">
    <cfset pageAction = "exportCustomer2.cfm">
<cfelse>
    <cfset headertype = "Supplier">
    <cfset custvpend= "apvend">
    <cfset custtype= "#target_apvend#">
    <cfset pageAction = "exportSupplier2.cfm">
</cfif>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<cfoutput>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>#headertype# Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getcust" datasource="#dts#">
  select custno, name from #custtype# order by custno 
</cfquery>

<body>
<h1 align="center">Export #headertype# to Excel</h1>

<cfform action="#pageAction#" name="form" id="form" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
	<input type="hidden" name="custvpend" id="custvpend" value="#custtype#" />
	<input type="hidden" name="headertype" id="headertype" value="#headertype#" />
  <table border="0" align="center" width="70%" class="data">
    <tr>
      <th>Customer From</th>

      <td>
      <select name="customerfrom" id="customerfrom">
          <option value="">Choose a customer</option>
          <cfloop query="getcust">
            <option value="#custno#">#custno# - #name#</option>
          </cfloop>
        </select>
        &nbsp;
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />
      </td>
    </tr>
    <tr>
      <th>Customer To</th>
      <td><select name="customerto" id="customerto">
          <option value="">Choose a customer</option>
          <cfloop query="getcust">
            <option value="#custno#">#custno# - #name#</option>
          </cfloop>
        </select>
        &nbsp;
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />
     </td>
    </tr>

    <td colspan="100%"><div align="center">
		<input type="button" name="back" id="back" value="Close" onclick="window.close()">
		&nbsp;<input type="Submit" name="Submit" id="Submit" value="Submit">
      </div></td>
  </tr>
  
  </table>
</cfform>

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

</script>

<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type=#custtype#&fromto={fromto}" />
</body>
</html>
</cfoutput>

