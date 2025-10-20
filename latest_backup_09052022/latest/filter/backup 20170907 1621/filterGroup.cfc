<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>  
        <cfset Hitemgroup=form.Hitemgroup>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT wos_group AS wosGroup, desp AS desp
            FROM icgroup
            WHERE (wos_group LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR desp LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            )
            <cfif Hitemgroup neq ''>
            AND wos_group='#Hitemgroup#'
            </cfif>
            ORDER BY wos_group
            LIMIT #start#,#limit#;
        </cfquery>
        
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.wosGroup')>
            <cfset matchedAccount["wosGroup"]=evaluate('listMatchedAccount.wosGroup')>
            <cfset matchedAccount["desp"]=listMatchedAccount.desp>
            <cfset ArrayAppend(matchedAccountList,matchedAccount)>
        </cfloop>
        <cfset output=StructNew()>
        <cfset output["total"]=getMatchedAccountLength.matchedAccountLength>
        <cfset output["result"]=matchedAccountList>
        <cfreturn output>
    </cffunction>
    
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
        <!---s--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>  
        <cfset Hitemgroup=form.Hitemgroup>
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT wos_group AS wosGroup, desp AS desp
            FROM icgroup
            WHERE wos_group=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
            <cfif Hitemgroup neq ''>
            AND wos_group='#Hitemgroup#'
            </cfif>
            ;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset matchedAccount["id"]=evaluate('getSelectedAccount.wosGroup')>
        <cfset selectedAccount["wosGroup"]=evaluate('getSelectedAccount.wosGroup')>
        <cfset selectedAccount["desp"]=getSelectedAccount.desp>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>