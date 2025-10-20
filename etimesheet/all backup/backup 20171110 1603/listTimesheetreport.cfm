<cfoutput>
<cfset targetTitle="Timesheet Submission Report - #MonthAsString(reportmonth)#">
<cfset targetTable="placement">
<cfset pageTitle="Timesheet Submission Report - #MonthAsString(reportmonth)#">
<cfset clientfrom=form.clientfrom>
<cfset clientto=form.clientto>
<cfset empfrom=form.empfrom>
<cfset empto=form.empto>
</cfoutput>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!---<cfoutput>


<cfif isdefined('form.empfrom')>
	<cfset form.empfrom = trim(form.empfrom)>
</cfif>

<cfif isdefined('form.empto')>
	<cfset form.empto = trim(form.empto)>
</cfif>--->

<cfset dts_p=replace(dts,'_i', '_p')>

	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    
    <!---changed some variable name and value--->
    <cfoutput>
		<script type="text/javascript">
            var dts='#dts#';
            var display='T';
            var targetTitle='#targetTitle#';
            var targetTable='#targetTable#';
            var custno ='Client No';
			var custname ='Client Name';
			var placementcount ='Placement Count';
			var submittedcount = 'Submitted';
			var approvedcount = 'Approved';
            var savedcount = 'Saved';
            var rejectedcount = 'Rejected';
            var processedcount = 'Processed';
            var summary = 'Summary';
            var monthselected = '#form.reportmonth#';
            var yearselected = '#form.reportyear#';
            var action='action';
            var SEARCH='Search';
			var clientfrom="#clientfrom#";
			var clientto="#clientto#";
			var empfrom="#empfrom#";
			var empto="#empto#";
        </script>
    </cfoutput>
    <script type="text/javascript" src="/etimesheet/listTimeSheetreport.js"></script>
</head>

<body>

<cfoutput>
	<cfsetting showdebugoutput="yes">
	<div class="container">
		<div class="page-header">
			<h2>
				#pageTitle#
				<!---<span class="glyphicon glyphicon-question-sign btn-link"></span>
				<span class="glyphicon glyphicon-facetime-video btn-link"></span>--->
	
				<!---<div class="pull-right">			
						<button type="button" class="btn btn-default" onclick="window.open('/etimesheet/listTimesheetreport.cfm?action=create','_self');">
							<span class="glyphicon glyphicon-plus"></span> New Hiring Manager
						</button>--->               
					
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

