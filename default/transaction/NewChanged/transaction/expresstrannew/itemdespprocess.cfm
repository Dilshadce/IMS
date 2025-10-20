<cfsetting showdebugoutput="no">


<cfoutput>
<cfquery name="updateitemdesp" datasource="#dts#">
update ictrantemp set 
<cfif isdefined('form.itemdetailitemno')>
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdetailitemno#">,
</cfif>
desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdesp#">,
despa=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdesp2#">,
comment=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemcomment#">,
gltradac=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.glt6#"> where trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdesptrancode#">  and uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdespuuid#"> 
</cfquery>

<script type="text/javascript">
ColdFusion.Window.hide('itemdesp');
setTimeout('refreshlist();',750);
</script>

</cfoutput>