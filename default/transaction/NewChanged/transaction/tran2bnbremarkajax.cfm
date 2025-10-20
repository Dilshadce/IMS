<cfsetting showdebugoutput="no">
<cfset remarkfield='lQUO'>
<cfif url.no eq 1>
<cfset remarkfield='lQUO'>
</cfif>
<cfif url.no eq 2>
<cfset remarkfield='lQUO2'>
</cfif>
<cfif url.no eq 3>
<cfset remarkfield='lQUO3'>
</cfif>
<cfif url.no eq 4>
<cfset remarkfield='lQUO4'>
</cfif>
<cfif url.no eq 5>
<cfset remarkfield='lQUO5'>
</cfif>

<cfquery name="gettermandcondition2" datasource="#dts#">
SELECT #remarkfield# as termcondition from ictermandcondition 
</cfquery>

<cfoutput>
<div style="display:none">

<textarea name="hidtermandconditionremarks" id="hidtermandconditionremarks">#gettermandcondition2.termcondition#</textarea>
</div>
</cfoutput>

