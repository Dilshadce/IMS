<cfcomponent>

    <cfquery name="getGeneral" datasource="#dts#">
        SELECT lastaccyear
        FROM gsetup;
    </cfquery>

    <cffunction name="listCNDN" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        <cfset targetCN=form.targetCN>
        <cfset targetDN=form.targetDN>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT *
            FROM 
            (SELECT * FROM ictran
            WHERE type = "#targetCN#" OR type = "#targetDN#"
            AND (void='' OR void IS NULL)
            GROUP BY type,refno
            ) a
            WHERE a.refno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            ORDER BY type,refno
            LIMIT #start#,#limit#;
        </cfquery>
        
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.refno')>
            <cfset matchedAccount["refNo"]=evaluate('listMatchedAccount.refno')>
            <cfset ArrayAppend(matchedAccountList,matchedAccount)>
        </cfloop>
        <cfset output=StructNew()>
        <cfset output["total"]=getMatchedAccountLength.matchedAccountLength>
        <cfset output["result"]=matchedAccountList>
        <cfreturn output>
    </cffunction>
    
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>
        <cfset value=form.value>
        <cfset targetCN=form.targetCN>
        <cfset targetDN=form.targetDN>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT *
            FROM ictran
            WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
            AND type="#targetCN#" OR type="#targetDN#"
            AND (void='' OR void IS NULL)
            GROUP BY type,refno
            ORDER BY type,refno 
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset matchedAccount["id"]=evaluate('getSelectedAccount.refno')>
        <cfset selectedAccount["refNo"]=evaluate('getSelectedAccount.refno')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>