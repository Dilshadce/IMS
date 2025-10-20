<cfprocessingdirective pageencoding="UTF-8">
<!--- <cfset words_id_list = "292,294,65,10,11,293,3"> --->
<!--- <cfinclude template="/latest/words.cfm"> --->
<!--- <cfinclude template="/latest/pageTitle/pageTitle.cfm"> --->
<cfset targetTitle="LocationMap">
<cfset targetTable="locationmap">
<!--- <cfset pageTitle="#words[293]#"> --->
<!--- <cfset displayEditDelete=getUserPin2.H10104_3b> --->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Location Mapping Profile</title>
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
        var target="LocationMap";
		var display='T';
        var targetTitle='#targetTitle#';
        var targetTable='#targetTable#';
		var menuID='';
		var service='Source Location';
		var description='System Location';
		var action='Action';
		var SEARCH='Search';
    </script>
    </cfoutput>
    <script type="text/javascript" src="/default/maintenance/locationmapping/accnoMapProfile.js"></script>

</head>

<body>
<cfoutput>
<div class="container">
	<div class="page-header">
		<h2>
			Location Mapping Profile
			<span class="glyphicon glyphicon-question-sign btn-link"></span>
			<span class="glyphicon glyphicon-facetime-video btn-link"></span>

			<div class="pull-right">
				<!--- <cfif getUserPin2.H10104_3a EQ 'T'> --->
                    <button type="button" class="btn btn-default" onclick="window.open('/default/maintenance/locationmapping/accno.cfm?action=create&menuID=','_self');">
                        <span class="glyphicon glyphicon-plus"></span> Add Location
                    </button>
                <!--- </cfif>
                <cfif getUserPin2.H10104_3c EQ 'T'> --->
                    <button type="button" class="btn btn-default" onclick="window.open('/default/maintenance/locationmapping/accnoprocess.cfm?action=print&pageTitle=Accno Map Profile','_blank');">
                        <span class="glyphicon glyphicon-print"></span> Print
                    </button>
                <!--- </cfif> --->
			</div>
		</h2>
	</div>
	<div class="container">
		<table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
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