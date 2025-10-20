<cfsetting showdebugoutput="no">
<cfquery name="getrefno" datasource="#dts#">
	select frrefno from iclink
	where frtype ='#url.reftype#'
    group by frrefno
	order by frrefno
</cfquery>
<cfoutput>
	<select id="oldrefno" name="oldrefno">
		<option value="">Choose a Reference No</option>
		<cfloop query="getrefno">
			<option value="#frrefno#">#frrefno#</option>
		</cfloop>
	</select>
</cfoutput>