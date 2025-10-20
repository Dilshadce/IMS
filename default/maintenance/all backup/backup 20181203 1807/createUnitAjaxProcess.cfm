	<cfset newUnitno = "#form.Unitno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from Unit where Unit = '#form.Unitno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0 and trim(form.Unitno) neq ''>
    <cfquery name="insertUnit" datasource="#dts#">
		insert into Unit
		(
        Unit,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Unitno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Unit Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateUnit('#form.Unitno#');ColdFusion.Window.hide('createUnitAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfset msg="Duplicate Unit No. Please Use Another Unit No.">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createUnitidAjax');" value="Close" >
 </cfoutput>
</cfif>