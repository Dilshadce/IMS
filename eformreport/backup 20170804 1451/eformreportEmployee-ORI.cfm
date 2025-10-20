<cfset targetTitle = "Eform Report">
<cfset targetTable = "emp_users">
<cfset pageTitle = "Eform Report">
<cfset empnoform = form.empno>

<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
	<title>Eform Report</title>

	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>

	<cfoutput>
		<script type="text/javascript">
            var dts='#dts#';
            var display='T';
            var targetTitle='#targetTitle#';
            var targetTable='#targetTable#';
            var empno ='Employee No';
			var empname ='Employee Name';
			var emailsent ='Account creation - Email Sent';
			var eformupdated = 'Eform Updated On';
			var pbupdated = 'PB Updated On';
			var approvecount = 'Count of Approval Date';
			var empnoform = "#empnoform#";
			<!---var clientfrom="#clientfrom#";
			var clientto="#clientto#";
			var empfrom="#empfrom#";
			var empto="#empto#";--->
        </script>
    </cfoutput>
    <script type="text/javascript" src="/eformreport/eformreportEmployee.js"></script>
</head>

<body>
	<cfoutput>
	<cfsetting showdebugoutput="yes">
        <div class="container">
            <div class="page-header">
                <h2>
                    #pageTitle#
                </h2>
            </div>
        </div>
        <div class="container">
            <table class="table table-bordered table-hover" id="resultTable" style="width:100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
	</cfoutput>
</body>
</html>