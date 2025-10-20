<cfcomponent>
	<cffunction name="getlist" access="remote" returntype="query">
		<cfargument name="tran" type="string" required="yes">
        <cfargument name="target_arcust" type="string">
        <cfargument name="target_apvend" type="string">
        <cfargument name="dts" type="string">
        
        <cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
      		<cfquery name="getcust" datasource="#dts#">
            	Select "Please Select a Supplier" as custname, "" as custno
                union all
        		Select concat(custno,'--',name) as custname,custno from #target_apvend# order by custno
      		</cfquery>
    	<cfelse>
      		<cfquery name="getcust" datasource="#dts#">
            	Select "Please Select a Customer" as custname,"" as custno
                union all
        		Select concat(custno,'--',name) as custname,custno from #target_arcust# order by custno
      		</cfquery>
    	</cfif>

		<cfreturn getcust>
	</cffunction>
    
    <cffunction name="getname" access="remote" returntype="string">
		<cfargument name="tran" type="string" required="yes">
        <cfargument name="target_arcust" type="string">
        <cfargument name="target_apvend" type="string">
        <cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
        <cfset varval = target_apvend>
		<cfelse>
        <cfset varval = target_arcust>
		</cfif>
		<cfreturn varval>
	</cffunction>
    
    <cffunction name="getagent" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        <cfargument name="Hlinkams" type="string">
		<cfif Hlinkams eq 'Y'>
        	<cfquery name="getagentqry" datasource="#replace(dts,'_i','_a','all')#">
            SELECT "Please select an agent" as agentdesp, "" as agent
            union all
            SELECT concat(agent,' - ',desp) as agentdesp, agent FROM icagent
            </cfquery>
        <cfelse>
        	<cfquery name="getagentqry" datasource="#dts#">
            SELECT "Please select an agent" as agentdesp, "" as agent
            union all
            SELECT concat(agent,' - ',desp) as agentdesp, agent FROM icagent
            </cfquery>
        </cfif>
            <cfreturn getagentqry>
	</cffunction>
    
    <cffunction name="getterms" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        <cfargument name="target_icterm" type="string">
        	<cfquery name="gettermsqry" datasource="#dts#">
            SELECT "Please select a terms" as termdesp, "" as term
            union all 
            SELECT concat(term,' - ',desp) as termdesp, term FROM #target_icterm#
            </cfquery>
            
            <cfreturn gettermsqry>
	</cffunction>
    
    <cffunction name="getproject" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        <cfargument name="Hlinkams" type="string">
		<cfif Hlinkams eq 'Y'>
        	<cfquery name="getprojectqry" datasource="#replace(dts,'_i','_a','all')#">
            SELECT "Choose a Project" as projectdesp, "" as source
            union all 
            SELECT concat(source,' - ',project) as projectdesp, source FROM project where porj = "P"
            </cfquery>
        <cfelse>
        	<cfquery name="getprojectqry" datasource="#dts#">
            SELECT "Choose a Project" as projectdesp, "" as source
            union all 
            SELECT concat(source,' - ',project) as projectdesp, source FROM project where porj = "P"
            </cfquery>
        </cfif>
            <cfreturn getprojectqry>
	</cffunction>
    
    <cffunction name="getjob" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        <cfargument name="Hlinkams" type="string">
		<cfif Hlinkams eq 'Y'>
        <cfquery name="getjobqry" datasource="#replace(dts,'_i','_a','all')#">
            SELECT "Choose a Job" as jobdesp, "" as source
            union all 
            SELECT concat(source,' - ',project) as jobdesp, source FROM project where porj = "J"
            </cfquery>
        <cfelse>
        	<cfquery name="getjobqry" datasource="#dts#">
            SELECT "Choose a Job" as jobdesp, "" as source
            union all 
            SELECT concat(source,' - ',project) as jobdesp, source FROM project where porj = "J"
            </cfquery>
        </cfif>
            <cfreturn getjobqry>
	</cffunction>
    
    <cffunction name="geteu" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        
        	<cfquery name="geteuqry" datasource="#dts#">
            SELECT "Choose an End User" as eudesp, "" as DRIVERNO
            union all 
            SELECT concat(driverno,' - ',name) as eudesp, driverno FROM driver
            </cfquery>
            
            <cfreturn geteuqry>
	</cffunction>
    
    <cffunction name="getcurr" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        <cfargument name="target_currency" type="string">
        	<cfquery name="getcurrqry" datasource="#dts#">
            SELECT "Choose a Currency" as currdesp, "" as currcode
            union all 
            SELECT concat(currcode,' - ',currency) as currdesp, currcode FROM #target_currency#
            </cfquery>
            
            <cfreturn getcurrqry>
	</cffunction>
    
    <cffunction name="getcurrrate" access="remote" returntype="string">
        <cfargument name="dts" type="string">
        <cfargument name="curr" type="string">
        <cfargument name="target_currency" type="string">
        <cfargument name="wos_date" type="string">
        	<cfquery name="getcurrqry" datasource="#dts#">
            SELECT * FROM #target_currency# where currcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#curr#" >
            </cfquery>
            <cfset ndate = createdate(right(wos_date,4),mid(wos_date,4,2),left(wos_date,2))>
            <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
            <cfif val(fperiod) gt 18 or val(fperiod) lte 0>
					<cfset rate2 = getcurrqry.currrate>
				<cfelse>
					<cfset counter = val(fperiod)>
					<cfset rate2 = Evaluate("getcurrqry.currp#counter#")>
				</cfif>
            
            <cfset returnval = #numberformat(rate2,'.___')#>
            <cfreturn returnval>
	</cffunction>
    
</cfcomponent>