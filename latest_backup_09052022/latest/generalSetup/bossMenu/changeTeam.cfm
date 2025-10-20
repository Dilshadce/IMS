<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1843, 517, 518, 1826, 65">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT team 
            FROM icteam
            WHERE team = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newTeam)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newTeam)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeTeam.cfm','_self');
            </script>
        <cfelse>
            <cftry>
            	<cfquery name="updateICAGENT" datasource="#dts#">
                    UPDATE icagent
                    SET team = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTeam#">
                    WHERE team = <cfqueryparam cfsqltype="cf_sql_char" value="#form.team#">
                </cfquery>
        
                <cfquery name="updateICTEAM" datasource="#dts#">
                    UPDATE icteam
                    SET 
                    	team = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTeam#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE team = <cfqueryparam cfsqltype="cf_sql_char" value="#form.team#"> 
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeteam',
                        		<cfqueryparam cfsqltype="cf_sql_char" value="#form.team#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTeam#">,
                                '#huserid#',
                                NOW()
                           )
                </cfquery>
                
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newTeam)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeTeam.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.team)# to #trim(form.newTeam)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60830','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1843]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterTeam.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeTeam.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1843]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="team">#words[517]#</label></th>
                    <td>
                        <input type="hidden" id="team" name="team" class="teamFilter" data-placeholder="#words[518]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newTeam">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newTeam" name="newTeam" placeholder="#words[1826]#" required />
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