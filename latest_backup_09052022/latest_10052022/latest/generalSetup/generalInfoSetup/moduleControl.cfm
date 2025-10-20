<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1778, 1779, 1329, 780, 1781, 1782, 1783, 1784, 1785">
<cfinclude template="/latest/words.cfm">

<cfset pageTitle="#words[1778]#">

<cfquery name="getModuleControl" datasource="#dts#">
    SELECT * 
    FROM modulecontrol;
</cfquery>


<cfset POStransaction = getModuleControl.postran>
<cfset matrixTransaction = getModuleControl.matrixtran>
<cfset repairTransaction = getModuleControl.repairtran>
<cfset simpleTransaction = getModuleControl.simpletran>
<cfset batchCode = getModuleControl.batchCode>

<cfset customTax = getModuleControl.customtax>
<cfset malaysiaGST = getModuleControl.malaysiaGST>



<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->
	<cfoutput>
    <title>#pageTitle#</title>
    </cfoutput>
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
 
</head>

<body class="container">
<cfoutput>
	<form class="form-horizontal" role="form" id="moduleControlForm" name="moduleControlForm" action="moduleControlProcess.cfm" method="post">
        <div class="page-header">
            <h3>#pageTitle#</h3>
        </div>
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
                    <h4 class="panel-title accordion-toggle">#words[1779]#</h4>
                </div>
                <div id="panel1Collapse" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-8">	
                                <div class="form-group">
                                    <label for="POStransaction" class="col-sm-4 control-label">#words[1329]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="POStransaction" name="POStransaction" value="1" <cfif POStransaction eq '1'>checked</cfif>>
                                                       	
                                                </div>													 
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="matrixTransaction" class="col-sm-4 control-label">Matrix Transaction</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="matrixTransaction" name="matrixTransaction" value="1" <cfif matrixTransaction eq '1'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div> 
                                <div class="form-group">
                                    <label for="repairTransaction" class="col-sm-4 control-label">#words[1781]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="repairTransaction" name="repairTransaction" value="1" <cfif repairTransaction eq '1'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div> 
                                <div class="form-group">
                                    <label for="simpleTransactionLabel" class="col-sm-4 control-label">#words[1782]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="simpleTransaction" name="simpleTransaction" value="1" <cfif simpleTransaction eq '1'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="batchCodeLabel" class="col-sm-4 control-label">Batch Code</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="batchCode" name="batchCode" value="1" <cfif batchCode eq '1'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>   
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            
            <div class="panel panel-default">
                <div class="panel-heading" data-toggle="collapse" href="##panel2Collapse">
                    <h4 class="panel-title accordion-toggle">#words[1783]#</h4>
                </div>
                <div id="panel2Collapse" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-8">	
                                <div class="form-group">
                                    <label for="customTax" class="col-sm-4 control-label">#words[1784]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="customTax" name="customTax" value="1" <cfif customTax eq '1'>checked</cfif>>
                                                       	
                                                </div>													 
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="malaysiaGST" class="col-sm-4 control-label">#words[1785]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="malaysiaGST" name="malaysiaGST" value="1" <cfif malaysiaGST eq '1'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div> 
                            </div>

                        </div>
                    </div>
                </div>
            </div>
 
        </div>
        <div class="pull-right">
            <input type="submit" value="Save" class="btn btn-primary"/>
            <input type="button" value="Cancel" onclick="window.location='/latest/body/bodymenu.cfm?id=60100'" class="btn btn-default" />
        </div>
    </form> 
</cfoutput>
</body>
</html>