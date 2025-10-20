<cfcomponent>
    <cffunction name="listCustomer" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>       
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset custArray =ArrayNew(1)>
        
        
        <cfquery name="listCustomer" datasource="#dts#">
            SELECT custno,name FROM arcust 
            WHERE name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" /> 
             OR custno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            ORDER BY custno ASC 
            LIMIT #start#,#limit#;
        </cfquery>
        <cfquery name="getListCustomerLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS length
        </cfquery>	
        
        <cfloop query="listCustomer">
        	<cfset cust = StructNew() />
            <cfset cust['id'] = listCustomer.custno />
            <cfset cust['desp'] = listCustomer.name  />
        	<cfset ArrayAppend(custArray,cust) />
        </cfloop>
 
        <cfset output=StructNew()>
        <cfset output["total"]=getListCustomerLength.length>
        <cfset output["result"]=custArray>
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
            SELECT custno,name FROM arcust 
            WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
        </cfquery>
        
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["id"]=evaluate('getSelectedAccount.custno')>
        <cfset selectedAccount["desp"]=evaluate('getSelectedAccount.name')>
        <cfreturn selectedAccount>
        
    </cffunction>
    
</cfcomponent>