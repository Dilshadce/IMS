<cfcomponent>
    
    <cffunction name="getvehicle" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        <cfargument name="custno" type="string">
        
        	<cfquery name="getvehicleqry" datasource="#dts#">
            select rem5 from artran where custno='#custno#'
            </cfquery>
            
            <cfreturn getvehicleqry>
	</cffunction>
    
    
</cfcomponent>