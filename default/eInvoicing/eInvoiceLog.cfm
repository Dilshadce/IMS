<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1215,1216,1217,706,1218,1219,1220">
<cfinclude template="/latest/words.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function getlogid(logid) {
		document.getElementById('einvoiceid').value = logid;
		ColdFusion.Window.show('viewattachfile');
	}
</script>
<title><cfoutput>#words[1215]#</cfoutput></title>
</head>
<body>
<cfoutput>
<cfquery name="getRecord" datasource="#dts#">
    SELECT * 
    FROM einvoiceLog 
    ORDER BY Logdatetime DESC
</cfquery>
<h1 align="center">#words[1215]#</h1>
<table width="70%" border="0" class="data" align="center">
    <tr>
        <th>#words[1216]#</th>
        <th>#words[1217]#</th>
        <th>#words[706]#</th>
        <th>#words[1218]#</th>
        <th>#words[1219]#</th>
        <th>#words[1220]#</th>
    </tr>
    <cfloop query="getRecord">
        <tr>
            <td>#getRecord.LogId#</td>
            <td>#dateformat(getRecord.logDateTime,'yyyy-mm-dd')# #timeformat(getRecord.logDateTime,'HH:MM:SS')#</td>
            <td>#getRecord.status#</td>
            <td>#getRecord.submitedby#</td>
            <td>
            <cfif getRecord.status eq "Success">
                <a href="/default/eInvoicing/eInvoiceFileDownload.cfm?file=#getRecord.historylogname#" >#words[1221]#</a>
            </cfif>
            </td>
            <td>
            <cfif getRecord.status eq "Success" and getRecord.invoicelist neq "">
                <a href="##" onclick="getlogid('#getRecord.LogId#')">#words[1222]#</a>
            </cfif>
            </td>
        </tr>
    </cfloop>
</table>
<form name="einvoiceform" id="einvoiceform" method="post">
    <input type="hidden" name="einvoiceid" id="einvoiceid" value="" />
</form>
<cfwindow name="viewattachfile" width="500" height="500" modal="true" closable="true" center="true" refreshonshow="true"
	title="View Attached Bill" initshow="false" 
    source="eInvoiceBillFile.cfm?einvoiceid={einvoiceform:einvoiceid}">
</cfwindow>
</cfoutput>
</body>
</html>
