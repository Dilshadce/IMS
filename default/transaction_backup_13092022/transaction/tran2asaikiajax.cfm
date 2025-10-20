<cfsetting showdebugoutput="no">

<cfquery name="getshipvia" datasource="#dts#">
select arrem3 from #target_arcust# where custno='#url.custno#'
union all
select arrem3 from #target_apvend# where custno='#url.custno#'
</cfquery>

<cfoutput>
<input type="hidden" name="hidshipvia" id="hidshipvia" value="#getshipvia.arrem3#" />
</cfoutput>

