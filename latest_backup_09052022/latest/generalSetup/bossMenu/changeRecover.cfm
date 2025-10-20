<!----
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
--->
<cfquery name="getReferenceType" datasource="#dts#">
	SELECT frtype as refnotype 
	FROM iclink
	GROUP BY frtype; 
</cfquery>

<cfquery name="getReferenceNo" datasource="#dts#">
	SELECT frrefno 
    FROM iclink
	WHERE frtype = 'INV'
    GROUP BY frrefno
	ORDER BY frrefno;
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Recover Updated Transaction</title>
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
    <form class="formContainer form2Button" action="/latest/generalSetup/bossMenu/changeRecoverProcess.cfm" method="post">
        <div>Recover Updated Transaction</div>
        <div>
            <table>
                <tr>
                    <th><label for="type">Bill Type</label></th>
                    <td>
                        <select id="referenceType" name="referenceType" onChange="ajaxFunction(document.getElementById('ajaxField'),'getRefnofromiclink.cfm?reftype='+this.value);">
                        	<option value="">Please Select a Transaction Type</option>
								<cfloop query="getReferenceType">
                                    <cfif getReferenceType.refnotype eq "INV">
                                        <cfset refnoname = "Invoice">
                                    <cfelseif getReferenceType.refnotype eq "RC">
                                        <cfset refnoname = "Purchase Receive">
                                    <cfelseif getReferenceType.refnotype eq "PR">
                                        <cfset refnoname = "Purchase Return">
                                    <cfelseif getReferenceType.refnotype eq "DO">
                                        <cfset refnoname = "Delivery Order">
                                    <cfelseif getReferenceType.refnotype eq "CS">
                                        <cfset refnoname = "Cash Sales">
                                    <cfelseif getReferenceType.refnotype eq "CN">
                                        <cfset refnoname = "Credit Note">
                                    <cfelseif getReferenceType.refnotype eq "DN">
                                        <cfset refnoname = "Debit Note">
                                    <cfelseif getReferenceType.refnotype eq "ISS">
                                        <cfset refnoname = "Issue">
                                    <cfelseif getReferenceType.refnotype eq "PO">
                                        <cfset refnoname = "Purchase Order">
                                    <cfelseif getReferenceType.refnotype eq "SO">
                                        <cfset refnoname = "Sales Order">
                                    <cfelseif getReferenceType.refnotype eq "QUO">
                                        <cfset refnoname = "Quotation">
                                    <cfelseif getReferenceType.refnotype eq "ASSM">
                                        <cfset refnoname = "Assembly">
                                    <cfelseif getReferenceType.refnotype eq "TR">
                                        <cfset refnoname = "Transfer">
                                    <cfelseif getReferenceType.refnotype eq "OAI">
                                        <cfset refnoname = "Adjustment Increase">
                                    <cfelseif getReferenceType.refnotype eq "OAR">
                                        <cfset refnoname = "Adjustment Reduce">
                                    <cfelseif getReferenceType.refnotype eq "SAM">
                                        <cfset refnoname = "Sample">
                                    <cfelseif getReferenceType.refnotype eq "CT">
                                        <cfset refnoname = "Consignment Note">
                                    <cfelse>
                                        <cfset refnoname = "Invoice">
                                    </cfif>
                                    <option value="#refnotype#" <cfif getReferenceType.refnotype eq "INV">selected</cfif>>#refnoname#</option>
                                </cfloop>
                            </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="billNumber">Bill Number</label></th>
                    <td>
                       <div id="ajaxField" name="ajaxField">
                       <select name="referenceNo">
                       		<option value="">Choose a Reference No</option>
                            <cfloop query="getReferenceNo">
                            	<option value="#frrefno#">#frrefno#</option>
                            </cfloop>
						</select>
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