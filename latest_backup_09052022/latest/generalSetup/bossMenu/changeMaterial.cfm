<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "148, 149, 1833, 65, 1943">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT colorid 
            FROM iccolorid
            WHERE colorid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newMaterial)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newMaterial)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeMaterial.cfm','_self');
            </script>
        <cfelse>
            <cftry>
            	<cfquery name="update" datasource="#dts#">
                    UPDATE icitem
                    SET 
                    	colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newMaterial#">
                    WHERE colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#form.material#"> 
                </cfquery>
        
                <cfquery name="update" datasource="#dts#">
                    UPDATE iccolorid
                    SET 
                    	colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newMaterial#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE colorid = <cfqueryparam cfsqltype="cf_sql_char" value="#form.material#"> 
                </cfquery>
                
                <cfquery name="inserteditbossmenu" datasource="#dts#">
                    INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changecolorid',
                    			<cfqueryparam cfsqltype="cf_sql_char" value="#form.material#">,
                    			<cfqueryparam cfsqltype="cf_sql_char" value="#form.newMaterial#">,
                                '#huserid#',
                                NOW()
                    		)
                </cfquery>
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newMaterial)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeMaterial.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.material)# to #trim(form.newMaterial)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60820','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1943]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterMaterial.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeMaterial.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1943]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="material">#words[148]#</label></th>
                    <td>
                        <input type="hidden" id="material" name="material" class="materialFilter" data-placeholder="#words[149]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newMaterial">#words[1833]#</label></th>
                    <td>
                        <input type="text" id="newMaterial" name="newMaterial" placeholder="#words[1833]#" required />
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