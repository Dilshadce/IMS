<cfsetting showdebugoutput="no">
<cfset tooltip_ID = trim(form.tool)>  <!--- Take value from tooltip.js --->

<cfquery name="getLanguage" datasource="#dts#">
	SELECT dflanguage 
    FROM gsetup
</cfquery>
<cfset language = getLanguage.dflanguage> 

<cfquery name="getTooltips" datasource="main">
    SELECT #getLanguage.dflanguage# AS language FROM tooltip_desp
    WHERE tooltip_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tooltip_ID#" />
</cfquery>
<cfif getTooltips.language NEQ ''>
	<cfset DESP = getTooltips.language>
<cfelse>
	<cfset DESP = "Hmm..What's this?">
</cfif>

<cfoutput>#DESP#</cfoutput> 