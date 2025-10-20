	<cfset newSizeno = "#form.Sizeno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from icSizeid where Sizeid = '#form.Sizeno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0 and trim(form.Sizeno) neq ''>
    <cfquery name="insertSize" datasource="#dts#">
		insert into icSizeid
		(
        Sizeid,
        desp<cfif left(dts,4) eq "tcds">,size1</cfif>)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sizeno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
        <cfif left(dts,4) eq "tcds">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.size1#"></cfif>
		)
	</cfquery>
    <cfset msg="New Size Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateSize('#form.Sizeno#');ColdFusion.Window.hide('createSizeAjax');<cfif left(dts,4) eq "tcds">document.getElementById('Remark5').value='#form.size1#';</cfif>" value="Close" >
 </cfoutput>
<cfelse>
	<cfif trim(form.Sizeno) eq ''>
    <cfset msg="Size No Cannot Be Empty!">
    <cfelse>
	<cfset msg="Duplicate Size No. Please Use Another Material No.">
    </cfif>
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createSizeidAjax');" value="Close" >
 </cfoutput>
</cfif>