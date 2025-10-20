<cfset status_msg="">

<cfif form.submit eq "Create">
	<cfif form.duedate neq "">
		<cfset form.duedate=createDate(ListGetAt(form.duedate,3,"/"),ListGetAt(form.duedate,2,"/"),ListGetAt(form.duedate,1,"/"))>
	<cfelse>
		<cfset form.duedate=now()>
	</cfif>
    <cfquery name="check" datasource="main">
    	select * from startupwarning
        where ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ID#">
    </cfquery>
    <cfif check.recordcount neq 0>
		<cfquery name="updateInfo" datasource="main">
            UPDATE startupwarning
                SET Message=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Message#">,
                    Details=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.Details#">,
                    duedate=#form.duedate#,
					disp_time=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.disp_time#">,
					disp_width=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.disp_width#">,
					disp_height=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.disp_height#">,
                    updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,
                    updated_on=now()
            WHERE ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ID#">
        </cfquery>
	</cfif>
<cfelseif form.submit eq "Edit">
	<cfif form.duedate neq "">
		<cfset form.duedate=createDate(ListGetAt(form.duedate,3,"/"),ListGetAt(form.duedate,2,"/"),ListGetAt(form.duedate,1,"/"))>
	<cfelse>
		<cfset form.duedate=now()>
	</cfif>
	<cfquery name="updateInfo" datasource="main">
		UPDATE startupwarning
			SET Message=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Message#">,
				Details=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.Details#">,
				duedate=#form.duedate#,
				disp_time=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.disp_time#">,
				disp_width=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.disp_width#">,
				disp_height=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.disp_height#">,
				updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,
				updated_on=now()
		WHERE ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ID#">
	</cfquery>
	<cfset status_msg="Record Updated Successfully">
<cfelseif form.submit eq "Delete">
	<cfquery name="deleteInfo" datasource="main">
		delete from startupwarning
		WHERE ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ID#">
	</cfquery>
	
	<cfset status_msg="Record Deleted Successfully">
<cfelseif form.submit eq "UploadFile">
	<cfset thisPath = ExpandPath("/super_menu/startupwarning/")>
	<cfif DirectoryExists("#thisPath#") eq 'NO'><cfdirectory action="create" directory="#thisPath#"></cfif>
	
	<cffile action="upload" 
		filefield="File" 
		destination="#variables.thisPath#" 
		nameconflict="makeunique"
		result="uResult">
						
	<cfquery name="updateInfo" datasource="main">
		UPDATE startupwarning
			SET File=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uResult.serverFile#">
		WHERE ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ID#">
	</cfquery>
						
	<cfset status_msg="File #uResult.serverFile# Upload Successfully">
<cfelseif form.submit eq "DeleteFile">
	<cfset thisPath = ExpandPath("/super_menu/startupwarning/#form.File#")>
	<cffile action = "delete" file = "#thisPath#">
	
	<cfquery name="updateInfo" datasource="main">
		UPDATE startupwarning
			SET File=''
		WHERE ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ID#">
	</cfquery>
	
	<cfset status_msg="File #form.File# Deleted Successfully">
</cfif>

<cfif form.submit eq "UploadFile" or form.submit eq "DeleteFile">
	<cfoutput>
	<form name="form" action="startupwarning2.cfm?type=edit&id=#form.ID#" method="post">
		<input type="hidden" name="status" value="#variables.status_msg#" />
	</form>
	</cfoutput>
<cfelse>
	<cfoutput>
	<form name="form" action="startupwarning.cfm" method="post">
		<input type="hidden" name="status" value="#variables.status_msg#" />
	</form>
	</cfoutput>
</cfif>

<script>form.submit();</script>	
