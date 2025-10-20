	<cfset newBrandno = "#form.Brandno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from brand where brand = '#form.Brandno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0  and trim(form.Brandno) neq ''>
    <cfquery name="insertBrand" datasource="#dts#">
		insert into brand
		(
        brand,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Brandno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Brand Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateBrand('#form.Brandno#');ColdFusion.Window.hide('createBrandAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfif trim(form.Brandno) eq ''>
    <cfset msg="Brand No Cannot Be Empty!">
    <cfelse>
	<cfset msg="Duplicate Brand No. Please Use Another Brand No.">
    </cfif>
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createBrandAjax');" value="Close" >
 </cfoutput>
</cfif>