<cfsetting showdebugoutput="no">
<cfif url.reftype eq "PACK">
<cfquery name="getrefno" datasource="#dts#">
SELECT packid as refno FROM packlist order by packid
</cfquery>
<cfelse>
<cfquery name="getformat" datasource="#dts#">
	select display_name, file_name from customized_format
	where type ='#url.reftype#'
    order by display_name, file_name
	</cfquery>
</cfif>
<cfoutput>
	<select id="format" name="format">
    <cfif getformat.recordcount eq 0>
		<option value="">Choose a format</option>
    </cfif>
		<cfloop query="getformat">
			<option value="#file_name#">#display_name#</option>
		</cfloop>
	</select>
</cfoutput>
