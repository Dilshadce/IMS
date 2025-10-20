<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
		<!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>--->
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="payroll_main">
            SELECT DS_ID, CompID, DS_NAME
            FROM payroll_dscontrol
            WHERE CompID <> "empty" AND CompID <> "manpowertest" AND(CompID LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR DS_NAME LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)
            ORDER BY CompID
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="payroll_main">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.CompID')>
            <cfset matchedAccount["CompID"]=evaluate('listMatchedAccount.CompID')>
            <cfset matchedAccount["DS_NAME"]=listMatchedAccount.DS_NAME>
            <cfset ArrayAppend(matchedAccountList,matchedAccount)>
        </cfloop>
        <cfset output=StructNew()>
        <cfset output["total"]=getMatchedAccountLength.matchedAccountLength>
        <cfset output["result"]=matchedAccountList>
        <cfreturn output>
    </cffunction>
    
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
		<!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>--->
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="payroll_main">
            SELECT DS_ID, CompID, DS_NAME
            FROM payroll_dscontrol
            WHERE CompID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.CompID')>
        <cfset selectedAccount["CompID"]=evaluate('getSelectedAccount.CompID')>
        <cfset selectedAccount["DS_NAME"]=evaluate('getSelectedAccount.DS_NAME')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>