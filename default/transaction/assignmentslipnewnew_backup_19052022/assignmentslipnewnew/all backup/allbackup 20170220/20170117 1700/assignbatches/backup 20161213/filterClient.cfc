<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="any">
        <!---<cfset dts=form.dts>--->
        
   		<cfset dts = "manpower_i">       
        <cfset Hitemgroup=form.Hitemgroup>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset matchedAccountList=ArrayNew(1)>
        
        <cfquery name="listMatchedAccount" datasource="#dts#">
           SELECT custno,name 
           FROM arcust 
		   ORDER BY name
           LIMIT #start#,#limit#;
        </cfquery>

        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>	
        
		<!---<cfset returnvalue = '{"total" : #getMatchedAccountLength.matchedAccountLength#, "result" : ['>  --->
        
        <cfloop query="listMatchedAccount">
            <!---<cfif GetAuthUser() neq "ultracai">--->
				<cfset matchedAccount=StructNew()>
                <cfset matchedAccount["custno"]=listMatchedAccount.custno>
                <cfset matchedAccount["name"]=listMatchedAccount.name>
                <cfset ArrayAppend(matchedAccountList,matchedAccount)>	
            <!---<cfelse>
				<cfset returnvalue = returnvalue & '{"id":"#listMatchedAccount.itemNo#","desp":"#evaluate('listMatchedAccount.desp')#","itemNo":"#listMatchedAccount.itemNo#"},'>		            </cfif> --->    
        </cfloop>
        
        <!--- <cfif GetAuthUser() neq "ultracai">--->
			<cfset output=StructNew()>
            <cfset output["total"]=getMatchedAccountLength.matchedAccountLength>
            <cfset output["result"]=matchedAccountList>
            <cfreturn output>
        <!---<cfelse>
			<cfset returnvalue = Left(returnvalue, len(returnvalue)-1) & ']}'>
			<cfreturn returnvalue>
		</cfif> --->
    </cffunction>
    
    <cffunction name="getSelectedAccount" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <!---<cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>--->
   		<cfset dts = "manpower_i">       
        <cfset Hitemgroup=form.Hitemgroup>
        <cfset value=form.value>
        
        <cfquery name="getSelectedAccount" datasource="#dts#">
            SELECT custno,name 
            FROM arcust 
            WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
        </cfquery>       

        <!--- <cfif GetAuthUser() neq "ultracai"> --->
        <cfset selectedAccount=StructNew()>
        <cfset selectedAccount["custno"]=getSelectedAccount.custno>
        <cfset selectedAccount["name"]=getSelectedAccount.name>
        <cfreturn selectedAccount>
        <!--- <cfelse>
			<cfset returnvalue = '{"id":"#getSelectedAccount.itemNo#", "itemNo" :"#getSelectedAccount.itemNo#","desp":"#getSelectedAccount.desp#"'>---
            <cfreturn returnvalue>  
        </cfif> --->       
    </cffunction>
</cfcomponent>