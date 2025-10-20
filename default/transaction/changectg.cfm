<cfsetting showdebugoutput="no">
<cfoutput>
	<cfset itemno = URLDecode(url.itemno)>
    <cfset refno = URLDecode(url.refno)>
    <cfset type = URLDecode(url.type)>
    <cfset trancode = URLDecode(url.trancode)>
    <cfset custno = URLDecode(url.custno)>
    <cfset period = URLDecode(url.period)>
    <cfset qty = URLDecode(url.qty)>
    <cfset agenno = URLDecode(url.agenno)>
    <cfset location = URLDecode(url.location)>
    <cfset currrate = URLDecode(url.currrate)>
    <cfset sign = URLDecode(url.sign)>
    <cfset price = URLDecode(url.price)>
    <cfset serialno = URLDecode(url.serialno)>
	<cfset date = URLDecode(url.date)>
    <cfset ctgno = URLDecode(url.ctgno)>
    
    <cftry>
			<cfquery name="checkExist" datasource="#dts#">
				select ctgno from iserial where type='#type#' and refno='#refno#' and ctgno='#ctgno#'
			</cfquery>

		<cfif checkExist.recordcount eq 0>
			<cfquery name="deleteserial" datasource="#dts#">
				update iserial set ctgno='#ctgno#' where type='#type#' and itemno='#itemno#'
				and serialno='#serialno#' and refno='#refno#' and trancode='#trancode#'
			</cfquery>
		</cfif>
        
		<cfcatch type="database">
        <h3>Serial No Update Fail</h3>
		</cfcatch>
	</cftry>

    
</cfoutput>