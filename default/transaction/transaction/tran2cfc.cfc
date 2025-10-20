<cfcomponent>
	<cffunction name="getwsq" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        
        <cfquery name="getwsqdts" datasource="#dts#">
        SELECT wsq FROM #target_project# where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="P"
        </cfquery>
		<cfset myResult=getwsqdts.wsq>
		<cfreturn myResult>
	</cffunction>
    
    	<cffunction name="getdate1" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        
        <cfquery name="getdatedts" datasource="#dts#">
        SELECT detail5 FROM #target_project# where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
		<cfset myResult1=getdatedts.detail5>
		<cfreturn myResult1>
	</cffunction>
    
        	<cffunction name="getdate2" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        
        <cfquery name="getdate2dts" datasource="#dts#">
        SELECT detail6 FROM #target_project# where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
		<cfset myResult2=getdate2dts.detail6>
		<cfreturn myResult2>
	</cffunction>
    
            	<cffunction name="getdate3" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        
        <cfquery name="getdate3dts" datasource="#dts#">
        SELECT detail7 FROM #target_project# where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
		<cfset myResult3=getdate3dts.detail7>
		<cfreturn myResult3>
	</cffunction>
    
            	<cffunction name="getdate4" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        
        <cfquery name="getdate4dts" datasource="#dts#">
        SELECT detail8 FROM #target_project# where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
		<cfset myResult4=getdate4dts.detail8>
		<cfreturn myResult4>
	</cffunction>
</cfcomponent>