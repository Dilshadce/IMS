<html>
<head>
<title>Outstanding Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>



<body>

<cfform action="outstandreport1.cfm?type=#type#" method="post" name="form">
<cfif type eq 'DO' or type eq 'QUO'>
<cfquery name="getcust" datasource="#dts#">
	select custno,name from #target_arcust# order by custno
</cfquery>
<cfquery name="getrefno" datasource="#dts#">
	select refno from artran where type = '#type#' order by refno
</cfquery>
<cfoutput><h1><center>Outstanding <cfif type eq 'QUO'>Quotation<cfelse>DO</cfif></center></h1></cfoutput>
<table align="center" border="0" width="65%" class="data">
  <tr>
      <th width="27%">Customer</th>
      <td width="10%"><div align="center">From</div></td>
    <td width="63%"><select name="custfrom">
          <option value="">Choose a Customer</option>
          <cfoutput query="getcust"> 
            <option value="#custno#">#custno# - #name#</option>
          </cfoutput> </select></td>
      </tr>
  <tr>
      <th>Customer</th>
    <td><div align="center">To</div></td>
    <td><select name="custto">
          <option value="">Choose a Customer</option>
          <cfoutput query="getcust"> 
            <option value="#custno#">#custno# - #name#</option>
          </cfoutput> </select></td>
    
  </tr>
  <tr>
    <td colspan="3"><hr></td>
    
  </tr>
  <tr>
      <th>Reference No</th>
    <td><div align="center">From</div></td>
    <td><select name="refnofrom">
          <option value="">Choose a Refno</option>
          <cfoutput query="getrefno"> 
            <option value="#refno#">#refno#</option>
          </cfoutput> </select></td>
    
  </tr>
  <tr>
      <th>Reference No</th>
    <td><div align="center">To</div></td>
    <td><select name="refnoto">
          <option value="">Choose a Refno</option>
          <cfoutput query="getrefno"> 
            <option value="#refno#">#refno#</option>
          </cfoutput> </select></td>
    
  </tr>
  <tr>
    <td colspan="3"><hr></td>
    
  </tr>
  <tr>
      <th>Date</th>
    <td><div align="center">From</div></td>
    <td><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY) </td>
    
  </tr>
  <tr>
      <th>Date</th>
    <td><div align="center">To</div></td>
    <td><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY)</td>
    
  </tr>
   <tr>
    <td colspan="3" align="right"><input name="submit" type="submit" value="Submit"></td>
    
  </tr>
</table>


<cfelse>
	<cfif type eq '3' or type eq '4'>
		<cfset title = target_apvend>
		<cfquery name="getrefno" datasource="#dts#">
			select refno from artran where type = 'PO' order by refno
		</cfquery>	
		<cfif type eq '3'>
			<h1><center>Outstanding PO Status</center></h1>
		<cfelse>
			<h1><center>Outstanding PO Details</center></h1>
		</cfif>
	<cfelse>		
		<cfset title = target_arcust>
		<cfquery name="getrefno" datasource="#dts#">
			select refno from artran where type = 'SO' order by refno
		</cfquery>
		<cfif type eq '5'>
			<h1><center>Outstanding SO Status</center></h1>
		<cfelseif type eq '6'>
			<h1><center>Outstanding SO Details</center></h1>
		<cfelseif type eq '7'>
			<h1><center>Outstanding SO to PO</center></h1>
		<!--- <cfelseif type eq '8'>
			<h1><center>SO to PO Report</center></h1> --->
		</cfif>
	</cfif>
	
	<cfquery name="getcust" datasource="#dts#">
		select custno,name from #title# order by custno
	</cfquery>
	
<table align="center" border="0" width="65%" class="data">
  <tr>
      <th width="27%"><cfoutput>#title#</cfoutput></th>
      <td width="10%"><div align="center">From</div></td>
    <td width="63%"><select name="custfrom">
          <cfoutput><option value="">Choose a #title#</option></cfoutput>
          <cfoutput query="getcust"> 
            <option value="#custno#">#custno# - #name#</option>
          </cfoutput> </select></td>
      </tr>
  <tr>
      <th><cfoutput>#title#</cfoutput></th>
    <td><div align="center">To</div></td>
    <td><select name="custto">
          <cfoutput><option value="">Choose a #title#</option></cfoutput>
          <cfoutput query="getcust"> 
            <option value="#custno#">#custno# - #name#</option>
          </cfoutput> </select></td>
    
  </tr>
  <tr>
    <td colspan="3"><hr></td>
    
  </tr>
  <tr>
      <th>Reference No</th>
    <td><div align="center">From</div></td>
    <td><select name="refnofrom">
          <option value="">Choose a Refno</option>
          <cfoutput query="getrefno"> 
            <option value="#refno#">#refno#</option>
          </cfoutput> </select></td>
    
  </tr>
  <tr>
      <th>Reference No</th>
    <td><div align="center">To</div></td>
    <td><select name="refnoto">
          <option value="">Choose a Refno</option>
          <cfoutput query="getrefno"> 
            <option value="#refno#">#refno#</option>
          </cfoutput> </select></td>
    
  </tr>
  <tr>
    <td colspan="3"><hr></td>    
  </tr>
  <cfif type neq '6'>
  	<cfquery name="getitem" datasource="#dts#">
		select itemno from icitem order by itemno
	</cfquery>
  <tr>
      <th>Product</th>
    <td><div align="center">From</div></td>
    <td><select name="productfrom">
          <option value="">Choose a Product</option>
          <cfoutput query="getitem"> 
            <option value="#itemno#">#itemno#</option>
          </cfoutput> </select></td>
    
  </tr>
  <tr>
      <th>Product</th>
    <td><div align="center">To</div></td>
    <td><select name="Productto">
          <option value="">Choose a Product</option>
          <cfoutput query="getitem"> 
            <option value="#itemno#">#itemno#</option>
          </cfoutput> </select></td>    
  </tr>
  <tr>
    <td colspan="3"><hr></td>    
  </tr>
  </cfif>
  <tr>
      <th>Date</th>
    <td><div align="center">From</div></td>
    <td><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY) </td>
    
  </tr>
  <tr>
      <th>Date</th>
    <td><div align="center">To</div></td>
    <td><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY)</td>
    
  </tr>
  <tr>
    <td colspan="3"><hr></td>
    
  </tr>
  <tr>
      <th>Delivery Date</th>
    <td><div align="center">From</div></td>
    <td><cfinput type="text" name="deldatefrom" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY) </td>
    
  </tr>
  <tr>
      <th>Delivery Date</th>
    <td><div align="center">To</div></td>
    <td><cfinput type="text" name="deldateto" maxlength="10" validate="eurodate" size="10">
        (DD/MM/YYYY)</td>
    
  </tr>
   <tr>
    <td colspan="3" align="right"><input name="submit" type="submit" value="Submit"></td>
    
  </tr>
</table>



</cfif>

</cfform>
</body>
</html>
