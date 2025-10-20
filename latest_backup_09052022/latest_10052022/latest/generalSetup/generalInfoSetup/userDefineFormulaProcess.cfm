<cfoutput>
    
    <cfset value1 = replace(form.quantityFormula,'Define1','xqty1','all')>
    <cfset value2 = replace(value1,'Define2','xqty2','all')>
    <cfset value3 = replace(value2,'Define3','xqty3','all')>
    <cfset value4 = replace(value3,'Define4','xqty4','all')>
    <cfset value5 = replace(value4,'Define5','xqty5','all')>
    <cfset value6 = replace(value5,'Define6','xqty6','all')>
    <cfset value7 = replace(value6,'Define7','xqty7','all')>
    
    <cfset value11 = replace(form.priceFormula,'Define1','xqty1','all')>
    <cfset value12 = replace(value11,'Define2','xqty2','all')>
    <cfset value13 = replace(value12,'Define3','xqty3','all')>
    <cfset value14 = replace(value13,'Define4','xqty4','all')>
    <cfset value15 = replace(value14,'Define5','xqty5','all')>
    <cfset value16 = replace(value15,'Define6','xqty6','all')>
    <cfset value17 = replace(value16,'Define7','xqty7','all')>
    
    <cftry>
        <cfquery name="updatePassword" datasource="#dts#">
            UPDATE gsetup
            SET
                xqty1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.Define1)#">,
                xqty2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Define2#">,
                xqty3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Define3#">,
                xqty4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Define4#">,
                xqty5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Define5#">,
                xqty6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Define6#">,
                xqty7 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Define7#">,
                qtyformula = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value7#">,
                priceformula = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value17#">
            WHERE companyid = 'IMS';
        </cfquery>
    <cfcatch type="any">
        <script type="text/javascript">
            alert('Failed to update the formula!\nError Message: #cfcatch.message#');
            window.open('/latest/generalSetup/generalInfoSetup/userDefineFormula.cfm','_self');
        </script>
    </cfcatch>
    </cftry>
    <script type="text/javascript">
        alert('Updated formula successfully!');
        window.open('/latest/generalSetup/generalInfoSetup/userDefineFormula.cfm','_self');
    </script>	
</cfoutput>