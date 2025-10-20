<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1839, 475, 1080, 1826, 506">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT source 
            FROM project
            WHERE source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newJob)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newJob)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeJob.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 
                    	job = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newJob#">
                    WHERE job = <cfqueryparam cfsqltype="cf_sql_char" value="#form.job#">;
                </cfquery>
                
                <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	job = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newJob#">
                    WHERE job = <cfqueryparam cfsqltype="cf_sql_char" value="#form.job#">;
                </cfquery>
                
                <cfquery name="updatePROJECT" datasource="#dts#">
                    UPDATE project
                    SET 
                    	source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newJob#">,
                    	project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">
                    WHERE source = <cfqueryparam cfsqltype="cf_sql_char" value="#form.job#"> 
                    AND porj = "J";
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changejob',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.job#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newJob#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
                
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newJob)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeJob.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.job)# to #trim(form.newJob)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60830','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1839]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterJob.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeJob.cfm" method="post" onSubmit="document.getElementById('project').disabled=false";>
        <div>#words[1839]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="job">#words[475]#</label></th>
                    <td>
                        <input type="hidden" id="job" name="job" class="jobFilter" data-placeholder="#words[1080]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newJob">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newJob" name="newJob" placeholder="#words[1826]#" required />
                    </td>
                </tr>
                <tr>
                    <th><label for="project">#words[506]#</label></th>
                    <td>
                        <input type="text" id="project" name="project" placeholder="#words[506]#" disabled="true" />
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