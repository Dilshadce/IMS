<cfsetting showdebugoutput="no">
<cfquery name="getattentionprofile" datasource="#dts#">
            select * from attention where customerno='#url.custno#' or customerno='' or customerno is null
            </cfquery>
<cfoutput>
            <select name="b_attn" id="b_attn">
            <option value="">Please Choose a Attention</option>
            <cfloop query="getattentionprofile">
            <option value="#getattentionprofile.attentionno#">#getattentionprofile.attentionno# - #getattentionprofile.name#</option>
            </cfloop>
            </select>
</cfoutput>