<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1828, 6, 1829, 1826, 23">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT code 
            FROM address
            WHERE code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newAddress)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newAddress)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeAddress.cfm','_self');
            </script>
        <cfelse>
            <cftry> 
                <cfquery name="update" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	rem0 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAddress#">
                    WHERE rem0 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.address#">; 
                </cfquery>
                
                <cfquery name="updateARTRAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAddress#">
                    WHERE rem1 = <cfqueryparam cfsqltype="cf_sql_char" value="#form.address#">;
                </cfquery>
                    
                <cfquery name="updateADDRESS" datasource="#dts#">
                    UPDATE address
                    SET 
                    	code = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAddress#">,
                    	name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">
                    WHERE code = <cfqueryparam cfsqltype="cf_sql_char" value="#form.address#"> ;
                </cfquery>
                
                <cfquery name="insertEDITEDBOSSMENU" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeaddress',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.address#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newAddress#">,
                                '#huserid#',
                                NOW()
                            )
                </cfquery>
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newAddress)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeAddress.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.address)# to #trim(form.newAddress)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60830','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1828]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterAddress.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeAddress.cfm" method="post" onSubmit="document.getElementById('name').disabled=false";>
        <div>#words[1828]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="address">#words[6]#</label></th>
                    <td>
                        <input type="hidden" id="address" name="address" class="addressFilter" data-placeholder="#words[1829]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newAddress">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newAddress" name="newAddress" placeholder="#words[1826]#" required />
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
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60800'" />
        </div>
    </form>
</cfoutput>    
</body>
</html>