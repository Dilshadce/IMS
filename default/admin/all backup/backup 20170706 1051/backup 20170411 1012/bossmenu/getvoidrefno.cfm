<cfsetting showdebugoutput="no">
<cfquery name="getrefno" datasource="#dts#">
	select refno from artran
	where type ='#url.reftype#' and void='Y'
    group by refno
	order by refno
</cfquery>
<cfoutput>
	<select id="oldrefno" name="oldrefno">
		<option value="">Choose a Reference No</option>
		<cfloop query="getrefno">
			<option value="#refno#">#refno#</option>
		</cfloop>
	</select>
</cfoutput>