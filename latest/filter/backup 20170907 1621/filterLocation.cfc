<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">
       <!--- <cfset dts=form.dts>--->
       <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>       
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        <cfif isdefined('form.huserloc')>
        <cfset huserloc=form.huserloc>
        <cfelse>
        <cfset huserloc="All_loc">
        </cfif>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
            SELECT location AS location, desp AS desp
            FROM iclocation
            WHERE (location LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR desp LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)
            <cfif Huserloc neq "All_loc">
				AND location IN (#ListQualify(Huserloc,"'",",")#)
			</cfif>
            ORDER BY location
            LIMIT #start#,#limit#;
        </cfquery>
        
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
        <cfloop query="listMatchedAccount">
            <cfset matchedAccount=StructNew()>
            <cfset matchedAccount["id"]=listMatchedAccount.location>
            <cfset matchedAccount["location"]=listMatchedAccount.location>
            <cfset matchedAccount["desp"]=listMatchedAccount.desp>
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
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT location AS location, desp AS desp
            FROM iclocation
            WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
            <cfif Huserloc neq "All_loc">
				AND location IN (#ListQualify(Huserloc,"'",",")#)
			</cfif>
            ;
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset matchedAccount["id"]=getSelectedAccount.location>
        <cfset selectedAccount["location"]=getSelectedAccount.location>
        <cfset selectedAccount["desp"]=getSelectedAccount.desp>
        <cfreturn selectedAccount>
        
    </cffunction>
</cfcomponent>