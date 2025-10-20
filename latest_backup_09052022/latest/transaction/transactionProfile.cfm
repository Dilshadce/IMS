<cfinclude template="/latest/pageTitle/pageTitle.cfm">
<cfquery datasource="#dts#" name="getRefNoSet">
	SELECT lastusedno AS lastUsedNo, refnoused AS arun 
    FROM refnoset
	WHERE type = '#tran#'
	AND counter = 1;
</cfquery>

<cfset transactionType=tran>
<cfset targetTitle="">
<cfset targetTable="artran">

<!---Conditions FOR: Update Button --->
<cfset condition1 = #tran# EQ 'DO' AND getpin2.h2305 eq 'T'>
<cfset condition2 = #tran# EQ 'PO' AND getpin2.h2866 eq 'T'>
<cfset condition3 = #tran# EQ 'SO' AND getpin2.h2886 eq 'T'>
<cfset condition4 = #tran# EQ 'QUO' AND getpin2.h2876 eq 'T'>
<cfset condition5 = #tran# EQ 'RQ' AND getpin2.h28G5 eq 'T'>
<cfset condition6 = #tran# EQ 'SO' AND getpin2.h2887 eq 'T'>
<cfset condition7 = #tran# EQ 'QUO' AND getpin2.h2878 eq 'T'>
<cfset condition8 = #tran# EQ 'PO' AND getpin2.h2865 eq 'T'>
<cfset condition9 = #tran# EQ 'SO' AND getpin2.h2887 eq 'T'>
<cfset condition10 = #tran# EQ 'QUO' AND getpin2.h2875 eq 'T'>
<cfset condition11 = #tran# EQ 'SAM' AND getpin2.h2855 eq 'T'>
<cfset condition12 = #tran# EQ 'QUO' AND getpin2.h2877 eq 'T'>
<cfset condition13 = #tran# EQ 'SAM' AND getpin2.h2855 eq 'T'>
<cfset condition14 = #tran# EQ 'SO' AND getpin2.h2885 eq 'T'>
<cfset condition15 = #tran# EQ 'QUO' AND getpin2.h2879 eq 'T'>
<cfset condition16 = #tran# EQ 'SO' AND getpin2.h2879 eq 'T'>

<!---Links TO: update page--->
<cfset updatePageAction1 = '/latest/transaction/update/updateProfile.cfm?pageTitle=#pageTitle#&t1=#tran#&t2=RC'>
<cfset updatePageAction2 = '/latest/transaction/update/updateProfile.cfm?pageTitle=#pageTitle#&t1=#tran#&t2=INV'>
<cfset updatePageAction3 = '/latest/transaction/update/updateProfile.cfm?pageTitle=#pageTitle#&t1=#tran#&t2=PO'>
<cfset updatePageAction4 = '/latest/transaction/update/updateProfile.cfm?pageTitle=#pageTitle#&t1=#tran#&t2=SO'>
<cfset updatePageAction5 = '/latest/transaction/update/updateProfile.cfm?pageTitle=#pageTitle#&t1=#tran#&t2=DO'>
<cfset updatePageAction6 = '/latest/transaction/update/updateProfile.cfm?pageTitle=#pageTitle#&t1=#tran#&t2=CS'>

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
		var tran='#transactionType#';
        var targetTitle='#targetTitle#';
        var targetTable='#targetTable#';
    </script>
    </cfoutput>
    <script type="text/javascript" src="/latest/js/transaction/transactionProfile.js"></script>

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
                <button type="button" class="btn btn-default" onclick="window.open('/latest/transaction/transaction1.cfm?action=create&tran=#tran#','_self');">
                    <span class="glyphicon glyphicon-plus"></span> Add #targetTitle#
                </button>
                
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    	<span class="glyphicon glyphicon-open"></span> 
                      		Update
						<span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                    	<cfif condition5 OR condition6 OR condition7>
                    		<li><a href="#updatePageAction3#" id="purchaseOrder" style="cursor:pointer;">To Purchase Order</a></li>
                        </cfif>
                        <cfif condition8 OR condition9>
							<li><a href="#updatePageAction1#" id="purchaseReceive" style="cursor:pointer;">To Purchase Receive</a></li>
                        </cfif>
						<cfif condition1 OR condition2 OR condition3 OR condition4>
                            <li><a href="#updatePageAction2#" id="invoice" style="cursor:pointer;"> To Invoice</a></li>
                        </cfif>       
                        <cfif condition10 OR condition11>
                        	<li><a href="#updatePageAction4#" id="salesOrder" style="cursor:pointer;">To Sales Order</a></li>
                        </cfif>
                        <cfif condition12 OR condition13 OR condition14>
                    		<li><a href="#updatePageAction5#" id="deliveryOrder" style="cursor:pointer;">To Delivery Order</a></li>
                        </cfif>   
                        <cfif condition15 OR condition16> 
                        	<li><a href="#updatePageAction6#" id="cashSales" style="cursor:pointer;">To Cash Sales</a></li>
                        </cfif>
                    </ul>
				</div> 
			</div>
		</h2>
	</div>
	<div class="container">
    	Last Used No: #getRefNoSet.lastUsedNo#
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