<cfquery name="checkused" datasource="#dts#">
SELECT used FROM voucher where voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernumvoid#">
</cfquery>

<cfquery name="updatevoucher" datasource="#dts#">
UPDATE voucher SET
used = <cfif checkused.used eq "Y">"N"<cfelse>"Y"</cfif>
WHERE voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernumvoid#">
</cfquery>
<cfoutput>
<script type="text/javascript">
alert('voucher #form.vouchernumvoid# has been set to <cfif checkused.used eq "Y">Unused<cfelse>Used</cfif>!');
window.location.href="vouchermaintenance.cfm";
</script>
</cfoutput>