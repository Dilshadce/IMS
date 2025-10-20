<cfif isdefined('form.oldid')>
<cfinclude template="/object/dateobject.cfm">
<cfquery name="updateleavedate" datasource="#dts#">
UPDATE leavelisttemp SET contractenddate = "#dateformatnew(form.newcontractenddate,'yyyy-mm-dd')#"  WHERE 
uuid = "#url.uuid#" 
and id = "#form.oldid#"
</cfquery>

<script type="text/javascript">
addleave('0','delete');
ColdFusion.Window.hide('editdate');
</script>
</cfif>