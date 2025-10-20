<html>
<head>
<title>Make Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select Make, desp from vehiMake order by Make
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from vehiMake order by Make
</cfquery>
<body>
<h1 align="center"><cfoutput>Make Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1F10 eq 'T'><a href="Maketable2.cfm?type=Create">Creating A New Make</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Maketable.cfm">List All Make</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Maketable.cfm?type=vehiMake">Search For Make</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Make.cfm">Make Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_Make.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Make Listing</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Make</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Make#">#Make# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Make Listing</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Make</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Make#">#Make# - #desp#</option>
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
