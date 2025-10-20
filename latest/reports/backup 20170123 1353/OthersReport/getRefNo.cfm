<cfsetting showdebugoutput="no">

<cfquery name="getRefNo" datasource="#dts#">
    SELECT refno from artran
    WHERE type ='#url.billType#'
    AND fperiod <> '99'
    AND (void = '' OR void IS NULL);
</cfquery>

<cfoutput>
	<select id="getrefNo" name="getrefNo" >
		<cfif getRefNo.recordcount eq 0>
            <option value="">None Available</option>         
        </cfif>
		<cfloop query="getRefNo">
			<option value="#refno#">#refno#</option>
		</cfloop>
	</select>
</cfoutput>
