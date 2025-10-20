<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
		<cfquery name="getdts" datasource="main">
         	SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset paydts = #replace(#dts#,'_i','_p')#>
        
		<!--- This is not needed as it is not linked to AMS by Edwin 6/12/2016
		<cfif getdts.linktoams eq "Y">
        	<cfset dts=replace(dts,'_i','_a','all')>
        </cfif>
        --->
		<cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#paydts#">
            SELECT empno, name, iname
            FROM pmast
            WHERE empno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR iname LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            ORDER BY name
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="#paydts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.empno')>
            <cfset matchedAccount["empno"]=evaluate('listMatchedAccount.empno')>
            <cfset matchedAccount["name"]=listMatchedAccount.name>
            <!---<cfset matchedAccount["iname"]=listMatchedAccount.iname>--->
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
        <cfset dts = trim(getdts.dts)>--->
        <!---<cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>--->
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#paydts#">
            SELECT empno, name, iname
            FROM pmast
            WHERE empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset matchedAccount["id"]=evaluate('getSelectedAccount.empno')>
        <cfset selectedAccount["empno"]=evaluate('getSelectedAccount.empno')>
        <cfset selectedAccount["name"]=evaluate('getSelectedAccount.name')>
        
        <!---iname is person honorific so its not important
        <cfset selectedAccount["iname"]=evaluate('getSelectedAccount.iname')>--->
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>