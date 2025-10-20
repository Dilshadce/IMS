<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select code, name,custno,add1,add2,add3,add4 from address order by code
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from Address order by Code
  </cfquery>


<body>
<h1 align="center"><cfoutput>address Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1F10 eq 'T'><a href="Addresstable2.cfm?type=Create">Creating a New Address</a> </cfif><cfif getpin2.h1F20 eq 'T'>|| <a href="Addresstable.cfm">List
    all Address</a> </cfif><cfif getpin2.h1F30 eq 'T'>|| <a href="s_Addresstable.cfm?type=Icitem">Search For Address</a></cfif>
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_addr.cfm">Address Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_addr.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Address</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Address Listing</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#code#">#code# - #name# - #custno# - #add1# - #add2# - #add3# - #add4#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Address</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Address Listing</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#code#">#code# - #name# - #custno# - #add1# - #add2# - #add3# - #add4#</option>
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
