<html>
<head>
<title><cfoutput>Voucher</cfoutput> Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
</head>

<body>
<cfquery name="getgroup" datasource="#dts#">
  select * from voucher order by voucherNo
</cfquery>

<cfquery name="getbatch" datasource="#dts#">
  select * from voucher group by batch order by voucherNo
</cfquery>


  <h1 align="center"><cfoutput>Voucher Listing</cfoutput></h1>
<cfoutput>
    <h4>
<a href="voucher.cfm">Create Voucher</a>|<a href="p_voucher.cfm">Voucher Listing</a>|<a href="vouchermaintenance.cfm">Voucher Maintenance</a><cfif getpin2.h1R10 eq "T">|<a href="voucherapprove.cfm">Voucher Approval</a></cfif>|<a href="voucherusage.cfm">Voucher Usage Report</a>|<a href="voucherprefix.cfm">Voucher Prefix</a></h4>
  </cfoutput>

<cfform action="l_voucher.cfm" name="form" method="post" target="_blank">
  	<input type="hidden" name="Tick" value="0">

  <table border="0" align="center" width="90%" class="data">
    <tr> 
      <th width="20%"><cfoutput>Batch</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Batch</cfoutput></option>
          <cfoutput query="getbatch">
            <option value="#batch#">#batch# </option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Batch</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Batch</cfoutput></option>
          <cfoutput query="getbatch">
            <option value="#batch#">#batch#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>

    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
    
    <tr> 
      <th width="20%"><cfoutput>Voucher No</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom2">
          <option value=""><cfoutput>Choose a Voucher No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#voucherno#">#voucherno#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Voucher</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto2">
          <option value=""><cfoutput>Choose a Voucher No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#voucherno#">#voucherno#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>
    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
   <tr> 
      <td colspan="8"><hr></td>
    </tr>
    <tr> 
      <th width="25%">Show Used voucher Only</th>
      <td width="5%"></td>
      <td width="20%">
      <input type="checkbox" name="cbYes" value="checkbox" onClick="javascript:Tickmodel()"></td>
      <td width="12%"> <cfoutput> </cfoutput></td>
      <td width="5%"><div align="right"> 
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>

  </table>
</cfform>
</body>
</html>
