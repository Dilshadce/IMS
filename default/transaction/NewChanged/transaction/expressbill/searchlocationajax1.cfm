<cfsetting showdebugoutput="no">
  <cfquery name="getlocation2" datasource="#dts#">
  select location,desp from iclocation where location like '%#url.location#%' or desp like '%#url.location#%'
	order by location
  </cfquery>
<cfoutput>
<select name="locationfr" id="locationfr">
<cfloop query="getlocation2">
<option value="#getlocation2.location#">#getlocation2.location# - #getlocation2.desp#</option>
</cfloop>
</select>
</cfoutput>