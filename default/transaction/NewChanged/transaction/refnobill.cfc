<cfcomponent>
    <cffunction name="getrefnoset" access="remote" returntype="query">
		<cfargument name="ft" type="string" required="yes">
        <cfargument name="dts" type="string" required="yes">
        
		<cfif ft eq "INV" or ft eq "">
        <cfset validset = "invoneset">
        <cfelse>
        <cfset validset = ft&"_oneset">
		</cfif>
        
        <cfquery name="validset" datasource="#dts#">
        SELECT #validset# as oneset from gsetup
        </cfquery>
        
        <cfquery datasource="#dts#" name="getset">
			select counter,concat(counter," - ",lastusedno) as lastno
            from refnoset
			where type = '#ft#'
            <cfif validset.oneset eq 1>
            and counter = 1
			</cfif>
             order by counter
		</cfquery>
        
		<cfreturn getset>
	</cffunction>
</cfcomponent>