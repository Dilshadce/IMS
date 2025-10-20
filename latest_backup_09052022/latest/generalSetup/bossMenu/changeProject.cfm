<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1841, 506, 1079, 1826, 65">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
    	<cfif hlinkams EQ "Y">
        	<cfset dts1=replaceNoCase(dts,"_i","_a","all")>
        </cfif>
        
        <cfquery name="checkExist" datasource="#dts#">
            SELECT source 
            FROM project
            WHERE source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newProject)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newProject)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeProject.cfm','_self');
            </script>
        <cfelse>
            <cftry>       	                
                <cfif hlinkams EQ "Y">
                	<cfquery name="updatePROJECT" datasource="#dts1#">
                        UPDATE project
                        SET 
                            source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newProject#">,
                            project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">
                        WHERE source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.project#"> 
                        AND porj = "P";
                    </cfquery>
                </cfif>
                
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 
                    	source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newProject#">
                    WHERE source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.project#">;
                </cfquery>
                
                <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newProject#">
                    WHERE source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.project#">;
                </cfquery>
                
                <cfquery name="updatePROJECT" datasource="#dts#">
                    UPDATE project
                    SET 
                    	source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newProject#">,
                    	project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">
                    WHERE source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.project#"> 
                    AND porj = "P";
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeproject',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.project#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newProject#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
                
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newProject)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeProject.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.project)# to #trim(form.newProject)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60830','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1841]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterproject.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeProject.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1841]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="project">#words[506]#</label></th>
                    <td>
                        <input type="hidden" id="project" name="project" class="projectFilter" data-placeholder="#words[1079]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newProject">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newProject" name="newProject" placeholder="#words[1826]#" required />
                    </td>
                </tr>
                <tr>
                    <th><label for="description">#words[65]#</label></th>
                    <td>
                        <input type="text" id="description" name="description" placeholder="#words[65]#" disabled="true" />
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="submit" id="submit" name="submit" value="Submit" />
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60830'" />
        </div>
    </form>
</cfoutput>    
</body>
</html>