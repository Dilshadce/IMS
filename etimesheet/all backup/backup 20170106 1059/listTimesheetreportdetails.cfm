<cfoutput>
<cfsetting showdebugoutput="yes">

<cfset dts_p=replace(dts,'_i', '_p')>
<cfquery name="getcustno" datasource="#dts#">
SELECT custno,custname,placementno,empno FROM placement
WHERE completedate >= now() and custno = #url.custno#
</cfquery>

<cfquery name="getplacement" datasource="#dts#">
SELECT empno,placementno,custno,custname, hrmgr FROM placement
WHERE 1=1 and custno = #url.custno#
<cfif getcustno.recordcount neq 0>
AND placementno in 
(
<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getcustno.placementno)#">
)
</cfif>
GROUP BY empno
ORDER BY empno
</cfquery>



<center><h1>Time Sheet Details Report</h1></center>
<cfset num =1>
<table border="1" cellpadding="5" align="center">
	<tr> #custno# - #getplacement.custname#
       	<th>No</th>
    	<th>Employee No</th>
		<th>Employee Name</th>
        <th>Phone</th>
        <th>Email</th>
        <th>Timesheet Status</th>
        <th>HM Name</th>
        <th>HM Email</th>
        <th>Submit date</th>
        <th>Approval Date</th>
    </tr>


	<cfloop query="getplacement">
       <cfquery name="getempname" datasource="#dts_p#">
            SELECT name, phone, email FROM pmast 
            WHERE empno = 
           <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#">
       </cfquery> 
       <cfquery name="gettimesheet" datasource="#dts_p#">
          SELECT status,created_on, updated_on FROM timesheet
          WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#">
       </cfquery>
       <cfquery name="getHMdetail" datasource="payroll_main">
          SELECT entryid, userName, userEmail FROM payroll_main.hmusers
          WHERE entryid = "#getplacement.hrmgr#"
       </cfquery>  
       <cfif getplacement.empno eq 0>
       <cfelse>     
           <tr>
                <td>#num#</td>
                <td>#getplacement.empno#</td>
                <td>#getempname.name#</td>
                <td>#getempname.phone#</td>
                <td>#getempname.email#</td>
                <td><cfif gettimesheet.status eq ''>Not Submitted<cfelse>Submitted - #gettimesheet.status#</cfif></td>
                <td>#getHMdetail.userName#</td>
                <td>#getHMdetail.userEmail#</td>
                <td><cfif gettimesheet.status eq ''><cfelse>#datetimeformat(gettimesheet.created_on, "yyyy/MM/dd h:mm:ss tt")#</cfif></td>
                <td><cfif gettimesheet.status neq 'Approved'><cfelse>#datetimeformat(gettimesheet.updated_on, "yyyy/MM/dd h:mm:ss tt")#</cfif></td>
            </tr>
            <cfset num += 1>
        </cfif>
    </cfloop>
</table>
</cfoutput>