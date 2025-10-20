<cfif form.frmtax neq form.totax>
<cfquery name="updateartran" datasource="#dts#">
Update artran set note = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.totax#"> where note = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.frmtax#">
</cfquery>
<cfquery name="updateictran" datasource="#dts#">
Update ictran set note_a = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.totax#"> where note_a = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.frmtax#">
</cfquery>
<cfelse>
No Changes
</cfif>
Done