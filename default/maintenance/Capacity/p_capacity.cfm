<html>
<head>
<title>Capacity Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select Capacity, desp from vehicapacity order by Capacity
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from vehicapacity order by Capacity
</cfquery>
<body>
<h1 align="center"><cfoutput>Capacity Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1F10 eq 'T'><a href="Capacitytable2.cfm?type=Create">Creating A New Capacity</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Capacitytable.cfm">List All Capacity</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Capacitytable.cfm?type=vehicapacity">Search For Capacity</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Capacity.cfm">Capacity Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_Capacity.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Capacity Listing</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Capacity</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Capacity#">#Capacity# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Capacity Listing</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Capacity</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Capacity#">#Capacity# - #desp#</option>
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
