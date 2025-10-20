<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var table='#target_arcust#';
		var limit=10;
		
			function formatResult2(result){
				return result.customerNo+' - '+result.name+' '+result.name2; 
			};
			
			function formatSelection2(result){
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
								table:table,
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
									table:table,
									value:value,
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
				});
				
				
				<!--- --->
				
				$('##custno').change(function(e) {
		var custno=$('##custno').select2('val');
		var targetTable=$("##targetTable").val();
		if (custno=='createNewTarget'){
			$("##target_div").css("display","none");
			$("##create_target_div").css("display","block");
		}else{
			var dataString="action=getTargetDetail&targetTable="+targetTable+"&custno="+custno;
			$.ajax({
				type:"POST",
				url:"/latest/transaction/TransactionAjax.cfm",
				data:dataString,
				dataType:"json",
				cache:false,
				success: function(result){
					var custinfo="";
					$("##name").val(result.NAME);
					$("##name2").val(result.NAME2);
					$("##b_name").val(result.NAME);
					$("##b_name2").val(result.NAME2);
					$("##b_add1").val(result.ADD1);
					$("##b_add2").val(result.ADD2);
					$("##b_add3").val(result.ADD3);
					$("##b_add4").val(result.ADD4);
					$("##b_attn").val(result.ATTN);
					$("##b_phone").val(result.PHONE);
					$("##b_phone2").val(result.PHONEA);
					$("##b_fax").val(result.FAX);
					$("##postalcode").val(result.POSTALCODE);
					$("##b_email").val(result.EMAIL);
					$("##d_name").val(result.NAME);
					$("##d_name2").val(result.NAME2);
					$("##d_add1").val(result.DADDR1);
					$("##d_add2").val(result.DADDR2);
					$("##d_add3").val(result.DADDR3);
					$("##d_add4").val(result.DADDR4);
					$("##d_attn").val(result.DATTN);
					$("##d_phone").val(result.DPHONE);
					$("##d_phone2").val(result.CONTACT);
					$("##d_fax").val(result.FAX);
					$("##d_postalcode").val(result.POSTALCODE);
					$("##d_email").val(result.EMAIL);
					
				},
				error: function(jqXHR,textStatus,errorThrown){
					alert(errorThrown);
				}
			});
		};
    });
			
				
				
			});
			
			
			
			
    </script>
</cfoutput>