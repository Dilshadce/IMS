
    <cfquery name="updatecost" datasource="#dts#">
     UPDATE icitem SET bom_cost = '#url.mcost#' where itemno = '#url.sitemno#'
    </cfquery>
