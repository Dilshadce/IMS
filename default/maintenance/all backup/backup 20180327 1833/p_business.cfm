<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select business, desp from business order by business
</cfquery>

<cfquery datasource='#dts#' name="getitem">
		Select * from business where business
	</cfquery>
<body>
<h1 align="center"><cfoutput>Business Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1630 eq 'T'><a href="businesstable2.cfm?type=Create">Creating a New Business</a></cfif> || 
<cfif getpin2.h1630 eq 'T'><a href="businesstable.cfm">List All Business</a> </cfif>|| 
<cfif getpin2.h1630 eq 'T'><a href="s_businesstable.cfm?type=business">Search For Business</a></cfif>

<cfif getpin2.h1630 eq 'T'>|| <a href="p_business.cfm">Business Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_business.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Business Listing</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Business</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Business#">#Business# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Business Listing</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Business</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Business#">#Business# - #desp#</option>
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
