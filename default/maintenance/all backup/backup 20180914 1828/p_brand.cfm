<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery datasource='#dts#' name="getgsetup">
	Select * from gsetup
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
  select brand, desp from brand order by brand
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from brand order by brand
</cfquery>

<body>
<h1 align="center"><cfoutput>#getgsetup.lbrand# Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1P10 eq 'T'><a href="brandtable2.cfm?type=Create">Creating a New #getgsetup.lbrand#</a> </cfif>
		<cfif getpin2.h1P20 eq 'T'>|| <a href="brandtable.cfm">List all #getgsetup.lbrand#</a> </cfif>
		<cfif getpin2.h1P30 eq 'T'>|| <a href="s_brandtable.cfm?type=brand">Search For #getgsetup.lbrand#</a></cfif>
        <cfif getpin2.h1630 eq 'T'>|| <a href="p_brand.cfm">#getgsetup.lbrand# Listing</a>
        </cfif>
  </h4>
  </cfoutput>

<cfform action="l_brand.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>#getgsetup.lbrand#</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a #getgsetup.lbrand#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#brand#">#brand# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>#getgsetup.lbrand#</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a #getgsetup.lbrand#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#brand#">#brand# - #desp#</option>
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
