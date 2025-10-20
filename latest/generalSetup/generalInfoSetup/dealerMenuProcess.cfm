<cfoutput>
    <cftry>	
        <cfquery name="updateGsetup" datasource="#dts#">
            UPDATE gsetup
            SET
            
            	<cfif IsDefined('minSellingPriceControl')>
                	gpricemin = "1",
                    priceminpass = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.minSellingPricePassword)#">,
                <cfelse>
                    gpricemin = "0",   
                    priceminpass = "",
                </cfif>
                
                <cfif IsDefined('minSellingPriceEmail')>
                	priceminctrlemail = "1",
                <cfelse>
                	priceminctrlemail = "0",
                </cfif>
                
                <cfif IsDefined('editBillPassword')>
               		editbillpassword = "1",
                	editbillpassword1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.selectResult5)#">
                <cfelse>
                	editbillpassword = "0",
                    editbillpassword1 = ""    
				</cfif>

            WHERE companyid = 'IMS';
        </cfquery>
        
        <cfquery name="updateDealerMenu" datasource="#dts#">
            UPDATE dealer_menu
            SET
            
            	<cfif IsDefined('sellingBelowCost')>
                	selling_below_cost = "Y",
                <cfelse>
                    selling_below_cost = "",   
                </cfif>
                
                <cfif IsDefined('sellingCannotLower')>
                	minimum_selling_price = "Y",
                    minimum_selling_price1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.selectResult1)#">,
                <cfelse>
                	minimum_selling_price = "",
                    minimum_selling_price1 = "",
                </cfif>
                
                <cfif IsDefined('overCreditLimit')>
               		selling_above_credit_limit = "Y",
                    selling_above_credit_limit1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.selectResult2)#">,
                <cfelse>
                	selling_above_credit_limit = "", 
                    selling_above_credit_limit1 = "",   
				</cfif>
                
                <cfif IsDefined('overCreditTerm')>
               		credit_term = "Y",
                    credit_term1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.selectResult3)#">,
                <cfelse>
                	credit_term = "",
                    credit_term1 = "",    
				</cfif>
                
                <cfif IsDefined('negativeStockControl')>
               		negstkpassword = "Y",
                    negstkpassword1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.selectResult4)#">,
                <cfelse>
                	negstkpassword = "",  
                    negstkpassword1 = "",  
				</cfif>
                
                <cfif IsDefined('tran_edit_term')>
               		tran_edit_term = "Y",
                 <cfelse>
                	tran_edit_term = "",  
				</cfif>
                
                <cfif IsDefined('tran_edit_name')>
               		tran_edit_name = "Y",
                 <cfelse>
                	tran_edit_name = "",  
				</cfif>
                
                custSuppSortBy = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.custSuppSortBy)#">,
                productSortBy = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.productSortBy)#">,
                transactionSortBy = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.transactionSortBy)#">,
                
                <cfif IsDefined('customCompany')>
               		customcompany = "Y"
                <cfelse>
                    customcompany = ""
				</cfif>;	                    
        </cfquery>
    <cfcatch type="any">
        <script type="text/javascript">
            alert('Failed to update the setup(s)!\nError Message: #cfcatch.message#');
            window.open('/latest/generalSetup/generalInfoSetup/dealerMenu.cfm','_self');
        </script>
    </cfcatch>
    </cftry>
    
    <script type="text/javascript">
        alert('Updated setup(s) successfully!');
        window.open('/latest/body/bodymenu.cfm?id=60100','_self');
    </script>	
</cfoutput>