<cfsetting showdebugoutput="no">
<cfquery name="getvehidetail" datasource="#dts#">
select * from vehicles where entryno='#url.vehicle#'
</cfquery>

<cfquery name="getcustname" datasource="#dts#">
select name from #target_arcust# where custno='#getvehidetail.custcode#'
</cfquery>

<cfoutput>
<input type="hidden" name="hidcustno" id="hidcustno" value="#getvehidetail.custcode#" maxlength="35" size="40"/>
<input type="hidden" name="hidowner" id="hidowner" value="#getvehidetail.owner#" maxlength="35" size="40"/>
<input type="hidden" name="hidcustname" id="hidcustname" value="#getcustname.name#" maxlength="35" size="40"/>
</cfoutput>
