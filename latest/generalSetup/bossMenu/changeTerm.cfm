<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT term 
            FROM #target_icterm#
            WHERE term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newTerm)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newTerm)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeTerm.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="updateARCUST" datasource="#dts#">
                    UPDATE #target_arcust#
                    SET 
                    	term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTerm#">
                    WHERE term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.term#">;
                </cfquery>
                
                <cfquery name="updateAPVEND" datasource="#dts#">
                    UPDATE #target_apvend#
                    SET 
                    	term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTerm#">
                    WHERE term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.term#">;
                </cfquery>
                
                <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTerm#">
                    WHERE term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.term#">; 
                </cfquery>
                
                <cfquery name="updateICTERM" datasource="#dts#">
                    UPDATE #target_icterm#
                    SET 
                    	term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTerm#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE term = <cfqueryparam cfsqltype="cf_sql_char" value="#form.term#">;
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeterm',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.term#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newTerm#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
                
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newTerm)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeTerm.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.term)# to #trim(form.newTerm)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60840','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Change Term</title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterTerm.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeTerm.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>Change Term</div>
        <div>
            <table>
                <tr>
                    <th><label for="term">Term</label></th>
                    <td>
                        <input type="hidden" id="term" name="term" class="termFilter" data-placeholder="Choose a Term" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newTerm">New Term</label></th>
                    <td>
                        <input type="text" id="newTerm" name="newTerm" placeholder="New Term" required />
                    </td>
                </tr>
                <tr>
                    <th><label for="description">Description</label></th>
                    <td>
                        <input type="text" id="description" name="description" placeholder="Description" disabled="true" />
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="submit" id="submit" name="submit" value="Submit" />
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60840'" />
        </div>
    </form>
</cfoutput>    
</body>
</html>