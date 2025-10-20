	<cfset newCateno = "#form.Cateno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from iccate where Cate = '#form.Cateno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0  and trim(form.Cateno) neq ''>
    <cfquery name="insertCate" datasource="#dts#">
		insert into iccate
		(
        Cate,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Category Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateCate('#form.Cateno#');ColdFusion.Window.hide('createCateAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfif trim(form.Cateno) eq ''>
    <cfset msg="Category No Cannot Be Empty!">
    <cfelse>
	<cfset msg="Duplicate Category No. Please Use Another Category No.">
    </cfif>
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createCateAjax');" value="Close" >
 </cfoutput>
</cfif>