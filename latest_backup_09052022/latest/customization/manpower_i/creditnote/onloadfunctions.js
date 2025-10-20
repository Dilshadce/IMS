$(document).ready(function(e) {
	$('.input-group.date').datepicker({
		format: "dd/mm/yyyy",
		todayBtn: "linked",
		autoclose: true,
		todayHighlight: true
	});
	});
	
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		var custno = '';
		var itemno = '';
		
		function formatResultItem(result){
				return result.itemno+' - '+result.desp;  
			};
			
			function formatSelectionItem(result){
				document.getElementById('desp').value=result.desp;
				return result.itemno+' - '+result.desp;  
			};
			
			function formatResultAssign(result){
				return result.date+' - '+result.refno+' - '+result.empname;  
			};
			
			function formatSelectionAssign(result){
				return result.date+' - '+result.refno+' - '+result.empname;  
			};
			
			$(document).ready(function(e) {
			var itemno = $("##itemno").val();
				$('.itemFilter').select2({
							ajax:{
								type: 'POST',
								url:'filterItem.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
										term:term,
										itemno:itemno,
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
										url:'filterItem.cfc',
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
							formatResult:formatResultItem,
							formatSelection:formatSelectionItem,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
						}).select2('val','');
						
						var assignrefno = $("##assignrefno").val();
				$('.AssignFilter').select2({
							ajax:{
								type: 'POST',
								url:'filterAssign.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
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
										url:'filterAssign.cfc',
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
							formatResult:formatResultAssign,
							formatSelection:formatSelectionAssign,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
						}).select2('val','');
			
			
				$("##addinvbtn").click(function () {

				
					var uuid = $("##uuid").val();
					var refno = $("##refno").val();
					var tran = $("##tran").val();
					var invno = $("##invoiceno").val();
					var custno = $("##custno").val();
					var dataString = "refno="+escape(refno);
					dataString = dataString+"&tran="+escape(tran);
					dataString = dataString+"&invno="+escape(invno);
					dataString = dataString+"&custno="+escape(custno);
					dataString = dataString+"&uuid="+uuid;

				$.ajax({
					type:"POST",
					url:"addproductsAjax.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){
						$("##body_section").html(result);
						calculatefooter();
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						
					}
				});
				});
				
				$("##additembtn").click(function () {
					
					if($("##itemno").val() == '' || $("##completedate").val() == '' ||$("##startdate").val()==''|| $("##assignrefno").val() == ''){
						alert('Item, Start Date, Complete Date and Assignmentslip must not be empty! Please select an item to add.');
						document.getElementById('additembtn').disabled = false;
					}else{
					
					var uuid = $("##uuid").val();
					var refno = $("##refno").val();
					var tran = $("##tran").val();
					var wos_date = $("##wos_date").val();
					var invno = $("##invoiceno").val();
					var custno = $("##custno").val();
					var itemno = $("##itemno").val();
					var desp = $("##desp").val();
					var qty = $("##qty").val();
					var price = $("##price").val();
					var amount = $("##amount").val();
					var startdate = $("##startdate").val();
					var completedate = $("##completedate").val();
					var assignrefno = $("##assignrefno").val();
					var dataString = "refno="+escape(refno);
					dataString = dataString+"&tran="+escape(tran);
					dataString = dataString+"&invno="+escape(invno);
					dataString = dataString+"&custno="+escape(custno);
					dataString = dataString+"&startdate="+escape(startdate);
					dataString = dataString+"&completedate="+escape(completedate);
					dataString = dataString+"&assignrefno="+escape(assignrefno);
					dataString = dataString+"&itemno="+itemno;
					dataString = dataString+"&desp="+desp;
					dataString = dataString+"&qty="+qty;
					dataString = dataString+"&price="+price;
					dataString = dataString+"&amount="+amount;
					dataString = dataString+"&wos_date="+wos_date;
					dataString = dataString+"&uuid="+uuid;

					$.ajax({
						type:"POST",
						url:"addsingleproductsAjax.cfm",
						data:dataString,
						dataType:"html",
						cache:false,
						success: function(result){
							$("##body_section").html(result);
							calculatefooter();
						},
						error: function(jqXHR,textStatus,errorThrown){
							alert(errorThrown);
						},
						complete: function(){
							
						}
					});
					}
				});
		});