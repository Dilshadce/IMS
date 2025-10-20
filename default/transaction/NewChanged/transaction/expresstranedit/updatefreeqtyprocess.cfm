
<cfif val(form.freeqty1) neq 0>
<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictran SET 
rem11 = "#val(form.freeqty1)#",
promotion = ""
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>   
</cfif>

<script type="text/javascript">
refreshlist();
ColdFusion.Window.hide('updatefreeqty');
</script>
