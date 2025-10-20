<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1840, 482, 1082, 1826, 65">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT location 
            FROM iclocation
            WHERE location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newLocation)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newLocation)# already exist!');
                window.open('/latest/generalsetup/bossMenu/changeLocation.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateICTRAN" datasource="#dts#">
					UPDATE ictran
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">;
                </cfquery>
                
                <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
                    AND type='TR';
                </cfquery>
                
                <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	rem2 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE rem2 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
                    AND type='TR';
                </cfquery>

                <cfquery name="updateICTRANTEMP" datasource="#dts#">
                    UPDATE ictrantemp
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">;
                </cfquery>
                
                <cfquery name="updateBILLMAT" datasource="#dts#">
                    UPDATE billmat
                    SET 
                    	bmlocation = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE bmlocation = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">;
                </cfquery>
                    
                <cfquery name="updateISERIAL" datasource="#dts#">
                    UPDATE iserial
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">; 
                </cfquery>
                
                <cfquery name="updateIGRADE" datasource="#dts#">
                    UPDATE igrade
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">; 
                </cfquery>
                
                <cfquery name="updateLOBTHOB" datasource="#dts#">
                    UPDATE lobthob
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">;
                </cfquery>
                
                <cfquery name="updateLOCADJTRAN" datasource="#dts#">
                    UPDATE locadjtran
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">;
                </cfquery>
                
                <cfquery name="updateLOCQDBF" datasource="#dts#">
                    UPDATE locqdbf
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">;
                </cfquery>
                
                <cfquery name="updateLOGRDOB" datasource="#dts#">
                    UPDATE logrdob
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">;
                </cfquery>
        
                <cfquery name="updateICLOCATION" datasource="#dts#">
                    UPDATE iclocation
                    SET 
                    	location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">; 
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                                'changelocation',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newLocation#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
            <cfcatch type="any">
            
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newLocation)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeLocation.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.location)# to #trim(form.newLocation)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60820','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charSET=utf-8" />
    <title><cfoutput>#words[1840]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterLocation.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSETup/bossMenu/changeLocation.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1840]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="location">#words[482]#</label></th>
                    <td>
                        <input type="hidden" id="location" name="location" class="locationFilter" data-placeholder="#words[1082]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newLocation">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newLocation" name="newLocation" placeholder="#words[1826]#" required />
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