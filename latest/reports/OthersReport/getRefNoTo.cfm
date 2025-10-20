<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1376">
<cfinclude template="/latest/words.cfm">

<cfsetting showdebugoutput="no">

<cfquery name="getRefNo" datasource="#dts#">
    SELECT refno from artran
    WHERE type ='#url.billType#'
    AND fperiod <> '99'
    AND (void = '' OR void IS NULL);
</cfquery>

<cfoutput>
	<select id="refNoTo" name="refNoTo" >
		<cfif getRefNo.recordcount eq 0>
            <option value="">#words[1376]#</option>         
        </cfif>
		<cfloop query="getRefNo">
			<option value="#refno#">#refno#</option>
		</cfloop>
	</select>
</cfoutput>
