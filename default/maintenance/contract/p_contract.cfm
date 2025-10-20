<html>
<head>
<title>Pro Server Agreement Record</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

</head>

<script language="JavaScript">

</script>

<body>
<cfquery name="getgroup" datasource="#dts#">
  select servicecode,desp from serviceagree
</cfquery>

<cfquery name="getcust" datasource="#dts#">
  select custno,name from #target_arcust# order by custno
</cfquery>



  <h1 align="center"><cfoutput>Pro Server Agreement
 Record</cfoutput></h1>
<cfoutput>
   <h4>
<a href="index.cfm" onMouseOver="this.style.cursor='hand'">Create Service Agreement</a>||<a href="servicelisting.cfm">Service Agreement Listing</a>||<a href="p_contract.cfm">Pro Server Agreement Record</a>||<a href="p_contract2.cfm">Collection Schedule Report</a></h4>
  </cfoutput>

<cfform action="l_contract.cfm" name="form" method="post" target="_blank">

  <table border="0" align="center" width="90%" class="data">
    <tr> 
      <th width="20%"><cfoutput>Service Agreement</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Service Agreement</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#servicecode#">#servicecode# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Service Agreement</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Service Agreement</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#servicecode#">#servicecode# - #desp#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>

    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
    
    <tr> 
      <th width="20%"><cfoutput>Customer</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom2">
          <option value=""><cfoutput>Choose Customer</cfoutput></option>
          <cfoutput query="getcust">
            <option value="#custno#">#custno# - #name#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Customer</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto2">
          <option value=""><cfoutput>Choose Customer</cfoutput></option>
          <cfoutput query="getcust">
            <option value="#custno#">#custno# - #name#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>




    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
   
    <tr>
    <td colspan="9"><div align="center">
    <input type="Submit" name="Submit" value="Submit"></div></td></tr>
  </table>
</cfform>
</body>
</html>
