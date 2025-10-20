<cfsetting showdebugoutput="no">
<cfset promoid = URLDecode(url.promoid)>

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
        
        <div id="promolocajaxFieldPro">
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
        </div>
        </cfoutput>