<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1154,1151,1152,1153,1155,1159,1160,352,1170,22">
<cfinclude template="/latest/words.cfm">
<html>
<head>
<title><cfoutput>#words[1154]#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfquery name="getgroup" datasource="#dts#">
    SELECT * 
    FROM repairtran 
    ORDER BY repairno
</cfquery>

<cfquery datasource='#dts#' name="getPersonnel">
    SELECT * 
    FROM repairtran 
    ORDER BY repairno
</cfquery>
<body>
<cfoutput>
<h1 align="center">#words[1154]#</h1>
    <h4>
	<a href="createrepairservicetable.cfm?type=Create">#words[1151]#</a>
	|| <a href="repairservicetable.cfm">#words[1152]#</a>
	|| <a href="s_repairservicetable.cfm?type=Repair">#words[1153]#</a>
    || <a href="p_repairservice.cfm">#words[1154]#</a>
	</h4>
<cfform action="l_repairservice.cfm" name="form" method="post" target="_blank">
    <table border="0" align="center" width="90%" class="data">
        <tr>
            <th width="20%">#words[1155]#</th>
            <td width="5%"> <div align="center">#UCase(words[1170])#</div></td>
            <td colspan="6">
            <select name="groupfrom">
                <option value="">#words[1159]#</option>
                <cfloop query="getgroup">
                    <option value="#repairno#">#repairno# - #custno#</option>
                </cfloop>
            </select>
            </td>
        </tr>
        <tr>
            <th height="24">#words[1155]#</th>
            <td><div align="center">#UCase(words[22])#</div></td>
            <td colspan="6" nowrap>
            <select name="groupto">
                <option value="">#words[1160]#</option>
                <cfloop query="getgroup">
                    <option value="#repairno#">#repairno# - #custno#</option>
                </cfloop>
            </select>
            </td>
        </tr>
        <tr>
        <td colspan="8">&nbsp;</td>
        </tr>
        <tr>
        <td colspan="8">
        <div align="right">
        	<input type="Submit" name="Submit" value="#words[352]#">
        </div></td>
        </tr>
    </table>
</cfform>
</cfoutput>
</body>
</html>
