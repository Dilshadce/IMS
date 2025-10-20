<cfset pageTitle="Update Company Profile">
<cfset pageAction="Update">

<cfquery name="listCurrency" datasource="#dts#">
	SELECT currcode,currency,currency1 
	FROM #target_currency#
	ORDER BY currcode;
</cfquery>

<cfif Hlinkams eq "Y">
    <cfquery name="getGsetup" datasource="#replace(dts,'_i','_a','all')#">
        SELECT * 
        FROM gsetup;
    </cfquery>
    
    <cfset companyID = getGsetup.companyid>
    <cfset compro = getGsetup.compro>

</cfif>

<cfquery name="getGsetup" datasource="#dts#">
    SELECT * 
    FROM gsetup;
</cfquery>

<cfset companyID = getGsetup.companyid>
<cfset compro = getGsetup.compro>


<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->

    <title>#pageTitle#</title>
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
</head>

<body class="container">
<cfoutput>
	<form class="form-horizontal" role="form" id="companyProfileForm" name="companyProfileForm" action="companyProfileProcess.cfm" method="post";>
        <div class="page-header">
            <h3>#pageTitle#</h3>
        </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" data-toggle="collapse" href="##mainInfoCollapse">
                            <h4 class="panel-title accordion-toggle">Sales Related Account</h4>
                        </div>
                        <div id="mainInfoCollapse" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">							
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Credit Sales Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Cash Sales Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Sales Return</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Sales Discount</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Sales TAX Account (GST)</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 1</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 2</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div>   
                                        <<div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 3</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 4</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 5</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 6</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 7</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                        
                    <div class="panel panel-default">
                        <div class="panel-heading" data-toggle="collapse" href="##financialInfoCollapse">
                            <h4 class="panel-title accordion-toggle">Purchase Related Account</h4>
                        </div>
                        <div id="financialInfoCollapse" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">                      
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Purchase Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 	
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Purchase Return Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Purchase Discount Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Purchase TAX Account (GST)</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 1</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 2</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 3</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 4</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 5</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 6</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Misc Charges 7</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div>                                         	                 						
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="panel panel-default">
                        <div class="panel-heading" data-toggle="collapse" href="##financialInfoCollapse">
                            <h4 class="panel-title accordion-toggle">Sales Payment Mode</h4>
                        </div>
                        <div id="financialInfoCollapse" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">                      
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Cash Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 	
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Deposit Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Cheque Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Credit Card Account 1</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Credit Card Account 2</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Debit Card Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Cash Voucher Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Withholding TAX Account</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">Bank Account (For Deposit Function)</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="" name="">
                                                </select>
                                            </div>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
    </form>
	<div>
		<input type="submit" value="#pageAction#" />
				<input type="reset" value="Reset"/>
			</div>
</cfoutput>
</body>
</html>

