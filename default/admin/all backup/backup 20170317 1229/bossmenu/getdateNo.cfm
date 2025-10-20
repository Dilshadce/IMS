<cfsetting showdebugoutput="no">

<cfquery name="getrefno" datasource="#dts#">
	select wos_date,refno from artran
	where type ='#url.reftype#'
	and (posted is null or posted ='')
	order by refno
</cfquery>
<cfoutput>
	<select id="oldrefno" name="oldrefno" >
		<option value="">Choose a Reference No</option>
		<cfloop query="getrefno">
			<option value="#refno#">#refno# - #dateformat(wos_date,'DD/MM/YYYY')#</option>
		</cfloop>
	</select>
</cfoutput>