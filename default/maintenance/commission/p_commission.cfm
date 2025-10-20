<html>
<head>
<title><cfoutput>Commission</cfoutput> Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

</head>

<body>
<cfquery name="getgroup" datasource="#dts#">
  select * from commission
</cfquery>

  <h1 align="center"><cfoutput>Commission Listing Report</cfoutput></h1>
<cfoutput>
<h4>
<a onClick="ColdFusion.Window.show('createcomm');" onMouseOver="this.style.cursor='hand'">Create Commission</a>||<a href="commissionpenalty.cfm">Set Commission Penalty</a>||<a href="p_commission.cfm">Commission Listing</a>||<a href="commReport.cfm">Commission Report</a></h4>
  </cfoutput>

<cfform action="l_commission.cfm" name="form" method="post" target="_blank">
  	<input type="hidden" name="Tick" value="0">

	
  <table border="0" align="center" width="90%" class="data">
    <tr> 
      <th width="20%"><cfoutput>Commission</cfoutput></th>
      <td width="10%"> <div align="center">From</div></td>
      <td width="70%"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Commission</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#commname#">#commname# - #commdesp# </option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24" width="20%"><cfoutput>Commission</cfoutput></th>
      <td width="10%"><div align="center">To</div></td>
      <td width="70%" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Commission</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#commname#">#commname# - #commdesp#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>

    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>


    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
   
   
    <tr> 

      <td colspan="3"><div align="center"> 
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
</cfform>
</body>
</html>
