<cfsetting showdebugoutput="no">

<cfoutput>
<cfif url.type eq 'RC' or url.type eq 'PO' or url.type eq 'PR'>
<input type="text" name="searchsuppfr" onKeyUp="getSupp('cust','Supplier');">
<cfelse>
<input type="text" name="searchsuppfr" onKeyUp="getSupp('cust','Customer');">
</cfif>
</cfoutput>