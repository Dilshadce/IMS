<cfsetting showdebugoutput="no">
<cfif url.tran eq "rc" or url.tran eq "pr" or url.tran eq "po">
      		<cfquery name="getcuststatus" datasource="#dts#">
        		Select status from #target_apvend# where custno = "#url.custno#"
      		</cfquery>
    	<cfelse>
      		<cfquery name="getcuststatus" datasource="#dts#">
        		Select status from #target_arcust# where custno = "#url.custno#"
      		</cfquery>
    	</cfif>

<cfif getcuststatus.status eq 'B'>

<font size="+1" color="#FF0000"><strong><cfoutput>This Customer/Supplier is Bad Status</cfoutput></strong></font>

</cfif>