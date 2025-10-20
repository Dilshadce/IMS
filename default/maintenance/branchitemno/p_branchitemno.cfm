<html>
<head>
<title>Branch Item No Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select branchitemno, desp from icbranchitemno order by branchitemno
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from icbranchitemno order by branchitemno
</cfquery>
<body>
<h1 align="center"><cfoutput>Branch Item No Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1F10 eq 'T'><a href="branchitemno2.cfm?type=Create">Creating A New Branch Item No</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="branchitemno.cfm">List All Branch Item No</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_branchiemno.cfm?type=icbranch">Search For Branch Item No</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_branchitemno.cfm">Branch Item No Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_branchitemno.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Branch Item No Listing</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Branch Item No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#branchitemno#">#branchitemno# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Branch Item No Listing</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Branch Item No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#branchitemno#">#branchitemno# - #desp#</option>
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
