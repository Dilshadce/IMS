<cfsetting showdebugoutput="yes">
<cfquery name="updateonhold" datasource="#dts#">
	update ictrantemp set onhold='' where uuid='#url.uuid#'
</cfquery>
