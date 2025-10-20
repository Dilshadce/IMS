<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1834, 86, 87, 1826, 65">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT area 
            FROM icarea
            WHERE area = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newArea)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newArea)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeArea.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 
                        area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newArea#">
                    WHERE area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.area#">;
                </cfquery>
                
                <cfquery name="update" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newArea#">
                    WHERE area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.area#">; 
                </cfquery>
                    
                <cfquery name="updateARCUST" datasource="#dts#">
                    UPDATE #target_arcust#
                    SET 
                    	area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newArea#">
                    WHERE area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.area#">; 
                </cfquery>
                
                <cfquery name="updateAPVEND" datasource="#dts#">
                    UPDATE #target_apvend#
                    SET 
                    	area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newArea#">
                    WHERE area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.area#">;
                </cfquery>
                
                <cfquery name="updateICAREA" datasource="#dts#">
                    UPDATE icarea
                    SET 
                    	area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newArea#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE area = <cfqueryparam cfsqltype="cf_sql_char" value="#form.area#"> ;
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changearea',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.area#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newArea#">,
                                '#huserid#',
                                NOW()
							)
                </cfquery>
                
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newArea)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeArea.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.area)# to #trim(form.newArea)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60830','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1834]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterArea.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeArea.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1834]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="area">#words[86]#</label></th>
                    <td>
                        <input type="hidden" id="area" name="area" class="areaFilter" data-placeholder="#words[87]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newArea">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newArea" name="newArea" placeholder="#words[1826]#" required />
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