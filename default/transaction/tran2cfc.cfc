<cfcomponent>
	<cffunction name="getwsq" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        <cftry>
        <cfquery name="getwsqdts" datasource="#replace(dts,'_i','_a','all')#">
        SELECT wsq from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="P"
        </cfquery>
        <cfcatch>
        <cfquery name="getwsqdts" datasource="#dts#">
        SELECT wsq from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="P"
        </cfquery>
        </cfcatch>
        </cftry>
		<cfset myResult=getwsqdts.wsq>
		<cfreturn myResult>
	</cffunction>
    
    	<cffunction name="getdate1" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        <cftry>
        <cfquery name="getdatedts" datasource="#replace(dts,'_i','_a','all')#">
        SELECT detail5 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        <cfcatch>
        <cfquery name="getdatedts" datasource="#dts#">
        SELECT detail5 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        </cfcatch></cftry>
		<cfset myResult1=getdatedts.detail5>
		<cfreturn myResult1>
	</cffunction>
    
        	<cffunction name="getdate2" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        <cftry>
        <cfquery name="getdate2dts" datasource="#replace(dts,'_i','_a','all')#">
        SELECT detail6 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        <cfcatch>
        <cfquery name="getdate2dts" datasource="#dts#">
        SELECT detail6 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        </cfcatch></cftry>
		<cfset myResult2=getdate2dts.detail6>
		<cfreturn myResult2>
	</cffunction>
    
            	<cffunction name="getdate3" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        <cftry>
        <cfquery name="getdate3dts" datasource="#replace(dts,'_i','_a','all')#">
        SELECT detail7 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        <cfcatch>
        <cfquery name="getdate3dts" datasource="#dts#">
        SELECT detail7 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        
        </cfcatch></cftry>
		<cfset myResult3=getdate3dts.detail7>
		<cfreturn myResult3>
	</cffunction>
    
            	<cffunction name="getdate4" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="source" type="string" required="no">
        <cftry>
        <cfquery name="getdate4dts" datasource="#replace(dts,'_i','_a','all')#">
        SELECT detail8 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        <cfcatch>
        <cfquery name="getdate4dts" datasource="#dts#">
        SELECT detail8 from project where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#source#" > and porj ="J"
        </cfquery>
        </cfcatch></cftry>
		<cfset myResult4=getdate4dts.detail8>
		<cfreturn myResult4>
	</cffunction>
</cfcomponent>