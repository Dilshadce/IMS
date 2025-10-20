<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1229,1224,1225,1226,1227,1228,1229,1230,1260,1257,1258,352">
<cfinclude template="/latest/words.cfm">
<html>
<head>
<title><cfoutput>#words[1229]#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<script src="/SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
</head>

<body>
<cfoutput>
<cfquery name="getgroup" datasource="#dts#">
    SELECT packid 
    FROM packlist
</cfquery>

<cfquery name="getdriver" datasource="#dts#">
    SELECT driverno,name 
    FROM driver 
    ORDER BY driverno
</cfquery>
<h1 align="center">#words[1229]#</h1>
<h4>
	<a href="/default/transaction/packinglist/packinglistmain.cfm">#words[1224]#</a> || 
	<a href="/default/transaction/packinglist/listpackingmain.cfm">#words[1225]#</a> || 
	<a href="/default/transaction/packinglist/assigndrivermain.cfm">#words[1226]#</a>||
    <a href="/default/transaction/packinglist/deliveryrecord/checkdelivered.cfm">#words[1227]#</a>||
    <a href="/default/transaction/packinglist/standardreport.cfm">#words[1228]#</a>||
    <a href="/default/transaction/packinglist/packinglistreportmenu.cfm">#words[1229]#</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">#words[1230]#</a>
</h4>
<cfform action="packingreportbydriver2.cfm" name="form" method="post" target="_blank">
    <table border="0" align="center" width="90%" class="data">
        <tr> 
        <th width="20%">Driver No.</th>
        <td colspan="6"><select name="groupfrom2">
                <option value="">#words[1260]#</option>
                <cfloop query="getdriver">
                    <option value="#Driverno#">#driverno# - #name# </option>
                </cfloop>
        </select>
        </td>
        </tr>
    <tr> 
        <th>#words[1257]#</th>
        <td colspan= "3">
        <input type="text" name="datefrom" id="datefrom" value="#dateformat(now(),"dd/mm/yyyy")#" validate="eurodate" size="10" maxlength="10">
        <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">
        (DD/MM/YYYY)
        </td>
    </tr>
    <tr> 
        <th>#words[1258]#</th>
        <td colspan= "3">
        <input type="text" name="dateto" id="dateto" value="#dateformat(DATEADD("m",1,Now()),"dd/mm/yyyy")#" validate="eurodate" size="10" maxlength="10">
        <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">
        (DD/MM/YYYY)
        </td>
    </tr>
    <tr> 
        <td colspan="8">&nbsp;</td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td width="5%">
        <div align="right">
        <input type="Submit" name="Submit" value="#words[352]#">
        </div>
        </td>
    </tr>
    </table>
</cfform>
</cfoutput>
</body>
</html>
