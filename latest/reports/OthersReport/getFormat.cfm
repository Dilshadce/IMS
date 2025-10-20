<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1598">
<cfinclude template="/latest/words.cfm">

<cfsetting showdebugoutput="no">
<cfif url.billType eq "PACK">
    <cfquery name="getrefno" datasource="#dts#">
        SELECT packid as refno 
        FROM packlist 
        ORDER BY packid;
    </cfquery>
<cfelse>
	<cfquery name="getFormat" datasource="#dts#">
        SELECT display_name, file_name 
        FROM customized_format
        WHERE type ='#url.billType#'
        ORDER BY display_name, file_name;
	</cfquery>
</cfif>

<cfoutput>
	<select id="format" name="format" >
		<cfif getFormat.recordcount eq 0>
            <option value="">#words[1598]#</option>         
        </cfif>
		<cfloop query="getFormat">
			<option value="#file_name#">#display_name#</option>
		</cfloop>
	</select>
</cfoutput>
