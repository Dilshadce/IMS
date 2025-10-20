   
    <cfquery name="updatebom" datasource="#dts#">
		UPDATE billmat 
        SET BmQty = '#url.qty#', BmLocation = '#url.locat#'
        WHERE itemno = '#url.sitemno#' 
        AND bomno = '#url.bomno#'
        AND bmitemno = '#url.sitem#'
	</cfquery>
