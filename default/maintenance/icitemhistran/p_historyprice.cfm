<html>
<head>
<title><cfoutput>History Price</cfoutput> Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
</head>

<body>

<cfquery name="getitem" datasource="#dts#">
  select * from icitemhistran group by itemno order by itemno
</cfquery>


  <h1 align="center"><cfoutput>Item History Price Listing</cfoutput></h1>
<cfoutput>
<cfoutput>
    <h4>
<a href="voucher.cfm">Create New History Price</a>|<a href="p_historyprice.cfm?itemno=#url.itemno#">History Price Listing</a></h4></cfoutput>
  </cfoutput>

<cfform action="l_historyprice.cfm" name="form" method="post" target="_blank">
  	<input type="hidden" name="Tick" value="0">

  <table border="0" align="center" width="90%" class="data">
    <tr> 
      <th width="20%"><cfoutput>Item No</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Item</cfoutput></option>
          <cfoutput query="getitem">
            <option value="#itemno#">#itemno# </option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Item No</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Item</cfoutput></option>
          <cfoutput query="getitem">
            <option value="#itemno#">#itemno#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>

    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
    
    
   <tr> 
      <td colspan="8"><hr></td>
    </tr>
      <td colspan="100%"><div align="center"> 
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>

  </table>
</cfform>
</body>
</html>
