<cfif isdefined('url.assignmenttype')>

	<cfif url.assignmenttype eq "invoice">
    <cfset prefix = "M">
    <cfelseif url.assignmenttype eq "sinvoice">
    <cfset prefix = "S">
    <cfelse>
    <cfset prefix = "E">
    </cfif>
    
<cfif isdefined('url.refno')>
	<cfif left(url.refno,1) neq prefix >
    
    	<cfquery name="company_details" datasource="payroll_main">
            SELECT mmonth,myear FROM gsetup WHERE comp_id = "#replace(dts,'_i','')#"
        </cfquery>
    	
        <cfquery name="getmaxrefno" datasource="#dts#">
        SELECT max(substring(refno,4,4)) as monthlyrefno FROM assignmentslip WHERE left(refno,1) = "#prefix#" and month(assignmentslipdate) = "#val(company_details.mmonth)#" and year(assignmentslipdate) = "#val(company_details.myear)#"
    	</cfquery>
        
        <cfif getmaxrefno.monthlyrefno eq "">
			<cfset monthlyrefno = "0001">
        <cfelse>
            <cfset monthlyrefno = getmaxrefno.monthlyrefno>
        </cfif>
        
        <cftry>
            <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#monthlyrefno#" returnvariable="monthlyrefnonew"/>
        <cfcatch>
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#monthlyrefno#" returnvariable="monthlyrefnonew" />	
        </cfcatch>
        </cftry>
        
	<cfset finalrefno = prefix&numberformat(company_details.mmonth,'00')&numberformat(monthlyrefnonew,'0000')&right(url.refno,5)>
    <cfoutput>
    <input type="hidden" name="getrefno" id="getrefno" value="#finalrefno#">
    </cfoutput>
   	<cfelse>     
	<cfoutput>
    <input type="hidden" name="getrefno" id="getrefno" value="#url.refno#">
    </cfoutput>
    </cfif>
<cfelse>
<cfquery name="getrunning" datasource="#dts#">
	SELECT refnoall FROM gsetup
</cfquery>

<cfquery name="company_details" datasource="payroll_main">
	SELECT mmonth,myear FROM gsetup WHERE comp_id = "#replace(dts,'_i','')#"
</cfquery>

<cfquery name="getmaxrefno" datasource="#dts#">
	SELECT max(substring(refno,4,4)) as monthlyrefno FROM assignmentslip WHERE left(refno,1) = "#prefix#" and month(assignmentslipdate) = "#val(company_details.mmonth)#" and year(assignmentslipdate) = "#val(company_details.myear)#"
</cfquery>

<cfif getmaxrefno.recordcount eq 0>
	<cfset monthlyrefno = "0001">
<cfelse>
	<cfset monthlyrefno = getmaxrefno.monthlyrefno>
</cfif>
      
<cftry>
	<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#monthlyrefno#" returnvariable="monthlyrefnonew"/>
<cfcatch>
	<cfinvoke component="cfc.refno" method="processNum" oldNum="#monthlyrefno#" returnvariable="monthlyrefnonew" />	
</cfcatch>
</cftry>

<cftry>
	<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#getrunning.refnoall#" returnvariable="refnonew"/>
<cfcatch>
	<cfinvoke component="cfc.refno" method="processNum" oldNum="#getrunning.refnoall#" returnvariable="refnonew" />	
</cfcatch>
</cftry>

<cfset finalrefno = prefix&numberformat(company_details.mmonth,'00')&numberformat(monthlyrefnonew,'0000')&numberformat(refnonew,'00000')>
<cfoutput>
<input type="hidden" name="getrefno" id="getrefno" value="#finalrefno#">
</cfoutput>
</cfif>
</cfif>