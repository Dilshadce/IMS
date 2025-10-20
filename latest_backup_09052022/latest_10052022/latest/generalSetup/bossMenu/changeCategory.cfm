<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "123, 143, 1826, 65, 1941">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT cate 
            FROM iccate
            WHERE cate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newCategory)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newCategory)# already exist!');
                window.open('/latest/generalsetup/bossMenu/changeCategory.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 
                    	category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newCategory#">
                    WHERE category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.category#">
                </cfquery>
                
                <cfquery name="updateICITEM" datasource="#dts#">
                    UPDATE icitem
                    SET 
                    	category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newCategory#">
                    WHERE category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.category#"> 
                </cfquery>
                
                <cfquery name="updateICITEMLASTYEAR" datasource="#dts#">
                    UPDATE icitem_last_year
                    SET 
                    	category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newCategory#">
                    WHERE category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.category#"> 
                </cfquery>
                    
                <cfquery name="updateICMITEM" datasource="#dts#">
                    UPDATE icmitem
                    SET 
                    	category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newCategory#">
                    WHERE category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.category#">
                </cfquery>
                
                <cfquery name="updateLOCQDBF" datasource="#dts#">
                    UPDATE locqdbf
                    SET 
                    	category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newCategory#">
                    WHERE category = <cfqueryparam cfsqltype="cf_sql_char" value="#form.category#">
                </cfquery>
                
                <cfquery name="updateICCATE" datasource="#dts#">
                    UPDATE iccate
                    SET 
                    	cate = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newCategory#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE cate = <cfqueryparam cfsqltype="cf_sql_char" value="#form.category#"> 
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                                'changecategory',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.category#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newCategory#">,
                                '#huserid#',
                                NOW()
                       	 	)
                </cfquery>
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newCategory)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSETup/bossMenu/changeCategory.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.category)# to #trim(form.newCategory)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60820','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charSET=utf-8" />
    <title><cfoutput>#words[1941]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterCategory.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSETup/bossMenu/changeCategory.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1941]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="category">#words[123]#</label></th>
                    <td>
                        <input type="hidden" id="category" name="category" class="categoryFilter" data-placeholder="#words[143]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newCategory">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newCategory" name="newCategory" placeholder="#words[1826]#" required />
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