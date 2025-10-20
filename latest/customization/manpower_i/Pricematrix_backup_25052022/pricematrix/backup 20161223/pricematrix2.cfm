<cfprocessingdirective pageencoding="UTF-8">
<cfinclude template="/CFC/convert_single_double_quote_script.cfm">

<cfif IsDefined('url.priceid')>
	<cfset URLpriceid = trim(urldecode(url.priceid))>
</cfif>

<cfquery name="getgsetup" datasource='#dts#'>
    SELECT * 
    FROM gsetup;
</cfquery>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
	
	<cfquery name="createpricematrix" datasource="#dts#">
		INSERT INTO manpowerpricematrix (pricename) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.pricename)#">)
	</cfquery>
	
	<cfquery name="selectpricematrix" datasource="#dts#">
		SELECT * FROM manpowerpricematrix WHERE pricename=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.pricename)#">
		order by priceid desc
	</cfquery>
	
	
		<cfset pageTitle="Create Pay & Bill Structure">
		<cfset pageAction="Save">
        
        <!--- Panel 1--->
        <cfset priceid = selectpricematrix.priceid>
		<cfset pricename = selectpricematrix.pricename>

         
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Pay & Bill Structure">
		<cfset pageAction="Save">
        
		<cfquery name="selectpricematrix" datasource='#dts#'>
            SELECT * 
            FROM manpowerpricematrix 
            WHERE priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLpriceid#">;
		</cfquery>
        
        <!--- Panel 1--->
        <cfset priceid = selectpricematrix.priceid>
		<cfset pricename = selectpricematrix.pricename>
        
	</cfif> 
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <!---<link rel="stylesheet" href="/latest/css/form.css" />--->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>

    
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
	
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>

	<link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
	
	<script>
	
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
	
	
	function additem(){
	
		if(document.getElementById('itemname').value != ''){
		
		if(document.getElementById('payable').checked == true){
		var payable = 'Y'
		}
		else{
		var payable = 'N'
		}
		
		if(document.getElementById('billable').checked == true){
		var billable = 'Y'
		}
		else{
		var billable = 'N'
		}
		
		if(document.getElementById('saf').checked == true){
		var saf = 'Y'
		}
		else{
		var saf = 'N'
		}
		
		
			var dataString='action=add&priceid='+document.getElementById('priceid').value+'&itemid='+document.getElementById('itemname').value+'&itemname='+document.getElementById('itemname2').value+'&payable='+payable+'&billable='+billable+'&payadminfee='+encodeURIComponent(document.getElementById('payadminfee').value)+'&billadminfee='+encodeURIComponent(document.getElementById('billadminfee').value)+'&payableamt='+encodeURIComponent(document.getElementById('payableamt').value)+'&billableamt='+encodeURIComponent(document.getElementById('billableamt').value)+'&trancode='+document.getElementById('ntrancode').value+'&saf='+saf;
				$.ajax({	
					type:'POST',
					url:'pricematrix2ajax.cfm',
					data:dataString,
					dataType:'html',
					cache:false,
					async: false,
					success: function(result){
						$("#pricematrixajaxField").html(result);

						$('#itemname').select2('open');
						$('#payableamt').val('');
						$('#billableamt').val('');
						$('#payadminfee').val('');
						$('#billadminfee').val('');
						document.getElementById('payable').checked = false;
						document.getElementById('billable').checked = false;
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
				});
		
		
		}
		else{
		alert("Please Choose an Item!");
		}
	
	}
	
	function deleteitem(trancode){
		if(confirm("Delete This Item?")){
			var dataString='action=delete&priceid='+document.getElementById('priceid').value+'&trancode='+trancode;
				$.ajax({	
					type:'POST',
					url:'pricematrix2ajax.cfm',
					data:dataString,
					dataType:'html',
					cache:false,
					async: false,
					success: function(result){
						$("#pricematrixajaxField").html(result);
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
				});
		}
	}
	<!---
	function changepayable(){
		if(document.getElementById('payable').checked == true){
			document.getElementById("payableamt").readOnly = false;
			document.getElementById("payadminfee").readOnly = false;
		}
		else{
			document.getElementById("payableamt").readOnly = true;
			document.getElementById("payadminfee").readOnly = true;
			document.getElementById("payableamt").value = "0.00";
			document.getElementById("payadminfee").value = "0";
		}
	
	}
	
	function changebillable(){
		if(document.getElementById('billable').checked == true){
			document.getElementById("billableamt").readOnly = false;
			document.getElementById("billadminfee").readOnly = false;
		}
		else{
			document.getElementById("billableamt").readOnly = true;
			document.getElementById("billadminfee").readOnly = true;
			document.getElementById("billableamt").value = "0.00";
			document.getElementById("billadminfee").value = "0";
		}
	
	}--->
	
	
	
	</script>
	
	
	<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
			function formatResult2(result){
				return result.dballid+' - '+result.dballname; 
			};
			
			function formatSelection2(result){
				$('##itemname2').val(result.dballname);
				return result.dballid+' - '+result.dballname;  
			};
		
			$(document).ready(function(e) {
				$('.itemnameFilter').select2({
					ajax:{
						type: 'POST',
						url:'filteritemname.cfc',
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
								url:'filteritemname.cfc',
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
					placeholder:"Choose a Item Name",
					
					
					
				}).select2('val','');
			});
    </script>
</cfoutput>
	

	
	
    
</head>

<body class="container">
<cfoutput>
<cfform id="form" name="form" class="form-horizontal" role="form" action="pricematrixProfile.cfm" method="post" onsubmit="return validatefield();" >
	<div class="page-header">
		<h3>#pageTitle#</h3>
	</div>
		<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Header</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<table width="100%">
                                <tr>
                                <th><div align="right">Pay & Bill Structure Name</div></th>
                                <td>
                                <input type="hidden" name="priceid" id="priceid" value="#priceid#">
											<cfinput type="text" size="50" id="pricename" name="pricename"  placeholder="Pay & Bill Structure Name" value="#pricename#" readonly required="true" message="Please Key In Pay & Bill Structure Name">									
                                </td>
                                </tr>
                                <tr>
                                <td colspan="100%">
                                <table width="100%">
                                <tr>
                                <th>Item Name</th>
                                <th>Payable</th>
                                <th><div align="right">Amount</div></th>
                                <th>Billable</th>
                                <th><div align="right">Amount</div></th>
                                <th><div align="right">Admin Fee</div></th>
                                <th>Same Statutory AF<br />

(only applicable for %)</th>
                                </tr>
                                <tr>
											<cfquery name="getallitem" datasource="#dts#">
                                            SELECT *  FROM (SELECT itemno,desp FROM icitem ORDER by itemno) as a
                                            union all
                                            SELECT *  FROM (
                                            SELECT concat("B-",cate) as itemno, desp FROM iccate order by cate
                                            ) as b
                                            union all
                                            SELECT *  FROM (
                                            SELECT
                                            concat("A-",shelf) as itemno, desp from icshelf order by length(shelf),shelf
                                            ) as c
                                            
                                            </cfquery>
                                            <td>
                                         <select name="itemname" id="itemname" onchange="document.getElementById('itemname2').value=this.options[this.selectedIndex].id" style="width:150px">
                                         <option value="">Choose an Item</option>
                                         <cfloop query="getallitem">
                                         <option value="#getallitem.itemno#" id="#getallitem.desp#">#getallitem.itemno# - #getallitem.desp#</option>
                                         </cfloop>
                                         <option value="ALLAWEXC" id="All AW EXCEPT 0%">All AW EXCEPT 0%</option>
                                         </select>
                                         <input type="hidden" name="itemname2" id="itemname2" value="" />
                                         
										</td>
                                        
										
										<td>
											<input type="checkbox" id="payable" name="payable" value="1" />
										</td>
                                        <td>
										<input type="text" class="form-control input-sm" style="text-align:right" id="payableamt" name="payableamt" value="" placeholder="Payable Amount" />
										</td><input type="hidden" class="pull-right form-control input-sm" style="text-align:right" id="payadminfee" name="payadminfee" value="" placeholder="Pay Admin Fee" />
                                        
										<td>
											<input type="checkbox" id="billable" name="billable" value="1" />
										</td>
                                        <td>
											<input type="text" class="form-control input-sm" style="text-align:right" id="billableamt" name="billableamt" value="" placeholder="Billable Amount" />
										</td>
                                        <td>
										<input type="text" class="pull-right form-control input-sm" style="text-align:right" id="billadminfee" name="billadminfee" value="" placeholder=" Billable Admin Fee" />
										</td>
                                        <td>
											<input type="checkbox" id="saf" name="saf" value="1" />
										</td>
										
					</tr>
                    <tr>
                    <td colspan="100%" align="center">					
									
											<input type="button" id="addlist" name="addlist" value="Add" onclick="additem();" />
										</td>
                                </tr>
                                </table>
                                </td>
                                </tr>
                                </table>
                		</div>
                	</div>					
				</div>
				
				
				<div id="pricematrixajaxField">
				<cfquery name="getmaxtrancode" datasource="#dts#">
							SELECT ifnull(max(trancode),0) as trancode from manpowerpricematrixdetail where priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
				</cfquery>
				<input type="hidden" name="ntrancode" id="ntrancode" value="#getmaxtrancode.trancode+1#">
					
					
				<cfquery name="getpriceiddetail" datasource="#dts#">
							SELECT * from manpowerpricematrixdetail where priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
							ORDER by trancode
				</cfquery>
				
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Details</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12"> 
                                 	
                                    
                                    <div class="form-group">
										<label for="itemname" class="col-sm-1 pull-left">Item Name</label>
										<label for="itemname" class="col-sm-1 control-label">Payable</label>
										<label for="itemname" class="col-sm-2 control-label">Amount</label>
										<!--- <label for="itemname" class="col-sm-2 control-label">Admin Fee</label> --->
										<label for="itemname" class="col-sm-1 control-label">Billable</label>
										<label for="itemname" class="col-sm-2 control-label">Amount</label>
										<label for="itemname" class="col-sm-2 control-label">Admin Fee</label>
                                         <label for="itemname" class="col-sm-2 control-label">Same Statutory AF<br />
(only applicable for %)</label>
										<label for="itemname" class="col-sm-1 control-label">Action</label>
									</div>
									
									<cfloop query="getpriceiddetail">
									<div class="form-group">
										<div class="col-sm-1" >
											#getpriceiddetail.itemname#
										</div>
										<div class="col-sm-1" align="center">
											#getpriceiddetail.payable#
										</div>
										<div class="col-sm-2" align="right">
											#getpriceiddetail.payableamt#
										</div>
										<!--- <div class="col-sm-2" align="right">
											#getpriceiddetail.payadminfee#
										</div> --->
										
										<div class="col-sm-1" align="center">
											#getpriceiddetail.billable#
										</div>
										<div class="col-sm-2" align="right">
											#getpriceiddetail.billableamt#
										</div>
										<div class="col-sm-2" align="right">
											#getpriceiddetail.billadminfee#
										</div>
                                        <div class="col-sm-2" align="right">
											#getpriceiddetail.saf#
										</div>
										<div class="col-sm-1" align="right">
											<input type="button" id="deletebtn" name="deletebtn" value="Delete" onclick="deleteitem('#getpriceiddetail.trancode#')" />
										</div>
									</div>
									</cfloop>

            					</div>
            				</div>
                		</div>
                	</div>					
				</div>
				</div>
			
                
				 
			</div>
            <hr>
            <div class="pull-right">
				<input type="button" value="#pageAction#" onclick="form.submit();" class="btn btn-primary">
				<input type="button" value="Cancel" onclick="window.location='pricematrixProfile.cfm';" class="btn btn-default" />
            </div>
        
</cfform>

</cfoutput>
</body>
</html>


