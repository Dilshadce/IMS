<cfcomponent>
    <cffunction name="getempno" access="remote" returntype="string">
    	<cfargument name="placementno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT empno FROM placement where placementno='#placementno#'
        </cfquery>
        <cfset varval = gettermsqry.empno>
		<cfreturn varval>
	</cffunction>
    
     <cffunction name="getstartdate" access="remote" returntype="string">
    	<cfargument name="placementno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT startdate FROM placement where placementno='#placementno#'
        </cfquery>
        <cfset varval = dateformat(gettermsqry.startdate,'DD/MM/YYYY')>
		<cfreturn varval>
	</cffunction>
    
     <cffunction name="getcompletedate" access="remote" returntype="string">
    	<cfargument name="placementno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT completedate FROM placement where placementno='#placementno#'
        </cfquery>
        <cfset varval = dateformat(gettermsqry.completedate,'DD/MM/YYYY')>
		<cfreturn varval>
	</cffunction>
	
     <cffunction name="getusualpay" access="remote" returntype="string">
    	<cfargument name="placementno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT usualpayrate FROM placement where placementno='#placementno#'
        </cfquery>
        <cfset varval = gettermsqry.usualpayrate>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="clientrate" access="remote" returntype="string">
    	<cfargument name="placementno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT clientrate FROM placement where placementno='#placementno#'
        </cfquery>
        <cfset varval = gettermsqry.clientrate>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getcustno" access="remote" returntype="string">
    	<cfargument name="placementno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT custno FROM placement where placementno='#placementno#'
        </cfquery>
        <cfset varval = gettermsqry.custno>
		<cfreturn varval>
	</cffunction>

	<cffunction name="getcustname" access="remote" returntype="string">
    	<cfargument name="custno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#replace(dts,'_i','_a','all')#">
            SELECT name FROM arcust where custno='#custno#'
        </cfquery>
        <cfset varval = gettermsqry.name>
		<cfreturn varval>
	</cffunction>
    
	
    
</cfcomponent>