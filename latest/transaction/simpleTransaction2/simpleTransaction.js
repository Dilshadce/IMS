var keyPressed = "";
var limit = 10;
var totalTrancodeValue = 1;
var defaultValueCounter = 0;
var priceDecimalCounter = '';
var discountDecimalCounter = '';
var totalDecimalCounter = '';


$(document).ready(function(e) {
	
	/*$(document).ajaxSend(function(event, request, settings) {
		$('#loading_indicator').show();
	});
	
	$(document).ajaxComplete(function(event, request, settings) {
		$('#loading_indicator').hide();
	});*/
	
	if(action=='Create'){
		$('.createButton').attr('disabled',true);
		$('#custno').parent().addClass('has-error');
		$("#custno,#refno,#wos_date").on("change", function() {
			if(!$(this).val()){
				$(this).parent().addClass('has-error');	
				$('.createButton').attr('disabled',true);
			}
			else{
				$(this).parent().removeClass('has-error');	
				createValidation();
			};
		});
		
		initItemnoSelect2(1);
		initialItemVariableValue(1);
		initialFooterVariableValue();	
		changeRefNoSet(1);
		getTax(1);
		showHideDeleteItem(0,1);
		$('#itemno_label_1').hide();
		setDecimalPlaces();
		initializeNumericValues();
		getCurrencyRate();	
		initializeTooltips();	
	}
	else{
		initCustnoSelect2();
		setDecimalPlaces();
		initializeNumericValues();
		getBillDetails();
		showHideDeleteItem(totalTrancodeValue,1);
		initializeTooltips();
	};	

	showHideTableColumn();	
	
	$('#custno').select2({
		ajax:{
			type: 'POST',
			url:'simpleTransaction.cfc',
			dataType:'json',
			cache:false,
			data:function(term,page){
				return{
					method:'listMatchedTargets',
					returnformat:'json',
					dts:dts,
					HlinkAMS:HlinkAMS,
					target:target,
					targetTable:targetTable,
					term:term,
					limit:limit,
					page:page-1
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
			var custno=$(element).val();
			if(custno!=''){
				$.ajax({
					type:'POST',
					url:'simpleTransaction.cfc',
					dataType:'json',
					cache:false,
					data:{
						method:'getSelectedTarget',
						returnformat:'json',
						dts:dts,
						HlinkAMS:HlinkAMS,
						targetTable:targetTable,
						custno:custno
					}
				}).done(function(data){callback(data);});
			};
		},
		width: '100%',
		formatResult: function (data) {
        	return data.text;
    	},	
		placeholder: "Select "+target,	
	}).select2('focus');
	
	
	$('#INVno').select2({
		ajax:{
			type: 'POST',
			url:'simpleTransaction.cfc',
			dataType:'json',
			cache:false,
			data:function(term,page){
				return{
					method:'listMatchedINV',
					returnformat:'json',
					dts:dts,
					/*HlinkAMS:HlinkAMS,
					target:target,
					targetTable:targetTable,*/
					term:term,
					limit:limit,
					page:page-1
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
			var INVno=$(element).val();
			if(INVno!=''){
				$.ajax({
					type:'POST',
					url:'simpleTransaction.cfc',
					dataType:'json',
					cache:false,
					data:{
						method:'getSelectedINV',
						returnformat:'json',
						dts:dts,
						/*HlinkAMS:HlinkAMS,
						targetTable:targetTable,*/
						INVno:INVno
					}
				}).done(function(data){callback(data);});
			};
		},
		width: '100%',
		formatResult: function (data) {
        	return data.text;
    	},	
		placeholder: "Select Tax Invoice",	
	});
	
	

	$('#custno').change(function(e) {
		defaultValueCounter = 1;
		initCustnoSelect2();
		$('#itemno_input_1').select2('open');	
    });
		
	/*Click SAVE create customer */
	$("#submit_create_target").click(function(e){
		var custno=$("#create_custno").val();
		var name=$("#create_name").val();
		var name2=$("#create_name2").val();
		var attn=$("#create_attn").val();
		var add1=$("#create_add1").val();
		var add2=$("#create_add2").val();
		var add3=$("#create_add3").val();
		var add4=$("#create_add4").val();
		var country=$("#create_country").val();
		var postalcode=$("#create_postalcode").val();
		var phone=$("#create_phone").val();
		var hp=$("#create_hp").val();
		var fax=$("#create_fax").val();
		var email=$("#create_email").val();
		var d_attn=$("#create_d_attn").val();
		var d_add1=$("#create_d_add1").val();
		var d_add2=$("#create_d_add2").val();
		var d_add3=$("#create_d_add3").val();
		var d_add4=$("#create_d_add4").val();
		var d_country=$("#create_d_country").val();
		var d_postalcode=$("#create_d_postalcode").val();
		var d_phone=$("#create_d_phone").val();
		var d_hp=$("#create_d_hp").val();
		var d_fax=$("#create_d_fax").val();
		var d_email=$("#create_d_email").val();
		var custNoExist=false;							
		var dataString="action=checkTargetCustno&";
		dataString=dataString+"targetTable="+targetTable+"&";
		dataString=dataString+"custno="+custno;	
									
		$.ajax({
			type:"POST",
			url:"simpleTransactionAjax.cfm",
			data:dataString,
			dataType:"html",
			cache:false,
			success: function(result){
				if(result>0){
					custNoExist=true;
				}else{
					custNoExist=false;
				};
			},
			error: function(jqXHR,textStatus,errorThrown){
				alert(errorThrown);
			},
			complete: function(){
				if(custNoExist==false){
					if(name==""){
						alert("Your "+target+"'s Name cannot be blank.");
						$("#name").focus();
					}else{
						var dataString="action=insertTarget&";
						dataString=dataString+"target="+target+"&";
						dataString=dataString+"targetTable="+targetTable+"&";
						dataString=dataString+"custno="+custno+"&";
						dataString=dataString+"name="+name+"&";
						dataString=dataString+"name2="+name2+"&";
						dataString=dataString+"attn="+attn+"&";
						dataString=dataString+"add1="+add1+"&";
						dataString=dataString+"add2="+add2+"&";
						dataString=dataString+"add3="+add3+"&";
						dataString=dataString+"add4="+add4+"&";
						dataString=dataString+"country="+country+"&";
						dataString=dataString+"postalcode="+postalcode+"&";
						dataString=dataString+"phone="+phone+"&";
						dataString=dataString+"hp="+hp+"&";
						dataString=dataString+"fax="+fax+"&";
						dataString=dataString+"email="+email+"&";
						dataString=dataString+"d_attn="+d_attn+"&";
						dataString=dataString+"d_add1="+d_add1+"&";
						dataString=dataString+"d_add2="+d_add2+"&";
						dataString=dataString+"d_add3="+d_add3+"&";
						dataString=dataString+"d_add4="+d_add4+"&";
						dataString=dataString+"d_country="+d_country+"&";
						dataString=dataString+"d_postalcode="+d_postalcode+"&";
						dataString=dataString+"d_phone="+d_phone+"&";
						dataString=dataString+"d_hp="+d_hp+"&";
						dataString=dataString+"d_fax="+d_fax+"&";
						dataString=dataString+"d_email="+d_email;
						
						$.ajax({
							type:"POST",
							url:"simpleTransactionAjax.cfm",
							data:dataString,
							dataType:"html",
							cache:false,
							success: function(result){
								alert("Created "+target+" successfully!");
							},
							error: function(jqXHR,textStatus,errorThrown){
								alert(errorThrown);
							},
							complete: function(){
								$('#custno').select2('val',custno);
								/*$('#myModalCreateCustomer').modal('hide');
								$('#myModalCreateCustomer').on('hidden', function () {
									$('input').val('');
								});*/
								initCustnoSelect2();
							}
						});
					};
				}else{
					alert("Your "+target+"'s No. exist already.Please input a new "+target+"'s No.");
				};
			}
		});
	});
	
	$("#close_create_target").click(function(e){


	});
	
	/*
		Function: Allow users to reshuffle the item's position.
		Action: getTotalTrancode
		Perform:  
				 Step 1: AJAX to get return of total item.
				 Step 2: Loop into an array.
				 Step 3: Pass the array to dropdown (X-Editable).
		Control: Can't reshuffle if 
				 i) Item Count EQ 0 or 1.		 		 	
				 ii) Itemno is blank/not selected. 
	*/
	$("form").on("click",".recordCount",function(e){
		
		var trancodeArray = [];
		var totalTrancode = 0;
		var trancode=$(this).closest("tr").attr("id");
		var itemno_input=$('#itemno_input_'+trancode).select2('val');
		var dataString="action=getTotalTrancode&";
		dataString=dataString+"uuid="+uuid;
		
		$.ajax({
				type: "POST",
				url: "simpleTransactionAjax.cfm",
				data: dataString,
				dataType: "json",
				cache: false,
				success: function(result){
					totalTrancode = result.TRANCODEID;
					for (var i = 1; i <= totalTrancode; i ++) {
						trancodeArray.push(i);	  
					};
					if(itemno_input != '' && totalTrancode > 1){
						$('#recordCount_'+trancode).editable({
							type: 'select',
							onblur: 'cancel',
							placement: 'right',
							source: function() {
								return trancodeArray;
							},
							success: function(response, newValue) {
										
									 	var dataString="action=updateTrancode&";
										dataString = dataString+"uuid="+uuid+"&";
									 	dataString=dataString+"currentTrancode="+trancode+"&";
									 	dataString=dataString+"newTrancode="+newValue;

										$.ajax({
											type:'POST',
											url:'simpleTransactionAjax.cfm',
											data:dataString,
											dataType:'html',
											cache:false,
											success: function(result){
														$("#item_table_body").html(result);
														initializeNumericValues();
														addRow(parseFloat(totalTrancode)+1);
														showHideDeleteItem(parseFloat(totalTrancode)+1,trancode);
														$('.itemno_label,.amt_input').addClass('input-disabled');
											},
											error: function(jqXHR,textStatus,errorThrown){
														alert(errorThrown);
											},
										});
    						},
						});
					};
				},
				error: function(jqXHR,textStatus,errorThrown){
					alert(errorThrown);
				}
		});
	});
	
	$("form").on("select2-close",".itemno_input",function(e){
		
		var trancode=$(this).closest("tr").attr("id");
		var itemno_input=$('#itemno_input_'+trancode).select2('val');
		if(itemno_input=="createNewItem"){
			
		}
		else if(itemno_input != '') {
						
			var dataString="action=getItemInfo&";
			dataString=dataString+"itemno_input="+escape(encodeURIComponent(itemno_input))+"&";
			dataString=dataString+"itemPriceType="+itemPriceType;
			
			$.ajax({
				type:'POST',
				url:'simpleTransactionAjax.cfm',
				data:dataString,
				dataType:'json',
				cache:false,
				success: function(result){
							$("#desp_input_"+trancode).val(result.DESP);
							$("#despa_input").val(result.DESPA);
							$("#comment_input").val(result.COMMENT);
							$("#price_input_"+trancode).val(Number(result.ITEMPRICE).toFixed(priceDecimalPoint));
							if(result.UNIT != ''){
								$("#unitOfMeasurement_input_"+trancode).val(result.UNIT);
							}
							else{
								$("#unitOfMeasurement_input_"+trancode).val(result.UNIT);
								$("#unitOfMeasurement_input_"+trancode).parent().addClass('has-error');	
								createValidation();
							}
							$("#factor1_"+trancode).val(1);
							$("#factor2_"+trancode).val(1);
							$("#lineCode_label_"+trancode).val(result.LINECODE);
				},
				error: function(jqXHR,textStatus,errorThrown){
					alert(errorThrown);
				},
				complete: function(){
					if (trancode >= totalTrancodeValue){
						$(".itemno_label").show();
						addRow(parseFloat(trancode)+1);
					}
					initializeNumericValues();
					itemCalculation(trancode);
					showHideDeleteItem(totalTrancodeValue,trancode);
					$('#itemno_label_'+trancode).val(itemno_input);
					$('#itemno_input_'+trancode).select2("destroy");
					$('.itemno_label,.amt_input').addClass('input-disabled');
					totalCalculation();
					updateItem(trancode,'');
				}
			});
		}				
	});
	
	$("#currcode,#wos_date").on("change", function() {
		getCurrencyRate();	
	});
	
	$("#currcode").on("change", function() {
		
		if($("#currcode").val() == ''){
			$("#currcode").parent().addClass('has-error');	
			$('.createButton').attr('disabled',true);
		}
		else{
			$("#currcode").parent().removeClass('has-error');	
			createValidation();
		};
	});
	
	$('#INVno').change(function(e) {
		
		var INVno=$("#INVno").val()
		var dataString="action=getINVdate&";
			dataString=dataString+"invoice_number="+escape(encodeURIComponent(INVno));
		$.ajax({
			type:"POST",
			url:'simpleTransactionAjax.cfm',
			data:dataString,
			dataType:'json',
			cache:false,
			success: function(result){
				$("#taxINVdate").val(result.DATE);
			},
			error: function(jqXHR,textStatus,errorThrown){
				alert(errorThrown);
			},
		});
    });

	
	$("form").on("change",".desp_input,.location_input,.factor1,.factor2",function(e){
		
		var trancode=$(this).closest("tr").attr("id");
		var itemno_input=$('#itemno_label_'+trancode).val();
		
		if(itemno_input != ''){
			updateItem(trancode,'');
		};	
	});
	
	$("form").on("change",".unitOfMeasurement_input",function(e){
		var trancode=$(this).closest("tr").attr("id");
		var itemno_label=$("#itemno_label_"+trancode).val();
		var qty_input=$("#qty_input_"+trancode).val();
		var unitOfMeasurement_input=$("#unitOfMeasurement_input_"+trancode).val();
		var dataString="action=getSecondUnitOfMeasurement&";
		dataString=dataString+"uuid="+uuid+"&";
		dataString=dataString+"trancode="+trancode+"&";
		dataString=dataString+"itemno_input="+escape(encodeURIComponent(itemno_label))+"&";
		dataString=dataString+"qty_input="+qty_input+"&";
		dataString=dataString+"unitOfMeasurement_input="+unitOfMeasurement_input;
		
		if(itemno_label != '' && unitOfMeasurement_input != ''){
			
			$("#unitOfMeasurement_input_"+trancode).parent().removeClass('has-error');	
			
			$.ajax({
				type:"POST",
				url:'simpleTransactionAjax.cfm',
				data:dataString,
				dataType:'json',
				cache:false,
				success: function(result){
					
					if(unitOfMeasurement_input == result.DEFAULTUNIT){
						$('#factor1_'+trancode).val(1).collapse('hide');
						$('#factor2_'+trancode).val(1).collapse('hide');	
					}
					else{
						$('#factor1_'+trancode).val(result.FACTOR_1).collapse('show');
						$('#factor2_'+trancode).val(result.FACTOR_2).collapse('show');
					}
					$("#price_input_"+trancode).val(Number(result.PRICE).toFixed(priceDecimalPoint));
				},
				error: function(jqXHR,textStatus,errorThrown){
					alert(errorThrown);
				},
			});
			createValidation();
		}	
	});

	$("form").on("click",".editItemDescription",function(e){

		var trancode=$(this).closest("tr").attr("id");
		var itemno_label=$("#itemno_label_"+trancode).val();
		var dataString="action=getItemDescription&";
		dataString=dataString+"uuid="+uuid+"&";
		dataString=dataString+"trancode="+trancode+"&";
		dataString=dataString+"itemno_label="+escape(encodeURIComponent(itemno_label));
		
		if(itemno_label != ''){
			$.ajax({
				type:"POST",
				url:'simpleTransactionAjax.cfm',
				data:dataString,
				dataType:'json',
				cache:false,
				success: function(result){
					$("#uuid_value").val(result.UNIQUEID);
					$("#itemno_value").val(result.ITEMNO);
					$("#trancode_value").val(result.TRANCODE);
					$("#despa_input").val(result.DESPA);
					$("#comment_input").val(result.COMMENT);
					$("#brem1_input").val(result.BREM1);
					$("#brem2_input").val(result.BREM2);
					$("#brem3_input").val(result.BREM3);
					$("#brem4_input").val(result.BREM4);
				},
				error: function(jqXHR,textStatus,errorThrown){
					alert(errorThrown);
				},
			});
		}
	});	

	$('#saveItemDescription').click(function(){
		var uuid_value=$("#uuid_value").val();
		var itemno_value=$("#itemno_value").val();
		var trancode_value=$("#trancode_value").val();
		var despa_input=$("#despa_input").val();
		var comment_input=$("#comment_input").val();
		var brem1_input=$("#brem1_input").val();
		var brem2_input=$("#brem2_input").val();
		var brem3_input=$("#brem3_input").val();
		var brem4_input=$("#brem4_input").val();
		var dataString="action=updateItemDescription&";
		dataString=dataString+"uuid_value="+uuid_value+"&";
		dataString=dataString+"trancode_value="+trancode_value+"&";
		dataString=dataString+"itemno_value="+escape(encodeURIComponent(itemno_value))+"&";
		dataString=dataString+"despa_input="+escape(encodeURIComponent(despa_input))+"&";
		dataString=dataString+"comment_input="+escape(encodeURIComponent(comment_input))+"&";
		dataString=dataString+"brem1_input="+escape(encodeURIComponent(brem1_input))+"&";
		dataString=dataString+"brem2_input="+escape(encodeURIComponent(brem2_input))+"&";
		dataString=dataString+"brem3_input="+escape(encodeURIComponent(brem3_input))+"&";
		dataString=dataString+"brem4_input="+escape(encodeURIComponent(brem4_input));
		
		$.ajax({
			type:"POST",
			url:'simpleTransactionAjax.cfm',
			data:dataString,
			dataType:'html',
			cache:false,
			success:function(result){
				$("#myItemDescription").modal('hide'); 	
			},
			error: function(jqXHR,textStatus,errorThrown){
				alert(errorThrown);
			},
		});
	});
		
	$('#myModalBillingAddress input:text').keyup(function(){

		var add1=$("#add1").val();
		var add2=$("#add2").val();
		var add3=$("#add3").val();
		var add4=$("#add4").val();
		var country=$("#country").val();
		var postalcode=$("#postalcode").val();
		var attn=$("#attn").val();
		var custinfo="";				

		if(add1!=""){
			custinfo=custinfo+add1+"<br />";
		};
		if(add2!=""){
			custinfo=custinfo+add2+"<br />";
		};
		if(add3!=""){
			custinfo=custinfo+add3+"<br />";
		};
		if(add4!=""){
			custinfo=custinfo+add4+"<br />";
		};
		if(country!=" "){
			custinfo=custinfo+country+" "+postalcode+"<br />";
		};
		if(attn!=""){
			custinfo=custinfo+"Attn: "+attn+"<br />";;
		};
				
		$('#custinfo').html(custinfo);
	});	
	
	$('#myModalDeliveryAddress input:text').keyup(function(){

		var d_add1=$("#d_add1").val();
		var d_add2=$("#d_add2").val();
		var d_add3=$("#d_add3").val();
		var d_add4=$("#d_add4").val();
		var d_country=$("#d_country").val();
		var d_postalcode=$("#d_postalcode").val();
		var d_attn=$("#d_attn").val();	
		var custinfo2="";				
		
		if(d_add1!=""){
			custinfo2=custinfo2+d_add1+"<br />";
		};
		if(d_add2!=""){
			custinfo2=custinfo2+d_add2+"<br />";
		};
		if(d_add3!=""){
			custinfo2=custinfo2+d_add3+"<br />";
		};
		if(d_add4!=""){
			custinfo2=custinfo2+d_add4+"<br />";
		};
		if(d_country!=" "){
			custinfo2=custinfo2+d_country+" "+d_postalcode+"<br />";
		};
		if(d_attn!=""){
			custinfo2=custinfo2+"Attn: "+d_attn+"<br />";;
		};
				
		$('#custinfo2').html(custinfo2);
	});	
	
	$('#submit_delivery_address,#submit_billing_address').click(function(){
		$('.modal').modal('hide'); 
	});
	
	$("form").on("change",".qty_input,.price_input",function(e){
		
		var trancode=$(this).closest("tr").attr("id");	
		var itemno_input=$('#itemno_label_'+trancode).val();
		
		if(isNaN($(this).val()) || $(this).val() == ''){
			$(this).parent().removeClass('has-success').addClass('has-error');
		}
		else{
			$(this).parent().removeClass('has-error');
			itemCalculation(trancode);
			if(itemno_input != ''){	
				totalCalculation();
				updateItem(trancode,'');
			}
		};
		createValidation();
	});
	
	$("form").on("change",".dispec1_input",function(e){
		
		var trancode=$(this).closest("tr").attr("id");
		var itemno_input=$('#itemno_label_'+trancode).val();
		var dispec1_input=Number($("#dispec1_input_"+trancode).val()).toFixed(2);
		
		if(isNaN($(this).val()) || $(this).val() == ''){
			$(this).parent().removeClass('has-success').addClass('has-error');
		}
		else{
			$(this).parent().removeClass('has-error');
			itemCalculation(trancode);
			if(itemno_input != ''){
				totalCalculation();
				updateItem(trancode,'');
			}
		};
		createValidation();	
	});
		
	$("#disp1_bil").change(function () {
		
		if($("#disp1_bil").val() == 0){
			$('#discount_bil').prop("disabled",false);
			$('#disp2_bil,#disp3_bil')
					.prop("disabled",true)
					.val(0.00);
		}
		else{
			$('#discount_bil,#disp3_bil').prop("disabled",true);
			$('#disp2_bil').prop("disabled",false);
		};
    });	
	
	$("#disp2_bil").change(function () {
		
		if($("#disp2_bil").val() == 0){
			$('#disp3_bil').prop("disabled",true);
		}
		else{
			$('#disp3_bil').prop("disabled",false);
		};
    });	
	
	$("#discount_bil").change(function () {
		
		if($("#discount_bil").autoNumeric('get') == 0){
			$('#disp1_bil').prop("disabled",false);
			$('#disp2_bil,#disp3_bil').prop("disabled",true);
		}
		else{
			$('#disp1_bil,#disp2_bil,#disp3_bil').prop("disabled",true);
		};
    });	
	
	$("#disp1_bil,#disp2_bil,#disp3_bil").change(function () {
        if(isNaN($(this).val()) || $(this).val() == ''){
			$(this).parent().removeClass('has-success').addClass('has-error');
		}
		else {
			$(this).parent().removeClass('has-error');
			totalCalculation();
		};
		createValidation();
    });	
	
	$("#discount_bil").change(function () {
        if(isNaN($(this).autoNumeric('get')) || $(this).autoNumeric('get') == ''){
			$(this).parent().removeClass('has-success').addClass('has-error');
		}
		else {
			$(this).parent().removeClass('has-error');
			totalCalculation();
		};
		createValidation();
    });	

	$("form").on("change","#taxCode,.itemTaxCode ",function(e){
		var trancode = $(this).closest("tr").attr("id");
		getTax(trancode);		
	});
	
	$("#billTaxIncluded").on("change",function(e) {
		if (!$(this).is(':checked')) {
			 $('#taxLabel').text('(Plus) Tax');
			 $('#billTaxIncluded').val('F');
		}
		else{
			$('#taxLabel').text('(Included) Tax');
			$('#billTaxIncluded').val('T');
		}
		totalCalculation();
	});	
		
	$("#RefNoSet").on("change", function() {
		var selectedValue=$("#RefNoSet").val();	
		changeRefNoSet(selectedValue)	
		
	});
	
	/* Delete item and row */
	$("form").on("dblclick",".delete_item",function(e){

		var trancode=$(this).closest("tr").attr("id");
		var dataString="action=deleteItem&";
		dataString=dataString+"uuid="+uuid+"&";
		dataString=dataString+"trancode="+trancode;
		
		$.ajax({	
			type:'POST',
			url:'simpleTransactionAjax.cfm',
			data:dataString,
			dataType:'html',
			cache:false,
			async: false,
			success: function(result){
				totalTrancodeValue--;
				$("#item_table_body").html(result);
				$('#itemno_label_'+totalTrancodeValue).hide();
				initializeNumericValues();
				initItemnoSelect2(totalTrancodeValue);
				initialItemVariableValue(totalTrancodeValue);
				totalCalculation();
				showHideDeleteItem(totalTrancodeValue,trancode);
				showHideTableColumn();
				$('.itemno_label,.amt_input').addClass('input-disabled');
				 
			},
			error: function(jqXHR,textStatus,errorThrown){
				alert(errorThrown);
			},
		});
	});	
	
	$('.input-group.date').datepicker({
		format:"dd/mm/yyyy",
		todayBtn:"linked",
		autoclose:true,
		todayHighlight:true
	});	

	$("form").on("focus",".priceHistory",function(e){
		var trancode=$(this).closest("tr").attr("id");
		var itemno=encodeURIComponent($('#itemno_label_'+trancode).val());
				
		if(itemno != ''){
			$('#price_input_'+trancode).popover({
				title:'Price History',
				placement:'bottom',
				trigger:'click,focus',
				html:true,
				content: function(){
					
						var returnResult = '';
						var dataString="action=getLast5Prices&";
						dataString=dataString+"itemno="+itemno;	
						$.ajax({	
							type:'POST',
							url:'simpleTransactionAjax.cfm',
							data:dataString,
							dataType:'html',
							cache:false,
							async: false,
							success: function(result){
								returnResult = result;
							}
						});
						return returnResult;
				}
			});
		}
	});	
	
	$("#create,#createAndNew").click(function(e){
		
		var buttonClicked = e.target.id;
		
		$(".saveTransaction").button('loading');
		$('.createButton').attr('disabled',true);	

		$("form:input", this).prop("disabled", false);
		createTransactionArtran(buttonClicked);
	});
	
	
	/* Cancel Transaction
	*/
	$(".cancelButton").on("click",function(e) {
		if(confirm("Are you sure you want to cancel ?")){
			window.location.replace("/default/transaction/transaction.cfm?tran="+type);
		};
	});	

	
/*	var inFormOrLink;
	$('a').on('click', function() { inFormOrLink = true; });
	$('form').on('submit', function() { inFormOrLink = true; });
	
	$(window).on("beforeunload", function() { 
		return inFormOrLink ? "Do you really want to close?" : null; 
	})*/
});

function getBillDetails(){
	var dataString="action=getBillDetails&"
	dataString=dataString+"type="+type+"&";
	dataString=dataString+"refno="+refno;
	
	$.ajax({
		type:'POST',
		url:'simpleTransactionAjax.cfm',
		data:dataString,
		dataType:'html',
		cache:false,
		success: function(result){
					$("#item_table_body").html(result);
					totalTrancodeValue = $("#totalTrancode").val()
					addRow(parseFloat(totalTrancodeValue)+1);
					
		},
		error: function(jqXHR,textStatus,errorThrown){
					alert(errorThrown);
		},
		complete: function(){
					totalCalculation();
		}
	});	
	
};

function createValidation(){
	if($(document).find('.has-error').length>0){
		$('.createButton').attr('disabled',true);
	}else{
		$('.createButton').removeAttr('disabled');
	}	
};


function showHideTableColumn(){
	if($("#locationList").val() == ''){
		$(".th_four,.td_four").hide();		
    };
	
	if($("#unitOfMeasurementList").val() == ''){
		$(".unitOfMeasurement_input").hide();		
    };

	if(itemTax == 1){
		$(".itemTax_bil").show();
		$(".billTaxIncluded,.taxCode,.taxp1_bil,.tax_bil,.discountSymbol_bil").hide();		
    }
	else{
		$(".th_eight").hide();
		$(".itemTaxTD").hide();
		$(".itemTax_bil").hide();	
	};
};

function showHideDeleteItem(totalTrancodeValue,trancode){
	
	if(totalTrancodeValue < 3){
		$(".delete_item").css('visibility', 'hidden');	
		/*$(".reshuffleTitle").css('border', 'none');	*/
	}
	else{
		$(".delete_item").css('visibility', 'visible');
	};	
	
	$("#"+totalTrancodeValue+" .delete_item").css('visibility', 'hidden');	
};

function initCustnoSelect2(){
	var custno=$('#custno').val();
	
	if (custno=='createNewTarget'){
		$('#myModalCreateCustomer').modal('show'); 
	}else{
		var dataString="action=getTargetDetail&targetTable="+targetTable+"&custno="+custno;
		
		$.ajax({
			type:"POST",
			url:"simpleTransactionAjax.cfm",
			data:dataString,
			dataType:"json",
			cache:false,
			success: function(result){
				
				$('#custno').parent().removeClass('has-error');
				$("#showLabel1,#showLabel2").css("visibility","visible");

				var custinfo="";				
				var custinfo2="";
				
				$("#name,#d_name").val(result.NAME);
				$("#name2,#d_name2").val(result.NAME2);
				
				if(result.ADD1!=""){
					custinfo=custinfo+result.ADD1+"<br />";
					$("#add1").val(result.ADD1);
				};
				if(result.ADD2!=""){
					custinfo=custinfo+result.ADD2+"<br />";
					$("#add2").val(result.ADD2);
				};
				if(result.ADD3!=""){
					custinfo=custinfo+result.ADD3+"<br />";
					$("#add3").val(result.ADD3);
				};
				if(result.ADD4!=""){
					custinfo=custinfo+result.ADD4+"<br />";
					$("#add4").val(result.ADD4);
				};
				if(result.COUNTRY!=" "){
					custinfo=custinfo+result.COUNTRY+" "+result.POSTALCODE+"<br />";
					$("#postalcode").val(result.POSTALCODE);
					$("#country").val(result.COUNTRY);
				};
				if(result.ATTN!=""){
					custinfo=custinfo+"Attn: "+result.ATTN+"<br />";;
					$("#attn").val(result.ATTN);
					$("#phone").val(result.PHONE);
					$("#fax").val(result.FAX);
					$("#hp").val(result.HP);
					$("#email").val(result.EMAIL);
				};										
				if(custinfo==''){
					custinfo='<b>N/A</b>';
				};

				if(result.DADDR1!=""){
					custinfo2=custinfo2+result.DADDR1+"<br />";
					$("#d_add1").val(result.DADDR1);
				};
				if(result.DADDR2!=""){
					custinfo2=custinfo2+result.DADDR2+"<br />";
					$("#d_add2").val(result.DADDR2);
				};
				if(result.DADDR3!=""){
					custinfo2=custinfo2+result.DADDR3+"<br />";
					$("#d_add3").val(result.DADDR3);
				};
				if(result.DADDR4!=""){
					custinfo2=custinfo2+result.DADDR4+"<br />";
					$("#d_add4").val(result.DADDR4);
				};
				if(result.DCOUNTRY!=" "){
					custinfo2=custinfo2+result.DCOUNTRY+" "+result.DPOSTALCODE+"<br />";
					$("#d_postalcode").val(result.DPOSTALCODE);
					$("#d_country").val(result.DCOUNTRY);
				};
				if(result.DATTN!=""){
					custinfo2=custinfo2+"Attn: "+result.DATTN+"<br />";
					$("#d_attn").val(result.DATTN);
					$("#d_phone").val(result.DPHONE);
					$("#d_fax").val(result.DFAX);
					$("#d_hp").val(result.DHP);
					$("#d_email").val(result.DEMAIL);
				};										
				if(custinfo2==''){
					custinfo2='<b>N/A</b>';
				};
				$('#custinfo').html(custinfo);
				$('#custinfo2').html(custinfo2);
				
				if(defaultValueCounter == 1){
					$('#term').val(result.TERM);
					if(result.CURRCODE != ''){
						$("#currcode").val(result.CURRCODE);
					};
					getCurrencyRate();
					/*if(result.CURRRATE != ''){
						$("#currencyRate").val(result.CURRRATE);
					};*/
					$("#agent").val(result.AGENT);
					$("#driver").val(result.ENDUSER);
				};

				if($("#currcode").val() == ''){
					$("#currcode").parent().addClass('has-error');	
					$('.createButton').attr('disabled',true);
				}
				else{
					$("#currcode").parent().removeClass('has-error');	
					createValidation();
				};
				setCurrencyCode();
			},
			error: function(jqXHR,textStatus,errorThrown){
				alert(errorThrown);
			}
		});
	};	
};

function changeRefNoSet(selectedValue){

	var RefNoCounter=selectedValue;	
	
	if(RefNoCounter == '1'){
		$("#RefNoSet").val('1');		
	};
	if(RefNoCounter == ''){
		$("#refno")
				.prop("disabled",false)
				.val('')
				.parent().addClass('has-error');	
		createValidation();
	}
	else {
						
		var dataString="action=getReferenceNo&RefNoCounter="+RefNoCounter+"&RefType="+type;
		$.ajax({
			type:'POST',
			url:'simpleTransactionAjax.cfm',
			data:dataString,
			dataType:'json',
			cache:false,
			success: function(result){
						$("#refno")
								.val(result.REFNO)
								.parent().removeClass('has-error');	
						if(result.REFNOUSED == 1){
							$("#refno").prop("disabled",true);
						};
			},
			error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
			},
		});	
	};
};

function getCurrencyRate(){
	
	var currcode=$('#currcode').val();
	var wos_date=$('#wos_date').val();
	var dataString="action=getCurrencyRate&";
	dataString=dataString+"currcode="+currcode+"&";
	dataString=dataString+"wos_date="+wos_date;
	
	$.ajax({
		type:'POST',
		url:'simpleTransactionAjax.cfm',
		data:dataString,
		dataType:'json',
		cache:false,
		success: function(result){
					if(result.CURRENTPERIOD != '99'){
						$("#currencyRate").val(result.CURRENCYRATE);
						setCurrencyCode();
					}
					
					else{
						alert("Current period setting is incorrect. Kindly recheck!");
					}
		},
		error: function(jqXHR,textStatus,errorThrown){
			alert(errorThrown);
		},
	});	
};

function setCurrencyCode(){
	
	var currencyCode = $('#currcode').val();
	if (currencyCode != ''){
		$('.currencyCode').text("("+currencyCode+")");
	};
	
	$(".discount_bil,.itemTax_bil,.tax_bil,.net_bil,.grand_bil").autoNumeric('update', {
		aSign: currencyCode+"  "
	});
};

function initItemnoSelect2(trancode){	
	$('#itemno_input_'+trancode).select2({
		ajax:{
			type:'POST',
			url:'simpleTransaction.cfc',
			dataType:'json',
			cache:true,
			data:function(term,page){
					return{
							method:'listMatchedItems',
							returnformat:'json',					
							dts:dts,
							term:term,
							limit:limit,
							page:page-1
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
			var itemno=$(element).val();
			if(itemno!=''){
				$.ajax({
					type:'POST',
					url:'simpleTransaction.cfc',
					dataType:'json',
					cache:true,
					data:{
							method:'getSelectedItem',
							returnformat:'json',						
							dts:dts,
							itemno:itemno
					}
				}).done(function(data){callback(data);});
			};
		},
		width:'100%',
		formatResult: function (data) {
        	return data.text;
    	},
	});
};


/* 
	Function: Duplicate New Row 	
	Parameter: Trancode + 1
*/
function addRow(trancode){

	$("#item_table_body").append(
		'	<tr id="'+trancode+'" class="edit_tr last_edit_tr">		<td class="td_one"><label for="recordCountLabel" id="recordCount_'+trancode+'" class="recordCount"><abbr title="" class="reshuffleTitle">'+trancode+'</abbr></label></td>  	<td><input type="text" id="itemno_label_'+trancode+'" name="itemno_label_'+trancode+'" class="form-control input-sm itemno_label" disabled="true"/><input type="hidden" id="itemno_input_'+trancode+'" name="itemno_input_'+trancode+'" class="editbox itemno_input addline" data-placeholder="Choose an item" /><input type="hidden" id="lineCode_label_'+trancode+'" name="lineCode_label_'+trancode+'" class="form-control input-sm"/></td>		<td><div class="input-group"><input type="text" id="desp_input_'+trancode+'" name="desp_input_'+trancode+'" class="form-control input-sm desp_input" value=""/><span class="input-group-addon glyphiconA glyphicon-plus editItemDescription" id="editItemDescription_'+trancode+'" data-toggle="modal" data-target="#myItemDescription"></span></div>		<td class="td_four"><select id="location_input_'+trancode+'" name="location_input_'+trancode+'" class="form-control input-sm location_input"><option value="">Location</option></select></td>	  <td><div class="row no-pad"><div class="col-sm-4"><input type="text" id="qty_input_'+trancode+'" name="qty_input_'+trancode+'" class="form-control input-sm qty_input textAlignRight" /></div><div class="col-sm-8"><select id="unitOfMeasurement_input_'+trancode+'" name="unitOfMeasurement_input_'+trancode+'" class="form-control input-sm unitOfMeasurement_input"></select></div></div><div class="row no-pad"><div class="col-sm-6"><input type="text" id="factor1_'+trancode+'" name="factor1_'+trancode+'" class="form-control input-sm collapse factor1  textAlignRight"/></div><div class="col-sm-6"><input type="text" id="factor2_'+trancode+'" name="factor2_'+trancode+'" class="form-control input-sm collapse factor2 textAlignRight"/></div></div></td>        <td><input type="text" id="price_input_'+trancode+'" name="price_input_'+trancode+'" class="form-control input-sm price_input textAlignRight priceHistory" /></td>		<td><div class="input-group"><input type="text" id="dispec1_input_'+trancode+'" name="dispec1_input_'+trancode+'" class="form-control input-sm dispec1_input textAlignRight" /><span class="input-group-addon" id="discount">%</span></div></td>	<td class="itemTaxTD"><select id="itemTaxCode_input_'+trancode+'" name="itemTaxCode_input_'+trancode+'" class="form-control input-sm itemTaxCode"></select><input type="hidden" id="taxpec1_input_'+trancode+'" name="taxpec1_input_'+trancode+'" class="form-control input-sm taxpec1_input textAlignRight" disabled="true"/><input type="hidden" id="taxAmtBil_input_'+trancode+'" name="taxAmtBil_input_'+trancode+'" class="form-control input-sm taxAmtBil_input textAlignRight" disabled="true"/></td>		<td><input type="text" id="amt_input_'+trancode+'" name="amt_input_'+trancode+'" class="form-control input-sm amt_input textAlignRight" disabled="true" /></td>		<td class="td_ten"><span class="glyphicon glyphicon-trash delete_item" id="'+trancode+'"></span></td>	</tr>	'
	);

	var tempLocationList = $("#locationList").val()
	var tempLocationArray = tempLocationList.split(','); 
	var location_input = $("#location_input_"+trancode);
	var tempUOMList = $("#unitOfMeasurementList").val()
	var tempUOMArray = tempUOMList.split(','); 
	var unitOfMeasurement_input = $("#unitOfMeasurement_input_"+trancode);
	var tempTaxCodeList = $("#taxCodeList").val()
	var tempTaxCodeArray = tempTaxCodeList.split(','); 
	var taxCode_input = $("#itemTaxCode_input_"+trancode);
	
	
	$.each(tempLocationArray, function (val, text) {
		location_input.append($('<option/>', { 
							value: text,
							text : text 
    					}));
	});

	$.each(tempUOMArray, function(val, text) {
		unitOfMeasurement_input.append($('<option/>', { 
							value: text,
							text : text 
    					}));
	});
	
	$.each(tempTaxCodeArray, function(val, text) {
		taxCode_input.append($('<option/>', { 
							value: text,
							text : text 
    					}));
	});
	
	if (trancode > totalTrancodeValue){
		totalTrancodeValue++;
	};
	
	showHideTableColumn();
	$('#itemno_label_'+trancode).hide();
	initItemnoSelect2(trancode);
	initializeNumericValues();
	initialItemVariableValue(trancode);
	initializeTooltips();
	$('#itemno_input_'+trancode).select2('open');
	
	$("#itemTaxCode_input_"+trancode).val(defaultTaxCode);
	$("#taxpec1_input_"+trancode).val(parseFloat(defaultTaxRate*100).toFixed(totalDecimalPoint));	
};	

function initializeTooltips(){
	
	$('.reshuffleTitle').tooltip({ 
		title:'Click to reshuffle',
		trigger:'hover',
		placement:'bottom',
	});
	
	$('.factor1').tooltip({ 
		title:'Basic Unit (e.g 20 Can). * Key in digits only',
		trigger:'hover',
		placement:'bottom',
	});
	
	$('.factor2').tooltip({ 
		title:'Packing Unit (e.g 1 Carton). * Key in digits only',
		trigger:'hover',
		placement:'bottom',
	});
	
	$("form").on("blur",".priceHistory",function(e){
		var trancode=$(this).closest("tr").attr("id");
		$("#price_input_"+trancode).popover('hide');
	});	

	$("form").on("mouseover",".delete_item",function(e){
		$('.delete_item').tooltip({ 
			title:'Double click to remove',
			trigger:'hover',
			placement:'bottom',
		});
	});	
}

function getTax(trancode){
	if(itemTax == 1 ){
		var taxCode=$("#itemTaxCode_input_"+trancode).val();
		updateItem(trancode,'');
	}
	else{
		var taxCode=$("#taxCode").val();		
	};
	var dataString="action=getTaxRate&taxCode="+taxCode;
	
	$.ajax({
		type:'POST',
		url:'simpleTransactionAjax.cfm',
		data:dataString,
		dataType:'json',
		cache:false,
		success: function(result){
					if(itemTax == 1){
						$("#taxpec1_input_"+trancode).val((result.TAXRATE*100).toFixed(totalDecimalPoint));
						$("#itemTaxCode_input_"+trancode).val(result.TAXCODE);
					}
					else{
						$("#taxp1_bil").val((result.TAXRATE*100).toFixed(totalDecimalPoint));
						$("#taxCode").val(result.TAXCODE);	
					}
					itemCalculation(trancode);
					totalCalculation();
		},
		error: function(jqXHR,textStatus,errorThrown){
			alert(errorThrown);
		},
	});		
};

/* Function: Set Decimal Places		
*/
function setDecimalPlaces(){
	
	for(var i=0; i<totalDecimalPoint; i++){
		totalDecimalCounter += '9';
	};
	
	for(var j=0; j<priceDecimalPoint; j++){
		priceDecimalCounter += '9';
	};
	
	for(var k=0; k<discountDecimalPoint; k++){
		discountDecimalCounter += '9';
	};
};



/* Function: Initialize autoNumeric values  		
*/
function initializeNumericValues(){
	$(".amt_input,.taxAmtBil_input,.net_bil,.itemTax_bil,.tax_bil,.grand_bil").autoNumeric('init', {
		aSep: ',', 
		aDec: '.',
		aForm: true,
		vMax: '999999999.'+totalDecimalCounter,
		vMin: '-999999999.'+totalDecimalCounter
	});
	
	$(".disp1_bil,.disp2_bil,.disp3_bil,.discount_bil").autoNumeric('init', {
		aSep: '',
		aForm: true,
		vMax: '999999999.'+discountDecimalCounter,
		vMin: '-999999999.'+discountDecimalCounter
	});

	$(".price_input").autoNumeric('init', {
		aSep: '', 
		aForm: true,
		vMax: '999999999.'+priceDecimalCounter,
		vMin: '-999999999.'+priceDecimalCounter
	});	
	
	$(".dispec1_input").autoNumeric('init', {
		aSep: '', 
		aForm: true,
		vMax: '999999999.'+discountDecimalCounter,
		vMin: '-999999999.'+discountDecimalCounter
	});
};

function setNumericValues(){
	$('.price_input').autoNumeric('set', data.total);
};



/* Function: Initialize item(body) variable values 
   Parameter: Trancode: 1 (On Load), + 1 (Each time add item)  		
*/
function initialItemVariableValue(trancode){
	var tempQtyValue = 1;
	var tempValue = 0.0000000000000

	$("#qty_input_"+trancode).val(tempQtyValue);
	$("#price_input_"+trancode).val(tempValue.toFixed(priceDecimalPoint));
	$("#dispec1_input_"+trancode).val(tempValue.toFixed(discountDecimalPoint));
	$("#amt_input_"+trancode).val(tempValue.toFixed(totalDecimalPoint));	
	if(itemTax == 1){
		$("#taxAmtBil_input_"+trancode).val(tempValue.toFixed(totalDecimalPoint));
	};
};


/* Function: Initialize total(footer) variable values  		
*/
function initialFooterVariableValue(){
	var tempTotalQtyValue = 0;
	var tempValue = 0.0000000000000
	
	$("#totalQty_bil").val(tempTotalQtyValue);
	$("#disp1_bil").val(tempValue.toFixed(discountDecimalPoint));
	$("#disp2_bil").val(tempValue.toFixed(discountDecimalPoint));
	$("#disp3_bil").val(tempValue.toFixed(discountDecimalPoint));
	$("#discount_bil").val(tempValue.toFixed(discountDecimalPoint));
	$("#net_bil").val(tempValue.toFixed(totalDecimalPoint));
	$("#taxp1_bil").val(tempValue.toFixed(totalDecimalPoint));
	$("#tax_bil").val(tempValue.toFixed(totalDecimalPoint));
	$("#grand_bil").val(tempValue.toFixed(totalDecimalPoint));
};

/*
	Function: Perform item calculation.
			  Per row calculation.
	Parameter: Current row (Trancode).		  		  
*/
function itemCalculation(trancode){
	
	var qty_input=Number($("#qty_input_"+trancode).val()).toFixed(2);
	var price_input=Number($("#price_input_"+trancode).val()).toFixed(priceDecimalPoint);
	var dispec1_input=Number($("#dispec1_input_"+trancode).val()).toFixed(discountDecimalPoint);
	var amt1=Number(qty_input*price_input).toFixed(totalDecimalPoint);
	var disamt=Number(amt1*(dispec1_input/100)).toFixed(discountDecimalPoint);
	var amt_input=Number(amt1-disamt).toFixed(totalDecimalPoint);

	var taxpec1_input=Number($("#taxpec1_input_"+trancode).val()).toFixed(2);	
	var taxAmtBil_input=Number(amt_input*(taxpec1_input/100)).toFixed(totalDecimalPoint);

	$("#taxAmtBil_input_"+trancode).val(taxAmtBil_input);
	$("#amt_input_"+trancode).val(amt_input).autoNumeric('update');
};	

/*
	Function: Perform bill calculation.
			  Total row calculation.		  
*/
function totalCalculation(){
	
	var totalQty_bil=0;
	var gross_bil=0.00; 
	var disp1_bil=Number($("#disp1_bil").val()).toFixed(discountDecimalPoint);
	var disp2_bil=Number($("#disp2_bil").val()).toFixed(discountDecimalPoint);
	var disp3_bil=Number($("#disp3_bil").val()).toFixed(discountDecimalPoint);
	var disAmtTemp1=0.00;
	var disAmtTemp2=0.00;
	var disAmtTemp3=0.00;
	var discount_bil=Number($("#discount_bil").autoNumeric('get')).toFixed(discountDecimalPoint);
	var net_bil=0.00;
	var taxp1_bil=Number($("#taxp1_bil").val()).toFixed(totalDecimalPoint);
	var tax_bil=0.00;
	var itemTax_bil=0.00;
	var totalItemTax=0.00;
	var totalTax=0.00;
	var roundingAdjustment=0.00;
	var grand_bil=0.00;
	var billTaxIncluded=$("#billTaxIncluded").val();

	$(".edit_tr").each(function(index, element) {
		var trancode=$(this).attr("id");
		if($("#itemno_label_"+trancode).val() != ''){
			totalQty_bil=(parseFloat(totalQty_bil)+parseFloat($("#qty_input_"+trancode).val())).toFixed(2);
			gross_bil=(parseFloat(gross_bil)+parseFloat($("#amt_input_"+trancode).autoNumeric('get'))).toFixed(totalDecimalPoint);
			if(itemTax == 1){
				totalItemTax=(parseFloat(totalItemTax)+parseFloat($("#taxAmtBil_input_"+trancode).val())).toFixed(totalDecimalPoint)
			};
		};		
	});

	disAmtTemp1=(parseFloat(gross_bil)*parseFloat(disp1_bil/100)).toFixed(discountDecimalPoint);
	disAmtTemp2=((parseFloat(gross_bil)-parseFloat(disAmtTemp1))*parseFloat(disp2_bil/100)).toFixed(discountDecimalPoint);
	disAmtTemp3=((parseFloat(gross_bil)-parseFloat(disAmtTemp1)-parseFloat(disAmtTemp2))*parseFloat(disp3_bil/100)).toFixed(discountDecimalPoint);
	if(disAmtTemp1 != 0){
		discount_bil=parseFloat(disAmtTemp1)+parseFloat(disAmtTemp2)+parseFloat(disAmtTemp3);
	};

	net_bil=(parseFloat(gross_bil)-parseFloat(discount_bil)).toFixed(totalDecimalPoint);
	
	if(itemTax == 1){
		itemTax_bil=parseFloat(totalItemTax);
		totalTax=parseFloat(itemTax_bil);
	}
	else{
		if(billTaxIncluded == 'T'){
			tax_bil=(parseFloat(gross_bil)*parseFloat(taxp1_bil/(100+parseFloat(taxp1_bil)))).toFixed(totalDecimalPoint);
			totalTax=0;
		}
		else{
			tax_bil=(parseFloat(gross_bil)*parseFloat(taxp1_bil/100)).toFixed(totalDecimalPoint);	
			totalTax=parseFloat(tax_bil);
		}
	};
	
	grand_bil=(parseFloat(net_bil)+parseFloat(totalTax)).toFixed(totalDecimalPoint);

	if (type == "CS"){
		roundingAdjustment=((((((parseFloat(grand_bil)*2).toFixed(1))/2).toFixed(2)-parseFloat(grand_bil))).toFixed(2)).replace('-', '');
		grand_bil=(((grand_bil* 2).toFixed(1))/2).toFixed(2);
	}

	$("#totalQty_bil").val(totalQty_bil);
	$("#disp1_bil").val(disp1_bil);
	$("#disp2_bil").val(disp2_bil);
	$("#disp3_bil").val(disp3_bil);
	$("#discount_bil").val(discount_bil).autoNumeric('update');
	$("#gross_bil").val(gross_bil);
	$("#net_bil").val(net_bil).autoNumeric('update');
	if(itemTax == 1){
		$("#itemTax_bil").val(totalItemTax).autoNumeric('update');
		$("#tax_bil").val(totalItemTax).autoNumeric('update');
	}
	else{
		$("#itemTax_bil").val(itemTax_bil).autoNumeric('update');
		$("#tax_bil").val(tax_bil).autoNumeric('update');
	};
	
	$("#roundingAdjustment").val(roundingAdjustment);
	$("#grand_bil").val(grand_bil).autoNumeric('update');
};

function updateItem(trancode,field){
	
	var itemno_input=$('#itemno_label_'+trancode).val();
	var linecode_input=$('#lineCode_label_'+trancode).val();
	var desp_input=$("#desp_input_"+trancode).val();
	var despa_input=$("#despa_input").val();
	var comment_input=$("#comment_input").val();
	var location_input=$("#location_input_"+trancode).val();
	var qty_input=$("#qty_input_"+trancode).val();
	var unitOfMeasurement_input=$("#unitOfMeasurement_input_"+trancode).val();
	var factor1_input=$("#factor1_"+trancode).val();
	var factor2_input=$("#factor2_"+trancode).val();
	var price_input=$("#price_input_"+trancode).val();
	if(itemTax == 1){
		var itemTaxCode_input=$("#itemTaxCode_input_"+trancode).val();
		var taxpec1_input=$("#taxpec1_input_"+trancode).val();
		var taxAmtBil_input=$("#taxAmtBil_input_"+trancode).val();
	}
	else{
		var itemTaxCode_input='';
		var taxpec1_input=0.00;
		var taxAmtBil_input=0.00;
	};
	var dispec1_input=$("#dispec1_input_"+trancode).val();
	var amt_input=$("#amt_input_"+trancode).val();
	var dataString="action=updateItem&";
	dataString=dataString+"type="+type+"&";
	dataString=dataString+"uuid="+uuid+"&";
	dataString=dataString+"trancode="+trancode+"&";
	dataString=dataString+"linecode="+linecode_input+"&";
	dataString=dataString+"field="+field+"&";	
	dataString=dataString+"itemno_input="+escape(encodeURIComponent(itemno_input))+"&";
	dataString=dataString+"desp_input="+escape(encodeURIComponent(desp_input))+"&";
	dataString=dataString+"despa_input="+escape(encodeURIComponent(despa_input))+"&";
	dataString=dataString+"comment_input="+escape(encodeURIComponent(comment_input))+"&";
	dataString=dataString+"location_input="+escape(encodeURIComponent(location_input))+"&";
	dataString=dataString+"qty_input="+qty_input+"&";
	dataString=dataString+"unitOfMeasurement_input="+unitOfMeasurement_input+"&";
	dataString=dataString+"factor1_input="+factor1_input+"&";
	dataString=dataString+"factor2_input="+factor2_input+"&";
	dataString=dataString+"price_input="+price_input+"&";
	dataString=dataString+"dispec1_input="+dispec1_input+"&";
	dataString=dataString+"itemTaxCode_input="+itemTaxCode_input+"&";
	dataString=dataString+"taxpec1_input="+taxpec1_input+"&";
	dataString=dataString+"taxAmtBil_input="+taxAmtBil_input+"&";
	dataString=dataString+"amt_input="+amt_input;	
	dataString=dataString;
	if(itemno_input != ''){
		$.ajax({
			type:"POST",
			url:'simpleTransactionAjax.cfm',
			data:dataString,
			dataType:"html",
			cache:false,
			success: function(result){
				if(!(trancode<totalTrancodeValue)){	
					initialItemVariableValue(parseFloat(trancode)+1);
				}
			},
			error: function(jqXHR,textStatus,errorThrown){
				alert(errorThrown);
			},
		});
	}
};


/*
	Function: Create Transaction.
			  Create value in ARTRAN table.		  
*/
function createTransactionArtran(buttonClicked){
	
	var custno = $("#custno").val();
	var name = $("#name").val();
	var name2 = $("#name2").val();
	var add1 = $("#add1").val();
	var add2 = $("#add2").val();
	var add3 = $("#add3").val();
	var add4 = $("#add4").val();
	var country = $("#country").val();
	var postalcode = $("#postalcode").val();
	var attn = $("#attn").val();
	var phone = $("#phone").val();
	var hp = $("#hp").val();
	var fax = $("#fax").val();
	var email = $("#email").val();
	var d_name = $("#d_name").val();
	var d_name2 = $("#d_name2").val();
	var d_add1 = $("#d_add1").val();
	var d_add2 = $("#d_add2").val();
	var d_add3 = $("#d_add3").val();
	var d_add4 = $("#d_add4").val();
	var d_country = $("#d_country").val();
	var d_postalcode = $("#d_postalcode").val();
	var d_attn = $("#d_attn").val();
	var d_phone = $("#d_phone").val();
	var d_hp = $("#d_hp").val();
	var d_fax = $("#d_fax").val();
	var d_email = $("#d_email").val();
	var refno = $("#refno").val();
	var refnoset = $("#RefNoSet").val();
	var wos_date = $("#wos_date").val();
	var currcode = $("#currcode").val();
	var currencyRate = $("#currencyRate").val();
	var term = $("#term").val();
	var desp = $("#desp").val();	
	var refno2 = $("#refno2").val();
	var pono = $("#pono").val();
	var quono = $("#quono").val();
	var sono = $("#sono").val();
	var dono = $("#dono").val();
	var project = $("#project").val();
	var job = $("#job").val();
	var agent = $("#agent").val();
	var driver = $("#driver").val();
	var remark5 = $("#remark5").val();
	var remark6 = $("#remark6").val();
	var remark7 = $("#remark7").val();
	var remark8 = $("#remark8").val();
	var remark9 = $("#remark9").val();
	var remark10 = $("#remark10").val();
	var remark11 = $("#remark11").val();
	var INVno = $("#INVno").val();
	var reason = $("#reason").val();	
	var termCondition = $("#termCondition").val();
	var disp1_bil = Number($("#disp1_bil").val());
	var disp2_bil = Number($("#disp2_bil").val());
	var disp3_bil = Number($("#disp3_bil").val());
	var discount_bil = Number($("#discount_bil").autoNumeric('get'));
	var gross_bil = Number($("#gross_bil").val());
	var net_bil = Number($("#net_bil").autoNumeric('get'));
	var taxCode = $("#taxCode").val();
	var taxp1_bil = Number($("#taxp1_bil").val());
	var tax_bil = Number($("#tax_bil").autoNumeric('get'));
	var grand_bil = Number($("#grand_bil").autoNumeric('get'));
	var billTaxIncluded = $("#billTaxIncluded").val();
	var dataString="action=createTransaction&";
	dataString=dataString+"discountDecimalPoint="+discountDecimalPoint+"&";
	dataString=dataString+"priceDecimalPoint="+priceDecimalPoint+"&";
	dataString=dataString+"totalDecimalPoint="+totalDecimalPoint+"&";
	dataString=dataString+"transactionAction="+action+"&";
	dataString=dataString+"uuid="+uuid+"&";
	dataString=dataString+"type="+type+"&";
	dataString=dataString+"custno="+custno+"&";
	dataString=dataString+"name="+escape(encodeURIComponent(name))+"&";
	dataString=dataString+"name2="+escape(encodeURIComponent(name2))+"&";
	dataString=dataString+"add1="+escape(encodeURIComponent(add1))+"&";
	dataString=dataString+"add2="+escape(encodeURIComponent(add2))+"&";
	dataString=dataString+"add3="+escape(encodeURIComponent(add3))+"&";
	dataString=dataString+"add4="+escape(encodeURIComponent(add4))+"&";
	dataString=dataString+"country="+escape(encodeURIComponent(country))+"&";
	dataString=dataString+"postalcode="+escape(encodeURIComponent(postalcode))+"&";
	dataString=dataString+"attn="+escape(encodeURIComponent(attn))+"&";
	dataString=dataString+"phone="+escape(encodeURIComponent(phone))+"&";
	dataString=dataString+"hp="+escape(encodeURIComponent(hp))+"&";
	dataString=dataString+"fax="+escape(encodeURIComponent(fax))+"&";
	dataString=dataString+"email="+escape(encodeURIComponent(email))+"&";
	dataString=dataString+"d_name="+escape(encodeURIComponent(d_name))+"&";
	dataString=dataString+"d_name2="+escape(encodeURIComponent(d_name2))+"&";
	dataString=dataString+"d_add1="+escape(encodeURIComponent(d_add1))+"&";
	dataString=dataString+"d_add2="+escape(encodeURIComponent(d_add2))+"&";
	dataString=dataString+"d_add3="+escape(encodeURIComponent(d_add3))+"&";
	dataString=dataString+"d_add4="+escape(encodeURIComponent(d_add4))+"&";
	dataString=dataString+"d_country="+escape(encodeURIComponent(d_country))+"&";
	dataString=dataString+"d_postalcode="+escape(encodeURIComponent(d_postalcode))+"&";
	dataString=dataString+"d_attn="+escape(encodeURIComponent(d_attn))+"&";
	dataString=dataString+"d_phone="+escape(encodeURIComponent(d_phone))+"&";
	dataString=dataString+"d_hp="+escape(encodeURIComponent(d_hp))+"&";
	dataString=dataString+"d_fax="+escape(encodeURIComponent(d_fax))+"&";
	dataString=dataString+"d_email="+escape(encodeURIComponent(d_email))+"&";
	dataString=dataString+"refno="+escape(encodeURIComponent(refno))+"&";
	dataString=dataString+"refnoset="+escape(encodeURIComponent(refnoset))+"&";
	dataString=dataString+"wos_date="+wos_date+"&";
	dataString=dataString+"currcode="+escape(encodeURIComponent(currcode))+"&";
	dataString=dataString+"currencyRate="+currencyRate+"&";
	dataString=dataString+"term="+escape(encodeURIComponent(term))+"&";
	dataString=dataString+"desp="+escape(encodeURIComponent(desp))+"&";
	dataString=dataString+"refno2="+escape(encodeURIComponent(refno2))+"&";
	dataString=dataString+"pono="+escape(encodeURIComponent(pono))+"&";
	dataString=dataString+"quono="+escape(encodeURIComponent(quono))+"&";
	dataString=dataString+"sono="+escape(encodeURIComponent(sono))+"&";
	dataString=dataString+"dono="+escape(encodeURIComponent(dono))+"&";
	dataString=dataString+"project="+escape(encodeURIComponent(project))+"&";
	dataString=dataString+"job="+escape(encodeURIComponent(job))+"&";
	dataString=dataString+"agent="+escape(encodeURIComponent(agent))+"&";
	dataString=dataString+"driver="+escape(encodeURIComponent(driver))+"&";	
	dataString=dataString+"remark5="+escape(encodeURIComponent(remark5))+"&";
	dataString=dataString+"remark6="+escape(encodeURIComponent(remark6))+"&";
	dataString=dataString+"remark7="+escape(encodeURIComponent(remark7))+"&";
	dataString=dataString+"remark8="+escape(encodeURIComponent(remark8))+"&";	
	dataString=dataString+"remark9="+escape(encodeURIComponent(remark9))+"&";
	dataString=dataString+"remark10="+escape(encodeURIComponent(remark10))+"&";
	dataString=dataString+"remark11="+escape(encodeURIComponent(remark11))+"&";
	dataString=dataString+"INVno="+escape(encodeURIComponent(INVno))+"&";
	dataString=dataString+"reason="+escape(encodeURIComponent(reason))+"&";
	dataString=dataString+"termCondition="+escape(encodeURIComponent(termCondition))+"&";	
	dataString=dataString+"disp1_bil="+disp1_bil+"&";	
	dataString=dataString+"disp2_bil="+disp2_bil+"&";	
	dataString=dataString+"disp3_bil="+disp3_bil+"&";	
	dataString=dataString+"discount_bil="+discount_bil+"&";	
	dataString=dataString+"gross_bil="+gross_bil+"&";	
	dataString=dataString+"net_bil="+net_bil+"&";	
	dataString=dataString+"taxCode="+taxCode+"&";	
	dataString=dataString+"taxp1_bil="+taxp1_bil+"&";	
	dataString=dataString+"tax_bil="+tax_bil+"&";	
	dataString=dataString+"grand_bil="+grand_bil+"&";
	dataString=dataString+"billTaxIncluded="+billTaxIncluded;
	
	$.ajax({
		type:"POST",
		url:'simpleTransactionAjax.cfm',
		data:dataString,
		dataType:"html",
		cache:false,
		async: false,
		success: function(result){
			
			$(".alertReferenceNoLabel").text(refno+" was successfully "+ action.toLowerCase() +"d !");	
			$(':input','#form')
				.not(':button, :submit, :reset, :hidden')
				.val('')
				.removeAttr('checked')
				.removeAttr('selected'); 

			if(buttonClicked == 'create'){
				var redirect = '/default/transaction/transaction3c.cfm?tran='+type+'&nexttranno='+refno;
				
				$('#createdTransactionMessage')
				.toggleClass('in')
				.delay(800)
				.show(0, function () {
					setTimeout(function () {
						location.href = '/default/transaction/transaction3c.cfm?tran='+type+'&nexttranno='+refno;
					}, 2000);
				});	
			}
			else if (buttonClicked == 'createAndNew'){
				
				$('#createdTransactionMessage')
				.toggleClass('in')
				.delay(800)
				.show(0, function () {
					setTimeout(function () {
						location.href = 'simpleTransaction.cfm?action=Create&type='+type; 
					}, 2000);
				});	
			}

			return false;
		},
		error: function(jqXHR,textStatus,errorThrown){
			alert(errorThrown);
		},
	});
};