<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
        <cfset term=trim(form.term)>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT po_no
            FROM placement
            WHERE po_no LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            GROUP BY po_no
            LIMIT #start#,#limit#;
        </cfquery>
                
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=evaluate('listMatchedAccount.po_no')>
            <cfset matchedAccount["po_no"]=evaluate('listMatchedAccount.po_no')>
            <cfset ArrayAppend(matchedAccountList,matchedAccount)>
        </cfloop>
        <cfset output=StructNew()>
        <cfset output["total"]=getMatchedAccountLength.matchedAccountLength>
        <cfset output["result"]=matchedAccountList>
        <cfreturn output>
    </cffunction>
    
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT po_no
            FROM placement
            WHERE placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.po_no')>
        <cfset selectedAccount["po_no"]=evaluate('getSelectedAccount.po_no')>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>