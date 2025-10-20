<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select location, desp,addr1,addr2,addr3,addr4,custno from iclocation order by location
</cfquery>

<cfquery name="getGsetup" datasource="#dts#">
  Select lLOCATION from GSetup
</cfquery>

<body>
<h1 align="center"><cfoutput>#getGsetup.lLOCATION# Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1D10 eq 'T'><a href="locationtable2.cfm?type=Create">Creating a New #getGsetup.lLOCATION#</a> </cfif>
	<cfif getpin2.h1D20 eq 'T'>|| <a href="locationtable.cfm">List All #getGsetup.lLOCATION#</a> </cfif>
	<cfif getpin2.h1D30 eq 'T'>|| <a href="s_locationtable.cfm?type=Icitem">Search For #getGsetup.lLOCATION#</a></cfif>
    
     <cfif getpin2.h1630 eq 'T'>|| <a href="p_location.cfm"> #getGsetup.lLOCATION# Listing</a></cfif>
      <cfif getpin2.h1630 eq 'T'>|| <a href="itemlocationenquire.cfm">Item #getGsetup.lLOCATION# Balance Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_location.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>#getGsetup.lLOCATION#</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a #getGsetup.lLOCATION#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#location#">#location# - #desp# - #addr1# - #addr2# - #addr3# - #addr4# - #custno#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>#getGsetup.lLOCATION#</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a #getGsetup.lLOCATION#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#location#">#location# - #desp# - #addr1# - #addr2# - #addr3# - #addr4# - #custno#</option>
          </cfoutput> </select> </td>
    </tr>
    <tr>
      <td colspan="8">&nbsp;</td>
    </tr>
    <cfif lcase(HcomID) eq "simplysiti_i">    
        <tr> 
        		<th>Cluster:</th>
                <td><div align="center">To</div></td>
        		<td>
                <select name="clusterfrom" id="clusterfrom">
                <option value="">No Cluster</option>
                <option value="A">A</option>
                <option value="A1">A1</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
                </select>
				</td>
      		</tr>
            <tr>
        <tr> 
        		<th>Cluster:</th>
                <td><div align="center">To</div></td>
        		<td>
                <select name="clusterto" id="clusterto">
                <option value="">No Cluster</option>
                <option value="A" >A</option>
                <option value="A1">A1</option>
                <option value="B" >B</option>
                <option value="C" >C</option>
                <option value="D" >D</option>
                </select>
				</td>
      		</tr>
            <tr>
      <td colspan="8">&nbsp;</td>
    </tr>
        </cfif>
    
    <tr>
      <td colspan="8"> <cfoutput> </cfoutput> <div align="right">
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
</cfform>
</body>
</html>
