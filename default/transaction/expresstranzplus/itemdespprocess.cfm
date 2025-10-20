<cfsetting showdebugoutput="no">

<!---getgrouplocation--->
<cfquery name="getlocationgroup" datasource="#dts#">
	select price_bil,itemno,location,trancode,qty from ictrantemp 
    WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemdesptrancodenew#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemdespuuid#">
</cfquery>
<!--- --->

<cfquery name="getlocationgroupitem" datasource="#dts#">
	select price_bil,itemno,location,trancode,qty from ictrantemp 
    WHERE 
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroup.itemno#">
and price_bil = '#getlocationgroup.price_bil#'
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemdespuuid#">
</cfquery>

<cfoutput>

<cfloop query="getlocationgroupitem">

<cfquery name="updateitemdesp" datasource="#dts#">
update ictrantemp set 
desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdesp#">,
despa=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdesp2#">,
comment=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemcomment#">,
gltradac=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.glt6#"> 
where trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">  and uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemdespuuid#"> 
</cfquery>
</cfloop>
<script type="text/javascript">
ColdFusion.Window.hide('itemdesp');
setTimeout('refreshlist();',750);
</script>

</cfoutput>