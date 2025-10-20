<cfoutput>
<cfsetting showdebugoutput="yes">

<cfif isdefined('form.empfrom')>
	<cfset form.empfrom = trim(form.empfrom)>
</cfif>

<cfif isdefined('form.empto')>
	<cfset form.empto = trim(form.empto)>
</cfif>

<cfset dts_p=replace(dts,'_i', '_p')>

<cfquery name="gettimesheet" datasource="#dts_p#">
SELECT empno,status,count(pdate) as totaldays FROM timesheet
WHERE 1=1
	<cfif form.empfrom neq "" and form.empto neq "" >
     AND empno BETWEEN '#form.empfrom#' AND '#form.empto#'
    <cfelse>
        <cfif form.empfrom neq "">
            AND empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#">
        <cfelseif form.empto neq "">
            AND empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
        </cfif>
     </cfif>
     <cfif (isdefined('form.monthfrom') and form.monthfrom neq "") and (isdefined('form.monthto') and form.monthto neq "")>
     	AND month(pdate) BETWEEN <cfqueryparam cfsqltype="cf_sql_integer" value="#form.monthfrom#"> AND <cfqueryparam cfsqltype="cf_sql_integer" value="#form.monthto#">
     <cfelse>
     	<cfif form.monthfrom neq "">
     		AND month(pdate) = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.monthfrom#">
        <cfelseif form.monthto neq "">
        	AND month(pdate) = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.monthto#">
        </cfif>
     </cfif>
GROUP BY empno
</cfquery>

<!---<cfquery name="notsubmit" datasource="#dts_p#">
SELECT * FROM pmast
WHERE empno NOT IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#gettimesheet.empno#">)
</cfquery>--->

<h1></h1>

<table border="1" cellpadding="5" align="center">
	<tr>
    	<th>Employee No</th>
		<th>Employee Name</th>
        <th>Timesheet Status</th>
        <!---<th>Range of submission date</th>--->
        <th>Total days submitted</th>
    </tr>
    <cfif gettimesheet.recordcount eq 0>
    	<tr>
        	<td colspan="5">
            The selected employee does not submit timesheet
            </td>
        </tr>
    <cfelse>
        <cfloop query="gettimesheet">
            <cfquery name="getempname" datasource="#dts_p#">
            SELECT name FROM pmast 
            WHERE empno = 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettimesheet.empno#">
            </cfquery>            
            <tr>
            	<td>#gettimesheet.empno#</td>
                <td>#getempname.name#</td>
                <td>#gettimesheet.status#</td>
                <td>#gettimesheet.totaldays#</td>
            </tr>
        </cfloop>
    </cfif>
</table>
</cfoutput>