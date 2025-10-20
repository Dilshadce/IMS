<cfoutput>
<cfsetting showdebugoutput="yes">

<cfif isdefined('form.empfrom')>
	<cfset form.empfrom = trim(form.empfrom)>
</cfif>

<cfif isdefined('form.empto')>
	<cfset form.empto = trim(form.empto)>
</cfif>

<cfset dts_p=replace(dts,'_i', '_p')>




<h1></h1>
<cfset num =1>
<table border="1" cellpadding="5" align="center">
	<tr>
    	<th>No</th>
    	<th>Employee No</th>
		<th>Employee Name</th>
        <th>Timesheet Status</th>
        <th>Client No</th>
        <th>Client Name</th>
        <th>Submit date</th>
        <th>Approval Date</th>
    </tr>
    <cfquery name="getcustno" datasource="#dts#">
    SELECT custno,custname,placementno,empno FROM placement
    WHERE completedate >= now()
    <cfif (isdefined('form.clientfrom') and form.clientfrom neq "") 
	and (isdefined('form.clientto') and form.clientto neq "")>
        AND custno BETWEEN 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clientfrom#"> 
        AND 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clientto#">
    <cfelse>
		<cfif form.clientfrom neq "">
            AND custno = 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clientfrom#">
        <cfelseif form.clientto neq "">
            AND custno = 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clientto#">
        </cfif>
     </cfif>
    </cfquery>
    
    <cfquery name="getplacement" datasource="#dts#">
    SELECT empno,placementno,custno,custname FROM placement
    WHERE 1=1
	<cfif form.empfrom neq "" and form.empto neq "" >
     AND a.empno BETWEEN '#form.empfrom#' AND '#form.empto#'
    <cfelse>
	  <cfif form.empfrom neq "">
          AND a.empno = 
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#">
      <cfelseif form.empto neq "">
          AND a.empno = 
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
      </cfif>
   </cfif>   
   <cfif getcustno.recordcount neq 0>
    AND placementno in 
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getcustno.placementno)#">
    )
    </cfif>
    GROUP BY empno
    ORDER BY empno
    </cfquery>

        <cfloop query="getplacement">
            <cfquery name="getempname" datasource="#dts_p#">
            SELECT name FROM pmast 
            WHERE empno = 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#">
            </cfquery> 
            <cfquery name="gettimesheet" datasource="#dts_p#">
            SELECT status,created_on, updated_on FROM timesheet
            WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#">
            </cfquery>  
            <cfif getplacement.empno eq 0>
            <cfelse>     
                <tr>
                	<td>#num#</td>
                    <td>#getplacement.empno#</td>
                    <td>#getempname.name#</td>
                    <td><cfif gettimesheet.status eq ''>Not Submitted<cfelse>Submitted - #gettimesheet.status#</cfif></td>
                    <td>#getplacement.custno#</td>
                    <td>#getplacement.custname#</td>
                    <td><cfif gettimesheet.status eq ''><cfelse>#datetimeformat(gettimesheet.created_on, "yyyy/MM/dd h:mm:ss tt")#</cfif></td>
                    <td>
					<cfif gettimesheet.status neq 'Approved'><cfelse>#datetimeformat(gettimesheet.updated_on, "yyyy/MM/dd h:mm:ss tt")#</cfif></td>
                </tr>
                <cfset num += 1>
            </cfif>
        </cfloop>
</table>
</cfoutput>