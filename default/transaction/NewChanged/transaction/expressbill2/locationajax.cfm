<cfsetting showdebugoutput="no">
  <cfquery name="getlocation" datasource="#dts#">
  select location,desp from iclocation
	order by location
  </cfquery>
  <cfif url.type eq "TR">
  
<cfquery name="getddllocation" datasource="#dts#">
SELECT ddllocation FROM gsetup
</cfquery>
Location From &nbsp;&nbsp;&nbsp;&nbsp;
<div id="ajaxlocationsearch1">
<cfoutput>
<select name="locationfr" id="locationfr">
<cfloop query="getlocation">
<option value="#getlocation.location#"<cfif getddllocation.ddllocation eq getlocation.location> Selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
</cfoutput>
</div>
&nbsp;<input type="text" name="findlocationfrom" id="findlocationfrom">&nbsp;<input type="button" name="findlocationfrom2" value="go" onclick="ajaxFunction(document.getElementById('ajaxlocationsearch1'),'/default/transaction/expressbill/searchlocationajax1.cfm?location='+document.getElementById('findlocationfrom').value);"/>
<br />
Location To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div id="ajaxlocationsearch2">
<cfoutput>
<select name="locationto" id="locationto">
<cfloop query="getlocation">
<option value="#location#">#location# - #desp#</option>
</cfloop>
</select>
</cfoutput>
</div>
&nbsp;<input type="text" name="findlocationto" id="findlocationto">&nbsp;<input type="button" name="findlocationto2" value="go" onclick="ajaxFunction(document.getElementById('ajaxlocationsearch2'),'/default/transaction/expressbill2/searchlocationajax2.cfm?location='+document.getElementById('findlocationto').value);" />

<cfelse>
<cfoutput>

</cfoutput>
</cfif>