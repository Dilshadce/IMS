<cfif isdefined('url.assignmenttype')>
<cfquery name="checkentity" datasource="#dts#">
SELECT location,jobpostype,custno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">
</cfquery>


<cfquery name="getlastno" datasource="#dts#">
SELECT invnogroup FROM bo_jobtypeinv WHERE officecode = "#checkentity.location#" 
AND jobtype = "#checkentity.jobpostype#"
</cfquery>

<cfquery name="getlastusedno" datasource="#dts#">
SELECT lastusedno FROM invaddress WHERE 
invnogroup = "#getlastno.invnogroup#"
</cfquery>


<cfif url.assignmenttype neq "invoice">
<cfquery datasource="#dts#" name="getlastusedno">
            select lastUsedNo 
            from refnoset
            where type = 'INV'
            and counter = 2
            </cfquery>
</cfif>
<cfset refno = getlastusedno.lastusedno>
	<cfif url.assignmenttype eq "invoice">
    <cfset prefix = "M">
    <cfset counter = 2>
    <cfset refnolen = 8>
    <cfelseif url.assignmenttype neq "invoice">
    <cfset prefix = "S">
     <cfset counter = 2>
    <cfset refnolen = 8>
  <cfelse>
    <cfset prefix = "E">
    <cfset counter = 1>
    <cfset refnolen = 8>
    </cfif>
    
<cfquery name="company_details" datasource="payroll_main">
SELECT mmonth,myear FROM gsetup WHERE comp_id = "#replace(dts,'_i','')#"
</cfquery>   
        
<cfif isdefined('url.refno')>
	<cfif left(url.refno,1) neq prefix >
    
<!---     <cfquery datasource="#dts#" name="getGeneralInfo">
            select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
            from refnoset
            where type = 'INV'
            and counter = #counter#
            </cfquery> --->



<cftry>
	<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
<cfcatch>
	<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
</cfcatch>
</cftry>

 <cfif url.assignmenttype neq "invoice">           
<cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
<cfelse>
<cfset refno = refnonew>
</cfif>

<cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='INV' and refno = "#refno#"
</cfquery>

<cfif checkexistrefno.recordcount eq 0>
<cfquery name="checkexistrefno" datasource="#dts#">
SELECT refno FROM assignmentslip WHERE refno = "#refno#"
</cfquery>
</cfif>

<cfif checkexistrefno.recordcount neq 0>
<cfset refnocheck = 0>

<cfloop condition="refnocheck eq 0">

    <cftry>
    <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
    <cfcatch>
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refnonew" />	
    </cfcatch>
    </cftry>
     <cfif url.assignmenttype neq "invoice">
    <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
    <cfelse>
    <cfset refno = refnonew>
    </cfif>

    <cfquery name="checkexistrefno" datasource="#dts#">
    select refno from artran where type='INV' and refno = "#refno#"
    </cfquery>
    
    <cfif checkexistrefno.recordcount eq 0>
    <cfquery name="checkexistrefno" datasource="#dts#">
    SELECT refno FROM assignmentslip WHERE refno = "#refno#"
    </cfquery>
    </cfif>

	<cfif checkexistrefno.recordcount eq 0>
    <cfset refnocheck = 1>
    </cfif>
</cfloop>                

</cfif>

<cfoutput>
    <input type="hidden" name="getrefno" id="getrefno" value="#refno#">
    </cfoutput>
   	<cfelse>     
	<cfoutput>
    <input type="hidden" name="getrefno" id="getrefno" value="#url.refno#">
    </cfoutput>
    </cfif>
<cfelse>
<cfif url.assignmenttype neq "invoice">
<cfquery datasource="#dts#" name="getGeneralInfo">
            select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
            from refnoset
            where type = 'INV'
            and counter = #counter#
            </cfquery>

<cfset refno = getGeneralInfo.tranno>
</cfif>

<cftry>
	<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
<cfcatch>
	<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
</cfcatch>
</cftry>

            <cfif url.assignmenttype neq "invoice">
<cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
<cfelse>
<cfset refno = refnonew>
</cfif>

<cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='INV' and refno = "#refno#"
</cfquery>

<cfif checkexistrefno.recordcount eq 0>
<cfquery name="checkexistrefno" datasource="#dts#">
SELECT refno FROM assignmentslip WHERE <!--- right(refno,5)=<cfqueryparam cfsqltype="cf_sql_varchar" value="#right(refno,5)#"> and length(refno) = "#refnolen#" and left(refno,#len(prefix)#) = "#prefix#" --->
refno = "#refno#"
</cfquery>
</cfif>

<cfif checkexistrefno.recordcount neq 0>
<cfset refnocheck = 0>

<cfloop condition="refnocheck eq 0">

    <cftry>
    <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
    <cfcatch>
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
    </cfcatch>
    </cftry>
  <cfif url.assignmenttype neq "invoice">  
    <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
    <cfelse>
    <cfset refno = refnonew>
</cfif>
    <cfquery name="checkexistrefno" datasource="#dts#">
    select refno from artran where type='INV' and refno = "#refno#"
    </cfquery>
    
    <cfif checkexistrefno.recordcount eq 0>
    <cfquery name="checkexistrefno" datasource="#dts#">
    SELECT refno FROM assignmentslip WHERE refno = "#refno#"
    </cfquery>
    </cfif>

	<cfif checkexistrefno.recordcount eq 0>
    <cfset refnocheck = 1>
    </cfif>
</cfloop>                

</cfif>

<cfoutput>
<input type="hidden" name="getrefno" id="getrefno" value="#refno#">
</cfoutput>
</cfif>
</cfif>