<html>
<head>
<title>Repair Transaction Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select * from repairtran order by repairno
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from repairtran order by repairno
</cfquery>
<body>
<h1 align="center"><cfoutput>Repair Transaction Listing</cfoutput></h1>
  <cfoutput>
    <h4>
	<a href="createrepairservicetable.cfm?type=Create">Creating A New Repair Transaction</a>
	|| <a href="repairservicetable.cfm">List All Repair Transaction</a>
	|| <a href="s_repairservicetable.cfm?type=Repair">Search For Repair Transaction</a>
    || <a href="p_repairservice.cfm">Repair Transaction Listing</a>
	</h4>
  </cfoutput>

<cfform action="l_repairservice.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Repair No</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Repair No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#repairno#">#repairno# - #custno#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Repair No</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Repair No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#repairno#">#repairno# - #custno#</option>
          </cfoutput> </select> </td>
    </tr>
    <tr>
      <td colspan="8">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="8"> <cfoutput> </cfoutput> <div align="right">
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
</cfform>
</body>
</html>
