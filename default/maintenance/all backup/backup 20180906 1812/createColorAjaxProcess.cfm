	<cfset newColorno = "#form.Colorno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from icColorid where Colorid = '#form.Colorno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0 and trim(form.Colorno) neq ''>
    <cfquery name="insertColor" datasource="#dts#">
		insert into icColorid
		(
        Colorid,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Colorno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Material Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateColorid('#form.Colorno#');ColdFusion.Window.hide('createColorAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfif trim(form.Colorno) eq ''>
    <cfset msg="Material No Cannot Be Empty!">
    <cfelse>
	<cfset msg="Duplicate Material No. Please Use Another Material No.">
    </cfif>
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createColoridAjax');" value="Close" >
 </cfoutput>
</cfif>