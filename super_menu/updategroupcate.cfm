<cfquery name="getallitem" datasource="#dts#">
select * from icitem
</cfquery>

<cfloop query="getallitem">

<cfquery name="updategroupcate" datasource="#dts#">
update ictran set wos_group='#getallitem.wos_group#',category='#getallitem.category#' where itemno='#getallitem.itemno#'
</cfquery>

</cfloop>
<cfoutput>
<h1>Category and group update has been done</h1>
</cfoutput>