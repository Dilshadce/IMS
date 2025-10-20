<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1119">
<cfinclude template="/latest/words.cfm">
<cfsetting showdebugoutput="no">
<cfset url.itemno = URLDECODE(URLDECODE(url.itemno))>

<cfquery name="getbomno" datasource="#dts#">
    SELECT bomno 
    FROM billmat 
    WHERE itemno='#url.itemno#' 
    GROUP BY bomno
</cfquery>

<cfoutput>  
<select name="bomno" id="bomno">
    <option value="">#words[1119]#</option>
    <cfloop query="getbomno">
    	<option value="#getbomno.bomno#">#getbomno.bomno#</option>
    </cfloop>
</select>
</cfoutput>
