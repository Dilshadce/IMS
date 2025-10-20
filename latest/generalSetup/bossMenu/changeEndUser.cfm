<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1837, 1358, 1838, 1826, 23">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT driverno 
            FROM driver
            WHERE driverno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newEndUser)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newEndUser)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeEndUser.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 
                    	van = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newEndUser#">
                    WHERE van = <cfqueryparam cfsqltype="cf_sql_char" value="#form.endUser#">;
                </cfquery>
                
                    <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	van = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newEndUser#">
                    WHERE van = <cfqueryparam cfsqltype="cf_sql_char" value="#form.endUser#">;
                </cfquery>
                
                <cfquery name="updateDRIVER" datasource="#dts#">
                    UPDATE driver
                    SET 
                    	driverno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newEndUser#">
                    WHERE driverno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.endUser#">;
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeenduser',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.endUser#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newEndUser#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
                
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newEndUser)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeEndUser.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.endUser)# to #trim(form.newEndUser)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60830','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1837]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterEndUser.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeEndUser.cfm" method="post" onSubmit="document.getElementById('name').disabled=false";>
        <div>#words[1837]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="endUser">#words[1358]#</label></th>
                    <td>
                        <input type="hidden" id="endUser" name="endUser" class="endUserFilter" data-placeholder="#words[1838]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newEndUser">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newEndUser" name="newEndUser" placeholder="#words[1826]#" required />
                    </td>
                </tr>
                <tr>
                    <th><label for="name">#words[23]#</label></th>
                    <td>
                        <input type="text" id="name" name="name" placeholder="#words[23]#" disabled="true" />
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