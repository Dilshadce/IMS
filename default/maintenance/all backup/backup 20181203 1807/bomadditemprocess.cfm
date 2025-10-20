
	<cfquery name="checkexist" datasource="#dts#">
		select * from billmat where itemno = '#url.sitemno#' and bomno = '#url.bomno#' and bmitemno = '#url.sitem#'
	</cfquery>
	<cfif checkexist.recordcount gt 0>
		<script>
			alert("Duplicate item! Please re-check");
		</script>
	</cfif>
	
	<cfquery name="insertbom" datasource="#dts#">
		INSERT INTO billmat VALUES('#url.sitemno#','#url.bomno#','#url.sitem#','#url.qty#','#url.locat#','#url.sgroup#')
	</cfquery>

