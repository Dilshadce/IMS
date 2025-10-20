<cfprocessingdirective pageencoding="UTF-8">

<cfif IsDefined('url.refno')>
	<cfset URLrefno = trim(urldecode(url.refno))>
</cfif>

<cfinclude template="/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getgsetup" datasource='#dts#'>
    SELECT * 
    FROM gsetup;
</cfquery>

<cfquery name="getusers" datasource='main'>
    SELECT * 
    FROM users
	WHERE userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(dts)#">;
</cfquery>


<cfset uuid = createuuid()>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>Create New Credit Note</cfoutput></title>
    <!---<link rel="stylesheet" href="/latest/css/form.css" />--->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
	
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>


	<link rel="stylesheet" type="text/css" href="creditnote.css"/>
	
	<script>
	$(document).ready(function(e) {
	$('.input-group.date').datepicker({
		format: "dd/mm/yyyy",
		todayBtn: "linked",
		autoclose: true,
		todayHighlight: true
	});
	});
	
	
	function validatefield(){
	
	alert(document.getElementById('custno').value);
	
	}
	
	
	
	
	</script>
	
	
	
<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		var custno = '';
		
			function formatResult2(result){
				return result.customerNo+' - '+result.name+' '+result.name2; 
			};
			
			function formatSelection2(result){
				return result.customerNo+' - '+result.name+' '+result.name2;  
			};
			
			function formatResultINV(result){
				return result.wos_date+' - '+result.refno; 
			};
			
			function formatSelectionINV(result){
				return result.wos_date+' - '+result.refno;  
			};
		
			$(document).ready(function(e) {
				$('.customerFilter').select2({
					ajax:{
						type: 'POST',
						url:'/latest/filter/filterCustomer.cfc',
						dataType:'json',
						data:function(term,page){
							return{
								method:'listAccount',
								returnformat:'json',
								dts:dts,
								Hlinkams:Hlinkams,
								term:term,
								limit:limit,
								page:page-1,
							};
						},
						results:function(data,page){
							var more=((page-1)*limit)<data.total;
							return{
								results:data.result,
								more:more
							};
						}
					},
					initSelection: function(element, callback) {
						var value=$(element).val();
						if(value!=''){
							$.ajax({
								type:'POST',
								url:'/latest/filter/filterCustomer.cfc',
								dataType:'json',
								data:{
									method:'getSelectedAccount',
									returnformat:'json',
									dts:dts,
									value:value,
									Hlinkams:Hlinkams,
								},
							}).done(function(data){callback(data);});
						};
					},
					formatResult:formatResult2,
					formatSelection:formatSelection2,
					minimumInputLength:0,
					width:'off',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose a Customer",
					
				}).on('change', function (e) {
				var custno = $("##custno").val();
				alert(custno);
					$('.invoiceFilter').select2({
							ajax:{
								type: 'POST',
								url:'filterInvoice.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
										term:term,
										custno:custno,
										limit:limit,
										page:page-1,
									};
								},
								results:function(data,page){
									var more=((page-1)*limit)<data.total;
									return{
										results:data.result,
										more:more
									};
								}
							},
							initSelection: function(element, callback) {
								var value=$(element).val();
								if(value!=''){
									$.ajax({
										type:'POST',
										url:'filterInvoice.cfc',
										dataType:'json',
										data:{
											method:'getSelectedAccount',
											returnformat:'json',
											dts:dts,
											value:value,
										},
									}).done(function(data){callback(data);});
								};
							},
							formatResult:formatResultINV,
							formatSelection:formatSelectionINV,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
						}).select2('val','');
				});
				
				
				
				$('.invoiceFilter').select2({
							ajax:{
								type: 'POST',
								url:'filterInvoice.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
										term:term,
										custno:custno,
										limit:limit,
										page:page-1,
									};
								},
								results:function(data,page){
									var more=((page-1)*limit)<data.total;
									return{
										results:data.result,
										more:more
									};
								}
							},
							initSelection: function(element, callback) {
								var value=$(element).val();
								if(value!=''){
									$.ajax({
										type:'POST',
										url:'filterInvoice.cfc',
										dataType:'json',
										data:{
											method:'getSelectedAccount',
											returnformat:'json',
											dts:dts,
											value:value,
										},
									}).done(function(data){callback(data);});
								};
							},
							formatResult:formatResultINV,
							formatSelection:formatSelectionINV,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
						}).select2('val','');
			
			
				$("##addinvbtn").click(function () {
				alert(1);
				<!---
					var uuid = $("#uuid").val();
					var refno = $("#refno").val();
					var invno = $("#invno").val();
					var custno = $("#custno").val();
					var dataString = "refno="+escape(refno);
					dataString = dataString+"&invno="+escape(invno);
					dataString = dataString+"&custno="+escape(custno);
					dataString = dataString+"&uuid="+uuid;
					$.ajax({
							type: "POST",
							url: "addproductsAjax.cfm",
							data: dataString,
							dataType: "json",
							cache: false,
							success: function(result){
									$.ajax({
									type:'POST',
									url:'/latest/transaction/simpleNew/simpleNewAjax.cfm',
									data:dataString,
									dataType:'html',
									cache:false,
									success: function(result){
									alert(1);
									$("#item_table_body").html(result);
									},
									error: function(jqXHR,textStatus,errorThrown){
												alert(errorThrown);
									},
									complete: function(){
									}
									});
									},
								});
							},
							error: function(jqXHR,textStatus,errorThrown){
								alert(errorThrown);
							}
				--->
				});

			});
    </script>
</cfoutput>

	
	
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
	
	
    
</head>

<body class="container">
<cfoutput>
<cfform id="form" name="form" class="form-horizontal" role="form" action="poProcess.cfm" method="post" onsubmit="return validatefield();" >
	<div class="page-header">
		<h3>Create CN/DN</h3>
	</div>
		<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Details</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12"> 
                                 	<div class="form-group">
										<label for="refno" class="col-sm-2 control-label">PO number</label>
										<div class="col-sm-4">
										
											<cfinput type="text" class="form-control input-sm" id="refno" name="refno"  placeholder="PO Number" value="" readonly required="true" message="Please Key In PO Number">									
										</div>
										<label for="wos_date" class="col-sm-2 control-label">Date</label>
										<div class="col-sm-2">
											<div class="input-group date">       
                                                <input type="text" class="form-control input-sm" id="wos_date" name="wos_date" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>											
										</div>
									</div>
                                    
                                    <div class="form-group">
										<label for="custno" class="col-sm-2 control-label">Customer</label>
                                        <div class="col-sm-10">
                                            <input type="hidden" id="custno" name="custno" class="customerFilter" value="" placeholder="Customer" />
                                        </div>
										
									</div>
									
									<div class="form-group">
										<label for="invoiceno" class="col-sm-2 control-label">Invoice</label>
                                        <div class="col-sm-3">
                                            <input type="hidden" id="invoiceno" name="invoiceno" class="invoiceFilter" value="" placeholder="Invoice" />
                                        </div>
										<div class="col-sm-1">
                                            <input type="button"  class="form-control input-sm" id="addinvbtn" name="addinvbtn" value="Add" />
                                        </div>
									</div>
									

            					</div>
            				</div>
                		</div>
						<form>
							<div class="row" id="body_section">  
								<table class="itemTable">
									<thead>
										<tr class="itemTableTR">
											<th class="th_one itemTableTH">Invoice Number</th>
											<th class="th_two itemTableTH">Item Number</th>
											<th class="th_three itemTableTH">Description</th>
											<th class="th_four itemTableTH">Quantity</th>
											<th class="th_five itemTableTH">Price</th>
											<th class="th_six itemTableTH">Amount</th>
										</tr>
									</thead>
									<tbody id="item_table_body">
										
									</tbody>
								</table>
							</div>
						</form> 
						
                	</div>					
				</div>
				
				
			
                
				 
			</div>
			
	
			
			
			
			
			
            <hr>
            <div class="pull-right">
				<input type="submit" value="Create" class="btn btn-primary">
				<input type="button" value="Cancel" onclick="window.location='poProfile.cfm'" class="btn btn-default" />
            </div>
        
</cfform>

</cfoutput>
</body>
</html>