
<cfif form.customerFrom neq "" and form.customerTo neq "">
    AND custno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerFrom#">
    AND custno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerTo#">    
</cfif>

<cfif form.billFrom neq "" and form.billTo neq "">
    AND refno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billFrom#">
    AND refno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billTo#">    
</cfif>

<cfif form.driverFrom neq "" and form.driverTo neq "">
    AND driverno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.driverFrom#">
    AND driverno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.driverTo#">    
</cfif>

<cfif form.periodFrom neq "" and form.periodTo neq "">
    AND fperiod >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodFrom#">
    AND fperiod <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodTo#">    
</cfif>

<cfif form.dateFrom neq "" and form.dateTo neq "">
	<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
        <cfset dd = dateformat(form.datefrom, "DD")>
        <cfif dd greater than '12'>
            <cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
        <cfelse>
            <cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
        </cfif>
    
        <cfset dd = dateformat(form.dateto, "DD")>
        <cfif dd greater than '12'>
            <cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
        <cfelse>
            <cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
        </cfif>
    </cfif>
    
    AND wos_date >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndatefrom#">
    AND wos_date <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndateto#">   
</cfif>