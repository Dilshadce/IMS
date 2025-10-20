// JavaScript Document
$(document).ready(function(e) {
	if(action=='Create'){
		$('#custno').parent().parent().parent().children('.help-block').html(targetNumberRequired).show();
		$('#custno').parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
		$('#name2').parent().children('.help-block').html(targetNameRequired).show();
		$('#name').parent().parent().removeClass('has-success').addClass('has-error');
		$('#name2').parent().parent().removeClass('has-success').addClass('has-error');
		$('#submit').attr('disabled',true);
	}

	$('#custno').on('change',function(e){
		$(this).val(this.value.toUpperCase());
	})		
	$('#custno').on('keyup',function(e){		
		
		if($(this).val().length>=1 && $(this).val().length!=8){
		custnolist();
		}
		
		var codepatern = "";		
		if(custSuppNoStyle == "1"){
			codepatern = new RegExp(/[\w]{4,4}[/][\w]{3,3}/g);
			if($(this).val()==''){
				$(this).parent().parent().parent().children('.help-block').html(targetNumberRequired).show();
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
			}else if(!$(this).val().match(codepatern)){
				$(this).parent().parent().parent().children('.help-block').html(targetFormat).show();
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
			}else if($(this).val().split(/[/]/g)[1]=='000'){
				$(this).parent().parent().parent().children('.help-block').html(targetSurfix).show();
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
			}else if(!custnoInRange()){
				$(this).parent().parent().parent().children('.help-block').html(targetRange+' '+codefr+' '+targetRangeTo+' '+codeto+' .').show();
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');			
			}else{
				$(this).parent().parent().parent().children('.help-block').hide();
				$(this).parent().parent().parent().parent().removeClass('has-error').addClass('has-success');
				custnoExist();
			}
		
		}else{			
			codepatern = new RegExp(/[\w]{4}[\w]{4}/g);
			if($(this).val()==''){
				$(this).parent().parent().parent().children('.help-block').html(targetNumberRequired).show();
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
			}else if(!$(this).val().match(codepatern)){
				/*$(this).parent().parent().parent().children('.help-block').html(targetFormat).show();*/
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
			}else if($(this).val().slice(-3)=='000'){
				$(this).parent().parent().parent().children('.help-block').html(targetSurfix).show();
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
			}else if(!custnoInRange()){
				$(this).parent().parent().parent().children('.help-block').html(targetRange+' '+codefr+' '+targetRangeTo+' '+codeto+' .').show();
				$(this).parent().parent().parent().parent().removeClass('has-success').addClass('has-error');				
			}else{
				$(this).parent().parent().parent().children('.help-block').hide();
				$(this).parent().parent().parent().parent().removeClass('has-error').addClass('has-success');
				custnoExist();
			}
		}
		if($(document).find('.has-error').length>0){
			$('#submit').attr('disabled',true);
		}else{
			$('#submit').removeAttr('disabled');
		}
	});
	
	$('#name').on('keyup',function(e){
		if($(this).val()==''){
			$('#name2').parent().children('.help-block').html(targetNameRequired).show();
			$('#name').parent().parent().removeClass('has-success').addClass('has-error');
			$('#name2').parent().parent().removeClass('has-success').addClass('has-error');
		}else{
			$('#name2').parent().children('.help-block').hide();
			$('#name').parent().parent().removeClass('has-error').addClass('has-success');
			$('#name2').parent().parent().removeClass('has-error').addClass('has-success');
			/*nameExist();*/
		}		
		if($(document).find('.has-error').length>0){
			$('#submit').attr('disabled',true);
		}else{
			$('#submit').removeAttr('disabled');
		}
	});
	
	$('#name2').on('keyup',function(e){
		$('#name2').parent().children('.help-block').hide();
		$('#name').parent().parent().removeClass('has-error').addClass('has-success');
		$('#name2').parent().parent().removeClass('has-error').addClass('has-success');
		/*nameExist();*/		
		if($(document).find('.has-error').length>0){
			$('#submit').attr('disabled',true);
		}else{
			$('#submit').removeAttr('disabled');
		}
	});
	
	$('.input-group.date').datepicker({
		format: "dd/mm/yyyy",
		todayBtn: "linked",
		autoclose: true,
		todayHighlight: true
	});
	
	$('.btn-toggle').on('click',function(e){
		$(this).find('.btn').toggleClass('active');
		if ($(this).find('.btn-primary').size()>0) {
			$(this).find('.btn').toggleClass('btn-primary');
		}
		$(this).find('.btn').toggleClass('btn-default');
	});
	
	$('.ngst').on('click',function(e){
		if($('#ngst_cust').attr('disabled')){
			$('#ngst_cust').removeAttr('disabled');
		}else{
			$('#ngst_cust').attr('disabled',true);
		}
	});
	
	$('.termExceed').on('click',function(e){
		if($('#termExceed').attr('disabled')){
			$('#termExceed').removeAttr('disabled');
		}else{
			$('#termExceed').attr('disabled',true);
		}
	});
	
	$('.lc_ex').on('click',function(e){
		if($('#lc_ex').val()==0){
			$('#lc_ex').val(1);
		}else{
			$('#lc_ex').val(0);
		}
	});
	
	$('#currcode').on('change',function(e){
		var selected=$(this).find('option:selected');
		$('#currency').val(selected.data('symbol'));
		$('#currency1').val(selected.data('description'));
	});
	
	$('.copyBillingAddress').on('click',function(e){
		var attn_input = $('#attn').val();
		var add1_input = $('#add1').val(); 
		var add2_input = $('#add2').val();
		var add3_input = $('#add3').val();
		var add4_input = $('#add4').val();
		var country_input = $('#country').val();
		var postalcode_input = $('#postalcode').val();
		var phone_input = $('#phone').val();
		var hp_input = $('#hp').val();
		var fax_input = $('#fax').val();
		var email_input = $('#email').val();
		
		$('#d_attn').val(attn_input);
		$('#d_add1').val(add1_input);
		$('#d_add2').val(add2_input);
		$('#d_add3').val(add3_input);
		$('#d_add4').val(add4_input);
		$('#d_country').val(country_input);
		$('#d_postalcode').val(postalcode_input);
		$('#d_phone').val(phone_input);
		$('#d_hp').val(hp_input);
		$('#d_fax').val(fax_input);
		$('#web_site').val(email_input);
	});
});

function custnoInRange(){
	var check = new Boolean(true);
	if(($('#custno').val().substring(0,4) >= codefr.substring(0,4)) && ($('#custno').val().substring(0,4) <= codeto.substring(0,4))){
		return true;
	}else{
		return false;
	}
	/*for(var start = 0; start <= codefr.length; start++){
		if(($('#custno').val().split(/[/]/g)[0].charAt(start) >= codefr.charAt(start)) && ($('#custno').val().split(/[/]/g)[0].charAt(start) <= codeto.charAt(start))){
			return true;
		}else{
			return false;
		}
	}*/
}

function custnolist()
{
		$.ajax({
		'dataType':'json',
		'type':'POST',
		'url':'/latest/maintenance/custnolist.cfc',
		'data':{
			method:'custlist',
			returnformat:'json',
			dts:dts,
			targetTable:targetTable,
			custno:$('#custno').val()
		},
		'success':function(data,status,jqXHR){
			if(data.recordTotal>=1){
				$('#custno').parent().parent().parent().children('.help-block').html('Last '+$('#custno').val()+' is :'+data.lastrecord).show();
			}
		}
	});
}

function custnoExist(){
	$.ajax({
		'dataType':'json',
		'type':'POST',
		'url':'/latest/maintenance/target.cfc',
		'data':{
			method:'checkCustNoExist',
			returnformat:'json',
			dts:dts,
			targetTable:targetTable,
			custno:$('#custno').val()
		},
		'success':function(data,status,jqXHR){
			if(data.recordTotal>=1){
				$('#custno').parent().parent().parent().children('.help-block').html($('#custno').val()+targetDuplicateNumber).show();
				$('#custno').parent().parent().parent().parent().removeClass('has-success').addClass('has-error');
			}
		}
	});
}

function nameExist(){
	$.ajax({
		'dataType':'json',
		'type':'POST',
		'url':'/latest/maintenance/target.cfc',
		'data':{
			method:'checkNameExist',
			returnformat:'json',
			dts:dts,
			targetTable:targetTable,
			name:$('#name').val(),
			name2:$('#name2').val()
		},
		'success':function(data,status,jqXHR){
			if(data.recordTotal>=1){
				$('#name2').parent().children('.help-block').html($('#name').val()+' '+$('#name2').val()+targetDuplicateName).show();
				$('#name').parent().parent().removeClass('has-success').addClass('has-error');
				$('#name2').parent().parent().removeClass('has-success').addClass('has-error');
			}
		}
	});
}