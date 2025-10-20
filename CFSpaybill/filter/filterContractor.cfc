<cfcomponent>
    <cffunction name="listContractor" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>       
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset conArray =ArrayNew(1)>
        
        
        <cfquery name="listContractor" datasource="#dts#">
            SELECT id,name FROM cfsemp 
            WHERE name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" /> 
            ORDER BY name ASC 
            LIMIT #start#,#limit#;
        </cfquery>
        <cfquery name="getListContractorLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS length
        </cfquery>	
        
        <cfloop query="listContractor">
        	<cfset con = StructNew() />
            <cfset con['id'] = listContractor.id />
            <cfset con['name'] = listContractor.name  />
        	<cfset ArrayAppend(conArray,con) />
        </cfloop>
 
        <cfset output=StructNew()>
        <cfset output["total"]=getListContractorLength.length>
        <cfset output["result"]=conArray>
        <cfreturn output>
    </cffunction>
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
		<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts,linktoams FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfif getdts.linktoams eq "Y">
        <cfset dts=replace(dts,'_i','_a','all')>
        </cfif>
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT id,name FROM cfsemp 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.id')>
        <cfset selectedAccount["name"]=evaluate('getSelectedAccount.name')>
        <cfreturn selectedAccount>
        
    </cffunction>
    
</cfcomponent>