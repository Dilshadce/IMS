<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select term, desp from #target_icterm# order by term
</cfquery>

<cfquery name="getitem" datasource="#dts#">
		select * from #target_icterm# where term
	</cfquery>
<body>
<h1 align="center"><cfoutput>Term Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1I10 eq 'T'>
		<a href="Termtable2.cfm?type=Create">Creating a Term</a> || 
	</cfif>
	<cfif getpin2.h1I20 eq 'T'>
		<a href="Termtable.cfm?">List all Term</a> || 
	</cfif>
	<cfif getpin2.h1I30 eq 'T'> 
		<a href="s_Termtable.cfm?type=icterm">Search For Term</a>
	</cfif>
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_term.cfm">Term Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_term.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Term Listing</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Term</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Term#">#Term# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Term Listing</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Term</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Term#">#Term# - #desp#</option>
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
