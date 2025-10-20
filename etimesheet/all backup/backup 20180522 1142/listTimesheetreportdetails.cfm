<cfset targetTitle="Time Sheet Details Report">
<cfset targetTable="placement">
<cfset pageTitle="Time Sheet Details Report">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    
    <cfset dts_p=replace(dts,'_i', '_p')>
    
    <!---changed some variable name and value--->
    <cfoutput>
		<script type="text/javascript">
            var dts='#dts#';
			var custno ='#url.custno#'
            var display='T';
            var targetTitle='#targetTitle#';
            var targetTable='#targetTable#';
            var empno ='Employee No';
			var empname ='Employee Name';
			var phone ='Phone';
			var email = 'Email';
			var timesheetstatus = 'Timesheet Status';
			var hmname = 'HM Name';
			var hmemail = 'HM Email';
			var submitdate = 'Submit date';
			var updateddate = 'Updated Date';
			var timesheetperiod = 'Timesheet Period';
            var monthselected = '#url.period#';
            var yearselected = '#url.year#';
            var action='action';
            var SEARCH='Search';
        </script>
    </cfoutput>
    <script type="text/javascript" src="/etimesheet/listTimeSheetreportdetails.js"></script>
    
</head>
<body>
<cfoutput>
	<cfsetting showdebugoutput="yes">
	<div class="container">
		<div class="page-header">
			<h2>  
            
            <cfquery name="getcustname" datasource="manpower_i">
            	SELECT custname
                FROM #targetTable#
                where custno = #url.custno#
			</cfquery>
            
				#pageTitle# - #getcustname.custname#
				<!---<span class="glyphicon glyphicon-question-sign btn-link"></span>
				<span class="glyphicon glyphicon-facetime-video btn-link"></span>--->
	
				<!---<div class="pull-right">			
						<button type="button" class="btn btn-default" onclick="window.open('/etimesheet/listTimesheetreport.cfm?action=create','_self');">
							<span class="glyphicon glyphicon-plus"></span> New Hiring Manager
						</button>  --->             
					
						<!---<button type="button" class="btn btn-default" onclick="window.open('/latest/customization/manpower_i/hrMgrProfile/hrMgrProcess.cfm?action=print','_blank');">
							<span class="glyphicon glyphicon-print"></span> Print
						</button>    --->     
				</div>
			</h2>
		</div>
		<div class="container">
			<table class="table table-bordered table-hover" id="resultTable" style="width:100%">
				<thead>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</cfoutput>

</body>
</html>



<!---<cfquery name="getcustno" datasource="#dts#">
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
</cfoutput>--->