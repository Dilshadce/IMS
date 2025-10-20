<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select area, desp FROM #target_icarea# order by area
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * FROM #target_icarea# order by area
</cfquery>
<body>
<h1 align="center"><cfoutput>Area Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1F10 eq 'T'><a href="areatable2.cfm?type=Create">Creating A New Area</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="areatable.cfm">List All Area</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_areatable.cfm?type=icarea">Search For Area</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_area.cfm">Area Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_area.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Area Listing</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Area</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#area#">#area# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Area Listing</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Area</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#area#">#area# - #desp#</option>
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
