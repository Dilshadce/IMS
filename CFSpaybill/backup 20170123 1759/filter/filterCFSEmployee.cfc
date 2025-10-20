<cfcomponent>
    <cffunction name="listEmployee" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>       
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset empArray =ArrayNew(1)>
        
        
        <cfquery name="listEmployee" datasource="#dts#">
            SELECT id,icno,name,name2 FROM cfsemp 
            WHERE name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            
            ORDER BY id ASC 
            LIMIT #start#,#limit#;
        </cfquery>
        <cfquery name="getlistEmployeeLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS length
        </cfquery>	
        
        <cfloop query="listEmployee">
        	<cfset employee = StructNew() />
            <cfset employee['id'] = listEmployee.icno />
            <cfset employee['desp'] = listEmployee.name & ' ' & listEmployee.name2 />
        	<cfset ArrayAppend(empArray,employee) />
        </cfloop>
 
        <cfset output=StructNew()>
        <cfset output["total"]=getlistEmployeeLength.length>
        <cfset output["result"]=empArray>
        <cfreturn output>
    </cffunction>
    
</cfcomponent>