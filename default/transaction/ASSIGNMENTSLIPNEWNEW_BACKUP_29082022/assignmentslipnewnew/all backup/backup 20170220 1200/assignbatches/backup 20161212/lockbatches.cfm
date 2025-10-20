<cfif isdefined('form.hidbatch')>
<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignmentslip SET 
locked = "Y"
,girono = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.girorefno#"> 
,locked_on = now()
WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidbatch#">
</cfquery>

<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignbatches SET locked = "Y" WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidbatch#">
</cfquery>

<cfquery name="getemployee" datasource="#dts#">
SELECT empno,paydate FROM assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidbatch#">
</cfquery>

<cfset dts2 = replace(dts,'_i','_p')>

<cfloop query="getemployee">
<cfquery name="updatecheqno" datasource="#dts2#">
UPDATE #getemployee.paydate# SET cheque_no = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.girorefno#"> WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getemployee.empno#">
</cfquery>
</cfloop>

<cfoutput>
<script type="text/javascript">
alert('Batch #form.hidbatch# Has Been Locked!');
ColdFusion.Window.hide('viewbatch');
location.reload(true);
</script>
</cfoutput>
</cfif>