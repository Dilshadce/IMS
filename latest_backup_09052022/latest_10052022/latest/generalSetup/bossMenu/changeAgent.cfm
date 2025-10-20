<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1842, 29, 30, 1826, 65">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT agent 
            FROM icagent
            WHERE agent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newAgent)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newAgent)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeAgent.cfm','_self');
            </script>
        <cfelse>
            <cftry> 
                <cfquery name="updateARCUST" datasource="#dts#">
                    UPDATE #target_arcust#
                    SET 
                    	agent = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">
                    WHERE agent = <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">;
                </cfquery>
                
                <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">
                    WHERE agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">; 
                </cfquery>
                
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 
                    	agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">
                    WHERE agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">; 
                </cfquery>
                    
                <cfquery name="updateISERIAL" datasource="#dts#">
                    UPDATE iserial
                    SET 
                    	agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">
                    WHERE agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">; 
                </cfquery>
                
                <cfquery name="updateICL3P" datasource="#dts#">
                    UPDATE icl3p
                    SET 
                    	agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">
                    WHERE agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">;
                </cfquery>
                
                <cfquery name="updateICL3P2" datasource="#dts#">
                    UPDATE icl3p2
                    SET 
                    	agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">
                    WHERE agenno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">; 
                </cfquery>
                
                <cfquery name="updateICAGENT" datasource="#dts#">
                    UPDATE #target_icagent#
                    SET 
                    	agent = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE agent = <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">;
                </cfquery>
                
                <cfquery name="inserteditbossmenu" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeagent',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.agent#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAgent#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newAgent)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeAgent.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.agent)# to #trim(form.newAgent)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60830','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1842]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterAgent.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeAgent.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1842]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="agent">#words[29]#</label></th>
                    <td>
                        <input type="hidden" id="agent" name="agent" class="agentFilter" data-placeholder="#words[30]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newAgent">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newAgent" name="newAgent" placeholder="#words[1826]#" required />
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