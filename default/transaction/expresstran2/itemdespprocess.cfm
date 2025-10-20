<cfsetting showdebugoutput="no">

<cfset desp=URLDecode(url.itemdesp)>
<cfset despa=URLDecode(url.itemdespa)>
<cfset comment=URLDecode(url.itemcomment)>
<cfoutput>
<cfquery name="updateitemdesp" datasource="#dts#">
update ictrantemp set desp='#desp#',despa='#despa#',comment='#comment#',gltradac='#url.glaccno#' where trancode='#listfirst(url.trancode)#' and uuid='#url.uuid#'
</cfquery>

</cfoutput>