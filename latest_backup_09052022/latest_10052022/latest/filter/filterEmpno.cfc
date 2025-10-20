<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
		<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>
        <cfset batches=form.batches>
        <cfset term=trim(form.term)>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT empno,empname
            FROM assignmentslip
            WHERE empno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            AND batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#batches#" />
            GROUP BY empno
            ORDER BY empno
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.empno')>
            <cfset matchedAccount["empno"]=evaluate('listMatchedAccount.empno')>
            <cfset matchedAccount["name"]=evaluate('listMatchedAccount.empname')>
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
            SELECT empno,empname
            FROM assignmentslip
            WHERE empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
            GROUP BY empno
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.empno')>
        <cfset selectedAccount["empno"]=evaluate('getSelectedAccount.empno')>
        <cfset selectedAccount["name"]=evaluate('getSelectedAccount.empname')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>