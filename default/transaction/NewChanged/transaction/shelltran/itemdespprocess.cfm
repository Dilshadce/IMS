<cfsetting showdebugoutput="no">
<cfoutput>
<cfquery name="updateitemdesp" datasource="#dts#">
update ictrantemp set desp='#url.itemdesp#',despa='#url.itemdespa#',comment='#url.itemcomment#' where trancode='#listfirst(url.trancode)#' and uuid='#url.uuid#'
</cfquery>

</cfoutput>