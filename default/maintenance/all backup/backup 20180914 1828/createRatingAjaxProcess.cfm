	<cfset newratingno = "#form.ratingno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from iccostcode where costcode = '#form.ratingno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0 and trim(form.ratingno) neq ''>
    <cfquery name="insertrating" datasource="#dts#">
		insert into iccostcode
		(
        costcode,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratingno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Rating Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateCostcode('#form.ratingno#');ColdFusion.Window.hide('createRatingAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfif trim(form.ratingno) eq ''>
    <cfset msg="Rating No Cannot Be Empty!">
    <cfelse>
	<cfset msg="Duplicate Rating No. Please Use Another Rating No.">
    </cfif>
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createRatingAjax');" value="Close" >
 </cfoutput>
</cfif>