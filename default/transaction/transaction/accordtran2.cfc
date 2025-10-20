<cfcomponent>
	<cffunction name="getremark6" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="carno" type="string" required="no">
        
        <cfquery name="getncd" datasource="#dts#">
        SELECT ncd from vehicles where carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#carno#" >
        </cfquery>
        
		<cfset myResult=getncd.ncd>
		<cfreturn myResult>
	</cffunction>
    
    	<cffunction name="getremark7" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="carno" type="string" required="no">
        
        <cfquery name="getscheme" datasource="#dts#">
        SELECT scheme from vehicles where carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#carno#" >
        </cfquery>
        
		<cfset myResult2=getscheme.scheme>
		<cfreturn myResult2>
	</cffunction>
    
    	<cffunction name="getremark8" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="carno" type="string" required="no">
        
        <cfquery name="getcoverage" datasource="#dts#">
        SELECT coveragetype from vehicles where carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#carno#" >
        </cfquery>
        
		<cfset myResult3=getcoverage.coveragetype>
		<cfreturn myResult3>
	</cffunction>
    
    	<cffunction name="getremark9" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="carno" type="string" required="no">
        
        <cfquery name="getcommission" datasource="#dts#">
        SELECT commission from vehicles where carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#carno#" >
        </cfquery>
        
		<cfset myResult4=getcommission.commission>
		<cfreturn myResult4>
	</cffunction>
    
    	<cffunction name="getremark10" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="carno" type="string" required="no">
        
        <cfquery name="getexcess" datasource="#dts#">
        SELECT excess from vehicles where carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#carno#" >
        </cfquery>
        <cfif getexcess.excess eq ''>
        <cfset excess1='SGD $'>
        <cfelse>
        <cfset excess1=getexcess.excess>
        </cfif>
		<cfset myResult5=excess1>
		<cfreturn myResult5>
	</cffunction>
    
        	<cffunction name="getremark11" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="carno" type="string" required="no">
        
        <cfquery name="getsuminsured" datasource="#dts#">
        SELECT financecom from vehicles where carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#carno#" >
        </cfquery>
        
		<cfset myResult6=getsuminsured.financecom>
		<cfreturn myResult6>
	</cffunction>
    
    <cffunction name="getremark13" access="remote" returntype="string">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="carno" type="string" required="no">
        
        <cfquery name="getcom" datasource="#dts#">
        SELECT com from vehicles where carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#carno#" >
        </cfquery>
        
		<cfset myResult7=getcom.com>
		<cfreturn myResult7>
	</cffunction>
    
</cfcomponent>