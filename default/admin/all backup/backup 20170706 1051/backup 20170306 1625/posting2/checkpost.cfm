<cfquery name="getpostlog" datasource="#dts#">
SELECT actiontype,actiondata FROM postlog where actiondata like "%#url.uuid#"
</cfquery>
<Cfif getpostlog.recordcount neq "0">
<cfset totalrow = getpostlog.actiondata>
<cfset totalpercentage = val(getpostlog.actiontype)/val(totalrow) * 100>
<cfif totalpercentage gt 100>
<cfset totalpercentage = 100>
</cfif>
<cfoutput>
<h1>#numberformat(totalpercentage,'.__')# %</h1>
</cfoutput>
</Cfif>