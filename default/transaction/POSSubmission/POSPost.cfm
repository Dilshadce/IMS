
<html>
<head>
<title>Daily Sales Submission </title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<h2 align="center">The Daily Sales file has been generated</h2>
<p align="center">Click <a href="/default/eInvoicing/eInvoiceFileDownload.cfm">here</a> to download the generated file</p>
<p align="center">Click <u><a onMouseOver="JavaScript:this.style.cursor='hand'" onClick="javascript:ColdFusion.Window.show('previewfile');">here</a></u> to preview the generated file</p>
</cfoutput>
<cfoutput>
<form action="/default/transaction/POSSubmission/POSPostProcess.cfm" method="post">
<table width="75%" border="0" class="data" align="center">
<tr>
<td align="center" colspan="6">
<input type="submit" value="Send Daily Sales" name="submit">
</td>
</tr>
</table>
</form>
</cfoutput>
<cfwindow name="previewfile" source="eInvoiceFilePreview.cfm?ndate=#form.billdate#" width="650" height="400" initshow="false" modal="true" closable="true" center="true" refreshonshow="true">
</cfwindow>
</body>
</html>