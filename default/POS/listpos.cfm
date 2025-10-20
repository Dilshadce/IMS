<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1312,1313,1314,1315,1316,1317,1318,1319,10">
<cfinclude template="/latest/words.cfm">
<html>
<head>
<title><cfoutput>#words[1312]#</cfoutput></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<h1>#words[1312]#</h1>
<h4>
    <a href="createlist.cfm?type=create">#words[1313]#</a>||
    <a href="listpos.cfm">#words[1314]#</a>||
    <a href="SetupFtp.cfm">#words[1315]#</a>||
    <a href="recalculatetax.cfm">#words[1316]#</a>
</h4>
<cfquery name="getposlist" datasource="#dts#">
    SELECT * 
    FROM poschannel 
    ORDER BY posid
</cfquery>
<table align="center">
    <tr>
        <th width="200px">#words[1317]#</th>
        <th width="200px">#words[1318]#</th>
        <th width="200px">#words[1319]#</th>
        <th width="250px">#words[10]#</th>
    </tr>
    <cfloop query="getposlist">
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td>#getposlist.posid#</td>
            <td>#getposlist.posfolder#</td>
            <td>#dateformat(getposlist.lastwork_on,'YYYY-MM-DD')#&nbsp;#timeformat(getposlist.lastwork_on,'HH:MM:SS')#</td>
            <td><a href="index.cfm?id=#getposlist.id#" ><img height="18px" width="18px" src="/images/Copy Icon.jpg" alt="Copy" border="0">Manage FTP</a>&nbsp;&nbsp;<a href="createlist.cfm?id=#getposlist.id#&type=edit"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>&nbsp;&nbsp;<a href="createlist.cfm?id=#getposlist.id#&type=delete"><img height="18px" width="18px" src="/images/delete.ICO" alt="Edit" border="0">Delete</a></td>
        </tr>
    </cfloop>
</table>
</cfoutput>
</body>
</html>