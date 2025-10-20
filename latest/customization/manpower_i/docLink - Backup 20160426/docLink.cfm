<cfset targetTitle="Document Linkeage Profile">
<cfset targetTable="doclink">
<cfset pageTitle="Document Linkeage Profile">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
 
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
            var docType ='document type';
			var client ='client';
			var associate ='associate';
			var expireDate ='expire date';
            var description='description';
            var action='action';
            var SEARCH='search';
        </script>
    </cfoutput>
    <script type="text/javascript" src="/latest/customization/manpower_i/docLink/docLink.js"></script>
</head>

<body>
<cfoutput>
	<div class="container">
		<div class="page-header">
			<h2>
				#pageTitle#
				<!---<span class="glyphicon glyphicon-question-sign btn-link"></span>
				<span class="glyphicon glyphicon-facetime-video btn-link"></span>--->
	
				<div class="pull-right">			
						<button type="button" class="btn btn-default" onclick="window.open('/latest/customization/manpower_i/docLink/docLinkDetail.cfm?action=create','_self');">
							<span class="glyphicon glyphicon-plus"></span> New Document Linkeage
						</button>               
					
						<!---<button type="button" class="btn btn-default" onclick="window.open('/latest/customization/manpower_i/docLink/docLinkProcess.cfm?action=print','_blank');">
							<span class="glyphicon glyphicon-print"></span> Print
						</button>   --->      
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