<cfquery name="getRecord1" datasource="#dts#">
SELECT invoicelist,logDateTime from einvoiceLog where logid = "#url.einvoiceid#"
</cfquery>
<cfoutput>
<h1 align="center">eInvoice ID : #url.einvoiceid#</h1>
<table width="70%" border="0" class="data" align="center">
<tr>
<th>Invoice Number</th>
<th>Download Bill</th>
</tr>
<cfloop list="#getRecord1.invoicelist#" index="i">
<tr>
<td>11#i#</td>
<td><a href="/default/eInvoicing/eInvoiceFileDownload.cfm?file=#i##dateformat(getRecord1.logDateTime,'yyyymmdd')##timeformat(getRecord1.logDateTime,'HHMMSS')#.pdf">download</a></td>
</tr>
</cfloop>
</table>
</cfoutput>