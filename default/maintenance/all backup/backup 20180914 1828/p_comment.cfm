<html>
<head>
<title>Comment Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select code, desp from comments order by code
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
	Select * from comments order by code
</cfquery>
<body>
<h1 align="center"><cfoutput>Comment Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1E10 eq 'T'><a href="commenttable2.cfm?type=Create">Creating a New Comment</a> </cfif><cfif getpin2.h1E20 eq 'T'>|| <a href="commenttable.cfm?">List all Comment</a> </cfif><cfif getpin2.h1E30 eq 'T'>|| <a href="s_commenttable.cfm?type=comments">Search For Comment</a></cfif>
  
   <cfif getpin2.h1630 eq 'T'>|| <a href="p_comment.cfm">Comment Listing</a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_comment.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>Comment Listing</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Comment</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#code#">#code# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Comment Listing</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Comment</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#code#">#code# - #desp#</option>
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
