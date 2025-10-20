<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgroup" datasource="#dts#">
  select agent, desp FROM #target_icagent# order by agent
</cfquery>

<cfquery name="getGsetup" datasource="#dts#">
  Select lAGENT from GSetup
</cfquery>

<body>
<h1 align="center"><cfoutput>#getGsetup.lAGENT# Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1B10 eq 'T'><a href="agenttable2.cfm?type=Create">Creating a New #getGsetup.lAGENT#</a> </cfif>
	<cfif getpin2.h1B20 eq 'T'>|| <a href="agenttable.cfm">List all #getGsetup.lAGENT#</a> </cfif>
	<cfif getpin2.h1B30 eq 'T'>|| <a href="s_agenttable.cfm?type=Icitem">Search For #getGsetup.lAGENT#</a></cfif>
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_agent.cfm">#getGsetup.lAGENT# Listing </a></cfif>
  </h4>
  </cfoutput>

<cfform action="l_agent.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th width="20%"><cfoutput>#getGsetup.lAGENT#</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="groupfrom" id="groupfrom" onChange="document.getElementById('groupto').selectedIndex=this.selectedIndex;">
          <option value=""><cfoutput>Choose a #getGsetup.lAGENT#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#agent#">#agent# - #desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>#getGsetup.lAGENT#</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="groupto" id="groupto">
          <option value=""><cfoutput>Choose a #getGsetup.lAGENT#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#agent#">#agent# - #desp#</option>
          </cfoutput> </select> </td>
    </tr>
    <tr>
      <td colspan="8">&nbsp;</td>
    </tr>
    <cfif left(dts,4) eq "beps">
     <cfquery name="getarea" datasource="#dts#">
                SELECT * FROM #target_icarea# ORDER BY area
                </cfquery>
    <tr>
      <th width="20%"><cfoutput>Location</cfoutput></th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="6"><select name="locationfrom" id="locationfrom" onChange="document.getElementById('locationto').selectedIndex=this.selectedIndex;">
          <option value=""><cfoutput>Choose a Location</cfoutput></option>
          <cfoutput query="getarea">
            <option value="#getarea.area#">#getarea.area# - #getarea.desp#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Location</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap> <select name="locationto" id="locationto">
          <option value=""><cfoutput>Choose a Location</cfoutput></option>
           <cfoutput query="getarea">
            <option value="#getarea.area#">#getarea.area# - #getarea.desp#</option>
          </cfoutput> </select> </td>
    </tr>
	</cfif>
    <tr>
      <td colspan="8"> <cfoutput> </cfoutput> <div align="right">
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
</cfform>
</body>
</html>
