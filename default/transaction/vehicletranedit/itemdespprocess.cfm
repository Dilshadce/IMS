<cfsetting showdebugoutput="no">
<cfoutput>
<cfquery name="updateitemdesp" datasource="#dts#">
update ictran set desp='#url.itemdesp#',despa='#url.itemdespa#',comment='#url.itemcomment#' where trancode='#listfirst(url.trancode)#' and refno='#url.refno#' and type='#url.tran#'
</cfquery>

</cfoutput>