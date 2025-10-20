<cfcomponent>
	<cffunction name="getTax" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="taxtable" type="string" required="yes">
        <cfargument name="taxcode" type="string">
        
        <cfquery name="taxrate" datasource="#dts#">
        SELECT rate1 FROM #taxtable# WHERE code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxcode#">
        </cfquery>
		<cfset myResult=val(taxrate.rate1) * 100>
		<cfreturn myResult>
	</cffunction>
</cfcomponent>