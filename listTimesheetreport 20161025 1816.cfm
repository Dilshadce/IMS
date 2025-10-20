<cfoutput>
<cfsetting showdebugoutput="no">
<cfquery name="gettimesheet" datasource="manpower_p">
select distinct(empno) as empno,status,updated_by from timesheet
</cfquery>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<h1>Timesheet Submission Report</h1>
<table border="1" cellpadding="5" align="center">
	<tr>
		<th>Employee Name</th>
        <th>Timesheet Status</th>
        <th>Submitted User ID</th>
    </tr>
	<cfloop query="gettimesheet">
    	<cfquery name="getempname" datasource="manpower_p">
        SELECT name from pmast where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettimesheet.empno#">
        </cfquery>
    	<tr>
        	<td>#getempname.name#</td>
            <td>#gettimesheet.status#</td>
            <td>#gettimesheet.updated_by#</td>
        </tr>
    </cfloop>
</table>
</cfoutput>