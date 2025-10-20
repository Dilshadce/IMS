<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
		<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT refno,custno,name
            FROM manpowerpo
            WHERE refno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR custno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            ORDER BY refno
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.refno')>
            <cfset matchedAccount["custno"]=evaluate('listMatchedAccount.custno')>
            <cfset matchedAccount["name"]=listMatchedAccount.name>
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

        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT refno,custno,name
            FROM manpowerpo
            WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.refno')>
        <cfset selectedAccount["custno"]=evaluate('getSelectedAccount.custno')>
        <cfset selectedAccount["name"]=evaluate('getSelectedAccount.name')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>