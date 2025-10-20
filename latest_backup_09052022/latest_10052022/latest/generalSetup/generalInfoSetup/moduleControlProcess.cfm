<cfquery name="checkExist" datasource="#dts#" >
	SELECT * 
    FROM modulecontrol;
</cfquery>

<cfoutput>
    <cftry>	
    	<cfif checkExist.recordcount EQ 0>
            <cfquery name="insertInto_module" datasource="#dts#">
                INSERT INTO modulecontrol (companyid,postran,matrixtran,simpletran,repairtran,customtax,malaysiaGST)
                VALUES
                        'IMS',	
                        <cfif IsDefined('form.POStransaction')>
                            '1'
                        <cfelse>
                            '0'
                        </cfif>,
                        <cfif IsDefined('form.matrixTransaction')>
                            '1'
                        <cfelse>
                            '0'
                        </cfif>,
                        <cfif IsDefined('form.simpleTransaction')>
                            '1'
                        <cfelse>
                            '0'
                        </cfif>,
                        <cfif IsDefined('form.batchCode')>
                            '1'
                        <cfelse>
                            '0'
                        </cfif>,
                        <cfif IsDefined('form.repairTransaction')>
                            '1'
                        <cfelse>
                            '0'
                        </cfif>,
                        <cfif IsDefined('form.customTax')>
                            '1'
                        <cfelse>
                            '0'
                        </cfif>,
                        <cfif IsDefined('form.malaysiaGST')>
                            '1'
                        <cfelse>
                            '0'
                        </cfif>
    
                WHERE companyid = 'IMS';
            </cfquery>
    	<cfelse>
			<cfquery name="update_module" datasource="#dts#">
                UPDATE modulecontrol
                SET
                    <cfif IsDefined('form.POStransaction')>
                        postran = '1'
                    <cfelse>
                        postran = '0'
                    </cfif>,
                    <cfif IsDefined('form.matrixTransaction')>
                        matrixtran = '1'
                    <cfelse>
                        matrixtran = '0'
                    </cfif>,
                    <cfif IsDefined('form.simpleTransaction')>
                        simpletran = '1'
                    <cfelse>
                        simpletran = '0'
                    </cfif>,
                    <cfif IsDefined('form.batchCode')>
                        batchcode = '1'
                    <cfelse>
                        batchcode = '0'
                    </cfif>,
                    <cfif IsDefined('form.repairTransaction')>
                        repairtran = '1'
                    <cfelse>
                        repairtran = '0'
                    </cfif>,
                    <cfif IsDefined('form.customTax')>
                        customtax = '1'
                    <cfelse>
                        customtax = '0'
                    </cfif>,
                    <cfif IsDefined('form.malaysiaGST')>
                        malaysiaGST = '1'
                    <cfelse>
                        malaysiaGST = '0'
                    </cfif>
    
                WHERE companyid = 'IMS';
        	</cfquery>        
        </cfif>        
    <cfcatch type="any">
        <script type="text/javascript">
            alert('Failed to update the setup(s)!\nError Message: #cfcatch.message#');
            window.open('/latest/generalSetup/generalInfoSetup/moduleControl.cfm','_self');
        </script>
    </cfcatch>
    </cftry>
    
    <script type="text/javascript">
        alert('Updated setup(s) successfully!');
        window.open('/latest/body/bodymenu.cfm?id=60100','_self');
    </script>	
</cfoutput>