
<cfsetting showdebugoutput="no">
<cfquery name="gettimesheet" datasource="manpower_p">
select empno,status,count(pdate) as totaldays, placementno from timesheet group by empno
</cfquery>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<style>
tbody {
    display:block;
    height:90vh;
    overflow:auto;
}
thead, tbody tr {
    display:table;
    width:60%;
    table-layout:fixed;
}
thead {
    width: calc( 60% - 1em )
}
thead th{
	text-align:left
}
</style>
<cfoutput>

<h1>Timesheet Submission Report</h1>
<body style="overflow:hidden;">

<table border="1">
	<thead>
	<tr>
    	<th>Employee No</th>
		<th >Employee Name</th>
        <th >Timesheet Status</th>
        <th>Total Submitted Days</th>
        <th>Placement No.</th>
    </tr>
    </thead>
	<tbody>
	<cfloop query="gettimesheet">
    	<cfquery name="getempname" datasource="manpower_p">
        SELECT name from pmast where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettimesheet.empno#">
        </cfquery>
    	<tr>
        	<td>#gettimesheet.empno#</td>
        	<td>#getempname.name#</td>
            <td>#gettimesheet.status#</td>
            <td style="text-align:center">#gettimesheet.totaldays#</td>
            <td style="text-align:center">#gettimesheet.placementno#</td>
        </tr>
    </cfloop>
    </tbody>
</table>

</body>
</cfoutput>