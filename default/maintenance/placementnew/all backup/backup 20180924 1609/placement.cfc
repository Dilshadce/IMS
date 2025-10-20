<cfcomponent>
	<cffunction name="getname" access="remote" returntype="string">
    	<cfargument name="custno" type="string" required="yes">
        <cfargument name="target_arcust" type="string">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT name FROM #target_arcust# where custno='#custno#'
        </cfquery>
        <cfset varval = gettermsqry.name>
		<cfreturn varval>
	</cffunction>
	
    <cffunction name="getbillto" access="remote" returntype="string">
    	<cfargument name="custno" type="string" required="yes">
        <cfargument name="target_arcust" type="string">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT attn FROM #target_arcust# where custno='#custno#'
        </cfquery>
        <cfset varval = gettermsqry.attn>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getcontact" access="remote" returntype="string">
    	<cfargument name="custno" type="string" required="yes">
        <cfargument name="target_arcust" type="string">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT contact FROM #target_arcust# where custno='#custno#'
        </cfquery>
        <cfset varval = gettermsqry.contact>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getarea" access="remote" returntype="string">
    	<cfargument name="custno" type="string" required="yes">
        <cfargument name="target_arcust" type="string">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT area FROM #target_arcust# where custno='#custno#'
        </cfquery>
        <cfset varval = gettermsqry.area>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getenduser" access="remote" returntype="string">
    	<cfargument name="custno" type="string" required="yes">
        <cfargument name="target_arcust" type="string">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT end_user FROM #target_arcust# where custno='#custno#'
        </cfquery>
        <cfset varval = gettermsqry.end_user>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getposition" access="remote" returntype="string">
    	<cfargument name="jobcode" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT name FROM driver where driverno='#jobcode#'
        </cfquery>
        <cfset varval = gettermsqry.name>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getnric" access="remote" returntype="string">
    	<cfargument name="empno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfargument name="dts1" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT nric FROM #dts1#.pmast where empno='#empno#'
        </cfquery>
        <cfset varval = gettermsqry.nric>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getsex" access="remote" returntype="string">
    	<cfargument name="empno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfargument name="dts1" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT sex FROM #dts1#.pmast where empno='#empno#'
        </cfquery>
        <cfset varval = gettermsqry.sex>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getbpay" access="remote" returntype="string">
    	<cfargument name="empno" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfargument name="dts1" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT brate FROM #dts1#.paytran where empno='#empno#'
        </cfquery>
        <cfset varval = gettermsqry.brate>
		<cfreturn varval>
	</cffunction>
	
    <cffunction name="getdate" access="remote" returntype="string">
    	<cfargument name="empno" type="string" required="yes">
        <cfargument name="project" type="string" required="yes">
        <cfargument name="dts" type="string">
        <cfargument name="dts1" type="string">
        <cfquery name="gettermsqry" datasource="#dts#">
            SELECT date_p FROM #dts1#.proj_rcd where empno='#empno#' and project_code='#project#'
        </cfquery>
        <cfset varval = dateformat(gettermsqry.date_p,'DD/MM/YYYY')>
		<cfreturn varval>
	</cffunction>
    
    
	
    
</cfcomponent>