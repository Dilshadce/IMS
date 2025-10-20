<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function getlogid(logid)
{
document.getElementById('einvoiceid').value = logid;
ColdFusion.Window.show('viewattachfile');
}
</script>
<title>Einvoice Log</title>
</head>
<body>
<cfquery name="getRecord" datasource="#dts#">
SELECT * from einvoiceLog ORDER by Logdatetime DESC
</cfquery>
<h1 align="center">eInvoice Log</h1>
<cfoutput>
<table width="70%" border="0" class="data" align="center">
<tr>
<th>eInvoice Id</th>
<th>Submission Date</th>
<th>Status</th>
<th>Submited By</th>
<th>Download EInvoice File</th>
<th>View Attached Bill</th>
</tr>
<cfloop query="getRecord">
<tr>
<td>#getRecord.LogId#</td>
<td>#dateformat(getRecord.logDateTime,'yyyy-mm-dd')# #timeformat(getRecord.logDateTime,'HH:MM:SS')#</td>
<td>#getRecord.status#</td>
<td>#getRecord.submitedby#</td>
<td><cfif getRecord.status eq "Success"><a href="/default/eInvoicing/eInvoiceFileDownload.cfm?file=#getRecord.historylogname#" >Download</a></cfif></td>
<td>
<cfif getRecord.status eq "Success" and getRecord.invoicelist neq ""><a href="##" onclick="getlogid('#getRecord.LogId#')">View</a></cfif>
</td>
</tr>
</cfloop>
</table>
</cfoutput>
<form name="einvoiceform" id="einvoiceform" method="post">
<input type="hidden" name="einvoiceid" id="einvoiceid" value="" />
</form>
<cfwindow name="viewattachfile" source="eInvoiceBillFile.cfm?einvoiceid={einvoiceform:einvoiceid}" title="View Attached Bill" width="500" height="500" initshow="false" modal="true" closable="true" center="true" refreshonshow="true">
</cfwindow>
</body>
</html>
