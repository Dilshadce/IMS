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
	WHERE userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(dts)#">
	AND userid not like "ultra%"
	;
</cfquery>

<cfquery datasource="#dts#" name="getrefnoset">
	select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
    from refnoset
	where type = 'CPO'
	and counter = '1'
</cfquery>

<cfinvoke component="cfc.refno" method="processNum" oldNum="#getrefnoset.tranno#" returnvariable="custpono" />	

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="Create Customer PO">
		<cfset pageAction="Create">
        
        <!--- Panel 1--->
        <cfset refno = "">
        <cfset custno = "">
		<cfset name = "">
        <cfset wos_date= dateformat(now(),'dd/mm/yyyy')>
        <cfset povalidate = "">
        <cfset poamount = "0.00">
		<cfset notificationemail = "">
		<cfset notificationuser = "">
		<cfset notificationsetting = "">
		<cfset virtualpo = "">
		<cfset pothresholdamount = "">

         
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Customer PO">
		<cfset pageAction="Update">
        
		<cfquery name="getpo" datasource='#dts#'>
            SELECT * 
            FROM manpowerpo 
            WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLrefno#">;
		</cfquery>
        
        <!--- Panel 1--->
        <cfset refno = getpo.refno>
        <cfset custno = getpo.custno>
        <cfset wos_date= dateformat(getpo.wos_date,'dd/mm/yyyy')>
        <cfset povalidate = dateformat(getpo.povalidate,'dd/mm/yyyy')>
        <cfset poamount = getpo.poamount>
		<cfset notificationemail = getpo.notificationemail>
		<cfset notificationuser = getpo.notificationuser>
		<cfset notificationsetting = getpo.notificationsetting>
		<cfset virtualpo = getpo.virtualpo>
		<cfset pothresholdamount = getpo.pothresholdamount>
		<cfset name = getpo.name>
	</cfif> 
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
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
	
	if(document.getElementById('custno').value == ""){
		alert('Please Choose A Customer')
		return false;
	}
	
	if((document.getElementById('poamount').value*1) == null || (document.getElementById('poamount').value*1) == 0){
		alert('Please Key In PO Amount')
		return false;
	}

		

	}
	<cfoutput>
	
	function virtualpofunc(){
	if(document.getElementById('virtualpo').checked == true){
	document.getElementById('refno').value='#custpono#';
	document.getElementById("refno").readOnly = true;
	}
	else{
	document.getElementById('refno').value='';
	document.getElementById("refno").readOnly = false;
	}
	
	}
	</cfoutput>
	
	</script>
	
	
	<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
			function formatResult2(result){
				return result.customerNo+' - '+result.name+' '+result.name2; 
			};
			
			function formatSelection2(result){
				$('##name').val(result.name);
				return result.customerNo+' - '+result.name+' '+result.name2;  
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
					
					<cfif NOT IsDefined('customer')>
						<cfset customer = "">
					</cfif>
					
				}).select2('val','#customer#');
			});
    </script>
</cfoutput>
	
	
	
	
	
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
	
	
    
</head>

<body class="container">
<cfoutput>
<cfform id="form" name="form" class="form-horizontal" role="form" action="poProcess.cfm?action=#url.action#" method="post" onsubmit="return validatefield();" >
	<div class="page-header">
		<h3>#pageTitle#</h3>
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
										<div class="col-sm-3">
										<cfif IsDefined("url.action") AND url.action NEQ "create">
											<cfinput type="text" class="form-control input-sm" id="refno" name="refno"  placeholder="PO Number" value="#refno#" readonly required="true" message="Please Key In PO Number">									
                                        <cfelse>
											<cfinput type="text" class="form-control input-sm" id="refno" name="refno"  placeholder="PO Number" value="#refno#" required="true" message="Please Key In PO Number">									
										</cfif>
										</div>
										<div class="col-sm-2">
								
										<input type="checkbox" id="virtualpo" name="virtualpo" <cfif virtualpo neq "">checked</cfif> value="T" <cfif IsDefined("url.action") AND url.action NEQ "create">disabled</cfif> onclick="virtualpofunc();"> 
										
										<label for="refno"control-label">( Virtual PO )</label>
										</div>
										<label for="wos_date" class="col-sm-2 control-label">Date</label>
										<div class="col-sm-2">
											<div class="input-group date">       
                                                <input type="text" class="form-control input-sm" id="wos_date" name="wos_date" placeholder="Date" value="#wos_date#">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>											
										</div>
									</div>
                                    
                                    <div class="form-group">
										<label for="custno" class="col-sm-2 control-label">Customer</label>
                                        <div class="col-sm-4">
                                            <input type="hidden" id="custno" name="custno" class="customerFilter" value="#custno#" placeholder="Customer" />
											<input type="hidden" id="name" name="name" value="#name#" />
                                        </div>
										<label for="povalidate" class="col-sm-3 control-label">Valid Date</label>
										<div class="col-sm-2">
											<div class="input-group date">       
                                                <input type="text" class="form-control input-sm" id="povalidate" name="povalidate" value="#povalidate#" placeholder="Valid Date" >
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>									
										</div>
									</div>
									
									<div class="form-group">
										<label for="desp" class="col-sm-2 control-label">PO Amount</label>
										<div class="col-sm-3">
											<cfinput type="text" class="form-control input-sm" id="poamount" name="poamount" value="#poamount#" placeholder="PO Amount" validate="float" message="Please Key In Number Only">								
                                        </div>
		
									</div>
									
									<div class="form-group">
										<label for="desp" class="col-sm-2 control-label">PO Threshold Amount</label>
										<div class="col-sm-3">
											<cfinput type="text" class="form-control input-sm" id="pothresholdamount" name="pothresholdamount" value="#pothresholdamount#" placeholder="PO Threshold Amount" validate="float" message="Please Key In Number Only">								
                                        </div>
										<label for="desp" class="col-sm-4 control-label">Nofitication Fequency (Days)</label>
										<div class="col-sm-1">
											<input type="text" class="form-control input-sm" id="notificationsetting" name="notificationsetting" value="#notificationsetting#" placeholder="Days" maxlength="100">								
                                        </div>
									</div>
									
									<div class="form-group">
										
									</div>
									
									<div class="form-group">
										<label for="desp" class="col-sm-2 control-label">Notification Email</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="notificationemail" name="notificationemail" value="#notificationemail#" placeholder="Email" maxlength="100">								
                                        </div>
									</div>
									
									<div class="form-group">
										<label for="desp" class="col-sm-2 control-label">Notification Users</label>
										<div class="col-sm-8">
											<cfloop query="getusers">
											<div class="col-sm-3">
											<input type="checkbox" id="notificationuser" name="notificationuser" <cfif listfind(notificationuser,getusers.userid) gt 0>checked</cfif> value="#getusers.userid#">  #getusers.userid#
											</div>
											</cfloop>
                                        </div>
									</div>
									<cfif IsDefined("url.action") AND url.action NEQ "create">
									<div class="form-group pull-right">
										<div class="col-sm-8">
											<input type="button" onclick="window.open('polink.cfm?refno='+escape(document.getElementById('refno').value))" value="View PO Link TO JO" class="btn btn-primary">
                                        </div>
									</div>
									</cfif>
            					</div>
            				</div>
                		</div>
                	</div>					
				</div>
			
                
				 
			</div>
            <hr>
            <div class="pull-right">
				<input type="submit" value="#pageAction#" class="btn btn-primary">
				<input type="button" value="Cancel" onclick="window.location='poProfile.cfm'" class="btn btn-default" />
            </div>
        
</cfform>

</cfoutput>
</body>
</html>