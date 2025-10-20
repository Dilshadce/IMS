<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1313,1314,1315,1317,1318,1321,1322,681,1320">
<cfinclude template="/latest/words.cfm">
<html>
<head>
<title><cfoutput>#words[1313]#</cfoutput></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<cfset posrowid = "">
<cfset posid = "">
<cfset posfolder = "">
<cfset posbill = "">
<cfset custno = "">
<cfset readonlyfield = "false">
<cfif isdefined('url.id')>
    <cfquery name="getposdetail" datasource="#dts#">
        SELECT id,posid, posfolder,posbill,custno 
        FROM poschannel 
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
    </cfquery>
    <cfset posid = getposdetail.posid>
    <cfset posfolder = getposdetail.posfolder>
    <cfset posrowid = getposdetail.id>
    <cfset posbill = getposdetail.posbill>
    <cfset custno = getposdetail.custno>
    <cfset readonlyfield = "true">
</cfif>
<h1>#words[1320]#</h1>
<h4>
    <a href="createlist.cfm?type=create">#words[1313]#</a>||
    <a href="listpos.cfm">#words[1314]#</a>||
    <a href="SetupFtp.cfm">#words[1315]#</a>
</h4>
<cfform action="createprocess.cfm" method="post" name="createpos" id="createpos">
    <input type="hidden" name="posrowid" id="posrowid" value="#posrowid#">
    <table align="center">
        <tr>
            <th>#words[1317]#</th>
            <td><cfinput type="text" maxlength="30" name="posid" id="posid" required="yes" message="POS channel id is required" size="50" value="#posid#"/></td>
        </tr>
        <tr>
            <th>#words[1318]#</th>
            <td><cfinput type="text" maxlength="30" name="posfolder" id="posfolder" required="yes" message="POS folder is required" size="50" value="#posfolder#" /></td>
        </tr>
        <tr>
            <th>#words[1321]#</th>
            <td><cfinput type="text" maxlength="5" name="posbill" id="posbill" required="yes" message="Bill initial is required" size="50" value="#posbill#" /></td>
        </tr>
        <tr>
            <th>#words[1322]#</th>
            <td>
            <cfquery name="getcustdetail" datasource="#dts#">
                SELECT "" AS custno, "#words[681]#" AS name 
                UNION ALL
                SELECT custno, concat(custno,' - ',name) AS name 
                FROM #target_arcust# 
                ORDER BY custno
            </cfquery>
            <cfselect name="custno" id="custno" query="getcustdetail" value="custno" display="name" required="yes" message="Cash Sales Customer is Required" selected="#custno#" ></cfselect>
            </td>
        </tr>
    <tr><td colspan="2" align="center"><cfinput type="submit" name="sub_btn" id="sub_btn" value="#UCASE(url.type)#" /></td></tr>
    </table>
</cfform>
</cfoutput>
</body>
</html>