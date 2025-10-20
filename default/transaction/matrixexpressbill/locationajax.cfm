<cfsetting showdebugoutput="no">
<cfquery name="getlocation" datasource="#dts#">
  select location,desp 
  from iclocation
</cfquery>
<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfset xrem1="">
<cfset xrem2="">

<cfif isdefined('url.refno') and url.type EQ 'TR'>
<cfquery name="getbilllocation" datasource="#dts#">
	select rem1,rem2 from artran where type="#url.type#" and refno="#url.refno#"
</cfquery>
<cfset xrem1=getbilllocation.rem1>
<cfset xrem2=getbilllocation.rem2>

</cfif>


<cfif url.type eq "TR">
	<cfoutput>
        Location From &nbsp;&nbsp;&nbsp;&nbsp;
        <select name="locationfr" id="locationfr">
            <cfloop query="getlocation">
                <option value="#location#" <cfif xrem1 eq getlocation.location>selected</cfif>>#location# - #desp#</option>
            </cfloop>
        </select>
        <br />
        Location To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <select name="locationto" id="locationto">
            <cfloop query="getlocation">
                <option value="#location#" <cfif xrem2 eq getlocation.location>selected</cfif>>#location# - #desp#</option>
            </cfloop>
        </select>
    </cfoutput>
<cfelse>
    <cfoutput>
        Location &nbsp;&nbsp;&nbsp;&nbsp;
        <select name="locationfr" id="locationfr">
            <cfif LCASE(hcomid) EQ 'aipl_i' and url.type EQ 'SO'>
                <option value="">Select a location</option>
                <cfloop query="getlocation">
                    <option value="#location#" <cfif getlocation.location eq 'HQ'>selected</cfif>>#location# - #desp#</option>
                </cfloop>
            <cfelse> 
                <cfloop query="getlocation">
                    <option value="#location#" <cfif getgsetup.ddllocation eq location>selected</cfif>>#location# - #desp#</option>
                </cfloop>
            </cfif>    
        </select>
        <input type="hidden" id="locationto" name="locationto" value="" />
	</cfoutput>
</cfif>