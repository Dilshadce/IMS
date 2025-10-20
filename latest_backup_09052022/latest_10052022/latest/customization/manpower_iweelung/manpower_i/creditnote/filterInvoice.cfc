<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
        <cfset term=form.term>
        <cfset limit=form.limit>
		<cfset custno=form.custno>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT refno,wos_date
            FROM artran
            WHERE (refno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR wos_date LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)
			AND type = "INV"
			AND custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#" />
            ORDER BY refno
            LIMIT #start#,#limit#;
        </cfquery>
        
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.refno')>
            <cfset matchedAccount["refno"]=evaluate('listMatchedAccount.refno')>
            <cfset matchedAccount["wos_date"]=dateformat(listMatchedAccount.wos_date,'dd/mm/yyyy')>
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
            SELECT refno,wos_date
            FROM artran
            WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset matchedAccount["id"]=evaluate('getSelectedAccount.refno')>
        <cfset selectedAccount["refno"]=evaluate('getSelectedAccount.refno')>
        <cfset matchedAccount["wos_date"]=dateformat(getSelectedAccount.wos_date,'dd/mm/yyyy')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>