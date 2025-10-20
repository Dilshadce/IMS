<cfinclude template="eSPTform.cfm">
<cfset pageTitle="eSPT Generation">
<cfset targetTitle="eSPT Generation">
<cfset targetTable="artran">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/general/taxprofile.css" />
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
        var targetTitle='#targetTitle#';
        var targetTable='#targetTable#';
    </script>
    </cfoutput>
    <script type="text/javascript" src="/latest/js/generalSetup/eSPT/eSPT.js"></script>

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
			</div>
		</h2>
	</div>
	<ul class="nav nav-tabs">
		<li id="purchaseReceiveNav" class="active"><a id="purchaseReceiveButton" class="navButton">Purchase Receive</a></li>
		<li id="purchaseReturnNav"><a id="purchaseReturnButton" class="navButton">Purchase Return</a></li>
		<li id="invoiceNav"><a id="invoiceButton" class="navButton">Invoice</a></li>
		<li id="creditNoteNav"><a id="creditNoteButton" class="navButton">Credit Note</a></li>
        <li id="debitNoteNav"><a id="debitNoteButton" class="navButton">Debit Note</a></li>
        <li id="cashSalesNav"><a id="cashSalesButton" class="navButton">Cash Sales</a></li>
	</ul>  
	<div class="container">
    	<div id="alertBox" class="alert fade in" style="display:none;">
			<button type="button" class="close closeAlertBox" aria-hidden="true">&times;</button>
			<p></p>
		</div>
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