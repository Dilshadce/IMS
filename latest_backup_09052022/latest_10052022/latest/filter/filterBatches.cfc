<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
		<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>
        <cfset term=trim(form.term)>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset mmonth = form.mmonth>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT batches
            FROM assignmentslip
            WHERE batches LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            AND payrollperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#mmonth#" />
            AND batches<>''
            GROUP BY batches
            ORDER BY batches
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.batches')>
            <cfset matchedAccount["batches"]=evaluate('listMatchedAccount.batches')>
            <cfset ArrayAppend(matchedAccountList,matchedAccount)>
        </cfloop>
        <cfset output=StructNew()>
        <cfset output["total"]=getMatchedAccountLength.matchedAccountLength>
        <cfset output["result"]=matchedAccountList>
        <cfreturn output>
    </cffunction>
    
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
		<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT batches
            FROM assignmentslip
            WHERE batches=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
            GROUP BY batches
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.batches')>
        <cfset selectedAccount["batches"]=evaluate('getSelectedAccount.batches')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>