<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
        <cfset term=trim(form.term)>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT refno ,empname,assignmentslipdate FROM assignmentslip
             WHERE refno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR empname LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            LIMIT #start#,#limit#
        </cfquery>
        
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.refno')>
            <cfset matchedAccount["refno"]=evaluate('listMatchedAccount.refno')>
            <cfset matchedAccount["empname"]=evaluate('listMatchedAccount.empname')>
            <cfset matchedAccount["date"]=dateformat(evaluate('listMatchedAccount.assignmentslipdate'),'dd/mm/yyyy')>
            <cfset ArrayAppend(matchedAccountList,matchedAccount)>
        </cfloop>
        <cfset output=StructNew()>
        <cfset output["total"]=getMatchedAccountLength.matchedAccountLength>
        <cfset output["result"]=matchedAccountList>
        <cfreturn output>
    </cffunction>
    
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT refno,empname,assignmentslipdate FROM assignmentslip
            WHERE refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('listMatchedAccount.refno')>
        <cfset selectedAccount["refno"]=evaluate('listMatchedAccount.refno')>
        <cfset selectedAccount["empname"]=evaluate('listMatchedAccount.empname')>
        <cfset selectedAccount["date"]=dateformat(evaluate('listMatchedAccount.assignmentslipdate'),'dd/mm/yyyy')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>