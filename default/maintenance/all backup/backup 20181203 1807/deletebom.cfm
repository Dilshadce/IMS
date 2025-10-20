<cfsetting showdebugoutput="no">

<cfset itemno = URLDecode(url.itemno)>
<cfset bomno = URLDecode(url.bomno)>

<cfquery name="deletebom" datasource="#dts#">
delete from billmat where itemno='#itemno#' and bomno='#bomno#'
</cfquery>