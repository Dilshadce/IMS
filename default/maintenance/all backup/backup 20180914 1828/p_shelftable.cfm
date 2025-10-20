<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select shelf, desp from icshelf order by shelf
</cfquery>

<cfquery datasource='#dts#' name="getgeneral">
	Select lmodel as layer from gsetup
</cfquery>

<body>
<h1 align="center"><cfoutput>#getgeneral.layer# Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1910 eq 'T'><a href="shelftable2.cfm?type=Create">Creating a #getgeneral.layer#</a> </cfif><cfif getpin2.h1920 eq 'T'>|| <a href="shelftable.cfm?">List 
    all #getgeneral.layer#</a> </cfif><cfif getpin2.h1930 eq 'T'>|| <a href="s_shelftable.cfm?type=icshelf">Search For #getgeneral.layer#</a></cfif>
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_shelftable.cfm">#getgeneral.layer# Listing </a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_shelftable.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>#getgeneral.layer#</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a #getgeneral.layer#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#shelf#">#shelf# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>#getgeneral.layer#</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a #getgeneral.layer#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#shelf#">#shelf# - #desp#</option>
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
