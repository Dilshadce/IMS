<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1827, 104, 156, 1826, 23">
<cfinclude template="/latest/words.cfm">

<cfoutput>
	<cfif IsDefined("form.submit")>
    	<cfif Hlinkams eq "Y">
        	<cfset dts1=replacenocase(dts,"_i","_a","all")>
	<cfelse>
		<cfset dts1=dts>
        </cfif>
        
        <cfquery name="checkExist" datasource="#dts1#">
            SELECT custno 
            FROM #target_apvend#
            WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newSupplier)#">;
        </cfquery>
        
        <cfif checkExist.recordcount>
            <script type="text/javascript">
                alert('This #trim(form.newSupplier)# already exist!');
                window.open('/latest/generalSetup/bossMenu/changeSupplier.cfm','_self');
            </script>
        <cfelse>
            <cftry>
				<cfif Hlinkams eq "Y">
                    <cfquery name="updateGLDATA" datasource="#dts1#">
                        UPDATE gldata 
                        SET 
                            accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateARCUST" datasource="#dts1#">
                        UPDATE arcust 
                        SET 
                            custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateAPVEND" datasource="#dts1#">
                        UPDATE apvend 
                        SET 	
                            custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateGLPOST" datasource="#dts1#">
                        UPDATE glpost 
                        SET 
                            accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateGLPOSTAT" datasource="#dts1#">
                        UPDATE glpostat 
                        SET 
                            accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateARPOST" datasource="#dts1#">
                        UPDATE arpost 
                        SET 
                            accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateAPPOST" datasource="#dts1#">
                        UPDATE appost 
                        SET 
                            accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateARPAY" datasource="#dts1#">
                        UPDATE arpay 
                        SET 
                            custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateAPPAY" datasource="#dts1#" >
                        UPDATE appay 
                        SET 
                            custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
            	</cfif>
            
                <cfquery name="updateARCUST" datasource="#dts#">
                    UPDATE arcust
                    SET 
                    	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateAPVEND" datasource="#dts#">
                    UPDATE apvend
                    SET 
                    	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateICTRAN" datasource="#dts#">
                    UPDATE ictran
                    SET 	
                    	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateARTAN" datasource="#dts#">
                    UPDATE artran
                    SET 
                    	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateARTRANAT" datasource="#dts#">
                    UPDATE artranat
                    SET
                    	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateDRIVER" datasource="#dts#">
                    UPDATE driver
                    SET 
                    	customerno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE Customerno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateGLPOST91" datasource="#dts#">
                    UPDATE glpost91 
                    SET 
                    	accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateGLPOST9" datasource="#dts#">
                    UPDATE glpost9
                    SET 
                    	accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE accno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateICL3P" datasource="#dts#">
                    UPDATE icl3p
                    SET custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateICL3P2" datasource="#dts#">
                    UPDATE icl3p2
                    SET 
                    	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateISERIAL" datasource="#dts#">
                    UPDATE iserial
                    SET 
                    	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
                
                <cfquery name="updateICITEMLASTYEAR" datasource="#dts#">
                    UPDATE icitem_last_year
                    SET 
                    	supp = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE supp = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#"> ;
                </cfquery>
                    
                <cfquery name="update" datasource="#dts#">
                    UPDATE icitem
                    SET 
                    	supp = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE supp = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">; 
                </cfquery>
                
                <cfquery name="update" datasource="#dts#">
                    UPDATE icmitem
                    SET 
                    	supp = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                    WHERE supp = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                </cfquery>
            
                <cfif LCASE(hcomid) EQ "accord_i">
                    <cfquery name="updateVEHICLES" datasource="#dts#">
                        UPDATE vehicles
                        SET 
                        	custcode = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE custcode = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
				</cfif>
                <cfif LCASE(hcomid) EQ "net_i">
                    <cfquery name="updateCONTRACTSERVICE" datasource="#dts#">
                        UPDATE contract_service
                        SET 
                        	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                    
                    <cfquery name="updateSERVICETRAN" datasource="#dts#">
                        UPDATE service_tran
                        SET 
                        	custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">
                        WHERE custno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">;
                    </cfquery>
                </cfif>
                
				<cfquery name="inserteditbossmenu" datasource="#dts#">
                    INSERT INTO edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) 
                    VALUES (
                    			'changeSupplier',
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.supplier#">,
                                <cfqueryparam cfsqltype="cf_sql_char" value="#form.newSupplier#">,
                                '#huserid#',
                                NOW()
                            )
				</cfquery>
        
           <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to update #trim(form.newSupplier)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/generalSetup/bossMenu/changeSupplier.cfm','_self');
                </script>
            </cfcatch>
            </cftry>
            <script type="text/javascript">
                alert('Updated #trim(form.supplier)# to #trim(form.newSupplier)# successfully!');
                window.open('/latest/body/bodymenu.cfm?id=60810','_self');
            </script>	
        </cfif>
    </cfif>
</cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1827]#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <cfinclude template="/latest/filter/filterSupplier.cfm">
</head>
<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeSupplier.cfm" method="post" onSubmit="document.getElementById('name').disabled=false";>
        <div>#words[1827]#</div>
        <div>
            <table>
                <tr>
                    <th><label for="supplier">#words[104]#</label></th>
                    <td>
                        <input type="hidden" id="supplier" name="supplier" class="supplierFilter" data-placeholder="#words[156]#" />
                    </td>
                </tr>
                <tr>
                    <th><label for="newSupplier">#words[1826]#</label></th>
                    <td>
                        <input type="text" id="newSupplier" name="newSupplier" placeholder="#words[1826]#" required />
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
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60810'" />
        </div>
    </form>
</cfoutput>    
</body>
</html>