	<cfset newGroupno = "#form.Groupno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * from icgroup where wos_group = '#form.Groupno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0 and trim(form.Groupno) neq ''>
    <cfquery name="insertGroup" datasource="#dts#">
		insert into icgroup
		(
        wos_group,
        desp)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Groupno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
		)
	</cfquery>
    <cfset msg="New Group Created Successfully">
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="updateGroup('#form.Groupno#');ColdFusion.Window.hide('createGroupAjax');" value="Close" >
 </cfoutput>
<cfelse>
	<cfif trim(form.Groupno) eq ''>
    <cfset msg="Group No Cannot Be Empty!">
    <cfelse>
	<cfset msg="Duplicate Group No. Please Use Another Group No.">
    </cfif>
     <cfoutput>
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createGroupidAjax');" value="Close" >
 </cfoutput>
</cfif>