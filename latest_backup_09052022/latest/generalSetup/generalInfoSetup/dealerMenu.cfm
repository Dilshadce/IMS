<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1744, 1745, 1746, 1747, 1748, 1749, 1750, 1751, 1752, 1753, 1574, 1755, 1756, 1757, 1758, 1759, 572, 793, 794, 796, 1754,2181,2182,2183,2184,2185">
<cfinclude template="/latest/words.cfm">

<cfset pageTitle="#words[1744]#">
<cfset pageAction="Update">

<cfquery name="getDealerMenu" datasource="#dts#">
    SELECT * 
    FROM dealer_menu;
</cfquery>

<cfquery name="getGsetup" datasource="#dts#">
	SELECT * 
	FROM gsetup;
</cfquery>

<cfset minSellingPriceControl = getGsetup.gpricemin>
<cfset minSellingPricePassword = getGsetup.priceminpass>
<cfset minSellingPriceEmail = getGsetup.priceminctrlemail>
<cfset sellingBelowCost = getDealerMenu.selling_below_cost>
<cfset sellingCannotLower = getDealerMenu.minimum_selling_price>
<cfset sellingCannotLowerLIST = getDealerMenu.minimum_selling_price1>
<cfset overCreditLimit = getDealerMenu.selling_above_credit_limit>
<cfset overCreditLimitLIST = getDealerMenu.selling_above_credit_limit1>
<cfset overCreditTerm = getDealerMenu.credit_term>
<cfset overCreditTermLIST = getDealerMenu.credit_term1>
<cfset negativeStockControl = getDealerMenu.negstkpassword>
<cfset negativeStockControlLIST = getDealerMenu.negstkpassword1>
<cfset editBillPassword = getGsetup.editbillpassword>
<cfset editBillPasswordLIST = getGsetup.editbillpassword1>
<cfset passwordControl = getDealerMenu.password>
<cfset customCompany = getDealerMenu.customcompany>

<cfset tran_edit_term = getDealerMenu.tran_edit_term>
<cfset tran_edit_name = getDealerMenu.tran_edit_name>
<cfset custSuppSortBy = getDealerMenu.custSuppSortBy>
<cfset productSortBy = getDealerMenu.productSortBy>
<cfset transactionSortBy = getDealerMenu.transactionSortBy>



<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->

    <cfoutput><title>#pageTitle#</title></cfoutput>
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
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
  	<script src="//code.jquery.com/jquery-1.9.1.js"></script>
  	<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	<script language="JavaScript" type="text/javascript">
		$(document).ready(function(){
			$('#checkbox1').change(function(){
				if(this.checked){
					$('#passwordField').fadeIn('slow');
					$("#minSellingPricePassword").prop("required", true);
				}
				else
					$('#passwordField').fadeOut('slow');
		
			});
		});
		
		$(document).ready(function(){
			$('#sellingCannotLower').change(function(){
				if(this.checked)
					$('#showList1').fadeIn('slow');
				else
					$('#showList1').fadeOut('slow');
		
			});
		});
		
		$(document).ready(function(){
			$('#sellingCannotLower').change(function(){
				if(this.checked)
					$('#showList1').fadeIn('slow');
				else
					$('#showList1').fadeOut('slow');
		
			});
		});
		
		$(document).ready(function(){
			$('#overCreditLimit').change(function(){
				if(this.checked)
					$('#showList2').fadeIn('slow');
				else
					$('#showList2').fadeOut('slow');
		
			});
		});
		
		$(document).ready(function(){
			$('#overCreditTerm').change(function(){
				if(this.checked)
					$('#showList3').fadeIn('slow');
				else
					$('#showList3').fadeOut('slow');
		
			});
		});
		
		$(document).ready(function(){
			$('#negativeStockControl').change(function(){
				if(this.checked)
					$('#showList4').fadeIn('slow');
				else
					$('#showList4').fadeOut('slow');
		
			});
		});
		
		$(document).ready(function(){
			$('#editBillPassword').change(function(){
				if(this.checked)
					$('#showList5').fadeIn('slow');
				else
					$('#showList5').fadeOut('slow');
		
			});
		});
		
		$(function() {
			$( "#selectable1").selectable({
				stop: function() {
				
					
				var result = $( "#selectResult1" ).empty();
				var a= "";

					$( ".ui-selected", this ).each(function() {
					  var index = $( "#selectable1 li" ).index( this );
		
					  if(index == 0){
						  a=a+"DO,";
					  }
					  else if(index == 1){
						 a=a+"INV,";
					  }
					  else if(index == 2){
						 a=a+"CS,";
					  }
					  else if(index == 3){
						 a=a+"CN,";
					  }
					  else if(index == 4){
						 a=a+"DN";
					  }
					  document.getElementById("selectResult1").value=a;
				  });
				}
			});
		});
		  
		$(function() {
			$( "#selectable2").selectable({
				stop: function() {
					
				var result = $( "#selectResult2" ).empty();
				var a="";
					$( ".ui-selected", this ).each(function() {
					  var index = $( "#selectable2 li" ).index( this );
		
					  if(index == 0){
						  a=a+"DO";
					  }
					  else if(index == 1){
						 a=a+"INV";
					  }
					  else if(index == 2){
						 a=a+"CS";
					  }
					  else if(index == 3){
						 a=a+"CN";
					  }
					  else if(index == 4){
						 a=a+"DN";
					  }
					  document.getElementById("selectResult2").value=a;
				  });
				}
			});
		});
		
		$(function() {
			$( "#selectable3").selectable({
				stop: function() {
					
				var result = $( "#selectResult3" ).empty();
				var a="";
					$( ".ui-selected", this ).each(function() {
					  var index = $( "#selectable3 li" ).index( this );
		
					  if(index == 0){
						  a=a+"DO";
					  }
					  else if(index == 1){
						 a=a+"INV";
					  }
					  else if(index == 2){
						 a=a+"CS";
					  }
					  else if(index == 3){
						 a=a+"CN";
					  }
					  else if(index == 4){
						 a=a+"DN";
					  }
					  document.getElementById("selectResult3").value=a;
				  });
				}
			});
		});		
		
		$(function() {
			$( "#selectable4").selectable({
				stop: function() {
					
				var result = $( "#selectResult4" ).empty();
				var a="";
					$( ".ui-selected", this ).each(function() {
					  var index = $( "#selectable4 li" ).index( this );
		
					  if(index == 0){
						  a=a+"DO";
					  }
					  else if(index == 1){
						 a=a+"INV";
					  }
					  else if(index == 2){
						 a=a+"CS";
					  }
					  else if(index == 3){
						 a=a+"CN";
					  }
					  else if(index == 4){
						 a=a+"DN";
					  }
					  document.getElementById("selectResult4").value=a;
				  });
				}
			});
		});	
		
		$(function() {
			$( "#selectable5").selectable({
				stop: function() {
					
				var result = $( "#selectResult5" ).empty();
				var a="";
					$( ".ui-selected", this ).each(function() {
					  var index = $( "#selectable5 li" ).index( this );
		
					  if(index == 0){
						  a=a+"DO";
					  }
					  else if(index == 1){
						 a=a+"INV";
					  }
					  else if(index == 2){
						 a=a+"CS";
					  }
					  else if(index == 3){
						 a=a+"CN";
					  }
					  else if(index == 4){
						 a=a+"DN";
					  }
					  document.getElementById("selectResult5").value=a;
				  });
				}
			});
		});					

	</script>
   
    <style>
	  	#feedback { font-size: 1.4em; }
	 	#selectable1 .ui-selecting { background: #FECA40; }
	 	#selectable1 .ui-selected { background: #F39814; color: white; }
	  	#selectable1 { list-style-type: none; margin: 0; padding: 0; width: 500px; }
		#selectable1 li { margin-left: 10px; padding: 1px; float: left; width: 80px; height: 24px; font-size: 15px; text-align: center; }
		
		
		#selectable2 .ui-selecting { background: #FECA40; }
	 	#selectable2 .ui-selected { background: #F39814; color: white; }
	  	#selectable2 { list-style-type: none; margin: 0; padding: 0; width: 500px; }
		#selectable2 li { margin-left: 10px; padding: 1px; float: left; width: 80px; height: 24px; font-size: 15px; text-align: center; }
		
		
		#selectable3 .ui-selecting { background: #FECA40; }
	 	#selectable3 .ui-selected { background: #F39814; color: white; }
	  	#selectable3 { list-style-type: none; margin: 0; padding: 0; width: 500px; }
		#selectable3 li { margin-left: 10px; padding: 1px; float: left; width: 80px; height: 24px; font-size: 15px; text-align: center; }
		
		
		#selectable4 .ui-selecting { background: #FECA40; }
	 	#selectable4 .ui-selected { background: #F39814; color: white; }
	  	#selectable4 { list-style-type: none; margin: 0; padding: 0; width: 500px; }
		#selectable4 li { margin-left: 10px; padding: 1px; float: left; width: 80px; height: 24px; font-size: 15px; text-align: center; }
		
		
		#selectable5 .ui-selecting { background: #FECA40; }
	 	#selectable5 .ui-selected { background: #F39814; color: white; }
	  	#selectable5 { list-style-type: none; margin: 0; padding: 0; width: 500px; }
		#selectable5 li { margin-left: 10px; padding: 1px; float: left; width: 80px; height: 24px; font-size: 15px; text-align: center; }
	</style>
    
    
</head>

<body class="container">
<cfoutput>
	<cfform class="form-horizontal" role="form" id="dealerMenuForm" name="dealerMenuForm" action="dealerMenuProcess.cfm" method="post">
        <div class="page-header">
            <h3>#pageTitle#</h3>
        </div>
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
                    <h4 class="panel-title accordion-toggle">#words[1745]#</h4>
                </div>
                <div id="panel1Collapse" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-8">	
                                <div class="form-group">
                                    <label for="minSellingPriceControlLabel" class="col-sm-4 control-label">#words[1746]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="minSellingPriceControl" name="minSellingPriceControl" value="1" <cfif minSellingPriceControl EQ '1'>checked</cfif>>
                                                    <div id="passwordField" class="passwordField"  <cfif minSellingPriceControl NEQ '1'>style="display:none"</cfif>>
                                                        <input type="password" class="form-control input-sm" id="minSellingPricePassword" name="minSellingPricePassword" value="#minSellingPricePassword#" placeholder="#words[572]#">
                                                    </div>    	
                                                </div>													 
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="minSellingPriceEmailLabel" class="col-sm-4 control-label">#words[1747]# </label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="minSellingPriceEmail" name="minSellingPriceEmail" value="1" <cfif minSellingPriceEmail eq '1'>checked</cfif>>
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
                    <h4 class="panel-title accordion-toggle">#words[1748]#</h4>
                </div>
                <div id="panel2Collapse" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-8">	
                                <div class="form-group">
                                    <label for="sellingBelowCost" class="col-sm-4 control-label">#words[1749]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="sellingBelowCost" name="sellingBelowCost" value="Y" <cfif sellingBelowCost eq 'Y'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>     
                                <div class="form-group">
                                    <label for="sellingCannotLower" class="col-sm-4 control-label">#words[1750]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="sellingCannotLower" name="sellingCannotLower" value="Y" <cfif sellingCannotLower eq 'Y'>checked</cfif>>
                                                    <div id="showList1" class="showList1" <cfif sellingCannotLower NEQ 'Y'>style="display:none"</cfif>>
                                                        <ol id="selectable1">
                                                          <li id="selectable1li0" class="ui-state-default">#words[793]#</li>
                                                          <li id="selectable1li1" class="ui-state-default">#words[794]#</li>
                                                          <li id="selectable1li2" class="ui-state-default">#words[796]#</li>
                                                          <li id="selectable1li3" class="ui-state-default">#words[1752]#</li>
                                                          <li id="selectable1li4" class="ui-state-default">#words[1753]#</li>
                                                        </ol>  
                                                    </div>
                                                </div>		
                                                <input type="hidden" id="selectResult1" name="selectResult1" value="#sellingCannotLowerLIST#">
                                                							
                                            </div>
                                        </div>											
                                    </div>
                                </div>  
                                <div class="form-group">
                                    <label for="overCreditLimit" class="col-sm-4 control-label">#words[1751]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="overCreditLimit" name="overCreditLimit" value="Y" <cfif overCreditLimit eq 'Y'>checked</cfif>>
                                                    <div id="showList2" class="showList2" <cfif overCreditLimit NEQ 'Y'>style="display:none"</cfif>>
                                                        <ol id="selectable2">
                                                          <li id="selectable2li0" class="ui-state-default">#words[793]#</li>
                                                          <li id="selectable2li1" class="ui-state-default">#words[794]#</li>
                                                          <li id="selectable2li2" class="ui-state-default">#words[796]#</li>
                                                          <li id="selectable2li3" class="ui-state-default">#words[1752]#</li>
                                                          <li id="selectable2li4" class="ui-state-default">#words[1753]#</li>
                                                        </ol>  
                                                    </div>
                                                </div>
                                                <input type="hidden" id="selectResult2" name="selectResult2" value="#overCreditLimitLIST#">													
                                            </div>
                                        </div>											
                                    </div>
                                </div> 
                                <div class="form-group">
                                    <label for="overCreditTerm" class="col-sm-4 control-label">#words[1754]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="overCreditTerm" name="overCreditTerm" value="Y" <cfif overCreditTerm eq 'Y'>checked</cfif>>
                                                    <div id="showList3" class="showList3" <cfif overCreditTerm NEQ 'Y'>style="display:none"</cfif>>
                                                        <ol id="selectable3">
                                                          <li id="selectable3li0" class="ui-state-default">#words[793]#</li>
                                                          <li id="selectable3li1" class="ui-state-default">#words[794]#</li>
                                                          <li id="selectable3li2" class="ui-state-default">#words[796]#</li>
                                                          <li id="selectable3li3" class="ui-state-default">#words[1752]#</li>
                                                          <li id="selectable3li4" class="ui-state-default">#words[1753]#</li>
                                                        </ol>  
                                                    </div>
                                                </div>
                                                <input type="hidden" id="selectResult3" name="selectResult3" value="#overCreditTermLIST#">													
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="negativeStockControl" class="col-sm-4 control-label">#words[1755]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="negativeStockControl" name="negativeStockControl" value="Y" <cfif negativeStockControl eq 'Y'>checked</cfif>>
                                                    <div id="showList4" class="showList4" <cfif negativeStockControl NEQ 'Y'>style="display:none"</cfif>>
                                                        <ol id="selectable4">
                                                          <li id="selectable4li0" class="ui-state-default">#words[793]#</li>
                                                          <li id="selectable4li1 "class="ui-state-default">#words[794]#</li>
                                                          <li id="selectable4li2" class="ui-state-default">#words[796]#</li>
                                                          <li id="selectable4li3" class="ui-state-default">#words[1752]#</li>
                                                          <li id="selectable4li4" class="ui-state-default">#words[1753]#</li>
                                                        </ol>  
                                                    </div>
                                                </div>	
                                                <input type="hidden" id="selectResult4" name="selectResult4" value="#negativeStockControlLIST#">												
                                            </div>
                                        </div>											
                                    </div>
                                </div>  
								<div class="form-group">
                                    <label for="editBillPassword" class="col-sm-4 control-label">#words[1756]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="editBillPassword" name="editBillPassword" value="1" <cfif editBillPassword eq '1'>checked</cfif>>
                                                    <div id="showList5" class="showList5" <cfif editBillPassword NEQ '1'>style="display:none"</cfif>>
                                                        <ol id="selectable5">
                                                          <li id="selectable5li0" class="ui-state-default">#words[793]#</li>
                                                          <li id="selectable5li1" class="ui-state-default">#words[794]#</li>
                                                          <li id="selectable5li2" class="ui-state-default">#words[796]#</li>
                                                          <li id="selectable5li3" class="ui-state-default">#words[1752]#</li>
                                                          <li id="selectable5li4" class="ui-state-default">#words[1753]#</li>
                                                        </ol>  
                                                    </div>
                                                </div>
                                                <input type="hidden" id="selectResult5" name="selectResult5" value="#editBillPasswordLIST#">														
                                            </div>
                                        </div>											
                                    </div>
                                </div>                                 
                                <div class="form-group">
                                    <label for="passwordControl" class="col-sm-4 control-label">#words[1757]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="password" class="form-control input-sm" id="passwordControl" name="passwordControl" value="#passwordControl#" placeholder="#words[572]#">
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="tran_edit_term" class="col-sm-4 control-label">#words[2181]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="tran_edit_term" name="tran_edit_term" value="Y" <cfif tran_edit_term eq 'Y'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="tran_edit_name" class="col-sm-4 control-label">#words[2182]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="tran_edit_name" name="tran_edit_name" value="Y" <cfif tran_edit_name eq 'Y'>checked</cfif>>
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
                <div class="panel-heading" data-toggle="collapse" href="##panel3Collapse">
                    <h4 class="panel-title accordion-toggle">#words[1758]#</h4>
                </div>
                <div id="panel3Collapse" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-8">	                              
                                <div class="form-group">
                                    <label for="customCompany" class="col-sm-4 control-label">#words[1759]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div class="checkbox">	
                                                    <input type="checkbox" id="customCompany" name="customCompany" value="Y" <cfif customCompany eq 'Y'>checked</cfif>>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="custSuppSortBy" class="col-sm-4 control-label">#words[2183]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div>	
                                                	<select name="custSuppSortBy" id="custSuppSortBy" class="form-control input-sm">
                                                        <option value="custno,name" <cfif custSuppSortBy eq "custno,name">selected</cfif>>Cust/Supp No.</option>
                                                        <option value="name,custno" <cfif custSuppSortBy eq "name,custno">selected</cfif>>Cust/Supp Name</option>
                                                        <option value="created_on desc" <cfif custSuppSortBy eq "created_on desc">selected</cfif>>Date Created (Descending)</option>
                                                    </select>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="productSortBy" class="col-sm-4 control-label">#words[2184]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div>	
                                                	<select name="productSortBy" id="productSortBy" class="form-control input-sm">
                                                        <option value="itemno,desp" <cfif productSortBy eq "itemno,desp">selected</cfif>>Item No.</option>
                                                        <option value="desp,itemno" <cfif productSortBy eq "desp,itemno">selected</cfif>>Item Description</option>
                                                        <option value="created_on desc" <cfif productSortBy eq "created_on desc">selected</cfif>>Date Created (Descending)</option>
                                                    </select>
                                                </div>													
                                            </div>
                                        </div>											
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="transactionSortBy" class="col-sm-4 control-label">#words[2185]#</label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-7">
                                                <div>	
                                                	<select name="transactionSortBy" id="transactionSortBy" class="form-control input-sm">
                                                      	<option value="created_on desc,refno desc" <cfif transactionSortBy eq "created_on desc,refno desc">selected</cfif>>Date Created (Descending)</option>
                                                        <option value="wos_date desc,refno desc" <cfif transactionSortBy eq "wos_date desc,refno desc">selected</cfif>>Bill Date (Descending)</option>
                                                        <option value="wos_date ASC,refno ASC" <cfif transactionSortBy eq "wos_date ASC,refno ASC">selected</cfif>>Bill Date (Ascending)</option>
                                                        <option value="refno desc,wos_date desc" <cfif transactionSortBy eq "refno desc,wos_date desc">selected</cfif>>Refno (Descending)</option>
                                                    </select>
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
            <input type="submit" value="#pageAction#" class="btn btn-primary"/>
            <input type="button" value="Cancel" onclick="window.location='/latest/body/bodymenu.cfm?id=60100'" class="btn btn-default" />
        </div>
    </cfform> 
</cfoutput>
</body>
</html>

<script language="JavaScript" type="text/javascript">
		
		for(i=1; i<6;i++){
			var type=["DO","INV","CS","CN","DN"];
			for(j=0; j<5;j++){
				var last = type[j];
				if(document.getElementById('selectResult'+i).value.indexOf(last) >-1){		
					document.getElementById('selectable'+i+'li'+j).className="ui-selected";		
				}
			}
		}
</script>
