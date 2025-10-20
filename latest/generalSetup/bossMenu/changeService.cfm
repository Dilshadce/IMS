<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1836, 1830, 1831, 1826, 65">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT servi 
            FROM icservi
            WHERE servi = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newService)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newService)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeService.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 
                        itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newService#">
                    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.service#">
                    AND linecode ='SV';
                </cfquery>
                
                <cfif lcase(hcomid) EQ "net_i">
                    <cfquery name="update" datasource="#dts#">
                        UPDATE contract_service
                        SET 
                            servi = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newService#">
                        WHERE servi = <cfqueryparam cfsqltype="cf_sql_char" value="#form.service#">;
                    </cfquery>
                    
                    <cfquery name="updateSERVICE_TYPE" datasource="#dts#">
                        UPDATE service_type
                        SET 
                            servi = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newService#">
                        WHERE servi = <cfqueryparam cfsqltype="cf_sql_char" value="#form.service#">;
                    </cfquery>
                </cfif>
                
                <cfquery name="updateICSERVI" datasource="#dts#">
                    UPDATE icservi
                    SET 
                        servi = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newService#">,
                        desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE servi = <cfqueryparam cfsqltype="cf_sql_char" value="#form.service#">; 
                </cfquery>
                
                <cfquery name="insertEDITED_BOSSMENU" datasource="#dts#">
                    INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                        'changeservice',
                        <cfqueryparam cfsqltype="cf_sql_char" value="#form.service#">,
                        <cfqueryparam cfsqltype="cf_sql_char" value="#form.newService#">,
                        '#huserid#',
                        NOW()
                    )
                </cfquery>
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newService)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeService.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.service)# to #trim(form.newService)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60810','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1836]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterService.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeService.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1836]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="service">#words[1830]#</label></th>
                    <td>
                        <input type="hidden" id="service" name="service" class="serviceFilter" data-placeholder="#words[1831]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newService">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newService" name="newService" placeholder="#words[1826]#" required />
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
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60810'" />
        </div>
    </form>
</cfoutput>    
</body>
</html>