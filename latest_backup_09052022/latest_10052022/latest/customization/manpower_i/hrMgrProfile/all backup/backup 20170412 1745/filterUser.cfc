<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
		<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="main">
            SELECT userID, userName, userEmail
            FROM users
            WHERE (userID LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR userName LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)
            AND LCASE(userGrpID) <> "super"
            ORDER BY userID
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="main">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.userID')>
            <cfset matchedAccount["userID"]=evaluate('listMatchedAccount.userID')>
            <cfset matchedAccount["userName"]=listMatchedAccount.userName>
            <cfset matchedAccount["userEmail"]=listMatchedAccount.userEmail>
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
        
        <cfquery name="getSelectedAccount" datasource="main">
            SELECT userID, userName, userEmail
            FROM users
            WHERE userID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.userID')>
        <cfset selectedAccount["userID"]=evaluate('getSelectedAccount.userID')>
        <cfset selectedAccount["userName"]=evaluate('getSelectedAccount.userName')>
        <cfset selectedAccount["userEmail"]=evaluate('getSelectedAccount.userEmail')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>