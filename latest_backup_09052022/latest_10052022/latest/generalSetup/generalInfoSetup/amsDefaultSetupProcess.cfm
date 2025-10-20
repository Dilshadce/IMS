<cfoutput>
    <cftry>	
    	<cfif Hlinkams eq "Y">
            <cfquery name="updateAMSDefaultSetup" datasource="#dts#">
                UPDATE gsetup
                SET
                    creditsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.creditSales)#">,
                    cashsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cashSales)#">,
                    salesreturn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.salesReturn)#">,
                    discsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.salesDiscount)#">,
                    gstsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.salesTax)#">,
                    <cfloop index="i" from="1" to="7">
                   		custmisc#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(evaluate('form.miscCharges#i+14#'))#">,
                    </cfloop>

                    purchasereceive = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.purchase)#">,
                    purchasereturn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.purchaseReturn)#">,
                    discpur = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.purchaseDiscount)#">,
                    gstpurchase = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.purchaseTax)#">,
                    <cfloop index="i" from="1" to="7">
                   		suppmisc#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(evaluate('form.miscCharges#i+33#'))#">,
                    </cfloop>
                    
                    cashaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cash)#">,
                    depositaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.deposit)#">,
                    chequeaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cheque)#">,
                    creditcardaccount1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.creditCard1)#">,
                    creditcardaccount2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.creditCard2)#">,
                    debitcardaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.debitCard)#">,
                    cashvoucheraccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cashVoucher)#">,
                    withholdingtaxaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cashVoucher)#">,
                    bankaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.bankAccount)#">,
                    roundingaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.roundingaccount)#">,
                    expensesaccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.expensesaccount)#">
                WHERE companyid = 'IMS';
            </cfquery>
		</cfif>
    <cfcatch type="any">
        <script type="text/javascript">
            alert('Failed to update the setup(s)!\nError Message: #cfcatch.message#');
            window.open('/latest/generalSetup/generalInfoSetup/companyProfile.cfm','_self');
        </script>
    </cfcatch>
    </cftry>
    
    <script type="text/javascript">
        alert('Updated setup(s) successfully!');
        window.open('/latest/body/bodymenu.cfm?id=60100','_self');
    </script>	
</cfoutput>