<cfcomponent>
    <cffunction name="getbomno" access="remote" returntype="any">
		<cfargument name="itemno" type="string" required="yes">
        <cfargument name="dts" type="string" required="yes">
        
        <cfquery name="getlastbomno" datasource="#dts#">
        	SELECT max(bomno) as bomno from billmat where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
        </cfquery>
        
        <cfif getlastbomno.bomno eq 0>
        <cfset xbomno="001">
        <cfelse>
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#getlastbomno.bomno#" returnvariable="xbomno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastbomno.bomno#" returnvariable="xbomno" />	
		</cfcatch>
        </cftry>
        </cfif>
        
        
		<cfreturn xbomno>
	</cffunction>
</cfcomponent>