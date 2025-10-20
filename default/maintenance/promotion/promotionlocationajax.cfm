<cfsetting showdebugoutput="no">
<cfset promoid = URLDecode(url.promoid)>
<cfset location = URLDecode(url.location)>

<cfif url.proces eq 'add'>

<cfif location neq ''>
<cfquery name="checklocation" datasource="#dts#">
        select * from promotion where promoid='#promoid#'
</cfquery>

<cfif listfindnocase(checklocation.location,location) eq 0>

<cfif checklocation.location eq ''>
<cfset newlocation=location>
<cfelse>
<cfset newlocation=checklocation.location&','&location>
</cfif>

<cfquery name="updatelocation" datasource="#dts#">
      update promotion set location='#newlocation#' where promoid='#promoid#'
</cfquery>
</cfif>

</cfif>

<cfelseif url.proces eq 'Delete'>


<cfquery name="checklocation" datasource="#dts#">
        select * from promotion where promoid='#promoid#'
</cfquery>

<cfif listfindnocase(checklocation.location,location) neq 0>

<cfset newlocation=listdeleteat(checklocation.location,ListFind(checklocation.location,location,","),",")>

<cfquery name="updatelocation" datasource="#dts#">
      update promotion set location='#newlocation#' where promoid='#promoid#'
</cfquery>

</cfif>

</cfif>

		<cfquery name="getgsetup" datasource="#dts#">
        select * from gsetup
        </cfquery>
        
        <cfquery name="getpromotionlocation" datasource="#dts#">
        select * from promotion where promoid='#promoid#'
        </cfquery>
        
        <cfquery name="getlocation" datasource="#dts#">
        select * from iclocation where location not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#getpromotionlocation.location#">) order by location
        </cfquery>
        
		<cfoutput>
        
        <cfset z=1>
        <table class="data">
        <tr><th>Promotion ID</th><td>#promoid#</td></tr>
        <tr><th nowrap="nowrap">Promotion Description</th><td>#getpromotionlocation.description#</td></tr>
		<tr>
			<th width="50">No</th>
			<th><cfoutput>Location</cfoutput></th>
			<th width="70">Action</th>
		</tr>
        <cfif getpromotionlocation.location neq ''>
        <cfloop list="#getpromotionlocation.location#" index="i">
        <tr>
        <td>#z#</td>
        <td>#i#</td>
        <td><input type="button" name="delete" value="delete" onClick="deletepromotionlocation('#promoid#','#i#')"></td>
        </tr>
        <cfset z=z+1>
        </cfloop>
        </cfif>

		<tr>
			<td>New</td>
			<td align="right">
            <select name="promotionlocation" id="promotionlocation">
            <option value="">Choose a Location</option>
            <cfloop query="getlocation">
            <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
            </cfloop>
            </select>
            </td>
			<td><input type="button" name="add_text" value="Add" onClick="addpromotionlocation('#promoid#')"></td>
		</tr>

		</table>
        </cfoutput>