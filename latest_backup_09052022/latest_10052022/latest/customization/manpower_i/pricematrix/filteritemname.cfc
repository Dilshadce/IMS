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
            SELECT *  FROM (SELECT *  FROM (SELECT itemno as dballid,desp as dballname FROM icitem
            ORDER by itemno) as a
                    union all
                    SELECT *  FROM (
                    SELECT concat("B-",cate) as dballid, desp as dballname FROM iccate
                    order by cate
                    ) as b
                    union all
                    SELECT *  FROM (
                    SELECT
                    concat("A-",shelf) as dballid, desp as dballname from icshelf
                    order by length(shelf),shelf
                    ) as c
                    union all
                    SELECT *  FROM (
                    SELECT
                    'ALLAWEXC' as dballid, 'All AW EXCEPT 0%' as dballname
                    ) as e
            )as d   
             WHERE (dballname LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR dballid LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)         
            GROUP BY dballid
            ORDER BY dballname
            <!---SELECT itemno as dballid,desp as dballname
            FROM icitem
            WHERE itemno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR desp LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            ORDER BY itemno--->
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.dballid')>
            <cfset matchedAccount["dballid"]=evaluate('listMatchedAccount.dballid')>
            <cfset matchedAccount["dballname"]=listMatchedAccount.dballname>
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
            SELECT *  FROM (SELECT itemno as dballid,desp as dballname FROM icitem 
            WHERE itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />) as a
                                            union all
                                            SELECT *  FROM (
                                            SELECT concat("B-",cate) as dballid, desp as dballname FROM iccate
                                            WHERE (concat("B-",cate) =<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
                                            ) as b
                                            union all
                                            SELECT *  FROM (
                                            SELECT
                                            concat("A-",shelf) as dballid, desp as dballname from icshelf
                                            WHERE (concat("A-",shelf) =<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
                                            ) as c
            <!---SELECT itemno as dballid,desp as dballname
            FROM icitem
            WHERE itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />;--->
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["dballid"]=evaluate('getSelectedAccount.dballid')>
        <cfset selectedAccount["dballid"]=evaluate('getSelectedAccount.dballid')>
        <cfset selectedAccount["dballname"]=evaluate('getSelectedAccount.dballname')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>