<cfsetting showdebugoutput="yes">
<cfquery name="updateonhold" datasource="#dts#">
	update locadjtran_temp set onhold='Y' where uuid='#uuid#'
</cfquery>
