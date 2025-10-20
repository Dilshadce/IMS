<cfoutput>
<cfsetting showdebugoutput="yes">

<cfif isdefined('form.empfrom')>
	<cfset form.empfrom = trim(form.empfrom)>
</cfif>

<cfif isdefined('form.empto')>
	<cfset form.empto = trim(form.empto)>
</cfif>

<cfset dts_p=replace(dts,'_i', '_p')>




<center><h1>Timesheet Submission Report</h1></center>
<cfset num =1>
<table border="1" cellpadding="5" align="center">
	<tr>
    	<th>No</th>
        <th>Client No</th>
        <th>Client Name</th>
        <th>Placement Count</th>
        <th>Count of Submit date</th>
        <th>Count of Approval Date</th>
    </tr>
    <cfquery name="getplacement" datasource="#dts#">
        SELECT custno,custname, count(placementno) as placementcount, placementno,empno FROM placement
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
         Group by custname
    </cfquery>
     
    <cfloop query = "getplacement">
         <tr>
    	 	<td>#num#</td>
            <td>#custno#</td>
            <td><a href="listTimesheetreportdetails.cfm?custno=#custno#" target="_blank">#custname#</a></td>
            <td>#placementcount#</td>
                    
            <cfquery name ="getplacementno" datasource="#dts#">
            	   select GROUP_CONCAT(placementno) as placementno from manpower_i.placement where custname = '#custname#'
                        and completedate >= now() 
            </cfquery>
                    
            <cfquery name='getvalidatedcount' datasource="#dts_p#">
                  	select placementno 
               			 from manpower_p.timesheet 
                		where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) 
               			 group by placementno
            </cfquery>
            <td>#getvalidatedcount.recordCount#</td>
                
 			<cfquery name='getapprovedcount' datasource="#dts_p#">
                    	select placementno 
               			 from manpower_p.timesheet 
                		where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) and status = "Approved" 
               			 group by placementno
            </cfquery>
            <td>#getapprovedcount.recordCount#</td>
                
         </tr>
         <cfset num += 1>
    </cfloop>
            
      
</table>
</cfoutput>