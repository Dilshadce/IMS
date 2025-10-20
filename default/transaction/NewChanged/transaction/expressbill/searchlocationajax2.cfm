<cfsetting showdebugoutput="no">
  <cfquery name="getlocation3" datasource="#dts#">
  select location,desp from iclocation where location like '%#url.location#%' or desp like '%#url.location#%'
	order by location
  </cfquery>
<cfoutput>
<select name="locationto" id="locationto">
<cfloop query="getlocation3">
<option value="#getlocation3.location#">#getlocation3.location# - #getlocation3.desp#</option>
</cfloop>
</select>
</cfoutput>