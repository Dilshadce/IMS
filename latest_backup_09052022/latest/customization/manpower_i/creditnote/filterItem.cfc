<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
        <cfset term=form.term>
        <cfset limit=form.limit>
		<cfset itemno=form.itemno>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT *  FROM (SELECT *  FROM (SELECT itemno,desp FROM icitem
            ORDER by itemno) as a
                                            union all
                                            SELECT *  FROM (
                                            SELECT cate as itemno, desp FROM iccate
                                            order by cate
                                            ) as b
                                            union all
                                            SELECT *  FROM (
                                            SELECT
                                            shelf as itemno, desp from icshelf
            								order by length(shelf),shelf
                                            ) as c
            )as d   
             WHERE (itemno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR desp LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)         
            GROUP BY itemno
            ORDER BY desp
            LIMIT #start#,#limit#
        </cfquery>
        
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.itemno')>
            <cfset matchedAccount["itemno"]=evaluate('listMatchedAccount.itemno')>
            <cfset matchedAccount["desp"]=evaluate('listMatchedAccount.desp')>
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
             SELECT *  FROM (SELECT itemno,desp FROM icitem 
            WHERE itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />) as a
                                            union all
                                            SELECT *  FROM (
                                            SELECT cate as itemno, desp FROM iccate
                                            WHERE (cate =<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
                                            ) as b
                                            union all
                                            SELECT *  FROM (
                                            SELECT
                                            shelf as itemno, desp from icshelf
                                            WHERE (shelf =<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
                                            ) as c
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset matchedAccount["id"]=evaluate('listMatchedAccount.itemno')>
        <cfset matchedAccount["itemno"]=evaluate('listMatchedAccount.itemno')>
        <cfset matchedAccount["desp"]=evaluate('listMatchedAccount.desp')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>