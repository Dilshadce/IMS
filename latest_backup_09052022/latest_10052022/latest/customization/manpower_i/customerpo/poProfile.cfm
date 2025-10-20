<cfprocessingdirective pageencoding="UTF-8">

<cfset targetTitle="Product">
<cfset targetTable="manpowerpo">
<cfset pageTitle="Customer PO Profile">
<cfset displayEditDelete=getUserPin2.H10103_3b>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * 
    from displaysetup;
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-multiselect/bootstrap-multiselect.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
 
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-multiselect/bootstrap-multiselect-collapsible-groups.js"></script>

    <cfoutput>
    <script type="text/javascript">
        var dts='#dts#';
        var targetTitle='#targetTitle#';
        var targetTable='#targetTable#';
		var display='#displayEditDelete#';
		var menuID='';

		var displaymultiselect="T"
		
		var action='Action';
		var SEARCH='Search';
		
		<cfif IsDefined('url.message')>
			window.setTimeout(function() {
				$(".alert").fadeTo(500, 0).slideUp(500, function(){
					$(this).remove(); 
				});
			}, 3000);
		</cfif>
    </script>
    </cfoutput>
    <script type="text/javascript" src="poProfile.js"></script>

</head>

<body>
<cfoutput>
<div class="container">
	<div class="page-header">
		<h2>
			#pageTitle#
			<span class="glyphicon glyphicon-question-sign btn-link"></span>
			<span class="glyphicon glyphicon-facetime-video btn-link"></span>
            
			<div class="pull-right">
            	
                    <button type="button" class="btn btn-default" onclick="window.open('po.cfm?action=create','_self');">
                        <span class="glyphicon glyphicon-plus"></span> Create
                    </button>
					
					<button type="button" class="btn btn-default" onclick="window.open('polink.cfm?action=create','_self');">
                        <span class="glyphicon glyphicon-plus"></span> Link PO To JO
                    </button>
				
                    <button type="button" class="btn btn-default" onclick="window.open('poforecastreport2.cfm','_self');">
                        <span class="glyphicon glyphicon-print"></span> Forecast Billable Report
                    </button>

             
                <select id="example-multiple-selected" multiple="multiple">
                	<option id="0" name="0" value="0" selected>PO Number</option>
                	<option id="1" name="1" value="1" selected>Date</option>
                    <option id="2" name="2" value="2" selected>Customer</option>
                	<option id="3" name="3" value="3" selected>Valid Date</option>
                    <option id="4" name="4" value="4" selected>Amount</option>
					<option id="5" name="5" value="5" selected>Threshold  Amount</option>
					<option id="6" name="6" value="6" selected>JO Used Amount</option>

                </select>   
                
			</div>
		</h2>
	</div>
	<div class="container">
    	<cfif IsDefined('url.message')>
        	<div class="alert alert-danger alert-dismissable">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              <strong>Customer PO cannot be deleted</strong> 
            </div>
    	</cfif>
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