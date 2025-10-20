<cfif isdefined('form.refnolist')>
<cfloop list="#form.refnolist#" index="i">
<cfset getcheqno = evaluate('form.chequeno#i#')>
<cfif getcheqno neq "">
<cfquery name="updatechequeno" datasource="#dts#">
UPDATE assignmentslip SET
chequeno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cheqprefix##getcheqno#">
WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
</cfquery>
</cfif>
</cfloop>

<cfoutput>
<script type="text/javascript">
alert('Cheque No Assign Success!')
window.location.href='generatecheqno.cfm';
</script>
</cfoutput>
</cfif>