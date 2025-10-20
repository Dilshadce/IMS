<cfquery name="getlocation" datasource="#dts#">
	SELECT location FROM iclocation
</cfquery>

<cfloop query="getlocation">
<cfquery name="getitem" datasource="#dts#">
	SELECT itemno FROM icitem
</cfquery>

<cfloop query="getitem">

<cfquery name="insertlocqdbf" datasource="#dts#">
	INSERT IGNORE INTO locqdbf (itemno,location) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getitem.itemno)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getlocation.location)#">)
</cfquery>


</cfloop>


</cfloop>

<script type="text/javascript">
window.opener.location.href="/latest/maintenance/openingQuantityProfile.cfm";
alert('Completed');
window.close();

</script>