   
    <cfquery name="updatebom" datasource="#dts#">
		DELETE FROM billmat 
        WHERE itemno = '#url.sitemno#' 
        AND bomno = '#url.bomno#'
        AND bmitemno = '#url.sitem#'
	</cfquery>
