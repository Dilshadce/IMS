<cfsetting showdebugoutput="no">
<cfif url.reftype eq "PACK">
<cfquery name="getrefno" datasource="#dts#">
SELECT packid as refno FROM packlist order by packid
</cfquery>
<cfelse>
<cfquery name="getrefno" datasource="#dts#">
	select refno from artran
	where type ='#url.reftype#'
	and fperiod <> '99'
	and (posted is null or posted ='')
	order by refno
</cfquery>
</cfif>
<cfoutput>
	<select id="rcno" name="rcno">
		<option value="">Choose a Reference No</option>
		<cfloop query="getrefno">
			<option value="#refno#">#refno#</option>
		</cfloop>
	</select>
</cfoutput>
