<cfprocessingdirective pageencoding="UTF-8">
<cfinclude template="/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getgsetup" datasource='#dts#'>
    SELECT * 
    FROM gsetup;
</cfquery>

<cfif isdefined('url.refno')>
<cfset refno=urldecode(url.refno)>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>PO Link Page</cfoutput></title>
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
	
	
	
	
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
	<script type="text/javascript" src="jquery.sortable.min.js"></script>
	
	
	<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
			function formatResultpo(result){
				return result.id+' - '+result.custno+' '+result.name; 
			};
			
			function formatSelectionpo(result){
				$('##name').val(result.name);
				return result.id+' - '+result.custno+' '+result.name;  
			};
		
			$(document).ready(function(e) {
				$('.ponoFilter').select2({
					ajax:{
						type: 'POST',
						url:'filterpo.cfc',
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
								url:'filterpo.cfc',
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
					formatResult:formatResultpo,
					formatSelection:formatSelectionpo,
					minimumInputLength:0,
					width:'off',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose a PO Number",
					
					
					
				}).on('change', function (e) {
				
				var dataString='refno='+document.getElementById('refno').value;
				$.ajax({	
					type:'POST',
					url:'polistajax.cfm',
					data:dataString,
					dataType:'html',
					cache:false,
					async: false,
					success: function(result){
						$("##polistajaxfield").html(result);
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
				});
				});
				
				<cfif isdefined('url.refno')>
				var dataString="refno=#refno#";
				$.ajax({	
						type:'POST',
						url:'polistajax.cfm',
						data:dataString,
						dataType:'html',
						cache:false,
						async: false,
						success: function(result){
							$("##polistajaxfield").html(result);
						},
						error: function(jqXHR,textStatus,errorThrown){
							alert(errorThrown);
						},
				});
				</cfif>
				
			});
			
			$(function () {
				$(".source, .target").sortable({
					connectWith: ".connected"
				});
			});
			
			$('.source li').dblclick(function() {
				var litem = $(this).clone();
				litem.appendTo($('.target'));
				$(this).remove();
			});
			
			$('.target li').dblclick(function() {
				var litem = $(this).clone();
				litem.appendTo($('.source'));
				$(this).remove();
			});

			function updateValues() {
				
				var dataString = [];
				$("ul.target").children().each(function() {
				  var jono = $(this).text();
				  dataString.push(jono);
				});
				
				dataString = "jono="+dataString
				
				dataString = dataString+"&refno="+document.getElementById('refno').value;
					
				$.ajax ({
				  url: "updatepolink.cfm",
				  type: "POST",
				  data: dataString,
				  dataType: "html",

				  success: function(){alert('PO Link Has Been Saved')},
				  error: function(){alert('Error Linking Bills')}
				});
			};
		
		
		
		
			
			
		</script>
	</cfoutput>
    
</head>

<body class="container">
<cfoutput>
	<div class="page-header">
		<h3>PO Link to JO</h3>
	</div>
		<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Link Header</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12"> 
                                 	<div class="form-group">
										<label for="pono" class="col-sm-2 control-label">PO Number</label>
                                        <div class="col-sm-4">
                                            <input type="hidden" id="refno" name="refno" class="ponoFilter" <cfif isdefined('url.refno')>value="#refno#"<cfelse>value=""</cfif> />
                                        </div>
									</div>
            					</div>
            				</div>
                		</div>
                	</div>
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse2">
						<h4 class="panel-title accordion-toggle">Link Detail</h4>
					</div>
                    <div id="panel1Collapse2" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12" id="polistajaxfield"> 
									<div class="form-group">
										<label for="pono" class="col-sm-6 control-label" style="text-align: center;" >JO Listing</label>
										<label for="pono" class="col-sm-6 control-label" style="text-align: center;" >In PO List</label>
									</div>
									
									<div class="form-group">
										<div class="col-sm-6">
										<ul class="source connected">
										  
										</ul>
										</div>
										<div class="col-sm-6">
											<ul class="target connected">
											</ul>
										</div>
									</div>
									
								</div>
            				</div>
                		</div>
                	</div>

					
				</div>
			
                
				 
			</div>
            <hr>
            <div class="pull-right">
				<input type="button" value="Save" class="btn btn-primary" onclick="updateValues();">
				<input type="button" value="Cancel" onclick="window.location='poProfile.cfm'" class="btn btn-default" />
            </div>

</cfoutput>
</body>
</html>
