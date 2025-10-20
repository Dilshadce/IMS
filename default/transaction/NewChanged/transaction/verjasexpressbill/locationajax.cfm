<cfsetting showdebugoutput="no">
  <cfquery name="getlocation" datasource="#dts#">
  select location,desp from iclocation
  </cfquery>
  <cfif url.type eq "TR">
  
<cfoutput>
Location From &nbsp;&nbsp;&nbsp;&nbsp;<select name="locationfr" id="locationfr">
<cfloop query="getlocation">
<option value="#location#">#location# - #desp#</option>
</cfloop>
</select>
<br />
Location To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="locationto" id="locationto">
<cfloop query="getlocation">
<option value="#location#">#location# - #desp#</option>
</cfloop>
</select>
</cfoutput>
<cfelse>
<cfoutput>
Location &nbsp;&nbsp;&nbsp;&nbsp;<select name="locationfr" id="locationfr">
<cfloop query="getlocation">
<option value="#location#">#location# - #desp#</option>
</cfloop>
</select>
<input type="hidden" id="locationto" name="locationto" value="" />
</cfoutput>
</cfif>