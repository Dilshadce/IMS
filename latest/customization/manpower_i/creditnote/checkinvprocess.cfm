<cfif isdefined('url.invoiceno')>
<cfoutput>
<cfquery name="getinvoiceno" datasource="#dts#">
SELECT refno,refno2,grand FROM artran WHERE trim(refno2) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(URLDECODE(url.invoiceno))#"> AND type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.type)#">
AND trim(refno2) != ''
AND (void is null or void='')
</cfquery>

<cfif getinvoiceno.recordcount neq 0>
<input type="hidden" name="invoiceexist" id="invoiceexist" value="#getinvoiceno.refno# - #getinvoiceno.refno2# - Total: #getinvoiceno.grand#">
<cfelse>
<input type="hidden" name="invoiceexist" id="invoiceexist" value="">
</cfif>
</cfoutput>
</cfif>