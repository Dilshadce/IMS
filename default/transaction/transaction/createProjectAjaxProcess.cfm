	<cfquery name="getgsetup" datasource="#dts#">
  select * from gsetup
</cfquery>
	
	<cfset newProjectno = "#form.Projectno#">
    <cfquery name="checkexist" datasource="#dts#">
    select * FROM #target_project# where source = '#form.Projectno#'
    </cfquery>
    
    <cfif checkexist.recordcount eq 0>
    <cfquery name="insertProject" datasource="#dts#">
		insert into #target_project#
		(
        source,
        project,
        porj)
		values
		( 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Projectno#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
        "P"
		)
	</cfquery>
   
     <cfoutput>
      <cfset msg="New #getgsetup.lproject# Created Successfully">
 <h2>#msg#</h2>
 <input type="button" onClick="updateProject('#form.Projectno#');ColdFusion.Window.hide('createProjectAjax');" value="Close" >
 </cfoutput>
<cfelse>
	
     <cfoutput>
     <cfset msg="Duplicate #getgsetup.lproject# No. Please Use Another Project No.">
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createProjectAjax');" value="Close" >
 </cfoutput>
</cfif>