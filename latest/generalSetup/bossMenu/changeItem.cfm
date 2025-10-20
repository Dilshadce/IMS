<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1835, 1302, 1131, 1826, 65">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
        <cfquery name="checkExist" datasource="#dts#">
            SELECT itemno 
            FROM icitem
            WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newItem)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newItem)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeItem.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE billmat
                    SET 
                    	itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE billmat
                    SET 
                    	BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE commentemp
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE fifoopq
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cftry>
                    <cfquery name="checkexist3" datasource="#dts#">
                        SELECT itemno 
                        FROM fifoopq_last_year
                        WHERE itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                    </cfquery>
                
                    <cfif checkexist3.recordcount neq 0>
                        <cfquery name="UPDATE" datasource="#dts#">
                            UPDATE fifoopq_last_year
                            SET 
                            	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                            WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                        </cfquery>
                    </cfif>
                    <cfcatch type="any">
                    </cfcatch>
                </cftry>
                        
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE icl3p
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE icl3p2
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE icl3p
                    SET 
                    	altitemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE altitemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE icl3p2
                    SET 
                    	altitemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE altitemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE iclink
                    SET ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE ictran
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE igrade
                    SET ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE iserial
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE itemgrd
                    SET ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE lobthob
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE locqdbf
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE logrdob
                    SET
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE monthcost
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE monthcost_last_year
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE obbatch
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE obbatch_last_year
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE temptrx
                    SET 
                    	ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                    WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                </cfquery>
                
                <cftry>
                    <cfquery name="checkexist2" datasource="#dts#">
                        SELECT itemno 
                        FROm icitem_last_year
                        WHERE itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">;
                    </cfquery>
                
                    <cfif checkexist2.recordcount neq 0>
                        <cfquery name="UPDATE" datasource="#dts#">
                            UPDATE icitem_last_year
                            SET 
                            	itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">
                            WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">; 
                        </cfquery>
                    </cfif>
                <cfcatch type="any">
                </cfcatch>
                </cftry>
                
                <cfquery name="UPDATE" datasource="#dts#">
                    UPDATE icitem
                    SET 
                    	itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">,
                    	desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">
                    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.product#"> 
                </cfquery>
                
                <cfquery name="inserteditbossmenu" datasource="#dts#">
                	INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeitemno',
                            	<cfqueryparam cfsqltype="cf_sql_char" value="#form.product#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newItem#">,'#huserid#',now())
                </cfquery>
                
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newItem)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeItem.cfm','_self');
                </script>
            </cfcatch>
            </cftry>	
            <script type="text/javascript">
                alert('Updated #trim(form.product)# to #trim(form.newItem)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60810','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1835]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterProduct.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeItem.cfm" method="post" onSubmit="document.getElementById('description').disabled=false";>
        <div>#words[1835]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="product">#words[1302]#</label></th>
                    <td>
                        <input type="hidden" id="product" name="product" class="productFilter" data-placeholder="#words[1131]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newItem">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newItem" name="newItem" placeholder="#words[1826]#" required />
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