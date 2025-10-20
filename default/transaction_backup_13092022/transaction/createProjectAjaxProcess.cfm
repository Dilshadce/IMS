	<cfquery name="getgsetup" datasource="#dts#">
  select * from gsetup
</cfquery>
	
	<cfset newProjectno = "#form.Projectno#">
    <cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
    <cfquery name="checkexist" datasource="#dts#">
    select * from weikendecor_a.project where source = '#form.Projectno#'
    </cfquery>
    <cfelse>
    <cfquery name="checkexist" datasource="#dts#">
    select * from #target_project# where source = '#form.Projectno#'
    </cfquery>
    </cfif>
    
    <cfif checkexist.recordcount eq 0 and trim(form.Projectno) neq ''>
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
    <cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
    <cfquery name="insertProject" datasource="#dts#">
		insert into weikendecor_a.project
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
    </cfif>
   
     <cfoutput>
      <cfset msg="New #getgsetup.lproject# Created Successfully">
 <h2>#msg#</h2>
 <input type="button" onClick="updateProject('#form.Projectno#');ColdFusion.Window.hide('createProjectAjax');" value="Close" >
 </cfoutput>
<cfelse>
	
     <cfoutput>
     <cfset msg="Duplicate #getgsetup.lproject# No./Project No cannot be blank. Please Use Another Project No.">
 <h2>#msg#</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createProjectAjax');" value="Close" >
 </cfoutput>
</cfif>