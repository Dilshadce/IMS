<cfsetting showdebugoutput="no">
<cfquery name="getsdccurrrate" datasource="#dts#">
SELECT currrate from #target_currency# where currcode="#url.currcode#"
</cfquery>

<cfoutput>
<input type='text' name='crequestdate' id="creq4"  maxlength='40' value='#getsdccurrrate.currrate#' size='20'>
</cfoutput>