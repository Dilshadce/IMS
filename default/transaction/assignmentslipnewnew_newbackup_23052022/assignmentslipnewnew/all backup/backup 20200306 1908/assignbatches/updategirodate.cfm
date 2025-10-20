<cfif isdefined('form.girobatch')>
<cfinclude template="/object/dateobject.cfm">
<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignmentslip SET 
giropaydate = "#dateformatnew(form.giropaydate,'yyyy-mm-dd')#"
WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.girobatch#">
</cfquery>
    
<cfquery name="lockbatch" datasource="#dts#">
UPDATE icgiro SET 
giropaydate = "#dateformatnew(form.giropaydate,'yyyy-mm-dd')#"
WHERE batchno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.girobatch#">
</cfquery>

<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignbatches SET paydate = "#dateformatnew(form.giropaydate,'yyyy-mm-dd')#" WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.girobatch#">
</cfquery>

<cfoutput>
<script type="text/javascript">
alert('Giro Pay Date of Batch #form.girobatch# Has Been Updated!');
ColdFusion.Window.hide('viewbatch');
location.reload(true);
</script>
</cfoutput>
</cfif>