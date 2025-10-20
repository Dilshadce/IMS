	<cfset newlocationno = "#form.locationno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from iclocation where location = '#form.locationno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0>
    <cfquery name="insertlocation" datasource="#dts#">
		insert into iclocation
		(
        location,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locationno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Location Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updatelocation('#form.locationno#');ColdFusion.Window.hide('createlocationAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfset msg="Duplicate location No. Please Use Another location No.">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createlocationAjax');" value="Close" >
 </cfoutput>
</cfif>