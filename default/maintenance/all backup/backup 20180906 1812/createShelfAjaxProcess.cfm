	<cfset newShelfno = "#form.Shelfno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from icShelf where Shelf = '#form.Shelfno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0 and trim(form.Shelfno) neq ''>
    <cfquery name="insertShelf" datasource="#dts#">
		insert into icShelf
		(
        Shelf,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Shelfno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Shelf Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateShelf('#form.Shelfno#');ColdFusion.Window.hide('createShelfAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfif trim(form.Shelfno) eq ''>
    <cfset msg="Shelf No Cannot Be Empty!">
    <cfelse>
	<cfset msg="Duplicate Shelf No. Please Use Another Shelf No.">
    </cfif>
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createShelfidAjax');" value="Close" >
 </cfoutput>
</cfif>