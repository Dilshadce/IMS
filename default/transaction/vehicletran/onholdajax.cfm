<cfsetting showdebugoutput="yes">
<cfquery name="updateonhold" datasource="#dts#">
	update ictrantemp set onhold='Y',rem9='#remark#',rem5='#vehicle#',custno='#custno#',refno2='#refno2#',permitno='#permitno#',agenno='#agenno#',multiagent1='#agenno2#',term='#term#',rem31='#rem31#',rem32='#rem32#',source='#project#',wos_group='#group#',coltype='#coltype#' where uuid='#uuid#'
</cfquery>
