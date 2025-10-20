<cfsetting showdebugoutput="no">
<cfquery name="getlasttran1" datasource="#dts#">
SELECT type,refno FROM artran where type="#url.type#" order by created_on desc limit 1 
</cfquery>
<cfoutput>
#getlasttran1.type#--#getlasttran1.refno#
</cfoutput>