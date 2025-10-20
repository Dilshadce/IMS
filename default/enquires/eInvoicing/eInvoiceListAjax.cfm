<cfsetting showdebugoutput="no">
<cfset gtSubmitedRecord = 0>
<cfquery name="getInvoice" datasource="#dts#">
SELECT refno,custno,Frem0,wos_date,grand_bil,eInvoice_Submited,SUBMITED_ON FROM ARTRAN 
where type = "INV" 
and fperiod <> 99
and (void = "" or void is null)
<cfif isdefined('url.invfrom')>
and refno >= "#url.invfrom#"
</cfif>
<cfif isdefined('url.invto')>
and refno <= "#url.invto#"
</cfif>
<cfif isdefined('url.comfrom')>
and custno >= "#url.comfrom#"
</cfif>
<cfif isdefined('url.comto')>
and custno <= "#url.comto#"
</cfif>
<cfif isdefined('url.periodfrom')>
and fperiod >= #url.periodfrom#
</cfif>
<cfif isdefined('url.periodto')>
and fperiod <= #url.periodto#
</cfif>
<cfif isdefined('url.datefrom')>
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.datefrom#" returnvariable="nDateCreate"/>
and wos_date >= "#nDateCreate#"
</cfif>
<cfif isdefined('url.dateto')>
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.dateto#" returnvariable="nDateCreate"/>
and wos_date <= "#nDateCreate#"
</cfif>
<cfif isdefined('url.showsubmited') eq false>
and (eInvoice_Submited is null or eInvoice_Submited = "")
</cfif>
</cfquery>
<cfoutput>
<form name="einvoice" action="/default/eInvoicing/eInvoiceProcess.cfm" method="post">
<table width="80%" border="0" class="data" align="center">
<tr>
<th width="100px">Invoice No</th>
<th width="150px">Company Name</th>
<th width="100px">Date</th>
<th width="100px">Amount</th>
<th width="50px">Status</th>
<th width="70px">Select&nbsp;&nbsp;&nbsp;&nbsp;<cfif getInvoice.recordcount neq 0><input type="checkbox" name="checkall" id="checkall" onClick="checkalllist(document.einvoice.einvoicelist)" value="uncheckall" checked ></cfif></th>
</tr>

<cfloop query="getInvoice">

<tr  <cfif getInvoice.eInvoice_Submited eq "Y">style="background-color:##FF0000"</cfif>>
<td>#getInvoice.refno#</td>
<td>#getInvoice.custno#-#getInvoice.Frem0#</td>
<td>#dateformat(getInvoice.wos_date,'YYYY-MM-DD')#</td>
<td align="right">#numberformat(getInvoice.grand_bil,'.__')#</td>
<td>#getInvoice.eInvoice_Submited#</td>
<td align="right"><input type="checkbox" name="einvoicelist" id="einvoicelist" value="#getInvoice.refno#" checked ></td>
</tr>
</cfloop>
<tr>
<td colspan="6" align="center">
<cfif getInvoice.recordcount neq 0>
<input type="submit" value="GENERATE" >
</cfif>
</td>
</tr>
</table>
</form>
</cfoutput>