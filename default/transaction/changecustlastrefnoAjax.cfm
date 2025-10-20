<cfsetting showdebugoutput="no">
<cfif url.tran eq "RC">
<cfquery name="getcustlastrefno" datasource="#dts#">
select * from #target_apvend# where custno='#url.custno#'
</cfquery>
<cfelse>
<cfquery name="getcustlastrefno" datasource="#dts#">
select * from #target_arcust# where custno='#url.custno#'
</cfquery>
</cfif>
<cfoutput>
<cfif url.tran eq 'QUO' or url.tran eq 'RC'> 
<h3>#getcustlastrefno.arrem2#</h3>
<cfelseif url.tran eq 'SO'>
<h3>#getcustlastrefno.arrem3#</h3>
<cfelseif url.tran eq 'INV'>
<h3>#getcustlastrefno.arrem4#</h3>
</cfif>
</cfoutput>

	