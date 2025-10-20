<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "146, 147, 1826, 65, 1942">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT wos_group 
            FROM icgroup
            WHERE wos_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newGroup)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newGroup)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeGroup.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateICITEM" datasource="#dts#">
                    UPDATE icitem
                    SET 
                        wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newGroup#">
                    WHERE wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#group#">; 
                </cfquery>
                
                <cfquery name="updateICITEMLASTYEAR" datasource="#dts#">
                    UPDATE icitem_last_year
                    SET 
                        wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newGroup#">
                    WHERE wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#group#">;
                </cfquery>
                
                <cfquery name="updateICMITEM" datasource="#dts#">
                    UPDATE icmitem
                    SET 
                        wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newGroup#">
                    WHERE wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#group#">;
                </cfquery>
                
                <cfquery name="update" datasource="#dts#">
                    UPDATE locqdbf
                    SET 
                    	wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newGroup#">
                    WHERE wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#group#">
                </cfquery>
                
                <cfquery name="updategroup" datasource="#dts#">
                    UPDATE icgroup
                    SET 
                        wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#newGroup#">,
                        desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#group#">;
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                    INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                                'changegroup',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#group#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#newGroup#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newGroup)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeGroup.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.group)# to #trim(form.newGroup)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60820','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1942]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterGroup.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeGroup.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1942]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="group">#words[146]#</label></th>
                    <td>
                        <input type="hidden" id="group" name="group" class="groupFilter" data-placeholder="#words[147]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newGroup">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newGroup" name="newGroup" placeholder="#words[1826]#" required />
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
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60800'" />
        </div>
    </form>
</cfoutput>    
</body>
</html>