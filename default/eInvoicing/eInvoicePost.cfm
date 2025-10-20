
<html>



<head>
<title>E-Invoicing Submission </title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfif form.errorvalid neq 1>
<cfoutput>
<h2 align="center">The eInvoice file has been generated</h2>
<p align="center" style="font-size:16px">Click <a href="/default/eInvoicing/eInvoiceFileDownload.cfm">here</a> to download the generated file</p>
<p align="center" style="font-size:16px">Click <u><a onMouseOver="JavaScript:this.style.cursor='hand'" onClick="javascript:ColdFusion.Window.show('previewfile');">here</a></u> to preview the generated file</p>
</cfoutput>
<cfoutput>
<form action="/default/einvoicing/eInvoicePostProcess.cfm" method="post">
<table width="75%" border="0" class="data" align="center">
<tr>
<th>Invoice Number</th>
<th>From PO</th>
<th>Customer Name</th>
<th>Freight Total</th>
<th>Bill Total</th>
<th>Attach Bill</th>
</tr>

<cfset alltotal = 0>
<cfloop list="#form.msg1#" index="i">
<cfquery name="getheader" datasource="#dts#">
SELECT * FROM artran as a left join #target_arcust# as ar on a.custno = ar.custno where a.refno = "#i#" 
</cfquery>
<tr>
<td>#i#</td>
<td>#getheader.PONO#</td>
<td>#getheader.name#</td>
<td>#numberformat(getheader.MC1_BIL,'.__')#</td>
<td>#numberformat(getheader.MC1_BIL +getheader.grand ,'.__')#</td>
<cfset alltotal = alltotal + getheader.MC1_BIL + getheader.grand >
<td><input type="checkbox" name="attachbill" value="#i#"></td>

</tr>
</cfloop>
<tr>
<td colspan="3"></td>
<th>Total of All Bill</th>
<td>#numberformat(alltotal,'.__')#</td>
</tr>
<tr>
<td colspan="6">&nbsp;

</td>
</tr>
<tr>
<td align="center" colspan="6">
<input type="submit" value="Send eInvoice" name="submitinvoice">
</td>
</tr>
</table>
<input type="hidden" name="invoicelist" value="#form.msg1#">
</form>
</cfoutput>
<cfelse>
<cfoutput>
<h3>Error has occur in file generation!</h3>
<h4>Error: #form.msg1#</h4>
</cfoutput>
</cfif>
<cfwindow name="previewfile" source="eInvoiceFilePreview.cfm" width="650" height="400" initshow="false" modal="true" closable="true" center="true" refreshonshow="true">
</cfwindow>
</body>
</html>