<html>
<head>
<title>Print  Sales Report By Month</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery>

<cfquery name="getprevlastaccyear" datasource="#dts#">
	select LastAccDate,ThisAccDate FROM icitem_last_year group by LastAccDate,ThisAccDate order by LastAccDate desc limit 2
</cfquery>
<cfif type eq "productmonth">
	<cfset trantype = "PRODUCTS">
<cfelseif type eq "customermonth">
	<cfset trantype = "CUSTOMERS">	
<cfelseif type eq "Agentmonth">
	<cfset trantype = "AGENT">		
<cfelseif type eq "groupmonth">
	<cfset trantype = "GROUP">
<cfelseif type eq "brandmonth">
	<cfset trantype = "BRAND">
<cfelseif type eq "endusermonth">
	<cfset trantype = "END USER">
</cfif>

<body>
<h1 align="center">
<cfoutput>Print #trantype# Sales Report By Month</cfoutput>
</h1>
<cfoutput>
<form name="itemform" action="salesmonthnew.cfm?type=#url.type#" method="post">
<table border="0" align="center" width="65%" class="data">
	<tr>
      	<th width="20%">Transaction Range</th>
      	<td width="*">&nbsp;
			
			<select name="lastaccdaterange">
          		<option value="">#dateformat(getgeneral.lastaccyear,"dd/mm/yyy")# - #dateformat(now(),"dd/mm/yyy")#</option>
          		<cfloop query="getprevlastaccyear">
            	<option value="#getprevlastaccyear.LastAccDate#">#dateformat(getprevlastaccyear.LastAccDate,"dd/mm/yyy")# - #dateformat(getprevlastaccyear.ThisAccDate,"dd/mm/yyy")#</option>
          		</cfloop>
			</select>
			
			&nbsp;&nbsp;<input type="submit" value="Submit">
		</td>
    </tr>
</table>
</form>
</cfoutput>
</body>
</html>